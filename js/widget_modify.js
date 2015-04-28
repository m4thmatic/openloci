//require <jquery.packed.js>
//require <xatajax.form.core.js>

//modifier: The widget to check data from
//modify: The widget to change
//table: The table to query
//data_field: The field to pull data from
function widget_modify(modifier, modify, table, data_field){
	var $ = jQuery;
	var findField = XataJax.form.findField;
	
	var fields = {
		modifier_field : findField(this, modifier),
		modify_field : findField(this, modify)
	};

	var q = {
		'-action' : 'export_json',
		'-table' : table,
		'-limit' : 1,
		'-mode' : 'browse',
		modifier : '',
		'--fields' : data_field
	};

	if ( $(fields.modifier_field).val() ){
		q[modifier] = '='+$(fields.modifier_field).val();
	}
			
	$.get(DATAFACE_SITE_HREF, q, function(res){
		if ( res ){
			$(fields.modify_field).val(res[0][data_field]);	
		} else {
			alert('Warning: No data in ' + data_field + ' was found.');
		}
	});
	
}