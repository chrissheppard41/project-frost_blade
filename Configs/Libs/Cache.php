<?php
/*
	@class Cache
	@author Chris Sheppard
	@desc handles the caching within the system
*/
class Cache {
	private static $cache = true;

/**
 * read method
 * Reads a cache file based on $config(folder) and $name(filename) and returns a array object
 *
 * @param $config (string), $name (string)
 * @return (Array)
 */
	public static function read($config, $name) {
		//chdir (ROOT);
		if (!self::$cache) return array();
		if (!file_exists(APP_ROOT . "tmp" . DS . "cache" . DS . $config . DS . $name)) return array();
		$filename = APP_ROOT . "tmp" . DS . "cache" . DS . $config . DS . $name;
		/*$threehours = 60*60*3;

		if((filemtime($filename)+$threehours) < time())
			return array();*/

		return include($filename);
	}

/**
 * write method
 * Writes a cache file based on $config(folder) and $name(filename) and ensures that the file is writable again
 *
 * @param $config (string), $name (string), $data (array)
 * @return (Array)
 */
	public static function write($config, $name, $data) {
		//chdir (ROOT);
		if (!file_exists(APP_ROOT . "tmp" . DS . "cache" . DS . $config))
			mkdir(APP_ROOT . "tmp" . DS . "cache" . DS . $config, 0777, true);

		$filename = APP_ROOT . "tmp" . DS . "cache" . DS . $config . DS . $name;
		$filew = fopen($filename, 'w');
		fwrite($filew, '<?php return '.var_export($data,true).';?>');
		fclose($filew);

		@chmod("$filename", 0777);
	}

/**
 * delete method
 * Deletes a cache file based on $config(folder) and $name(filename)
 *
 * @param $config (string), $name (string)
 * @return (Array)
 */
	public static function delete($config, $name) {
		//chdir (ROOT);
		$filename = APP_ROOT . "tmp" . DS . "cache" . DS . $config . DS . $name;
		if (file_exists($filename)) {
			if(file_exists($filename)) {
				unlink($filename);
			}
		}
	}

/**
 * deleteDir method
 * Deletes a cache folder based on $config(folder)
 *
 * @param $config (string)
 * @return (Array)
 */
	public static function deleteDir($config) {
		$filename = APP_ROOT . "tmp" . DS . "cache" . DS . $config;
		if (! is_dir($filename)) {
			throw new InvalidArgumentException("$filename must be a directory");
		}
		if (substr($filename, strlen($filename) - 1, 1) != '/') {
			$filename .= '/';
		}
		$files = glob($filename . '*', GLOB_MARK);
		foreach ($files as $file) {
			if (is_dir($file)) {
				self::deleteDir($file);
			} else {
				unlink($file);
			}
		}
		rmdir($filename);
		mkdir($filename, 0777);
	}

}
