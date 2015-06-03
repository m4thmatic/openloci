<?php

class tables_vehicle_inventory {

	//Set the record title
		function getTitle(&$record){
			//Pull the name data
			$vehicle_record = df_get_record('vehicles', array('vehicle_id'=>$record->val('vehicle_id')));
			$inventory_record = df_get_record('inventory', array('inventory_id'=>$record->val('inventory_id')));

			return $vehicle_record->strval('vehicle_number') . " - " . $inventory_record->strval('item_name');
		}

}

?>