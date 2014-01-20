<?php
namespace Frost\Configs;

/**
 *	@class Logging
 *	@author Chris Sheppard
 *	@desc handles the final response from the server when a player
 */
class Logging {

/**
 * Access method
 * Creates a access log everytime a user accesses the site
 *
 * @param
 * @return
 */
	public static function Access() {
		self::l_write("[".$_SERVER['REMOTE_ADDR']."] - ".date('Y-m-d H:i:s', time())." - ".$_SERVER['REQUEST_METHOD']." [".$_SERVER['REDIRECT_STATUS']."] ".$_SERVER['REQUEST_URI']." - ".$_SERVER['HTTP_USER_AGENT']);
	}

/**
 * Error method
 * Creates a error log everytime an error occurs on the website
 *
 * @param $message(string), $code(int), $trace(array)
 * @return
 */
	public static function Error($message, $code = 500, $trace = array()) {
		self::l_write("[".$_SERVER['REMOTE_ADDR']."] - ".date('Y-m-d H:i:s', time())." - ".$_SERVER['REQUEST_METHOD']." [".$code."] \n".$message."\n\n".$trace, "error");
	}

/**
 * l_write method
 * Manually gives the developer an ability to create a log within the site
 *
 * @param $message(string), $name(string)
 * @return
 */
	public static function l_write($message, $name = "access") {
		$filename = "tmp".DS."logs".DS.$name . ".log";
		$filew = fopen($filename, 'a');
	    fwrite($filew, $message."\n");
	    fclose($filew);

	    @chmod("$filename", 0777);
	}
}
