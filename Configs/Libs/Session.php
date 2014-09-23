<?php
namespace Frost\Configs;

/**
 *	@class Session
 *	@author Chris Sheppard
 *	@description handles the session calls
 */
class Session {

/**
 * [Reads the session data based on the key]
 * @param  [string] $key [Key is the index in the array]
 * @return [array]      []
 */
	public function read($key) {
		return Session_handler::read($_SESSION, $key);
	}

/**
 * [Writes to a session based on key and data]
 * @param  [string] $key  [where to save the data in the session]
 * @param  [array] $data [passed data into the session]
 */
	public function write($key, $data) {
		$keys = explode(".", $key);
		$index = array_shift($keys);
		$_SESSION[$index] = Session_handler::write(array(), implode(".", $keys), $data);
	}

/**
 * [Deletes a session based on a key]
 * @param  [string] $key [where to delete the data in the session]
 */
	public function delete($key) {
		Session_handler::delete($_SESSION, $key);
	}
}
