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
	public function Save($queries) {

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
 * Generates a update method
 *
 * @param $querys (PDO::query)
 * @return (bool)
 */
	public function Update($queries) {

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
 * Find method
 * Returns the SELECTs data values as an array object
 *
 * @param $querys (PDO::query)
 * @return (bool)
 */
	public function Find($format, $queries) {

		//echo "<pre>".print_r($queries, true)."</pre>";
		$output = array();

		foreach($queries as $table => $query) {
			foreach($query as $headers => $data) {
				$where = "";
				$arr = array();
				$sql = "SELECT ";
				$sql .= implode(",", array_values($data['fields']));

				$i = 0;
				if(isset($data['condition'])) {
					foreach($data['condition'] as $head => $val) {
						if($head == "or") {
							foreach($val as $heador => $valor) {
								if($i != 0) {
									$where .= " OR ";
								}
								$where .= $heador."=:".$heador;
								$arr[":".$heador] = $valor;
								$i++;
							}
						} else {
							if($i != 0) {
								$where .= " AND ";
							}
							$where .= $head."=:".$head;
							$arr[":".$head] = $val;
							$i++;
						}

					}
				}

				$sql .= " FROM ".strtolower($table)."";
				if($where != "") {
					$sql .= " WHERE ".$where;
				}

				if($format == "pagination") {
					$page_count = ((isset($data['pagination']))?$data['pagination']:10);
					$page = $this->Page($page_count);
					if(isset($page[1])) {
						$sql .= " ORDER BY ".$page[1]." ".$page[2]."";
					}
					$sql .= " LIMIT ".((int)$page[0]*$page_count).",".(int)$page_count."";
				}
				$sql .= ";";

				$q = array(
					"query" => $sql,
					"params" => $arr
				);
				if($results = $this->results($this->query($q))) {
					if($format == "first") {
						$output[$table] = $results[0];
					} else if($format == "group") {
						$output[$table][] = $results;
					} else if($format == "pagination") {
						$output[$table] = $results;
					} else {
						$output[$table] = $results;
					}

				} else {
					$output[$table][] = null;
				}
			}
		}
		return $output;

	}
/**
 * Delete method
 * Deletes a entry or group of entries based on given ID's
 *
 * @param $key (string)
 * @return
 */
	public function Delete($queries) {

		//echo "<pre>".print_r($queries, true)."</pre>";
		foreach($queries as $table => $query) {
			$arr = array();
			$sql = "DELETE FROM ".strtolower($table)."";

			if(count($query) > 0) {
				$sql .= " WHERE";
				foreach($query as $column => $list) {
					$i = 0;
					foreach($list as $key => $value) {
						if($i != 0) {
							$sql .= " OR";
						}
						$sql .= ' '.$column.' = :'.'key_'.$key;
						$arr[':key_'.$key] = $value;

						$i++;
					}
				}
			}
			$sql .= ";";

			$q = array(
				"query" => $sql,
				"params" => $arr
			);
			if(!$this->query($q)) {
				throw new \PDOException("Bad error handler most likely something to do with the query string");
			}
		}
	}

/**
 * Page method
 * Gets the current page for pagination by reading the url
 *
 * @param $key (string)
 * @return
 */
	public function Page($page_count) {
		$index = count(\Configure::$url['param'])-1;
		if($index != -1) {

			$arr 				= preg_split("/(Pag:|:)/",\Configure::$url['param'][$index]);
			\Configure::$url['param'][$index] .= ":".$page_count;

			if(count($arr) >= 2) {
				$column = (isset($arr[2]))?$arr[2]:null;
				$order = (isset($arr[3]))?$arr[3]:"ASC";
				return array($arr[1],$column,$order);
			}

		}
		\Configure::$url['param'][] .= "Pag:0:".$page_count;
		return array(0,null,null);
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
