<?php
namespace Frost\Configs;


/**
 *	@class Session
 *	@author Chris Sheppard
 *	@desc handles the session calls
 */
class Session {

/**
 * read method
 * Reads the session data based on the key
 *
 * @param $key (string)
 * @return (array)
 */
	public function read($key) {
		return Session_handler::read($_SESSION, $key);
	}

/**
 * write method
 * Writes to a session based on key and data
 *
 * @param $key (string), $data (mixin)
 * @return
 */
	public function write($key, $data) {
		$keys = explode(".", $key);
		$index = array_shift($keys);
		$_SESSION[$index] = Session_handler::write(array(), implode(".", $keys), $data);
	}

/**
 * delete method
 * Deletes a session based on a key
 *
 * @param $key (string)
 * @return
 */
	public function delete($key) {
		Session_handler::delete($_SESSION, $key);
	}
}
