<?php
namespace Frost\Configs;

/**
 *	@class Logging
 *	@author Chris Sheppard
 *	@description handles the final response from the server when a player
 */
class Logging {

/**
 * [Creates a access log everytime a user accesses the site]
 */
	public static function Access() {
		self::l_write("[".$_SERVER['REMOTE_ADDR']."] - ".date('Y-m-d H:i:s', time())." - ".$_SERVER['REQUEST_METHOD']." [".$_SERVER['REDIRECT_STATUS']."] ".$_SERVER['REQUEST_URI']." - ".$_SERVER['HTTP_USER_AGENT']);
	}

/**
 * [Creates a error log everytime an error occurs on the website]
 * @param [string]  $message []
 * @param [integer] $code    []
 * @param [array]   $trace   []
 */
	public static function Error($message, $code = 500, $trace = array()) {
		self::l_write("[".$_SERVER['REMOTE_ADDR']."] - ".date('Y-m-d H:i:s', time())." - ".$_SERVER['REQUEST_METHOD']." [".$code."] \n".$message."\n\n".$trace, "error");
	}

/**
 * [Manually gives the developer an ability to create a log within the site]
 * @param  [type] $message []
 * @param  [string] $name    []
 */
	public static function l_write($message, $name = "access") {
		$filename = APP_ROOT."tmp".DS."logs".DS.$name . ".log";
		$filew = fopen($filename, 'a');
	    fwrite($filew, $message."\n");
	    fclose($filew);

	    @chmod("$filename", 0777);
	}
}
