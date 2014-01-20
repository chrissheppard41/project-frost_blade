<?php
namespace Frost\Configs;

require "\Configs\Connection.php";
/*
	@class Database
	@author Chris Sheppard
	@desc handles the database connection, writing and quering from that database, the ablity to cache responses into folders
*/
class Database {
	public $connection = null;

	function __construct() {
		$this->connection = Connection::PDO();
		$this->connection->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
	}

/**
 * query method
 * The default method for quering tables within the databases (SELECT, INSERT, DROP, UPDATE etc)
 *
 * @param $query (array)
 * @return $q (PDO::query)
 */
	public function query($query) {
		/*echo "<pre>";
		print_r($query);
		echo "</pre>";*/

		if(empty($query['params'])) {
			$q = $this->connection->prepare($query['query']);
			$q->execute();
		} else {
			$q = $this->connection->prepare($query['query']);
			if($q) {
				$res = $q->execute($query['params']);

				if ($res === FALSE)	{
					throw new \PDOException($q->errorInfo());
				}
			} else {
				throw new \PDOException("Bad error handler most likely something to do with the query string");
			}
		}

		return $q;
	}

/**
 * returnCount method
 * Returns the SELECT row count (only works for queries)
 *
 * @param $query (PDO::query)
 * @return (int)
 */
	public function returnCount($query) {
		return $query->rowCount();
	}

/**
 * returnLastId method
 * Returns the INSERT/UPDATE last inserted ID
 *
 * @param $query (PDO::query)
 * @return (int)
 */
	public function returnLastId($query) {
		return $this->connection->lastInsertId();
	}

/**
 * results method
 * Returns the SELECTs data values as an array object
 *
 * @param $query (PDO::query)
 * @return (Array)
 */
	public function results($query) {
		if(@$query) {
			return $query->fetchAll(\PDO::FETCH_ASSOC);
		}
	}


/**
 * c_read method
 * Reads a cache file based on $config(folder) and $name(filename) and returns a array object
 *
 * @param $config (string), $name (string)
 * @return (Array)
 */
	public function c_read($config, $name) {
		if(LIVE) {
			$filename = "tmp" . DS . "cache" . DS . $config . DS . $name;
			$data = null;

			if($filer = @fopen($filename, 'r')) {
				$data = fread($filer, filesize($filename));
				fclose($filer);
				return unserialize($data);
			} else {
				return array();
			}

		} else {
			return array();
		}
	}

/**
 * c_write method
 * Writes a cache file based on $config(folder) and $name(filename) and ensures that the file is writable again
 *
 * @param $config (string), $name (string), $data (array)
 * @return (Array)
 */
	public function c_write($config, $name, $data) {
		if(LIVE) {
			$filename = "tmp" . DS . "cache" . DS . $config . DS . $name;
			$filew = fopen($filename, 'w');
		    fwrite($filew, serialize ($data));
		    fclose($filew);

		    @chmod("$filename", 0777);
		}
	}

/**
 * c_delete method
 * Deletes a cache file based on $config(folder) and $name(filename)
 *
 * @param $config (string), $name (string)
 * @return (Array)
 */
	public function c_delete($config, $name) {
		if(LIVE) {
			$filename = "tmp" . DS . "cache" . DS . $config . DS . $name;
			if(file_exists($_SERVER['DOCUMENT_ROOT']. DS .$filename)) {
				unlink($filename);
			}
		}
	}
}
