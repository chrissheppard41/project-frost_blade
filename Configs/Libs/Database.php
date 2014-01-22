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
 * save method
 * Returns the SELECTs data values as an array object
 *
 * @param $querys (PDO::query)
 * @return (bool)
 */
	public function save($queries) {

		//echo "<pre>".print_r($queries, true)."</pre>";

		foreach($queries as $key => $value) {
			$sql = "INSERT INTO ".$key."(";
			$headers = array_keys($value[0]);
			$sql .= implode(",", $headers);
			$sql .= ") VALUES ";
			$inval = "";
			for($i = 0; $i < count($headers); $i++) {
				if($i < (count($headers)-1))
					$inval .= "?, ";
				else
					$inval .= "?";
			}
			$qPart = array_fill(0, count($value), "(".$inval.")");
			$sql .=  implode(",",$qPart);

			$q = $this->connection->prepare($sql);
			$i = 1;
			foreach($value as $item) { //bind the values one by one
				foreach($headers as $h) {
					$q->bindParam($i++, $item[$h]);
				}
			}
		}

		if(!$q->execute()) {
			throw new \PDOException("Bad error handler most likely something to do with the query string");
		}
	}

/**
 * update method
 * Returns the SELECTs data values as an array object
 *
 * @param $querys (PDO::query)
 * @return (bool)
 */
	public function update($queries) {

		//echo "<pre>".print_r($queries, true)."</pre>";

		foreach($queries as $key => $value) {
			$sql = "UPDATE ".$key." SET ";
			$where = "";
			$arr = array();
			foreach($value as $key2 => $data) {
				$i = 0;
				foreach($data['data'] as $head => $val) {
					if($i != 0) {
						$sql .= ", ";
					}
					$sql .= $head."=:".$head;
					$arr[":".$head] = $val;
					$i++;
				}
				$i = 0;
				foreach($data['condition'] as $head => $val) {
					if($i != 0) {
						$sql .= ", ";
					}
					$where .= $head."=:".$head;
					$arr[":".$head] = $val;
					$i++;
				}
				if($where != "") {
					$sql .= " WHERE ".$where;
				}
			}
			$query = array(
				"query" => $sql,
				"params" => $arr
			);

			if(!$this->query($query)) {
				throw new \PDOException("Bad error handler most likely something to do with the query string");
			}
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
