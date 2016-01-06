<?php

class tables_purchase_orders {

//SQL to create VIEW:
//(SELECT purchase_order_id, assigned_voucher_id, vendor_id FROM `purchase_order_inventory`) union (SELECT purchase_order_id, assigned_voucher_id, vendor_id FROM `purchase_order_service`) union (SELECT purchase_order_id, assigned_voucher_id, vendor_id FROM `purchase_order_tool`) union (SELECT purchase_order_id, assigned_voucher_id, vendor_id FROM `purchase_order_vehicle`)

	function getTitle(&$record){
		return 'Purchase Order: ' . $record->val('purchase_order_id');
	}
	
	
}
?>
