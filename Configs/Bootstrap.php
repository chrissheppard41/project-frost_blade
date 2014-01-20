<?php

Configure::write("Company.name", "Army Tool");


if(isset($_SERVER['APPLICATION_ENV']) && !empty($_SERVER['APPLICATION_ENV'])) {

	$environment = $_SERVER['APPLICATION_ENV'];

	switch ($environment) {
		case 'dev':
			define('DEBUG_MODE', false);
			define('STARTDATE', strtotime('30-11-2013'));
			define('ENDDATE', strtotime('21-01-2014'));
			define('CRYPTKEY', "zB8Fznw/");
			break;
		case 'staging':
			define('DEBUG_MODE', false);
			define('STARTDATE', strtotime('30-11-2013'));
			define('ENDDATE', strtotime('21-01-2014'));
			define('CRYPTKEY', "+lCa4URU");
			break;
		case 'production':
			define('DEBUG_MODE', false);
			define('STARTDATE', strtotime('07-01-2014'));
			define('ENDDATE', strtotime('21-01-2014'));
			define('CRYPTKEY', "b+bBBPI8");
			break;
		case 'local':
		default:
			define('DEBUG_MODE', false);
			define('STARTDATE', strtotime('30-11-2013'));
			define('ENDDATE', strtotime('21-01-2014'));
			define('CRYPTKEY', "zB8Fznw/");
			break;
	}

} else {
	define('DEBUG_MODE', false);
	define('STARTDATE', strtotime('30-11-2013'));
	define('ENDDATE', strtotime('21-01-2014'));
	define('CRYPTKEY', "zB8Fznw/");
}