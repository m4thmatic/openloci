<?php

class tables_accounts_receivable_voucher_accounts {

	//Create an Accounts Receivable Voucher Entry returns Record ID on success, -1 on failure
	public function create_accounts_receivable_voucher_entry($voucher_id, $account_id, $amount){
		//Create New Record
		$ar_record = new Dataface_Record('accounts_receivable_voucher_accounts', array());
		$ar_record->setValues(array(
			'voucher_id'=>$voucher_id,
			'account_id'=>$account_id,
			'amount'=>$amount
		));
		$res = $ar_record->save(null, true);  // checks permissions

		if ( PEAR::isError($res) ){return PEAR::raiseError("FIN",DATAFACE_E_NOTICE);return -1;}
		
		return $ar_record->val('arva_id');
	}
	
}
?>