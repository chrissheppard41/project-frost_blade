<?php

/**
 *	@class Configure
 *	@author Chris Sheppard
 *	@description handles the session calls
 */
class Configure {

	public static $url = array();

/**
 * [Reads the session data based on the key]
 * @param  [string] $key [the key inputed to search the $_SESSION with]
 * @return [data]      [data from the session]
 */
	public static function read($key) {
		return \Frost\Configs\Session_handler::read($_SESSION, $key);
	}

/**
 * [Writes to a session based on key and data]
 * @param  [string] $key  [Where to save the data in the SESSION]
 * @param  [array] $data [the data to be saved into SESSION]
 */
	public static function write($key, $data) {
		$keys = explode(".", $key);
		$index = array_shift($keys);
		$_SESSION[$index] = \Frost\Configs\Session_handler::write(array(), implode(".", $keys), $data);
	}

/**
 * [Deletes a session based on a key]
 * @param  [string] $key [Where to delete SESSION]
 */
	public static function delete($key) {
		\Frost\Configs\Session_handler::delete($_SESSION, $key);
	}

/**
 * [Configures the Log in for a user]
 * @param [array] $data [description]
 */
	public static function Auth($data = null) {
		if(isset($data) && $data == null)
			\Configure::delete("Auth.user");
		else
			\Configure::write("Auth.user", $data);
	}

/**
 * [Checks to see if the user is logged in or not]
 * @return [boolean]
 */
	public static function Logged() {
		$user = self::read("Auth.user");

		if(isset($user) && !empty($user) && (count($user) > 0)) {
			return true;
		}
		return false;
	}

/**
 * [Checks Logged in User data]
 * @param [string] $field [Based on Session get data on user]
 */
	public static function User($field) {
		$user = self::read("Auth.user.".$field);
		if(isset($user)); {
			return $user;
		}
		return null;
	}

/**
 * [awesome <pre> wrapper method]
 * @param [mixed]  $data
 * @param [boolean]  $doDie
 * @return [boolean]  ||  [void]
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
 * [generates a random string]
 * @return  [string] []
 */
	public static function Random_generation() {
		return substr( "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", mt_rand(0, 50) , 1) .substr( md5( time() ), 1);
	}

/**
 * [recursive method to search multidimensional  arrays]
 * @param  [string]  $needle   []
 * @param  [array]  $haystack []
 * @param  [string]  $field    []
 * @param  [boolean] $strict   []
 * @return [boolean]            []
 */
	public static function in_array_r($needle, $haystack, $field = null, $strict = false) {
		if(!empty($haystack)) {
			if(is_array($haystack)) {
				foreach ($haystack as $key => $item) {
					if($field === null) {
						if (($strict ? $item === $needle : $item == $needle) || (is_array($item) && self::in_array_r($needle, $item, $field, $strict))) {
							return true;
						}
					} else {
						if(($key == $field && ($strict ? $item === $needle : $item == $needle)) || (is_array($item) && self::in_array_r($needle, $item, $field, $strict))) {
							return true;
						}
					}

				}
			}
		}

		return false;
	}

}
