<?php

/**
 *	@class Configure
 *	@author Chris Sheppard
 *	@desc handles the session calls
 */
class Configure {

	public static $url = array();
/**
 * read method
 * Reads the session data based on the key
 *
 * @param $key (string)
 * @return (array)
 */
	public static function read($key) {
		return \Frost\Configs\Session_handler::read($_SESSION, $key);
	}

/**
 * write method
 * Writes to a session based on key and data
 *
 * @param $key (string), $data (mixin)
 * @return
 */
	public static function write($key, $data) {
		$keys = explode(".", $key);
		$index = array_shift($keys);
		$_SESSION[$index] = \Frost\Configs\Session_handler::write(array(), implode(".", $keys), $data);
	}
/**
 * delete method
 * Deletes a session based on a key
 *
 * @param $key (string)
 * @return
 */
	public static function delete($key) {
		\Frost\Configs\Session_handler::delete($_SESSION, $key);
	}
/**
 * Auth method
 * Configures the Log in for a user
 *
 * @param $method (string)
 * @return (bool)
 */
	public static function Auth($data = null) {
		if(isset($data) && $data == null)
			\Configure::delete("Auth.user");
		else
			\Configure::write("Auth.user", $data);
	}
/**
 * Logged method
 * Checks to see if the user is logged in or not
 *
 * @param
 * @return (bool)
 */
	public static function Logged() {
		$user = self::read("Auth.user");

		if(isset($user) && !empty($user) && (count($user) > 0)) {
			return true;
		}
		return false;
	}
/**
 * User method
 * Checks Logged in User data
 *
 * @param $key (string)
 * @return
 */
	public static function User($field) {
		$user = self::read("Auth.user.".$field);
		if(isset($user)); {
			return $user;
		}
		return null;
	}
	/**
	 * awesome <pre> wrapper method
	 *
	 * @param ( mixed ) $data
	 * @param ( bool ) $doDie
	 * @return ( bool ) || ( void )
	 */
	public static function pre($data, $doDie = true) {
		echo "<pre>";

		if (is_array($data))
			print_r($data);
		else
			var_dump($data);

		echo "</pre>";

		if ($doDie) { die(); }

		return true;
	}
/**
 * Random_generation method
 * generates a random string
 *
 * @param $key (string)
 * @return
 */
	public static function Random_generation() {
		return substr( "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", mt_rand(0, 50) , 1) .substr( md5( time() ), 1);
	}

}
