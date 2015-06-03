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
			unset($_SESSION["transfer_status"]); //Reset transfer_status session variable - in case it hasn't already been.
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
			//$vehicle_inventory = df_get_records_array("vehicle_inventory",array('vehicle_id'=>$vehicles[$from_id]["id"], 'quantity'=>">0"));
			$vehicle_inventory = df_get_records_array("vehicle_inventory",array('vehicle_id'=>$from_id, 'quantity'=>">0"));
			foreach($vehicle_inventory as $inventory){
				$inventory_record = df_get_record('inventory',array('inventory_id'=>$inventory->val('inventory_id')));

				$v_inventory[$inventory->val('inventory_id')]["id"] = $inventory->val('inventory_id');
				$v_inventory[$inventory->val('inventory_id')]["quantity"] = $inventory->val('quantity');
				$v_inventory[$inventory->val('inventory_id')]["name"] = $inventory_record->val('item_name');
			}
			
			//Pull from vehicle tool inventory
			//$vehicle_tools = df_get_records_array("vehicle_tools",array('vehicle_id'=>$vehicles[$from_id]["id"], 'quantity'=>">0"));
			$vehicle_tools = df_get_records_array("vehicle_tools",array('vehicle_id'=>$from_id, 'quantity'=>">0"));
			foreach($vehicle_tools as $tools){
				$tool_record = df_get_record('tool_inventory',array('tool_id'=>$tools->val('tool_id')));

				$v_tools[$tools->val('tool_id')]["id"] = $tools->val('tool_id');
				$v_tools[$tools->val('tool_id')]["quantity"] = $tools->val('quantity');
				$v_tools[$tools->val('tool_id')]["name"] = $tool_record->val('item_name');
			}

			$_SESSION['transfer_status'] = "transfer"; //Set transfer_status session variable to "transfer".
			
			df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"from_n"=>$vehicles[$from_id]["number"],"to_n"=>$vehicles[$to_id]["number"],"status"=>$status,"inventory"=>$v_inventory,"tools"=>$v_tools,"error"=>$error), 'vehicle_transfer.html'); //Display page
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
					$inv_transfer_record_from = df_get_record("vehicle_inventory", array("vehicle_id"=>$from_id,"inventory_id"=>$item['id']));
					
					//Sanity check
					if($item['quantity'] < 0)
						$error["inv"][$item["id"]] = "neg";
					elseif($item['quantity'] > $inv_transfer_record_from->val("quantity"))
						$error["inv"][$item["id"]] = "max";
					else{
						$inv_transfer_record_from->setValue('quantity', $inv_transfer_record_from->val("quantity") - $item['quantity'] );
						$inv_transfer_record_to = df_get_record("vehicle_inventory", array("vehicle_id"=>$to_id,"inventory_id"=>$item['id']));
						//If no record for the given vehicle / inventory item exists, then create a new one.
						if($inv_transfer_record_to == null){
							$inv_transfer_record_to = new Dataface_Record('vehicle_inventory', array());
							$inv_transfer_record_to->setValues(array(
								'vehicle_id'=>$to_id,
								'inventory_id'=>$item["id"]
							));
						}
						$inv_transfer_record_to->setValue('quantity', $inv_transfer_record_to->val("quantity") + $item['quantity'] );
					}
				}
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
					$tool_transfer_record_from = df_get_record("vehicle_tools", array("vehicle_id"=>$from_id,"inventory_id"=>$item['id']));

					//Sanity check
					if($item['quantity'] < 0)
						$error["tool"][$item["id"]] = "neg";
					elseif($item['quantity'] > $tool_transfer_record_from->val("quantity"))
						$error["tool"][$item["id"]] = "max";
					else{
						$tool_transfer_record_from->setValue('quantity', $tool_transfer_record_from->val("quantity") - $item['quantity'] );
					
						$tool_transfer_record_to = df_get_record("vehicle_tools", array("vehicle_id"=>$to_id,"inventory_id"=>$item['id']));
						//If no record for the given vehicle / inventory item exists, then create a new one.
						if($tool_transfer_record_to == null){
							$tool_transfer_record_to = new Dataface_Record('vehicle_tools', array());
							$tool_transfer_record_to->setValues(array(
								'vehicle_id'=>$to_id,
								'tool_id'=>$item["id"]
							));
						}
						$tool_transfer_record_to->setValue('quantity', $tool_transfer_record_to->val("quantity") + $item['quantity'] );
					}
				}
			}
			
			//****************************************
			if($error != null){
				print_r($error);
				//df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"from_n"=>$vehicles[$from_id]["number"],"to_n"=>$vehicles[$to_id]["number"],"status"=>$status,"error"=>$error), 'vehicle_transfer.html'); //Display page
				echo "fail";
				return 0;
			}
			//****************************************
			
			if($_SESSION['transfer_status'] == "transfer"){ //Check session variable before save.
				if(isset($inv_transfer)){
					$res = $inv_transfer_record_from->save();
					$res = $inv_transfer_record_to->save();
				}
				if(isset($tool_transfer)){
					$res = $tool_transfer_record_from->save();
					$res = $tool_transfer_record_to->save();
				}
				
				//Create a Vehicle Transfer Record
					$vehicle_transfer_record = new Dataface_Record('vehicle_transfer', array());
					$vehicle_transfer_record->setValues(array(
						'date'=>date("Y-m-d"),
						'transfer_from'=>$from_id,
						'transfer_to'=>$to_id
					));
					$res = $vehicle_transfer_record->save();

				//Create Vehicle Inventory Transfer Record
				foreach($inv_transfer as $item){
					$vehicle_transfer_inv_record = new Dataface_Record('vehicle_transfer_inventory', array());
					$vehicle_transfer_inv_record->setValues(array(
						'transfer_id'=>$vehicle_transfer_record->val("transfer_id"),
						'transfer_from'=>$from_id,
						'transfer_to'=>$to_id,
						'inventory_id'=>$item['id'],
						'quantity'=>$item['quantity']
					));
					$res = $vehicle_transfer_inv_record->save();
				}

				//Create Vehicle Tool Transfer Record
				foreach($tool_transfer as $item){
					$vehicle_transfer_tool_record = new Dataface_Record('vehicle_transfer_tools', array());
					$vehicle_transfer_tool_record->setValues(array(
						'transfer_id'=>$vehicle_transfer_record->val("transfer_id"),
						'transfer_from'=>$from_id,
						'transfer_to'=>$to_id,
						'tool_id'=>$item['id'],
						'quantity'=>$item['quantity']
					));
					$res = $vehicle_transfer_tool_record->save();
				}
			}

			//Display the page
			if($_SESSION['transfer_status'] == "transfer") //Check session variable before displaying confirmation page.
				df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"veh_from"=>$vehicles[$from_id]["number"],"veh_to"=>$vehicles[$to_id]["number"],"status"=>$status,"inventory"=>$inv_transfer,"tools"=>$tool_transfer), 'vehicle_transfer.html');
			else //If not set, go back to the vehicle selection page.
				df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"vehicles"=>$vehicles), 'vehicle_transfer.html'); //Display page

			unset($_SESSION["transfer_status"]); //Reset transfer_status session variable.
		}
	}
}

?>
