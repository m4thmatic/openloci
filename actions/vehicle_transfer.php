<?php

class actions_vehicle_transfer {


	function handle(&$params){

		//Permission check
		if ( !isUser() )
			return Dataface_Error::permissionDenied("You are not logged in");
		
		if ( get_userPerms('vehicles') != "edit"){
			df_display(array("error"=>"permissions"), 'vehicle_transfer.html'); //Display page
			return 0;
		}
		
		$app =& Dataface_Application::getInstance();
		$query =& $app->getQuery();

		//Variables
		$from_id = isset($_GET['from_id']) ? $_GET['from_id'] : null;
		$to_id = isset($_GET['to_id']) ? $_GET['to_id'] : null;
		$status = isset($_GET['status']) ? $_GET['status'] : null;
		$error = null;
		
		//Pull Vehicle Data
		$vehicle_records = df_get_records_array("vehicles",array('use_as_location'=>'Y'));
		foreach($vehicle_records as $vehicle){
			$vehicles[$vehicle->val('vehicle_id')]["id"] = $vehicle->val('vehicle_id');
			$vehicles[$vehicle->val('vehicle_id')]["number"] = $vehicle->val('vehicle_number');
		}
		
		//Vehicle Selection Screen
		if($status == null){
			df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"vehicles"=>$vehicles), 'vehicle_transfer.html'); //Display page
		}
		
		//Inventory Selection Screen
		elseif($status == "transfer"){
			//Check for erroneous vehicle selection - If so, redisplay the Vehicle Selection Screen
			if( !(isset($vehicles[$from_id], $vehicles[$to_id])) ){ //If one or more of the vehicles hasn't been selected, or is invalid
				df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"vehicles"=>$vehicles,"error"=>"selection_invalid"), 'vehicle_transfer.html'); //Display page
				return 0;
			}
			elseif($from_id == $to_id){ //If the same vehicle is selected for both
				df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"vehicles"=>$vehicles,"error"=>"selection_same"), 'vehicle_transfer.html'); //Display page
				return 0;
			}
			
			//Pull from vehicle inventory
			$vehicle_inventory = df_get_records_array("vehicle_inventory",array('vehicle_id'=>$vehicles[$from_id]["id"]));
			foreach($vehicle_inventory as $inventory){
				$inventory_record = df_get_record('inventory',array('inventory_id'=>$inventory->val('inventory_id')));

				$v_inventory[$inventory->val('inventory_id')]["id"] = $inventory->val('inventory_id');
				$v_inventory[$inventory->val('inventory_id')]["quantity"] = $inventory->val('quantity');
				$v_inventory[$inventory->val('inventory_id')]["name"] = $inventory_record->val('item_name');
			}
			
			//Pull from vehicle tool inventory
			$vehicle_tools = df_get_records_array("vehicle_tools",array('vehicle_id'=>$vehicles[$from_id]["id"]));
			foreach($vehicle_tools as $tools){
				$tool_record = df_get_record('tool_inventory',array('tool_id'=>$tools->val('tool_id')));

				$v_tools[$tools->val('tool_id')]["id"] = $tools->val('tool_id');
				$v_tools[$tools->val('tool_id')]["quantity"] = $tools->val('quantity');
				$v_tools[$tools->val('tool_id')]["name"] = $tool_record->val('item_name');
			}

			df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"status"=>$status,"inventory"=>$v_inventory,"tools"=>$v_tools,"error"=>$error), 'vehicle_transfer.html'); //Display page
		}
		
//Check for errors: sanity (not negative, number), quantity is more than max (not assigned), item exists - if error, redisplay inventory selection - keep current selection and highlight error?
		elseif($status == "transferred"){

			if(isset($_GET['inventory'])){
				$quantities = $_GET['inv_quantity'];

				//Create Inventory Transfer Array
				foreach($_GET['inventory'] as $item){
					$inventory_record = df_get_record('inventory',array('inventory_id'=>$item));

					$inv_transfer[$item]['id'] = $item;
					$inv_transfer[$item]['name'] = $inventory_record->val('item_name');
					$inv_transfer[$item]['quantity'] = $quantities[$item];
				}

				//Transfer Inventory
				foreach($inv_transfer as $item){
					$transfer_record_from = df_get_record("vehicle_inventory", array("vehicle_id"=>$from_id,"inventory_id"=>$item['id']));
					$transfer_record_from->setValue('quantity', $transfer_record_from->val("quantity") - $item['quantity'] );
				
					$transfer_record_to = df_get_record("vehicle_inventory", array("vehicle_id"=>$to_id,"inventory_id"=>$item['id']));
					//If no record for the given vehicle / inventory item exists, then create a new one.
					if($transfer_record_to == null){
						$transfer_record_to = new Dataface_Record('vehicle_inventory', array());
						$transfer_record_to->setValues(array(
							'vehicle_id'=>$to_id,
							'inventory_id'=>$item["id"]
						));
					}
					$transfer_record_to->setValue('quantity', $transfer_record_to->val("quantity") + $item['quantity'] );
				}
				
				$res = $transfer_record_from->save();
				$res = $transfer_record_to->save();
			}
			
			if(isset($_GET['tool'])){
				$quantities = $_GET['tool_quantity'];

				//Create Tool Transfer Array
				foreach($_GET['tool'] as $item){
					$inventory_record = df_get_record('tool_inventory',array('tool_id'=>$item));

					$tool_transfer[$item]['id'] = $item;
					$tool_transfer[$item]['name'] = $inventory_record->val('item_name');
					$tool_transfer[$item]['quantity'] = $quantities[$item];
				}
			
				//Transfer Tools
				foreach($tool_transfer as $item){
					$transfer_record_from = df_get_record("vehicle_tools", array("vehicle_id"=>$from_id,"inventory_id"=>$item['id']));
					$transfer_record_from->setValue('quantity', $transfer_record_from->val("quantity") - $item['quantity'] );
				
					$transfer_record_to = df_get_record("vehicle_tools", array("vehicle_id"=>$to_id,"inventory_id"=>$item['id']));
					//If no record for the given vehicle / inventory item exists, then create a new one.
					if($transfer_record_to == null){
						$transfer_record_to = new Dataface_Record('vehicle_tools', array());
						$transfer_record_to->setValues(array(
							'vehicle_id'=>$to_id,
							'tool_id'=>$item["id"]
						));
					}
					$transfer_record_to->setValue('quantity', $transfer_record_to->val("quantity") + $item['quantity'] );
				}
				
				$res = $transfer_record_from->save();
				$res = $transfer_record_to->save();
			}
			
			//Create a Transfer Record
			//vehicle_transfer
				//date, transfer_from, transfer_to
			//vehicle_transfer_inventory(tools)
				//transfer_id, transfer_from, transfer_to, inventory_id(tool_id), quantity
			

			//Display the page
			df_display(array("veh_from"=>$vehicles[$from_id]["number"],"veh_to"=>$vehicles[$to_id]["number"],"status"=>$status,"inventory"=>$inv_transfer,"tools"=>$tool_transfer), 'vehicle_transfer.html');
		}
	}
}

?>
