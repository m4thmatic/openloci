<?php

class tables_vehicle_transfer {

	//Permissions
		function getPermissions(&$record){
			//Check if the user is logged in & what their permissions for this table are.
			if( isUser() ){
				$userperms = get_userPerms('vehicles');
				if($userperms == "view")
					return Dataface_PermissionsTool::getRolePermissions("READ ONLY"); //Assign Read Only Permissions
				elseif($userperms == "edit"){
					//return Dataface_PermissionsTool::getRolePermissions(myRole()); //Assign Permissions based on user Role (typically USER)
					return Dataface_PermissionsTool::getRolePermissions("READ ONLY"); //Assign Read Only Permissions
				}
			}

			//Default: No Access
			return Dataface_PermissionsTool::NO_ACCESS();
		}
		
	//Set the record title
		function getTitle(&$record){
			return "Vehicle Transfer #" . $record->strval('transfer_id');
		}

	function section__details(&$record){
		$inventoryRecords = $record->getRelatedRecords('transfer_inventory');
		$toolRecords = $record->getRelatedRecords('transfer_tool_inventory');
		
		$childString .= '<b><u>Inventory Transferred</u></b><br><br>';
		$childString .= '<table class="view_add"><tr>
							<th>Inventory ID</th>
							<th>Item Name</th>
							<th>Quantity</th>
						</tr>';
						
		foreach($inventoryRecords as $i_record){
			$inventory_record = df_get_record("inventory", array("inventory_id"=>$i_record["inventory_id"]));
			$childString .= "<tr>
								<td>" . $i_record["inventory_id"] . "</td>
								<td>" . $inventory_record->val("item_name") . "</td>
								<td>" . $i_record["quantity"] . "</td>
							</tr>";
		}
		
		$childString .= "</table><br><br>";

		$childString .= '<b><u>Tools Transferred</u></b><br><br>';
		$childString .= '<table class="view_add"><tr>
							<th>Tool ID</th>
							<th>Item Name</th>
							<th>Quantity</th>
						</tr>';
						
		foreach($toolRecords as $i_record){
			$inventory_record = df_get_record("tool_inventory", array("tool_id"=>$i_record["tool_id"]));
			$childString .= "<tr>
								<td>" . $i_record["tool_id"] . "</td>
								<td>" . $inventory_record->val("item_name") . "</td>
								<td>" . $i_record["quantity"] . "</td>
							</tr>";
		}

		$childString .= "</table>";
		
		return array(
			'content' => "$childString",
			'class' => 'main',
			'label' => 'Transfer Details',
			'order' => 10
		);
	}
}

?>