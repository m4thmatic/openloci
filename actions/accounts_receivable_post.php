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

		
		//Set Headers as an empty array
		$headers = array();

		//Clear Error Flags
		//$display_errors = false;
		$error = false;

		//Initial Page Load - Post button has not pressed.
		if($confirm == null){
			//Get the application instance - used for pulling the query data
			$app =& Dataface_Application::getInstance();
			$query =& $app->getQuery();

			//Extend the limit of df_get_records_array past the usual first 30 records, and query the records where [post_status == "Pending"] and [user_id == (current user)]
			$query['-skip'] = 0;
			$query['-limit'] = ""; //******I think this will do *all*, but need to double check********
			$query['post_status'] = 'Pending';
			//$query['batch_id'] = '='; //This is from an old version where you would first assign receivables to batches.

			//Determine if we are displaying only those billing entries created by the current user, or all.
			if(!isset($_GET['all'])){
				$query['user_id'] = userID();
			}

			//Pull all records with Pending status
			$ARrecords = df_get_records_array('accounts_receivable', $query);

			//Unset the 'post_status' query
			unset($query['post_status']);

			//Run through all pulled records to get header information
			foreach($ARrecords as $i=>$ARrecord){
				$headers[$i] = $this->getHeader($ARrecord);
			}
			
			//Reset post_status session variable - in case it hasn't already been.
			unset($_SESSION["post_status"]);
		}
		//Review
		elseif($confirm == "review"){

			//Check to make sure that entries have been selected
			if(isset($_GET['select_entries'])){
				//Get selected entries
				$entries = $_GET['select_entries'];

				//Run through all selected records
				foreach($entries as $i=>$entry){
					//Pull Associated Record
					$ARrecord = df_get_record("accounts_receivable", array("voucher_id"=>$entry));
					
					//Pull Header Information from Record
					$headers[$i] = $this->getHeader($ARrecord);
				}
			}
			
			//Set post_status session variable to "Reviewed"
			$_SESSION["post_status"] = "Reviewed";
		}
		//Post
		elseif($confirm == "post"){

			//Check to make sure that the session variable is set to "Reviewed" - to prevent refreshing the page and "re-posting"
			if(isset($_SESSION["post_status"]) && $_SESSION["post_status"] == "Reviewed"){
				//Check to make sure that entries have been selected
				if(isset($_GET['select_entries'])){
					//Get the selected entries
					$entries = $_GET['select_entries'];
				
					$journal_data = array();
					$journal_entry = array();

					//Start Transaction - on error, rollback changes.
					df_transaction_begin();
					
					//Create Batch
					$batch_record = new Dataface_Record('accounts_receivable_batch', array());
					$batch_record->setValues(array(
						'batch_name'=>"AR ".date("Y-m-d")." (".userName().")",
						'post_date'=>date("Y-m-d")
					));
					$res = $batch_record->save(null, true); //Save Record w/ permission check.

					//Check for errors.
					if ( PEAR::isError($res) ){
						$error = true;
						$headers[$i]['error_msg'] .= "Failed on: create Accounts Receivable Batch record. $res<br>";
					}

					//Get Batch ID
					$batch_id = $batch_record->val("batch_id");
					
					//Run through all pulled records
					foreach($entries as $i=>$entry){
						//Pull Associated Record
						$ARrecord = df_get_record("accounts_receivable", array("voucher_id"=>$entry));
						if(isset($ARrecord)){
							//Pull Header Information from Record
							$headers[$i] = $this->getHeader($ARrecord);
							$headers[$i]['error_msg'] = "";

							//Check to insure that the record has not already been posted.
							if($ARrecord->val("post_status") == "Posted"){
								$error = true;
								$headers[$i]['error_msg'] .= "Failed on: Record has already been posted.";
							}
							
							$ARrecord->setValue('post_status',"Posted"); //Set status to Posted.
							$ARrecord->setValue('post_date',date('Y-m-d')); //Set post date.
							$res = $ARrecord->save(null, true); //Save Record w/ permission check.

							//Check for errors.
							if ( PEAR::isError($res) ){
								$error = true;
								$headers[$i]['error_msg'] .= "Failed on: update Accounts Receivable record. $res<br>";
							}
						}
						else{
							$error = true;
							$headers[$i]['error_msg'] .= "Failed on: get Accounts Receivable record.<br>";
						}

						//Add AR record to the batch record
						//Create Batch Voucher Record
						$batch_voucher_record = new Dataface_Record('accounts_receivable_batch_vouchers', array());
						$batch_voucher_record->setValues(array(
							'batch_id'=>$batch_id,
							'voucher_id'=>$entry
						));
						$res = $batch_voucher_record->save(null, true); //Save Record w/ permission check.

						//Check for errors.
						if ( PEAR::isError($res) ){
							$error = true;
							$headers[$i]['error_msg'] .= "Failed on: create Accounts Receivable Batch Voucher record. $res<br>";
						}					
						
						//Set Call Slip Status to "BLD" (Billed) & Payment Status to "Unpayed"
						$CSrecord = df_get_record("call_slips",array("call_id"=>$ARrecord->val("invoice_id")));
						if(isset($CSrecord)){
							$CSrecord->setValue("status","BLD");
							$CSrecord->setValue("payment_status","Unpayed");
							$res = $CSrecord->save(null,true);

							//Check for errors.
							if ( PEAR::isError($res) ){
								$error = true;
								$headers[$i]['error_msg'] .= "Failed on: update Call Slip record. $res<br>";
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
								$headers[$i]['error_msg'] .= "Failed on: update Customer record. $res<br>";
							}
						}
						else{ //Error
							$error = true;
							$headers[$i]['error_msg'] .= "Failed on: get Customer record.<br>";
						}
						
						//Collect & Parse General Ledger Information
						//Debit asset account (accts recv)
						if(isset($journal_data["debit"][$ARrecord->val('account')])){
							$journal_data["debit"][$ARrecord->val('account')] += $ARrecord->val('amount');
						}
						else
							$journal_data["debit"][$ARrecord->val('account')] = $ARrecord->val('amount');
						//Credit others
						$AR_account_records = df_get_records_array('accounts_receivable_voucher_accounts', array("voucher_id"=>$ARrecord->val('voucher_id')));
						foreach($AR_account_records as $AR_account_record){
							if(isset($journal_data["credit"][$AR_account_record->val("account_id")])){
								$journal_data["credit"][$AR_account_record->val("account_id")] += $AR_account_record->val("amount");
							}
							else
								$journal_data["credit"][$AR_account_record->val("account_id")] = $AR_account_record->val("amount");
						}
					}

					//Reframe General Ledger Information
					foreach($journal_data["debit"] as $account => $amount){
						$journal_entry[] = array("account_number"=>$account,"debit"=>$amount);
					}
					foreach($journal_data["credit"] as $account => $amount){
						$journal_entry[] = array("account_number"=>$account,"credit"=>$amount);
					}

					//Create General Ledger Entry
					$description = "Accounts Receivable Entry, Batch ID: " . $batch_id;
					$res = create_general_ledger_entry($journal_entry, $description);

					if($res < 0){
						$error = true;
						$headers[$i]['error_msg'] .= "Failed on: create General Ledger Entry. $res<br>";
					}

					//Check if there were errors
					if($error == true){
						//$display_errors = true;
								
						//Rollback Changes
						df_transaction_rollback();
					}
					else{
						//Commit Changes
						df_transaction_commit();
					}
					
					//Change post_status session variable to "Posted"
					$_SESSION["post_status"] = "Posted";

				}
				else{ //If nothing was selected go back to the beginning - this shouldn't happen, unless someone was messing with URLs
					$confirm = "error";
					$error = "Nothing selected. -3";
				}
			}
			else{ //If page was refreshed, or someone tried to mess with URLs
				//If "select_entries" is defined, someone probably hit the refresh button, simply redisplay the page
				if(isset($_GET['select_entries'])){
					//Get the selected entries
					$entries = $_GET['select_entries'];
					
					//Run through all pulled records
					foreach($entries as $i=>$entry){
						//Pull Associated Record
						$ARrecord = df_get_record("accounts_receivable", array("voucher_id"=>$entry));
						if(isset($ARrecord)){
							//Pull Header Information from Record
							$headers[$i] = $this->getHeader($ARrecord);
						}
					}
				}
				else{ //Someone was likely doing something they shouldn't
					$confirm = "error";
					$error = "Oops! Something went wrong. Please try again. If this problem persists, please see your system administrator. -2";
				}
			}
		}
		else{
			//Something went wrong...
			$confirm = "error";
			$error = "Oops! Something went wrong. Please try again. If this problem persists, please see your system administrator. -1";
		}
		

		//Display the page
		df_display(array("headers"=>$headers,"confirm"=>$confirm,"display_errors"=>$error), 'accounts_receivable_post.html');

	}
	
	//Return "Header" Information
	function getHeader($record, $partial_list = false){
		
		//Basic Information
		$out['id'] = $record->val('voucher_id');
		$out['date'] = $record->strval('voucher_date');//$rdate['month'].'-'.$rdate['day'].'-'.$rdate['year'];
		$out['customer'] = $record->display('customer_id');
		$out['invoice'] = $record->display('invoice_id');
		$out['rec_acct'] = $record->display('account');
		$out['rec_amount'] = $record->display('amount');

		if($partial_list == false){
			//Pull the CS record for the Customer Site information
			$CSrecord = df_get_record('call_slips',array('call_id'=>$record->val('invoice_id')));
			$site = $CSrecord->display("site_id");

			$out['customer'] .= "<br><center>(" . $site . ")</center>";
			
			
			//Get Account Records
			$out['rev_accts'] = "";
			$out['rev_amounts'] = "";
			$account_records = df_get_records_array('accounts_receivable_voucher_accounts', array("voucher_id"=>$record->val('voucher_id')));
			foreach($account_records as $account_record){
				$out['rev_accts'] .= $account_record->display("account_id")."<br>";
				$out['rev_amounts'] .= $account_record->display("amount")."<br>";
			}
		}
		
		return $out;
	}
	
	
}


?>