<?php
namespace Frost\Configs;

/**
 *	@class Session_handler
 *	@author Chris Sheppard
 *	@desc handles the session calls
 */
class Session_handler {

/**
 * read method
 * Master reads the session data based on the key
 *
 * @param $key (string)
 * @return (array)
 */
	public static function read(array $source, $key) {
		$keys = explode(".", $key);

		foreach ($keys as $value) {
			if (is_array($source) && isset($source[$value])) {
				$source =& $source[$value];
			} else {
				return null;
			}
		}
		return $source;

	}

/**
 * write method
 * Master writes to the session data based on the key
 *
 * @param $key (string)
 * @return (array)
 */
	public static function write(array $source, $key, $data = array()) {
		$keys = explode(".", $key);

		if(count($keys) < 1 || $keys[0] == "")
			return $data;

		$index = array_shift($keys);
		$source[$index] = self::write(array(), implode(".", $keys), $data);

		return $source;
	}

/**
 * delete method
 * Master delete array from the session
 *
 * @param $key (string)
 * @return (array)
 */
	public static function delete(array &$source, $key) {
		$keys = explode(".", $key);

		$end = array_pop($keys);

		foreach ($keys as $value) {
			$source =& $source[$value];
		}

		unset($source[$end]);
	}
}
