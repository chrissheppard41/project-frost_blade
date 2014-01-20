<?php

/**
 *	@class Configure
 *	@author Chris Sheppard
 *	@desc handles the session calls
 */
class Configure {

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

}
