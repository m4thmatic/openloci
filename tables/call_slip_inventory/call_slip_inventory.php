<?php

class tables_call_slip_inventory {

	//Permissions
	function getPermissions(&$record){
		//Check if the user is logged in & what their permissions for this table are.
		if( isUser() ){
			$userperms = get_userPerms('call_slips');
			if($userperms == "view")
				return Dataface_PermissionsTool::getRolePermissions("READ ONLY"); //Assign Read Only Permissions
			elseif($userperms == "edit")
				return Dataface_PermissionsTool::getRolePermissions(myRole()); //Assign Permissions based on user Role (typically USER)
		}

		//Default: No Access
		return Dataface_PermissionsTool::NO_ACCESS();
	}

	//This is for Call Slip Invoices
	function field__total_cost($record){
		$total_cost = number_format($record->val('quantity') * $record->val('sell_cost'),2);
		return $total_cost;
	}
	
	function beforeSave(&$record){
//$_SESSION["log_data"] .= "CSI beforeSave: ".$record->val("csi_id")."<br>";

		$inventory_record = df_get_record('inventory', array('inventory_id'=>$record->val('inventory_id')));

		//If an inventory "purchase price" is empty - i.e. an item has just been added - set it.
		if($record->val('purchase_price') == null){
			$purchase_price = ($inventory_record->val('last_purchase') > $inventory_record->val('average_purchase')) ? $inventory_record->val('last_purchase') : $inventory_record->val('average_purchase');
			$record->setValue('purchase_price', $purchase_price);
		}
		
		//If the "Location" is empty, set to "inv" (Inventory).
		if($record->val('location') == null){
			$record->setValue('location', "inv");
		}

		//Handle modifying inventory
		if($record->recordChanged()){
//$_SESSION["log_data"] .= "Record Changed<br>";
			//Get original values
			//$snapshot = $record->getSnapshot(); //<-- this should work but isn't
			//v - this is the workaround
			if($record->val("csi_id") != null){
				$snapshot = df_get_record("call_slip_inventory", array("csi_id"=>$record->val("csi_id")));
				$snapshot = $snapshot->vals();
				$location = ($snapshot['location'] == "") ? "inv" : $snapshot['location'];
				$quantity = $snapshot['quantity'];
				$item = $snapshot['inventory_id'];
			}
			else{
				$location = ($record->val('location') == "") ? "inv" : $record->val('location');
				$quantity = 0;
				$item = $record->val('inventory_id');
			}

			//Get new values
			$new_location = ($record->val('location') == "") ? "inv" : $record->val('location');
			$new_quantity = $record->val('quantity');
			$new_item = $record->val('inventory_id');

//$_SESSION["log_data"] .= "O Values: " . print_r($snapshot, true) . "<br>";
//$_SESSION["log_data"] .= "N Values: " . print_r($record->vals(), true) . "<br>";
//$_SESSION["log_data"] .= "Quantity Modification: from " .$quantity. " to " .$new_quantity. " = ". ($quantity - $new_quantity) . "<br>";


			//If "Location" or "Item" has changed
			if(($location != $new_location) || ($item != $new_item)){
//$_SESSION["log_data"] .= "location/item change<br>";
				//Pull original location/inventory record
				$loc_inv = ($location == 'inv') ?
					df_get_record('inventory', array('inventory_id'=>$item)) :
					df_get_record('vehicle_inventory', array('vehicle_id'=>$location,'inventory_id'=>$item));
				
				//Pull new location/inventory record
				$new_loc_inv = ($new_location == 'inv') ?
					df_get_record('inventory', array('inventory_id'=>$new_item)) :
					df_get_record('vehicle_inventory', array('vehicle_id'=>$new_location,'inventory_id'=>$new_item));

				//Check for quantity error (this includes a check to make sure that the location record exists)
				if($new_loc_inv == null || $new_loc_inv->val('quantity') < $new_quantity)
					return PEAR::raiseError('Exceeds Max Inventory',DATAFACE_E_NOTICE);

					
				//Add old quantity to the old item/location record
//$_SESSION["log_data"] .= "Set location <b>" . $location . "</b> item <b>" . $item . "</b> quantity to:" . ($loc_inv->val('quantity') + $quantity) . " -- Previously: " . $loc_inv->val('quantity'). "<br>";
				$loc_inv->setValue("quantity",($loc_inv->val('quantity') + $quantity));
				$loc_inv->save();

				//Add new quantity to the new item/location record
//$_SESSION["log_data"] .= "Set location <b>" . $new_location . "</b> item <b>" . $new_item . "</b> quantity to:" . ($new_loc_inv->val('quantity') - $new_quantity) . " -- Previously: " . $new_loc_inv->val('quantity'). "<br>";
				$new_loc_inv->setValue("quantity",($new_loc_inv->val('quantity') - $new_quantity));
				$new_loc_inv->save();

//*MINOR ISSUE: WHEN TRANSFERRING FROM VEH TO INV (OR OTHER WAY) CAUSES 2 SAVES OF THE SAME RECORD IN GENERAL INVENTORY
//NUMERICALLY CORRECT, HOWEVER, THIS COULD CAUSE CONFUSION WHEN LOOKING AT THE HISTORY
//EG:	itemX has 100quantity in general inventory & location been set to a vehicle, current quantity 5
//		change only location from vehicle to inv ->
//			general inventory first gets saved at 95 (from above), then second save puts it back to 100 (below)
//This is correct, as it should stay 100, but the extra save is really confusing when looking at history,
//as the inventory record, from a user perspective, should never have been set to 95.

				//Modify general inventory quantity - if necessary
				if($location != "inv"){
					$gen_inv = df_get_record('inventory', array('inventory_id'=>$item));
//$_SESSION["log_data"] .= "Set <b>general inventory</b> item <b>" . $item . "</b> quantity to:" . ($gen_inv->val('quantity') + $quantity) . " -- Previously: " . $gen_inv->val('quantity'). "<br>";
					$gen_inv->setValue('quantity',($gen_inv->val('quantity') + $quantity));
					$gen_inv->save();
				}
				if($new_location != "inv"){
					$gen_inv_new = df_get_record('inventory', array('inventory_id'=>$new_item));
//$_SESSION["log_data"] .= "Set <b>general inventory</b> item <b>" . $new_item . "</b> quantity to:" . ($gen_inv_new->val('quantity') - $new_quantity) . " -- Previously: " . $gen_inv_new->val('quantity'). "<br>";
					$gen_inv_new->setValue('quantity',($gen_inv_new->val('quantity') - $new_quantity));
					$gen_inv_new->save();
				}

			}
			//If only Quantity has changed - we separate this case out, so that we don't save the same record twice
			elseif($quantity != $new_quantity){
//$_SESSION["log_data"] .= "quantity only change<br>";

				//Pull general inventory record
				$gen_inv = df_get_record('inventory', array('inventory_id'=>$item));

				//If the location is general inventory, only process general inventory
				if($location == 'inv'){
					//Check for quantity error
					if($gen_inv->val('quantity') > ($new_quantity - $quantity)){ //Should have more than needed in general inventory
						//Modify the general inventory quantity
//$_SESSION["log_data"] .= "Set <b>general inventory</b> item <b>" . $item . "</b> quantity to:" . ($gen_inv->val('quantity') + $quantity - $new_quantity) . " -- Previously: " . $gen_inv->val('quantity'). "<br>";
						$gen_inv->setValue('quantity',($gen_inv->val('quantity') + $quantity - $new_quantity));
						$gen_inv->save();
					}
					else
						return PEAR::raiseError('Exceeds Max Inventory',DATAFACE_E_NOTICE);

				}
				else{ //Otherwise process both general inventory and location inventory
					//Pull location inventory record
					$loc_inv = df_get_record('vehicle_inventory', array('vehicle_id'=>$location,'inventory_id'=>$item));

					//Check for quantity error
					if($gen_inv->val('quantity') > ($new_quantity - $quantity)){ //Should have more than needed in general inventory
						if($loc_inv->val('quantity') > ($new_quantity - $quantity)){ //Should have more than needed in location inventory
							//Modify general inventory & location inventory quantity
//$_SESSION["log_data"] .= "Set <b>general inventory</b> item <b>" . $item . "</b> quantity to:" . ($gen_inv->val('quantity') + $quantity - $new_quantity) . " -- Previously: " . $gen_inv->val('quantity'). "<br>";
//$_SESSION["log_data"] .= "Set location <b>" . $location . "</b> item <b>" . $item . "</b> quantity to:" . ($loc_inv->val('quantity') + $quantity - $new_quantity) . " -- Previously: " . $loc_inv->val('quantity'). "<br>";
							$gen_inv->setValue('quantity',($gen_inv->val('quantity') + $quantity - $new_quantity));
							$loc_inv->setValue('quantity',($loc_inv->val('quantity') + $quantity - $new_quantity));
							$gen_inv->save();
							$loc_inv->save();
						}
						else
							return PEAR::raiseError('Exceeds Max Location Inventory',DATAFACE_E_NOTICE);
					}
					else
						return PEAR::raiseError('Exceeds Max Inventory',DATAFACE_E_NOTICE);
				}
			}
//$_SESSION["log_data"] .= "<br>--------------------------------<br><br>";
//exit(0);
//$gen_inv->save(null, true);
//$gen_inv->save();
//return PEAR::raiseError('END',DATAFACE_E_NOTICE);
			
		}
	}

	
	function beforeDelete(&$record){
		//Get record values
		$location = ($record->val('location') == "") ? "inv" : $record->val('location');
		$quantity = $record->val('quantity');
		$item = $record->val('inventory_id');

		//Modify the general inventory quantity
		$gen_inv = df_get_record('inventory', array('inventory_id'=>$item));
		$gen_inv->setValue('quantity',($gen_inv->val('quantity') + $quantity));
		$gen_inv->save();

		//If the location was not general inventory, modify it as well
		if($location != 'inv'){
			$loc_inv = df_get_record('vehicle_inventory', array('vehicle_id'=>$location,'inventory_id'=>$item));
			$loc_inv->setValue('quantity',($loc_inv->val('quantity') + $quantity));
			$loc_inv->save();
		}
	}
	
	
	//Calculated fields - for HTML Reports
	function field__item_cost($record){
		//If sale overide cost has been set in the call slip, use it
		if($record->val('sale_price') != null)
			return number_format($record->val('sale_price'),2);

		//Otherwise, pull the item / cost out of the 'inventory' table
		$inventory_record = df_get_record('inventory', array('inventory_id'=>$record->val('inventory_id')));
		
		//If item is set for cost overide, use 'sale_overide'
		if($inventory_record->val('sale_method') == "overide")
			return $inventory_record->val('sale_overide');
			
		//Otherwise, calculate the price from the sale average
		$customerRecord = df_get_record('customers', array('customer_id'=>$record->val('customer_id')));
		$markupRecords = df_get_records_array('customer_markup_rates', array('markup_id'=>$record->val('markup')));

		$purchase_price = $record->val('purchase_price');
		
		foreach ($markupRecords as $mr) {
			if($mr->val('to') == null)
				$no_limit = true;

			if( ($purchase_price >= $mr->val('from')) && ($purchase_price <= $mr->val('to') || $no_limit == true) ){
				$markup = $mr->val('markup_percent');
				break;
			}
		}

		$sale_price = number_format($purchase_price * (1+$markup),2,".","");
		
		return $sale_price;
	}

	function field__item_total($record){
		return number_format($record->val('sale_price') * $record->val('quantity'),2);
	}
	
}

?>