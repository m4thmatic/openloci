<?php

class tables_cash_receipts_checks {

	function cash_receipts_account__default() {
		$account_default_record = df_get_record("_account_defaults",array("default_id"=>1));
		return $account_default_record->val("cash_receipts_account");
	}

	
	function section__invoices(&$record){

		$childString = "";

		$childString .= '<b><u>Hours</u></b><br><br>';
		$childString .= '<table class="view_add"><tr>
							<th>AR Voucher ID</th>
							<th>Invoice ID</th>
							<th>Amount</th>
							<th>Invoice Total</th>
							</tr>';


		$invoice_records = $record->getRelatedRecords('check_invoices');
		foreach ($invoice_records as $invoice_record){
			$ar_record = df_get_record("accounts_receivable",array("voucher_id"=>$invoice_record["ar_voucher_id"]));
			
			if($invoice_record["amount"] > $ar_record->val("amount")){
				$background = 'style="background-color: lightgreen"';
			}
			elseif($invoice_record["amount"] < $ar_record->val("amount")){
				$background = 'style="background-color: #ff7070"';
			}
			
			$childString .= '<tr><td '.$background.'>' . $invoice_record["ar_voucher_id"] .
							'</td><td '.$background.'>' . $ar_record->display("invoice_id") .
							'</td><td '.$background.'>$' . $invoice_record["amount"] . '</span>' .
							'</td><td '.$background.'>$' . $ar_record->val("amount") . '</span>' .
							"</td></tr>";
		}

		$childString .= '</table><br>';

		return array(
			'content' => "$childString",
			'class' => 'main',
			'label' => 'Invoices',
			'order' => 10
		);
	}
	
	
	
	
	
	function invoices__validate(&$record, $accts_recv_vouchers, &$params){
		//Empty the error message
		$params['message'] = '';

		$amount_total = 0;
		
		//echo "<pre>".print_r($accts_recv_vouchers,true)."</pre>";
		
		foreach ($accts_recv_vouchers as $key => $accts_recv_voucher){
			//Skip any lines that aren't integers (i.e. __loaded__, __deleted__, etc)
			if(is_int($key)){

				//If an accouts receivable voucher has *not* been assigned - check for other assigned data (error), or ignore line
				if($accts_recv_voucher['ar_voucher_id'] == ''){
					//If the inventory item field has been left empty, but other data has been assigned - Error
					if($accts_recv_voucher['amount']){
						$params['message'] .= 'Error: An Accounts Receivable Voucher has been left unassigned.';
						return false;
					}
				}
				else{
					$amount_total += $accts_recv_voucher["amount"];
				}
			}
		}
		
		//$params['message'] .= $amount_total . " - ";
		
		if($amount_total != $record->val("amount")){
			$params['message'] .= "Check Amount ($".number_format($record->val("amount"),2).") does not equal the amount total from the selected invoices ($".number_format($amount_total,2).").";
			return 0;
		}
		
		//For Testing Purposes: Insure that the validation check fails.
		//$params['message'] .= "done.";
		//return 0;

		//If no errors have occured, move along.
		return 1;
	}
	
	function beforeSave(&$record){
		//Start Transaction - on error, rollback changes.
		df_transaction_begin();
	}

	function afterSave(&$record){
		$record_invoices = $record->getRelatedRecords("check_invoices");
		$error = false;

		foreach($record_invoices as $record_invoice){
			$ar_record = df_get_record("accounts_receivable",array("voucher_id"=>$record_invoice["ar_voucher_id"]));
			$ar_record->setValue("check_id",$record->val("check_id"));
			$res = $ar_record->save(null,true);
			
			if( PEAR::isError($res) ){
				$error = true;
				break;
			}
		}
	
		//On error saving AR entries - rollback entire transaction and return an error
		if($error == true){
			df_transaction_rollback();
			return PEAR::raiseError("Could not assign Check# to account receivable entry. Please insure you have the proper permissions.",DATAFACE_E_NOTICE);
		}
		
		//If no errors, commit transaction
		df_transaction_commit();
	}

	
}

?>