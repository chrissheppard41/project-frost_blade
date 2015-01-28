<?php
error_reporting(E_ALL);
ini_set('display_errors', 'On');

date_default_timezone_set('Europe/Belfast');
//
DEFINE("PATH", dirname(__FILE__)."/");
DEFINE("LIVE", true);
require "./Configs/Core.php";


$core = new Frost\Configs\Core();

if(!LIVE && (isset($_GET['decrypt']) && ($_GET['decrypt'] == 1))) {
	echo $core->decr($core->load());
} else {
	echo $core->load();
}
exit();

