<?php //Main Application access point

//Default Sort Orders
$sort_order = parse_ini_file("conf/sort_order_defaults.ini");

if ( isset($sort_order[@$_REQUEST['-table']]) and !isset($_REQUEST['-sort']) and @$_REQUEST['-table'] == @$_REQUEST['-table'] ){
	$_REQUEST['-sort'] = $_GET['-sort'] = $sort_order[@$_REQUEST['-table']];
}


		
//require_once "../xataface-rc2.0.3/dataface-public-api.php";
//df_init(__FILE__, "../xataface-rc2.0.3");
require_once "../xataface/dataface-public-api.php";
df_init(__FILE__, "../xataface");
$app =& Dataface_Application::getInstance();
$app->display();

function isUser(){
    $auth =& Dataface_AuthenticationTool::getInstance();
    $user =& $auth->getLoggedInUser();
    if ( $user )  return true;
    return false;
}

function isAdmin(){
    $auth =& Dataface_AuthenticationTool::getInstance();
    $user =& $auth->getLoggedInUser();
    if ( $user and ($user->val('role') == 'ADMIN' or $user->val('role') == 'SYSTEM') )  return true;
    return false;
}

function myRole(){
	$auth =& Dataface_AuthenticationTool::getInstance();
	$user =& $auth->getLoggedInUser();
	return $user->val('role'); 
}

function userID(){
	$auth =& Dataface_AuthenticationTool::getInstance();
	$user =& $auth->getLoggedInUser();
	return $user->val('user_id'); 
}

function userName(){
	$auth =& Dataface_AuthenticationTool::getInstance();
	$user =& $auth->getLoggedInUser();
	return $user->val('username'); 
}

function get_userPerms($perm){
	$auth =& Dataface_AuthenticationTool::getInstance();
	$user =& $auth->getLoggedInUser();
	return $user->val($perm);
}

function default_location_state(){
	$app =& Dataface_Application::getInstance();
	$record = df_get_record('_company_info', array('id'=>1));
	return $record->val('state');
	//return "FL";
}

function company_name(){
	$app =& Dataface_Application::getInstance();
	$record = df_get_record('_company_info', array('id'=>1));
	return $record->val('name');
}

function company_address(){
	$app =& Dataface_Application::getInstance();
	$record = df_get_record('_company_info', array('id'=>1));
	$c_address['address'] = $record->val('address');
	$c_address['city'] = $record->val('city');
	$c_address['state'] = $record->val('state');
	$c_address['zip'] = $record->val('zip');
	return $c_address;
}

function company_phone(){
	$app =& Dataface_Application::getInstance();
	$record = df_get_record('_company_info', array('id'=>1));
	return $record->val('phone');
}

function company_fax(){
	$app =& Dataface_Application::getInstance();
	$record = df_get_record('_company_info', array('id'=>1));
	return $record->val('fax');
}

function company_county(){
	$app =& Dataface_Application::getInstance();
	$record = df_get_record('_company_info', array('id'=>1));
	$record_county = df_get_record('admin_county_tax', array('county_id'=>$record->val('county')));
	return $record_county->val('county');
}

function company_webaddress(){
	$app =& Dataface_Application::getInstance();
	$record = df_get_record('_company_info', array('id'=>1));
	return $record->val('web_address');
}

function url_data($url){
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	$data = curl_exec($ch);
	curl_close($ch);
	return $data;
}


//Transaction Functions

function df_transaction_begin(){ //Begin Transaction
	xf_db_query("BEGIN TRANSACTION",df_db()); //BEGIN
	xf_db_query("SET autocommit = 0",df_db()); //Set Autocommit to OFF -- Normally shouldn't have to set this explicitly, but it seems to be required for Xataface.
}
function df_transaction_commit(){ //Commit Transaction
	xf_db_query("COMMIT",df_db()); //COMMIT
	xf_db_query("SET autocommit = 1",df_db()); //Set Autocommit back to ON
}
function df_transaction_rollback(){ //Rollback Transaction
	xf_db_query("ROLLBACK",df_db()); //ROLLBACK
	xf_db_query("SET autocommit = 1",df_db()); //Set Autocommit back to ON
}





//Create General Ledger & Associated Journal Entries
//Return: 1 == success, -1 == record not created (permission error), -2 == malformed $journal_entry_array, -3 == partial entry created
function create_general_ledger_entry($journal_entry_array, $description = null){

	//Check to insure $journal_entry_array has all necessary information
	foreach($journal_entry_array as $key => $entry){
		if(!isset($entry['account_number'])) return -2;
		if(!(isset($entry['credit']) || isset($entry['debit']))) return -2;
	}
		
	//Create new General Ledger Entry
	$gl_record = new Dataface_Record('general_ledger', array());
	$gl_record->setValues(array(
		'ledger_date'=>date("Y-m-d"),
		'ledger_description'=>$description
	));

	//Save Record
	$res = $gl_record->save(null, true); //Save w/ permission check
	
	//Check for errors.
	if ( PEAR::isError($res) ){
		// An error occurred
		return -1;
	}

	//Parse through all journal entries and save
	foreach($journal_entry_array as $key => $entry){
		$glj_record = new Dataface_Record('general_ledger_journal', array());
		$glj_record->setValues(array(
			'ledger_id'=>$gl_record->val('ledger_id'),
			'date'=>date("Y-m-d"),
			'account_id'=>$entry['account_number'],
			'debit'=>isset($entry['debit']) ? $entry['debit'] : null,
			'credit'=>isset($entry['credit']) ? $entry['credit'] : null
		));

		//Save Record
		$res = $glj_record->save(); //Save w/o permission check - presumably if the first check passed, the user has permission to post payroll
	}


return 1;

}


//https://groups.google.com/forum/?fromgroups=#!topic/xataface/1aH8Q3rdcsc
//Quick and dirty method of pulling an htmlreport as text
//	$reportid - the 'report_id' field of the desired htmlreport
//	$record - the record containing the data for the report.
function getHTMLReport(Dataface_Record $record, $report_name){
	//Pull the appropriate HTML Report
	$report = df_get_record("dataface__htmlreports_reports", array("actiontool_name"=>'='.$report_name));
	//This works too...
	//	$mod = Dataface_ModuleTool::getInstance()->loadModule('modules_htmlreports');
	//	$report = $mod->getReportById($reportid);

	//Include XfHtmlReportBuilder.class.php
	require_once(dirname(__FILE__).'\modules\htmlreports\classes\XfHtmlReportBuilder.class.php');
	
	//Get the results from XfHtmlReportBuilder
	$results = '<style>' . XfHtmlReportBuilder::fillReportSingle($record, $report->val('template_css')) . '</style>';
	$results .= XfHtmlReportBuilder::fillReportSingle($record, $report->val('template_html'));

	return $results;
}
