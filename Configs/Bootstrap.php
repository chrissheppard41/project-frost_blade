<?php

Configure::write("Company.name", "Army Display tool");


if(isset($_SERVER['APPLICATION_ENV']) && !empty($_SERVER['APPLICATION_ENV'])) {

	$environment = $_SERVER['APPLICATION_ENV'];

	switch ($environment) {
		case 'dev':
			define("APP_ROOT");
			define('DEBUG_MODE', false);
			define('CRYPTKEY', "zB8Fznw/");
			break;
		case 'staging':
			define("APP_ROOT");
			define('DEBUG_MODE', false);
			define('CRYPTKEY', "+lCa4URU");
			break;
		case 'production':
			define("APP_ROOT");
			define('DEBUG_MODE', false);
			define('CRYPTKEY', "b+bBBPI8");
			break;
		case 'local':
		default:
			define("APP_ROOT", "C:".DS."www".DS."frost".DS);
			define('DEBUG_MODE', false);
			define('CRYPTKEY', "zB8Fznw/");
			break;
	}

} else {
	define("APP_ROOT", "C:".DS."www".DS."frost".DS);
	define('DEBUG_MODE', false);
	define('CRYPTKEY', "zB8Fznw/");
}