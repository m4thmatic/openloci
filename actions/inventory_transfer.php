<?php

class actions_inventory_transfer {


	function handle(&$params){

		//Permission check
		if ( !isUser() )
			return Dataface_Error::permissionDenied("You are not logged in");
		
		if ( get_userPerms('vehicles') != "edit" && (get_userPerms('inventory') != "edit" || get_userPerms('inventory') != "overide")){
			df_display(array("error"=>"permissions"), 'inventory_transfer.html'); //Display page
			return 0;
		}
		
		$app =& Dataface_Application::getInstance();
		$query =& $app->getQuery();

		//Variables
		$from_id = isset($_GET['from_id']) ? $_GET['from_id'] : null;
		$to_id = isset($_GET['to_id']) ? $_GET['to_id'] : null;
		$status = isset($_GET['status']) ? $_GET['status'] : null;
		$error = null;

		$vehicles['inv']["id"] = 'inv';
		$vehicles['inv']['number'] = "Inventory";
		
		//Pull Vehicle Data
		$vehicle_records = df_get_records_array("vehicles",array('use_as_location'=>'Y'));
		foreach($vehicle_records as $vehicle){
			$vehicles[$vehicle->val('vehicle_id')]["id"] = $vehicle->val('vehicle_id');
			$vehicles[$vehicle->val('vehicle_id')]["number"] = $vehicle->val('vehicle_number');
		}

		//Vehicle Selection Screen
		if($status == null){
			unset($_SESSION["transfer_status"]); //Reset transfer_status session variable - in case it hasn't already been.
			df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"vehicles"=>$vehicles), 'inventory_transfer.html'); //Display page
		}
		
		//Inventory Selection Screen
		elseif($status == "transfer"){
			//Check for erroneous vehicle selection - If so, redisplay the Vehicle Selection Screen
			if( !(isset($vehicles[$from_id], $vehicles[$to_id])) ){ //If one or more of the vehicles hasn't been selected, or is invalid
				df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"vehicles"=>$vehicles,"error"=>"selection_invalid"), 'inventory_transfer.html'); //Display page
				return 0;
			}
			elseif($from_id == $to_id){ //If the same vehicle is selected for both
				df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"vehicles"=>$vehicles,"error"=>"selection_same"), 'inventory_transfer.html'); //Display page
				return 0;
			}

			//Pull Inventory
			if($from_id == "inv"){ //If "Inventory" is selected
				//Get All Inventory
				$main_inventory = df_get_records_array("inventory", array('quantity'=>">0"));
				foreach($main_inventory as $inventory){
					//Get the quantity already assigned to vehicles, to subtract from available quantity
					$location_records = df_get_records_array('vehicle_inventory', array('inventory_id'=>$inventory->val('inventory_id')));
					$location_quantity = 0;
					foreach ($location_records as $location_record){
						$location_quantity += $location_record->val('quantity');
					}

					$v_inventory[$inventory->val('inventory_id')]["id"] = $inventory->val('inventory_id');
					$v_inventory[$inventory->val('inventory_id')]["quantity"] = $inventory->val('quantity') - $location_quantity;
					$v_inventory[$inventory->val('inventory_id')]["name"] = $inventory->val('item_name');
				}

				//Get All Tool Inventory
				$main_tools = df_get_records_array("tool_inventory", array('quantity'=>">0"));
				foreach($main_tools as $tools){
					//Get the quantity already assigned to vehicles, to subtract from available quantity
					$location_records = df_get_records_array('vehicle_tools', array('tool_id'=>$tools->val('tool_id')));
					$location_quantity = 0;
					foreach ($location_records as $location_record){
						$location_quantity += $location_record->val('quantity');
					}

					$v_tools[$tools->val('tool_id')]["id"] = $tools->val('tool_id');
					$v_tools[$tools->val('tool_id')]["quantity"] = $tools->val('quantity') - $location_quantity;
					$v_tools[$tools->val('tool_id')]["name"] = $tools->val('item_name');
				}
			}
			else{ //If a vehicle is selected
				//Pull from vehicle inventory
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
			}

			$_SESSION['transfer_status'] = "transfer"; //Set transfer_status session variable to "transfer".
			
			df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"from_n"=>$vehicles[$from_id]["number"],"to_n"=>$vehicles[$to_id]["number"],"status"=>$status,"inventory"=>$v_inventory,"tools"=>$v_tools,"error"=>$error), 'inventory_transfer.html'); //Display page
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
					//Get From Source Record
					if($from_id == "inv") //If from Inventory
						$inv_transfer_record_from[$item['id']] = df_get_record("inventory", array("inventory_id"=>$item['id']));
					else //If from Vehicle
						$inv_transfer_record_from[$item['id']] = df_get_record("vehicle_inventory", array("vehicle_id"=>$from_id,"inventory_id"=>$item['id']));
					
					//Sanity check
					//if(!is_numeric(trim($item['quantity'])))
					if(!is_numeric(trim($item['quantity'])))
						$error["inv"][$item["id"]] = "Not a Number";
					elseif($item['quantity'] < 0)
						$error["inv"][$item["id"]] = "Negative Number";
					elseif($item['quantity'] > $inv_transfer_record_from[$item['id']]->val("quantity"))
						$error["inv"][$item["id"]] = "Greater Than Maximum Availble";
					else{ //If no errors, proceed
						//If from "inventory", don't change the value (will show up automatically as "assigned"), otherwise subtract the transferred amount
						if($from_id != "inv")
							$inv_transfer_record_from[$item['id']]->setValue('quantity', $inv_transfer_record_from[$item['id']]->val("quantity") - $item['quantity'] );
						
						//Get To Source Record
						if($to_id == "inv"){ //If to Inventory
							$inv_transfer_record_to[$item['id']] = df_get_record("inventory", array("inventory_id"=>$item['id']));
							
							//Error check: If no record for the given item exists.
							if($inv_transfer_record_to[$item['id']] == null)
								$error["inv"][$item["id"]] = "Item Does Not Exist (this should never happen! see System Admin!)";
						//	else //Set Value
						//		$inv_transfer_record_to[$item['id']]->setValue('quantity', $inv_transfer_record_to[$item['id']]->val("quantity") + $item['quantity'] );
						}
						else{ //If to Vehicle
							$inv_transfer_record_to[$item['id']] = df_get_record("vehicle_inventory", array("vehicle_id"=>$to_id,"inventory_id"=>$item['id']));

							//If no record for the given vehicle / inventory item exists, then create a new one.
							if($inv_transfer_record_to[$item['id']] == null){
								$inv_transfer_record_to[$item['id']] = new Dataface_Record('vehicle_inventory', array());
								$inv_transfer_record_to[$item['id']]->setValues(array(
									'vehicle_id'=>$to_id,
									'inventory_id'=>$item["id"]
								));
							}
							$inv_transfer_record_to[$item['id']]->setValue('quantity', $inv_transfer_record_to[$item['id']]->val("quantity") + $item['quantity'] );
						}
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
					//Get From Source Record
					if($from_id == "inv") //If from Inventory
						$tool_transfer_record_from[$item['id']] = df_get_record("tool_inventory", array("tool_id"=>$item['id']));
					else //If from Vehicle
						$tool_transfer_record_from[$item['id']] = df_get_record("vehicle_tools", array("vehicle_id"=>$from_id,"tool_id"=>$item['id']));

					//Sanity check
					if(!is_numeric(trim($item['quantity'])))
						$error["tool"][$item["id"]] = "Not a Number";
					elseif($item['quantity'] < 0)
						$error["tool"][$item["id"]] = "Negative Number";
					elseif($item['quantity'] > $tool_transfer_record_from[$item['id']]->val("quantity"))
						$error["tool"][$item["id"]] = "Greater Than Maximum Availble";
					else{ //If no errors, proceed
						//If from "inventory", don't change the value (will show up automatically as "assigned"), otherwise subtract the transferred amount
						if($from_id != "inv")
							$tool_transfer_record_from[$item['id']]->setValue('quantity', $tool_transfer_record_from[$item['id']]->val("quantity") - $item['quantity'] );
						
						//Get To Source Record
						if($to_id == "inv"){ //If to Inventory
							$tool_transfer_record_to[$item['id']] = df_get_record("tool_inventory", array("tool_id"=>$item['id']));
							
							//Error check: If no record for the given item exists.
							if($tool_transfer_record_to[$item['id']] == null)
								$error["tool"][$item["id"]] = "Item Does Not Exist (this should never happen! see System Admin!)";
						//	else //Set Value
						//		$tool_transfer_record_to[$item['id']]->setValue('quantity', $tool_transfer_record_to[$item['id']]->val("quantity") + $item['quantity'] );
						}
						else{ //If to Vehicle
							$tool_transfer_record_to[$item['id']] = df_get_record("vehicle_tools", array("vehicle_id"=>$to_id,"tool_id"=>$item['id']));

							//If no record for the given vehicle / inventory item exists, then create a new one.
							if($tool_transfer_record_to[$item['id']] == null){
								$tool_transfer_record_to[$item['id']] = new Dataface_Record('vehicle_tools', array());
								$tool_transfer_record_to[$item['id']]->setValues(array(
									'vehicle_id'=>$to_id,
									'tool_id'=>$item["id"]
								));
							}
							$tool_transfer_record_to[$item['id']]->setValue('quantity', $tool_transfer_record_to[$item['id']]->val("quantity") + $item['quantity'] );
						}
					}
				}
			}
			
			if($inv_transfer == null && $tool_transfer == null)
				$error["none"] = "none";
			
			//*** Error Handling ***
			if($error != null){
				//echo "<pre>"; print_r($error); echo "</pre>";

				//Pull Inventory
				if($from_id == "inv"){ //If "Inventory" is selected
					//Get All Inventory
					$main_inventory = df_get_records_array("inventory", array('quantity'=>">0"));
					foreach($main_inventory as $inventory){
						//Get the quantity already assigned to vehicles, to subtract from available quantity
						$location_records = df_get_records_array('vehicle_inventory', array('inventory_id'=>$inventory->val('inventory_id')));
						$location_quantity = 0;
						foreach ($location_records as $location_record){
							$location_quantity += $location_record->val('quantity');
						}

						$v_inventory[$inventory->val('inventory_id')]["id"] = $inventory->val('inventory_id');
						$v_inventory[$inventory->val('inventory_id')]["quantity"] = $inventory->val('quantity') - $location_quantity;
						$v_inventory[$inventory->val('inventory_id')]["name"] = $inventory->val('item_name');
					}

					//Get All Tool Inventory
					$main_tools = df_get_records_array("tool_inventory", array('quantity'=>">0"));
					foreach($main_tools as $tools){
						//Get the quantity already assigned to vehicles, to subtract from available quantity
						$location_records = df_get_records_array('vehicle_tools', array('tool_id'=>$tools->val('tool_id')));
						$location_quantity = 0;
						foreach ($location_records as $location_record){
							$location_quantity += $location_record->val('quantity');
						}

						$v_tools[$tools->val('tool_id')]["id"] = $tools->val('tool_id');
						$v_tools[$tools->val('tool_id')]["quantity"] = $tools->val('quantity') - $location_quantity;
						$v_tools[$tools->val('tool_id')]["name"] = $tools->val('item_name');
					}
				}
				else{ //If a vehicle is selected
					//Pull from vehicle inventory
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
				}

				//unset($_SESSION["transfer_status"]); //Reset transfer_status session variable - in case it hasn't already been.
				$status = "transfer";

				//df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"from_n"=>$vehicles[$from_id]["number"],"to_n"=>$vehicles[$to_id]["number"],"status"=>$status,"error"=>$error), 'inventory_transfer.html'); //Display page
				df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"from_n"=>$vehicles[$from_id]["number"],"to_n"=>$vehicles[$to_id]["number"],"status"=>$status,"inventory"=>$v_inventory,"tools"=>$v_tools,"error"=>$error,"inv_transfer"=>$inv_transfer,"tool_transfer"=>$tool_transfer), 'inventory_transfer.html'); //Display page
				return 0;
			}
			//**********************
			
			if($_SESSION['transfer_status'] == "transfer"){ //Check session variable before save.
				//Save inventory transfer - NOTE: This could probably get combined with below, to save on processing time (wouldn't need multiple loops).
				if(isset($inv_transfer)){
					foreach($inv_transfer as $item){
						$res = $inv_transfer_record_from[$item['id']]->save();
						$res = $inv_transfer_record_to[$item['id']]->save();
					}
				}
				if(isset($tool_transfer)){
					foreach($tool_transfer as $item){
						$res = $tool_transfer_record_from[$item['id']]->save();
						$res = $tool_transfer_record_to[$item['id']]->save();
					}
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

			//Assign the appropriate name
			$from_name = ($from_id == "inv") ? "Inventory" : $vehicles[$from_id]["number"];
			$to_name = ($to_id == "inv") ? "Inventory" : $vehicles[$to_id]["number"];

			//Display the page
			if($_SESSION['transfer_status'] == "transfer") //Check session variable before displaying confirmation page.
				df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"from_name"=>$from_name,"to_name"=>$to_name,"status"=>$status,"inventory"=>$inv_transfer,"tools"=>$tool_transfer,"record_id"=>$vehicle_transfer_record->getID()), 'inventory_transfer.html');
			else //If not set, go back to the vehicle selection page.
				df_display(array("from_id"=>$from_id,"to_id"=>$to_id,"vehicles"=>$vehicles), 'inventory_transfer.html'); //Display page

			unset($_SESSION["transfer_status"]); //Reset transfer_status session variable.
		}
	}
}

?>
