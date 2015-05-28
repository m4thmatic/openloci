<?php

class tables_vehicles {

	//Permissions
		function getPermissions(&$record){
			//Check if the user is logged in & what their permissions for this table are.
			if( isUser() ){
				$userperms = get_userPerms('vehicles');
				if($userperms == "view")
					return Dataface_PermissionsTool::getRolePermissions("READ ONLY"); //Assign Read Only Permissions
				elseif($userperms == "edit"){
					return Dataface_PermissionsTool::getRolePermissions(myRole()); //Assign Permissions based on user Role (typically USER)
				}
			}

			//Default: No Access
			return Dataface_PermissionsTool::NO_ACCESS();
		}

	function rel_vehicle_purchase_history__permissions($record){
		return array(
			'add new related record' => 0,
			'add existing related record' => 0,
			'remove related record' => 0,
			'delete related record' => 0			
		);
	}
	
	
	function block__before_record_actions(){
		$app =& Dataface_Application::getInstance(); 
		$record =& $app->getRecord();

		if(get_userPerms('vehicles') == "edit")
			echo '	<div class="dataface-view-record-actions">
						<ul>
							<li id="transfer_inventory" class="plain">
								<a class="" id="transfer_inventory-link" href="'.$app->url('-action=vehicle_transfer&from_id='.$record->val("vehicle_id")).'">
									<img id="transfer_inventory-icon" src="images/inventory_icon.png" alt="Transfer Inventory">
									<span class="action-label">Transfer Inventory / Tools</span>
								</a>
							</li>
						</ul>
					</div>';
	}
}

?>