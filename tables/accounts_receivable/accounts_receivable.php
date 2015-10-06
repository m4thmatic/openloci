<?php

class tables_accounts_receivable {

//SQL to create VIEW: (SELECT purchase_order_id, assigned_voucher_id, vendor_id FROM `purchase_order_inventory` WHERE assigned_voucher_id IS NULL) UNION (SELECT purchase_order_id, assigned_voucher_id , vendor_id FROM `purchase_order_service` WHERE assigned_voucher_id IS NULL)

	//Permissions
	function getPermissions(&$record){
		//Check if the user is logged in & what their permissions for this table are.
		if( isUser() ){
			$userperms = get_userPerms('accounts_receivable');
			if($userperms == "view")
				return Dataface_PermissionsTool::getRolePermissions("READ ONLY"); //Assign Read Only Permissions
			elseif($userperms == "edit" || $userperms == "post"){
				//Check status, determine if record should be uneditable.
			//	if ( isset($record) && $record->val('post_status') == 'Posted')
			//			return Dataface_PermissionsTool::getRolePermissions('NO_EDIT_DELETE');

				$perms = Dataface_PermissionsTool::getRolePermissions(myRole()); //Assign Permissions based on user Role (typically USER)
					unset($perms['delete']);
				return $perms;
			}
		}
		
		//Default: No Access
		return Dataface_PermissionsTool::NO_ACCESS();
	}

	function __field__permissions($record){
		if( isset($record) && ($record->val('post_status') == 'Posted' || $record->val('post_status') == 'Pending') )
			return array('edit'=>0);
	}
	
	//Remove the "edit" tab, if applicable. --- Field permissions are set to 'edit'=>0 anyway, but since changing "status" required general edit access via getPermissions(), which then automatically shows the tab - this needs to be visually disabled.
	function init(){
		$app =& Dataface_Application::getInstance();
		$query =& $app->getQuery();
		$record =& $app->getRecord();
			
		//Only on the 'view' page. Otherwise, causes issues with looking at the entire table (i.e. user sees a blank page).
		//If record exists & the status is set such that the record shouldn't be editable.
		//Make sure table is "accounts_receivable" otherwise screws up other tables that call accounts_receivable.
		if($query['-action'] == 'view' && $query['-table'] == 'accounts_receivable')
				if($record->val('post_status') == 'Posted' || $record->val('post_status') == 'Pending')
					echo "<style>#record-tabs-edit{display: none;}</style>";
	}
		
	function post_status__permissions(&$record){
		//Check permissions & if allowed, set edit permissions for "account_status"
		if(get_userPerms('accounts_receivable') == "edit" || get_userPerms('accounts_receivable') == "post")
			return array("edit"=>1);
	}
	
	function post_date__permissions(&$record){
		//Check permissions & if allowed, set edit permissions for "account_status"
		if(get_userPerms('accounts_receivable') == "edit" || get_userPerms('accounts_receivable') == "post")
			return array("edit"=>1);
	}

	function credit_invoice_id__permissions(&$record){
		//Check permissions & if allowed, set edit permissions for "account_status"
		if(get_userPerms('accounts_receivable') == "edit" || get_userPerms('accounts_receivable') == "post")
			return array("edit"=>1);
	}
	
	function check_id__permissions(&$record){
			//Check permissions & if allowed, set edit permissions for "account_status"
			if(get_userPerms('accounts_receivable') == "edit" || get_userPerms('accounts_receivable') == "post")
				return array("edit"=>1);
	}
	
	function getTitle(&$record){
		return "Accounts Receivable for Invoice " . $record->val('invoice_id') . " (" . $record->display("customer_id") . ")";
		//$po_type = substr($record->val('purchase_order_id'),0,1);
		//return 'Voucher ID #' . $record->val('voucher_id') . " (" . $record->strval('voucher_date') . ") - Type: " . $po_type . ", Invoice ID: " . $record->val('invoice_id');

		//return 'Invoice ID: ' . $record->val('invoice_id') . ' - Status: ' . $record->val('post_status');
	}

	//function titleColumn(){
	//	return 'CONCAT("Invoice ID: ", invoice_id," - Status: ",post_status)';
	//}	

	
	function account__default(){
		//Get default Accounts Receivable acct
		$default_accounts = df_get_record('_account_defaults', array('default_id'=>1));
		$ar_account = $default_accounts->val('accounts_receivable');
		
		return $ar_account;
	}
	
	function voucher_date__default(){
		return date('Y-m-d');
	}

	function amount__display(&$record){
		if($record->val('amount') != NULL)
			return "$" . $record->val('amount');
			
	}

	
	//Create an Accounts Receivable Entry returns AR Record ID on success, -1 on failure
	public function create_accounts_receivable_entry($invoice_id, $customer_id, $amount, $customer_po){
		//Get default Accounts Receivable acct
		$default_accounts = df_get_record('_account_defaults', array('default_id'=>1));
		$ar_account = $default_accounts->val('accounts_receivable');

		//Create New Record
		$ar_record = new Dataface_Record('accounts_receivable', array());
		$ar_record->setValues(array(
			'invoice_id'=>$invoice_id,
			'customer_id'=>$customer_id,
			'amount'=>$amount,
			'customer_po'=>$customer_po,
			'voucher_date'=>date('Y-m-d'),
			'account'=>$ar_account,
			'user_id'=>userID()
		));
		$res = $ar_record->save(null, true);  // checks permissions

		if ( PEAR::isError($res) ){return -1;}
		
		return $ar_record->val('voucher_id');
	}
	

//	function customer_id__display(&$record){
//		if($record->val('customer_id') == NULL)
//			return "---";
			
//		$customer_record = df_get_record('customers', array('customer_id'=>$record->val('customer_id')));
//		return $customer_record->val('customer');
//	}

	function section__accounts(&$record){
		//$app =& Dataface_Application::getInstance(); 
		//$query =& $app->getQuery();
		$childString = '';
			
		$childString .= '<table class="view_add">';
		$childString .= '<tr><th>Account</th><th>Amount</th></tr>';
		
		//$account_records = $record->getRelatedRecords("accounts_receivable_voucher_accounts");
		$account_records = df_get_records_array("accounts_receivable_voucher_accounts",array("voucher_id"=>$record->val("voucher_id")));
		foreach($account_records as $account_record){
			$childString .= '<tr>';
			$childString .= '<td>' . $account_record->display('account_id') . '</td><td style="text-align: right;">$' . $account_record->val('amount') . "</td>";
			$childString .= '</tr>';
		}
		$childString .= '</table>';
		
		
		return array(
			'content' => "$childString",
			'class' => 'main',
			'label' => 'Accounts',
			'order' => 9
		);
	}	

	function section__status(&$record){
		$app =& Dataface_Application::getInstance(); 
		$query =& $app->getQuery();
		$childString = '';

		//If the "Change Status" button has been pressed.
		//Because both the $_GET and $query will be "" on a new record, check to insure that they are not empty.
		if(($_GET['-status_change'] == $query['-recordid']) && ($query['-recordid'] != "")){
			
			$status_button = $_GET['status_button'];
			
			//Pending
			if($status_button == "Change Status to Pending"){
				$record->setValue('post_status',"Pending"); //Set status to Pending.
				$res = $record->save(null, true); //Save Record w/ permission check.
				$msg = '<input type="hidden" name="--msg" value="Status Changed to Pending">';
			}
			
			//Remove Pending
			if($status_button == "Remove Pending Status"){
				$record->setValue('post_status',""); //Set status to null.
				$res = $record->save(null, true); //Save Record w/ permission check.
				$msg = '<input type="hidden" name="--msg" value="Pending Status Removed">';
			}

			//Check for errors.
			if ( PEAR::isError($res) ){
				// An error occurred
				$msg = '<input type="hidden" name="--error" value="Unable to change status. This is most likely because you do not have the required permissions.">';
			}
			
			$childString .= '<form name="status_change">';
			$childString .= '<input type="hidden" name="-table" value="'.$query['-table'].'">';
			$childString .= '<input type="hidden" name="-action" value="'.$query['-action'].'">';
			$childString .= '<input type="hidden" name="-recordid" value="'.$record->getID().'">';

			$childString .= $msg;

			$childString .= '</form>';
			$childString .= '<script language="Javascript">document.status_change.submit();</script>';
		}
		//Show the appropriate buttons
		else{
			$childString .= '<form>';
			$childString .= '<input type="hidden" name="-table" value="'.$query['-table'].'">';
			$childString .= '<input type="hidden" name="-action" value="'.$query['-action'].'">';
			$childString .= '<input type="hidden" name="-recordid" value="'.$record->getID().'">';
			$childString .= '<input type="hidden" name="-status_change" value="'.$record->getID().'">';

			//Show Pending button
			if(	$record->val('post_status') == ''){
				$childString .= '<input type="submit" name="status_button" value="Change Status to Pending">'; //Pending Button
			}
			//Show Remove Pending button
			elseif(	$record->val('post_status') == 'Pending'){
				$childString .= '<input type="submit" name="status_button" value="Remove Pending Status">'; //Remove Pending Button
			}
			else {
				$childString .= "No further options available";
			}

			$childString .= '</form>';
		}
		
		//if(	$record->val('post_status') == '')
		return array(
			'content' => "$childString",
			'class' => 'main',
			'label' => 'Change Status',
			'order' => 10
		);
	}


	function accounts__validate(&$record, $value, &$params){
		//Empty the error message
		$params['message'] = '';
		$total_amount = 0;

		//Get rid of the last set in the array - it isn't needed for our use and causes issues
		unset($value['__loaded__']);

		foreach ($value as $account_record){

			//Skip empty lines - do nothing (unless an amount has been assigned, and then return an error)
			if($account_record['account_id'] == ''){
				if($account_record['amount']){ //Case where the 'account' field has been left empty, but an amount has been given
					$params['message'] .= 'Error: An amount has been given, but an account has not been assigned.';
					return false;
				}
			}
			else{
				//Add current amount to total
				$total_amount += $account_record["amount"];
			}
		}

		if($total_amount != $record->val("amount")){
			$params['message'] .= 'Error: The value in "Total Amount" ('.$record->val("amount").') must match the total from the "Accounts" ('.$total_amount.')';
			return false;
		}
		
		//If no errors have occured, move along.
		$params['message'] .= "success!";
		return true;
	}

}
?>
