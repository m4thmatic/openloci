<?php

class tables_inventory {


	//Permissions
	function getPermissions(&$record){
		//Check if the user is logged in & what their permissions for this table are.
		if( isUser() ){
			$userperms = get_userPerms('inventory');
			if($userperms == "view")
				return Dataface_PermissionsTool::getRolePermissions("READ ONLY"); //Assign Read Only Permissions
			elseif($userperms == "edit" || $userperms == "overide"){
				$perms = Dataface_PermissionsTool::getRolePermissions(myRole()); //Assign Permissions based on user Role (typically USER)
				unset($perms['delete']);
				return $perms;
			}
		}

		//Default: No Access
		return Dataface_PermissionsTool::NO_ACCESS();
	}
	
	function rel_inventory_purchase_history__permissions($record){
		return array(
			'add new related record' => 0,
			'add existing related record' => 0,
			'remove related record' => 0,
			'delete related record' => 0			
		);
	}
	function rel_inventory_locations__permissions($record){
		return array(
			'add new related record' => 0,
			'add existing related record' => 0,
			'remove related record' => 0,
			'delete related record' => 0			
		);
	}
	
	
	
	
	function block__before_record_actions(){
		$app =& Dataface_Application::getInstance(); 
	//	$record =& $app->getRecord();

		if(get_userPerms('inventory') == "overide")
			echo '	<div class="dataface-view-record-actions">
						<ul>
							<li id="inventory_overide" class="plain">
								<a class="" id="inventory_overide-link" href="'.$app->url('-action=inventory_overide').' title="" data-xf-permission="view">
									<img id="inventory_overide-icon" src="images/report_icon.png" alt="Adjust Quantity">
									<span class="action-label">Adjust Quantity</span>
								</a>
							</li>
						</ul>
					</div>';

		//Prompt.
		echo '	<script>
					jQuery("#inventory_overide").click(function(){
						return confirm("NOTICE: You are about to edit the inventory quantity. Do you wish to proceed?");
					});
				</script>';
	}
	
	
/*	function block__after_rate_label_widget(){
		echo '<table class="rate_codes"><tr><td>';
	}

	function block__after_supr_tt_widget(){
		echo '</td></tr></table>';
	}
*/

/*	function rate_data__renderCell(&$record){
		$result = '<table class="rate_codes">';
		foreach ( $record->val('rate_data') as $vals){ $result .= '<tr><th>' . $vals['type'] . '</th><th>' . $vals['rate'] . '</th></tr>'; };
		$result .= "</table>";

		return $result;
	}

	function rate_data__htmlValue(&$record){
		$result = '<table class="rate_codes">';
		foreach ( $record->val('rate_data') as $vals){ $result .= '<tr><th>' . $vals['type'] . '</th><th>' . $vals['rate'] . '</th></tr>'; };
		$result .= "</table>";

		return $result;
	}
*/	

	function status__display(&$record){
		if($record->val("status") == "Active")
			return "";
		return $record->val("status");
	}

	function quantity__display(&$record){
		$quantity = explode('.',$record->val('quantity'));
		if($quantity[1] != 0)
			$quantity[1] = '.'.$quantity[1];
		else
			$quantity[1] = '';

		return $quantity[0] . rtrim($quantity[1],0);
	}

	function vehicle_quantity__display(&$record){
		$location_records = $record->getRelatedRecords('inventory_locations');
		$location_quantity = 0;
		foreach ($location_records as $location_record){
			$location_quantity += $location_record['quantity'];
		}
		
		//If 0, show blank
		$location_quantity = ($location_quantity == 0) ? "" : $location_quantity;

		return rtrim($location_quantity);
	}

	function stock_quantity__display(&$record){
		$location_records = $record->getRelatedRecords('inventory_locations');
		$location_quantity = 0;
		foreach ($location_records as $location_record){
			$location_quantity += $location_record['quantity'];
		}
		
		//If 0, show blank
		$location_quantity = ($location_quantity == 0) ? "" : $location_quantity;

		return rtrim($record->val('quantity') - $location_quantity);
	}
	
	function beforeSave(&$record){
		//Update Average Purchase Price
			$purchase_history_records = $record->getRelatedRecords('inventory_purchase_history');

			$purchase_total = 0;
			$count = 0;

			foreach($purchase_history_records as $purchase_history_record){
				$count++;
				$purchase_total += $purchase_history_record['purchase_price'];
				if($count == 10)
					break;
			}

			if($count > 0){
				$average = number_format($purchase_total / $count, 2);
				$record->setValue('average_purchase',$average);
			}
	}
	
	function beforeInsert(&$record){
			$record->setValue('last_purchase',0);
			$record->setValue('average_purchase',0);
	}
	
	function inStock($record){
		//Check to insure $record exists
		if($record == null)
			return -1;
	
		$location_records = $record->getRelatedRecords('inventory_locations');
		$location_quantity = 0;
		foreach ($location_records as $location_record){
			$location_quantity += $location_record['quantity'];
		}
		
		return $record->val('quantity') - $location_quantity;
	}
}

?>