<?php

class actions_accounts_receivable_post {
	
	function handle(&$params){

		//Permission check
		if ( !isUser() )
			return Dataface_Error::permissionDenied("You are not logged in.");
			
		if(get_userPerms('accounts_receivable') != "post")
			return Dataface_Error::permissionDenied("You do not have permission to post Accounts Receivables.");
			
		//If the page has been submitted (Post button pressed), this will be "true", otherwise NULL.
		$confirm = isset($_GET['confirm_post']) ? $_GET['confirm_post'] : null;

		//Get the application instance - used for pulling the query data
		$app =& Dataface_Application::getInstance();

		//Extend the limit of df_get_records_array past the usual first 30 records, and query the records where [post_status == "Pending"]
		$query =& $app->getQuery();
		$query['-skip'] = 0;
		$query['-limit'] = ""; //******I think this will do *all*, but need to double check********
		$query['post_status'] = 'Pending';
		$query['batch_id'] = '=';
			
		//Pull all records with Pending status
		$ARrecords = df_get_records_array('accounts_receivable', $query);

		//Unset the 'post_status' query
		unset($query['post_status']);
		
		//Set Headers as an empty array
		$headers = array();
		
		$display_errors = false;

		//Initial Page Load - Post button has not pressed.
		if($confirm == null){
			//Run through all pulled records
			foreach($ARrecords as $i=>$ARrecord){

				//Get basic header info
				$headers[$i]['id'] = $ARrecord->val('voucher_id');
				$headers[$i]['date'] = $ARrecord->strval('voucher_date');//$rdate['month'].'-'.$rdate['day'].'-'.$rdate['year'];
				$headers[$i]['customer'] = $ARrecord->display('customer_id');
				$headers[$i]['invoice'] = $ARrecord->display('invoice_id');

				//Get more detailed header info
				//$headers[$i]['invoice_date'] = "";
				$headers[$i]['credit'] = $ARrecord->display('credit_invoice_id');
				$headers[$i]['rec_acct'] = $ARrecord->display('account');
				$headers[$i]['rec_amount'] = $ARrecord->display('amount');
				$headers[$i]['rev_accts'] = "";
				$headers[$i]['rev_amounts'] = "";
					
				//Get Account Records
				$AR_account_records = df_get_records_array('accounts_receivable_voucher_accounts', array("voucher_id"=>$ARrecord->val('voucher_id')));
				foreach($AR_account_records as $AR_account_record){
					$headers[$i]['rev_accts'] .= $AR_account_record->display("account_id")."<br>";
					$headers[$i]['rev_amounts'] .= $AR_account_record->display("amount")."<br>";
				}
			}
		}
		else{ //Post
				
			//Run through all pulled records
			foreach($ARrecords as $i=>$ARrecord){
			
				//Get basic header info
				$headers[$i]['id'] = $ARrecord->val('voucher_id');
				$headers[$i]['date'] = $ARrecord->strval('voucher_date');//$rdate['month'].'-'.$rdate['day'].'-'.$rdate['year'];
				$headers[$i]['customer'] = $ARrecord->display('customer_id');
				$headers[$i]['invoice'] = $ARrecord->display('invoice_id');
				
				//Only modify selected records
				if($_GET[$ARrecord->val('voucher_id')]=="on"){

					//Start Transaction - on error, rollback changes.
					xf_db_query("BEGIN TRANSACTION",df_db());
					xf_db_query("SET autocommit = 0",df_db()); //Normally shouldn't have to set this explicitly, but is required in this instance. Not entirely sure why, but I think it may have to do with saving records in functions that are being called from another class - separate transaction?
					$error = false;

					$ARrecord->setValue('post_status',"Posted"); //Set status to Posted.
					$ARrecord->setValue('post_date',date('Y-m-d')); //Set post date.
					$res = $ARrecord->save(); //Save Record w/o permission check.
					//$res = $record->save(null, true); //Save Record w/ permission check.  ****Fix permissions in accounts_receivable.php to allow for this.

					//Check for errors.
					if ( PEAR::isError($res) ){
						$error = true;
						$headers[$i]['error_msg'] .= "Failed on: update Accounts Receivable record.<br>";
					}
						
					//Create General Ledger Entry
					//	- debit asset account (accts recv)
					//	- credit others
					$AR_account_records = df_get_records_array('accounts_receivable_voucher_accounts', array("voucher_id"=>$ARrecord->val('voucher_id')));
					$journal_entry[] = array("account_number"=>$ARrecord->val('account'),"debit"=>$ARrecord->val('amount'));
					foreach($AR_account_records as $AR_account_record){
						$journal_entry[] = array("account_number"=>$AR_account_record->val("account_id"),"credit"=>$AR_account_record->val("amount"));
					}
					$description = "Accounts Receivable Entry, Voucher ID: " . $ARrecord->val('voucher_id');
					$res = create_general_ledger_entry($journal_entry, $description);

					if($res < 0){
						$error = true;
						$headers[$i]['error_msg'] .= "Failed on: create General Ledger Entry. $res<br>";
					}

					/*
					Call Slip - Status: Billed
					*/
					$CSrecord = df_get_record("call_slips",array("call_id"=>$ARrecord->val("invoice_id")));
					if(isset($CSrecord)){
						$CSrecord->setValue("status","BLD");
						$res = $CSrecord->save(null,true);

						//Check for errors.
						if ( PEAR::isError($res) ){
							$error = true;
							$headers[$i]['error_msg'] .= "Failed on: update Call Slip record.<br>";
						}
					}
					else{
						$error = true;
						$headers[$i]['error_msg'] .= "Failed on: get Call Slip record.<br>";
					}

					//Add balance to customer record
					$customer_record = df_get_record('customers',array('customer_id'=>$ARrecord->val('customer_id'))); //Get Customer Record
					if(isset($customer_record)){
						$customer_balance = $customer_record->val('balance'); //Get current customer balance
						$customer_record->setValue('balance',$customer_balance + $ARrecord->val('amount')); //Add receivables total to balance
						$res = $customer_record->save(null, true); //Save balance, with permission check
						
						//Check for errors.
						if ( PEAR::isError($res) ){
							$error = true;
							$headers[$i]['error_msg'] .= "Failed on: update Customer record.<br>";
						}
					}
					else{
						$error = true;
						$headers[$i]['error_msg'] .= "Failed on: get Customer record.<br>";
					}

					if($error == true){
						//Tag to denote which entries have failed.
						$headers[$i]['posted'] = "fail";
						$display_errors = true;
						
						//Rollback Changes
						xf_db_query("ROLLBACK",df_db());

					}
					else{
						//Tag to denote which entries have been posted.
						$headers[$i]['posted'] = "true";
						
						//Commit Changes
						xf_db_query("COMMIT",df_db());
					}
					
					xf_db_query("SET autocommit = 1",df_db()); //Reset this back to normal.


				}
				
			}
		}
		

		//Display the page
		df_display(array("headers"=>$headers,"confirm"=>$confirm,"display_errors"=>$display_errors), 'accounts_receivable_post.html');

	}
}


?>