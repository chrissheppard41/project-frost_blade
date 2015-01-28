<?php
namespace Frost\Configs;

require PATH."Configs/Connection.php";
/*
 * @class Database
 * @author Chris Sheppard
 * @description handles the database connection, writing and quering from that database, the ablity to cache responses into folders
 */
class Database {
	public $connection = null;
	protected $table = null;
	protected $validation = array();
	public $post = array();

	protected $relationships = array();
	public $last_id = 0;

	function __construct() {
		$this->connection = Connection::PDO();
		$this->connection->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
		//$this->connection->setAttribute(\PDO::ATTR_STRINGIFY_FETCHES, false);
	}

/**
 * [The default method for quering tables within the databases (SELECT, INSERT, DROP, UPDATE etc)]
 * @param  [array] $query [query from system]
 * @return [PDO::query]        []
 */
	public function query($query) {
		//\Configure::pre($query, false);

		if(empty($query['params'])) {
			$q = $this->connection->prepare($query['query']);
			$q->execute();
		} else {
			$q = $this->connection->prepare($query['query']);
			if($q) {
				$q->execute($query['params']);
			}
		}

		return $q;
	}

/**
 * [Returns the SELECT row count (only works for queries)]
 * @param  [PDO::query] $query [pdo query]
 * @return [int]        [0 = false, 1 = true]
 */
	public function returnCount($query) {
		return $query->rowCount();
	}

/**
 * [Returns the INSERT/UPDATE last inserted ID]
 * @return [int] [the last inserted id]
 */
	public function returnLastId() {
		return $this->connection->lastInsertId();
	}

/**
 * [results description]
 * @param  [PDO::query] $query [query insert for results]
 * @return [array]        [the results from the data]
 */
	public function results($query) {
		return $query->fetchAll(\PDO::FETCH_ASSOC);
	}

/**
 * [Returns the SELECTs data values as an array object]
 * @param [array] $queries [array to be saved]
 * @return [array]        [whether it was saved or not]
 */
	public function Save($queries = array()) {
		if(isset($queries) && !empty($queries))
			$this->post = $queries;

		if(isset($this->post['_Token']))
			unset($this->post['_Token']);

		$table = ucfirst($this->table);
		foreach($this->post as $key => $value) {
			$returnval = null;

			if(isset($value[0])) {
				$returnval = $this->deepsave($key, $value, 0, $this->relationships);
			} else {
				$returnval = $this->shallowsave($key, $value);
			}
			if(isset($returnval["error"])) {
				return $returnval;
			}
		}
		return true;
	}

/**
 * [A method that handles the datagrouping conditions]
 * @param  [string] $table [tabel to be saved into]
 * @param  [string] $value [value to be saved]
 * @param  [int] $id    [related save last inserted ID]
 */
	private function relatedsave($table, $value, $id) {
		$query = array(
			"query" => "",
			"params" => array()
		);
		$query["query"] = "INSERT INTO ".strtolower($this->relationships[$table]["linktable"])." (".
			$this->relationships[$table]["linkColumn"].", ".
			$this->relationships[$table]["baseColumn"].", ".
			"created, ".
			"modified) VALUES ";
		$i = 0;

		if(is_array($value)) {
			foreach($value as $val) {
				if($i != 0) $query["query"] .= ", ";

				$query["query"] .= "(".
					":".$i.$this->relationships[$table]["linkColumn"].", ".
					":".$i.$this->relationships[$table]["baseColumn"].", ".
					":".$i."created, ".
					":".$i."modified".
					")";

				$query["params"] = array_merge($query["params"], array(
					":".$i.$this->relationships[$table]["linkColumn"] => $val,
					":".$i.$this->relationships[$table]["baseColumn"] => $id,
					":".$i."created" => date("Y-m-d H:i:s"),
					":".$i."modified" => date("Y-m-d H:i:s"))
				);
				$i++;
			}
		} else {
			$query["query"] .= "(".
				":".$this->relationships[$table]["linkColumn"].", ".
				":".$this->relationships[$table]["baseColumn"].", ".
				":"."created, ".
				":"."modified".
				")";

			$query["params"] = array_merge($query["params"], array(
				":".$this->relationships[$table]["linkColumn"] => $value,
				":".$this->relationships[$table]["baseColumn"] => $id,
				":"."created" => date("Y-m-d H:i:s"),
				":"."modified" => date("Y-m-d H:i:s"))
			);
		}

		$query["query"] .= ";";

		$this->query($query);
	}

/**
 * [A method that handles the datagrouping conditions]
 * @param  [string]  $key          [the table to be saved into]
 * @param  [array]  $value        [values to be saved]
 * @param  [integer] $index        [used in the deep saved index]
 * @param  [array]   $relationship [the relationship assocated in the model]
 * @param  [integer] $lastInsertId [the last id]
 * @param  [string]  $linkedColumn [the linked column in the relationship assocated in the model]
 * @return [array]                [deep data to be saved]
 */
	private function deepsave($key, $value, $index = 0, $relationship = array(), $lastInsertId = 0, $linkedColumn = "") {

		if(!isset($value[$index]) && empty($value[$index])) {
			return array();
		}

		$deepval = $value[$index];

		$i = 0;
		$deepsql = "";
		$sql_ = "";
		$arr = array();
		$habtm = array();

		$sql_ = "INSERT INTO ".strtolower($key)." (";

		$deepval = array_merge($deepval, array("created" => date("Y-m-d H:i:s"), "modified" => date("Y-m-d H:i:s")));
		if($linkedColumn != null) {
			$deepval = array_merge($deepval, array($linkedColumn => $lastInsertId));
		}

		$j = 0;
		$sqlval = null;
		foreach($deepval as $header => $val) {
			if(isset($relationship[$key]["Connect"]) && in_array($header, array_keys($relationship[$key]["Connect"]))) {$habtm[$header] = $val; unset($deepval[$header]); continue;}

			$validation = \Validation::validate($header, $deepval, $this->validation, $this->table, "add");
			if($validation["error"])
				return $validation;
			if($validation["skip"])
				continue;

			if($j == 0)
				$sqlval .= ":".$i.$j.$header;
			else
				$sqlval .= ", :".$i.$j.$header;

			$arr[":".$i.$j.$header] = $validation["value"];
			$j++;
		}
		$qPart = array_fill(0, 1, "(".$sqlval.")");
		$deepsql .= implode(",",$qPart);

		$deepsql .= ";";

		$headers = array_keys($deepval);
		$sql_ .= implode(",", $headers).")";
		$sql_ .= " VALUES";
		$sql_ .= " ".$deepsql;

		$query = array(
			"query" => $sql_,
			"params" => $arr
		);
//\Configure::pre($query, false);
//\Configure::pre($habtm, false);

		$this->query($query);
		$this->last_id = $this->returnLastId();

		if(!empty($habtm)) {
			foreach($habtm as $keyHeader => $keyVal) {
				$this->deepsave(
					$keyHeader,
					$keyVal,
					0,
					$relationship[$key]["Connect"],
					$this->last_id,
					$relationship[$key]["Connect"][$keyHeader]["linkColumn"]
				);
			}

		}

		return $this->deepsave($key, $value, ($index+1), $relationship, $lastInsertId, $linkedColumn);
	}

/**
 * [A method that handles the datagrouping conditions]
 * @param  [string] $key   [the table to be saved into]
 * @param  [string] $value [values to be saved]
 * @return [array]        [the output array]
 */
	private function shallowsave($key, $value) {
		$value = array_merge($value, array("created" => date("Y-m-d H:i:s"), "modified" => date("Y-m-d H:i:s")));

		$arr = array();
		$i = 0;
		$sqlval = null;
		$sql = "INSERT INTO ".strtolower($key)." (";

		$habtm = array();
		foreach($value as $header => $val) {
			if(in_array($header, array_keys($this->relationships))) {$habtm[$header] = $val; unset($value[$header]); continue;}

			$validation = \Validation::validate($header, $value, $this->validation, $this->table, "add");

			if($validation["error"])
				return $validation;
			if($validation["skip"]){
				unset($value[$header]);
				continue;
			}
			if($i == 0)
				$sqlval .= ":".$i.$header;
			else
				$sqlval .= ", :".$i.$header;

			$arr[":".$i.$header] = $validation["value"];
			$i++;
		}
		$headers = array_keys($value);
		$sql .= implode(", ", $headers);
		$sql .= ") VALUES ";
		$qPart = array_fill(0, 1, "(".$sqlval.")");
		$sql .=  implode(",",$qPart).";";

		$query = array(
			"query" => $sql,
			"params" => $arr
		);

		$this->query($query);
		$this->last_id = $this->returnLastId();

		if(!empty($habtm)) {
			foreach($habtm as $head => $val) {
				$this->relatedsave($head, $val, $this->last_id);
			}
		}

		return array();
	}

/**
 * [A method that handles the Where conditions]
 * @param  [string] $value    []
 * @param  [string] $head     []
 * @param  [string] $op       []
 * @param  [array] $wherearr []
 * @param  [array] $arr      []
 * @param  [int] $i        []
 */
	private function group($value, $head, $op, &$wherearr, &$arr, &$i) {
		$wherearr[$op][] = $head."=:a".$i.str_replace(array("."), "", $head);
		$arr[":a".$i.str_replace(array("."), "", $head)] = $value;
		$i++;
	}

/**
 * [A method that handles the Where conditions]
 * @param  [array] $condition []
 * @return [array]            []
 */
	private function conditions($condition) {
		$where = "";
		$wherearr = array("or" => array(), "and" => array());
		$arr = array();
		$i = 0;

		if(isset($condition["conditions"])) {
			foreach($condition["conditions"] as $head => $val) {
				$operation = ($head == "or")?"or":"and";

				if(is_array($val) && $head == "or") {
					foreach($val as $headarray => $or) {
						if(is_array($or)) {
							foreach($or as $valarray) {
								$this->group($valarray, $headarray, $operation, $wherearr, $arr, $i);
							}
						} else {
							$this->group($or, $headarray, $operation, $wherearr, $arr, $i);
						}
					}
				} else if(is_array($val) && $head != "or") {
					foreach($val as $valarray) {
						$this->group($valarray, $head, $operation, $wherearr, $arr, $i);
					}
				} else {
					$this->group($val, $head, $operation, $wherearr, $arr, $i);
				}
			}

			$where = implode(" AND ", $wherearr["and"]).(($wherearr["or"] && $wherearr["and"])?" AND ":"").implode(" OR ", $wherearr["or"]);
		}

		return array(
			"where" => $where,
			"arr" => $arr
		);
	}

/**
 * [Generates a update method]
 * @param [array] $queries   []
 * @param [array]  $condition []
 * @return [boolean]            []
 */
	public function Update($queries, $condition = array()) {
		$output = true;
		if(isset($queries[0])){
			foreach($queries as $query) {
				$output = $this->UpdateQuery($query);
			}
		} else {
			if(!empty($condition)) {
				$queries = array(
					$this->table => array(
						"data" => $queries[$this->table],
						"conditions" => $condition
					)
				);
			}
			$output = $this->UpdateQuery($queries);
		}

		return $output;
	}

/**
 * [UpdateQuery description]
 * @param [arrat] $queries []
 * @return [boolean]            []
 */
	private function UpdateQuery($queries) {

		foreach($queries as $key => $value) {
			$sql = "UPDATE ".strtolower($key)." SET ";
			$where = "";
			$arr = array();
			$i = 0;

			$value['data'] = array_merge($value['data'], array("modified" => date("Y-m-d H:i:s")));

			foreach($value['data'] as $head => $val) {
				if(in_array($head, array_keys($this->relationships))) {$habtm[$head] = $val; unset($value[$head]); continue;}
				$validation = \Validation::validate($head, $value['data'], $this->validation, $this->table, "edit");
				if($validation["error"])
					return $validation;
				if($validation["skip"])
					continue;

				if($i != 0) {
					$sql .= ", ";
				}

				$sql .= $head."=:".$head;
				$arr[":".$head] = $validation['value'];
				$i++;
			}
			$returned = $this->conditions($value);
			$where = $returned['where'];
			$arr = array_merge($arr, $returned['arr']);

			if($where != "") {
				$sql .= " WHERE ".$where;
			}
			$query = array(
				"query" => $sql,
				"params" => $arr
			);
			$this->query($query);

			if(!empty($this->relationships) && isset($value["conditions"]["id"])) {
				foreach($this->relationships as $h => $v) {
					if($v["type"] == "HABTM") {
						$this->Delete(array(
							$v["linktable"] => array(
								"conditions" => array(
									$v["baseColumn"] => $value["conditions"]["id"]
								)
							)
						));
					}
				}
			}


			if(!empty($habtm) && isset($value["conditions"]["id"])) {
				foreach($habtm as $head => $val) {
					$this->relatedsave($head, $val, $value["conditions"]["id"]);
				}
			}
		}
		return true;
	}

/**
 * [Returns the SELECTs data values as an array object]
 * @param [string] $format  []
 * @param [array] $queries []
 */
	public function Find($format, $queries) {

		$output = array();

		foreach($queries as $this->tab => $query) {
			foreach($query as $headers => $data) {
				$where = "";
				$arr = array();
				$sql = "SELECT ";

				$returned = $this->conditions($data);
				$where = $returned['where'];
				$arr = $returned['arr'];

				$contains = $this->contains($data);
				$sql .= strtolower(implode(", ", array_values(array_merge(array_map(function($str) {if (strpos($str, 'COUNT(*)') !== FALSE) {return $str;}return $this->tab.".".$str;}, $data['fields']), $contains['fields']))));

				$sql .= " FROM ".strtolower($this->tab)."";

				if(isset($data["contains"]))
					$sql .= $contains["join"];

				if($where != "")
					$sql .= " WHERE ".$where;

				if($format == "pagination") {
					$page_count = ((isset($data['pagination']))?$data['pagination']:10);
					$page = $this->Page($page_count);
					if(isset($page[1]))
						$sql .= " ORDER BY ".$page[1]." ".$page[2]."";

					$sql .= " LIMIT ".((int)$page[0]*$page_count).",".(int)$page_count."";
				}

				if(!empty($data["order"])) {
					$sql .= " ORDER BY ".$data["order"][0];
				}
				if(!empty($data["limit"])) {
					$sql .= " LIMIT ".$data["limit"];
				}

				$sql .= ";";

				$q = array(
					"query" => $sql,
					"params" => $arr
				);

				if($results = $this->results($this->query($q))) {
					if($format == "first")
						$output[$this->tab] = $this->relationdata($results[0], $data, $contains["relationship"]);
					else
						$output[$this->tab] = $this->relationdata($results, $data, $contains["relationship"], false);
				} else {
					$output[$this->tab] = array();
				}

			}
		}

		return $output;
	}

/**
 * [if the connect exist as a relationship then for each record pull the data in.]
 * @param  [array] $data    []
 * @param  [array] $connect []
 * @return [array]          []
 */
	private function connect($data, $connect) {

		foreach($connect as $h => $k) {
			$sql_ = "";
			foreach($data as $dataHeader => $dataValue) {
				if($k["type"] == "belongs") {
					$sql_ = "SELECT ".implode(", ", $k["leftcols"])." FROM ".strtolower($k['lefttable']);

					if(isset($k["Join"])) {
						foreach($k["Join"] as $joinHeader => $joinData) {
							$to = "id";
							if(isset($joinData['toColumn'])) {
								$to = $joinData['toColumn'];
							}

							$sql_ .= " LEFT JOIN ".strtolower($joinData['lefttable']);
							$sql_ .= " ON ".strtolower($k['lefttable']).".".$joinData['linkColumn']." = ".strtolower($joinData['lefttable']).".".$to;
						}
					}
					$sql_ .= " WHERE ".strtolower($k['lefttable']).".".$k['linkColumn']."=:id";

					$q = array(
						"query" => $sql_,
						"params" => array(":id" => $dataValue[$k['dataColumn']])
					);

					if($results = $this->results($this->query($q))) {
						if(isset($k["Connect"])) {
							$data[$dataHeader][$h] = $this->connect($results, $k["Connect"])[0];
						} else {
							$data[$dataHeader][$h] = $results[0];
						}
					}
				} else if($k["type"] == "HABTM") {
					$sql_ = "SELECT ".implode(", ", $k["leftcols"])." FROM ".
						$k["linktable"]." LEFT JOIN ".$k["lefttable"]." ON ".
						$k["linktable"].".".$k["linkColumn"]." = ".$k["lefttable"].".id WHERE ".$k["linktable"].".".$k["baseColumn"].
						" = :id;";

					$q = array(
						"query" => $sql_,
						"params" => array(":id" => $dataValue[$k['dataColumn']])
					);

					if($results = $this->results($this->query($q))) {
						if(isset($k["Connect"])) {
							$data[$dataHeader][$h] = $this->connect($results, $k["Connect"]);
						} else {
							$data[$dataHeader][$h] = $results;
						}
					}
				} else if($k["type"] == "HM") {
					$sql_ = "SELECT ".implode(", ", $k["leftcols"])." FROM ".strtolower($k['lefttable']).
						" WHERE ".$k["lefttable"].".".$k["linkColumn"].
						" = :id;";

					$q = array(
						"query" => $sql_,
						"params" => array(":id" => $dataValue[$k['dataColumn']])
					);

					if($results = $this->results($this->query($q))) {
						if(isset($k["Connect"])) {
							$data[$dataHeader][$h] = $this->connect($results, $k["Connect"]);
						} else {
							$data[$dataHeader][$h] = $results;
						}
					}
				}
			}
		}


		return $data;
	}

/**
 * [if the contains exist as a relationship then for each record pull the data in.]
 * @param  [array] $data    []
 * @param  [array] $contain []
 * @return [array]          []
 */
	private function handleRelationship($data, $contain) {

		$keys = array_keys($contain["contains"]);
		foreach($keys as $header) {
			if(in_array($header, array_keys($this->relationships)) && $this->relationships[$header]["type"] == "HABTM") {
				$sql_ = "SELECT ".implode(", ", $this->relationships[$header]["leftcols"])." FROM ".
					$this->relationships[$header]["linktable"];

				$sql_ .= " LEFT JOIN ".$this->relationships[$header]["lefttable"]." ON ".
					$this->relationships[$header]["linktable"].".".$this->relationships[$header]["linkColumn"]." = ".$this->relationships[$header]["lefttable"].".id";

				if(isset($this->relationships[$header]["Join"])) {
					foreach($this->relationships[$header]["Join"] as $joinHeader => $joinData) {
						$sql_ .= " LEFT JOIN ".strtolower($joinData['lefttable']);
						$sql_ .= " ON ".strtolower($this->relationships[$header]['lefttable']).".".$joinData['linkColumn']." = ".strtolower($joinData['lefttable']).".id";
					}
				}

				$sql_ .= " WHERE ".$this->relationships[$header]["linktable"].".".$this->relationships[$header]["baseColumn"].
					" = :id;";

				$q = array(
					"query" => $sql_,
					"params" => array(":id" => $data["id"])
				);

				if($results = $this->results($this->query($q))) {
					if(isset($this->relationships[$header]["Connect"])) {
						$data[$header] = $this->connect($results, $this->relationships[$header]["Connect"]);
					} else {
						$data[$header] = $results;
					}
				}
			} else if(in_array($header, array_keys($this->relationships)) && $this->relationships[$header]["type"] == "HM") {
				$sql_ = "SELECT ".implode(", ", $this->relationships[$header]["leftcols"])." FROM ".
					$this->relationships[$header]["lefttable"];

				if(isset($this->relationships[$header]["Join"])) {
					foreach($this->relationships[$header]["Join"] as $joinHeader => $joinData) {
						$sql_ .= " LEFT JOIN ".strtolower($joinData['lefttable']);
						$sql_ .= " ON ".strtolower($this->relationships[$header]['lefttable']).".".$joinData['linkColumn']." = ".strtolower($joinData['lefttable']).".id";
					}
				}

				$sql_ .= " WHERE ".$this->relationships[$header]["lefttable"].".".$this->relationships[$header]["linkColumn"].
				" = :".$this->relationships[$header]["linkColumn"].";";

				$q = array(
					"query" => $sql_,
					"params" => array(":".$this->relationships[$header]["linkColumn"] => $data["id"])
				);

				if($results = $this->results($this->query($q))) {
					if(isset($this->relationships[$header]["Connect"])) {
						$data[$header] = $this->connect($results, $this->relationships[$header]["Connect"]);
					} else {
						$data[$header] = $results;
					}
				}
			}
		}
		return $data;
	}

/**
 * [if the contains exist as a relationship then for each record pull the data in.]
 * @param  [array]  $data         [description]
 * @param  [array]  $contain      [description]
 * @param  [array]  $relationship [description]
 * @param  [boolean] $singlearray  [description]
 * @return [array]                [description]
 */
	private function relationdata($data, $contain, $relationship, $singlearray = true) {

		if($relationship) {

			if($singlearray) {
				$data = $this->handleRelationship($data, $contain);
			} else {
				foreach($data as $key => $v) {
					$data[$key] = $this->handleRelationship($v, $contain);
				}
			}
		}

		return $data;
	}

/**
 * [Generates a contain join between 2 tables on request]
 * @param  [array] $contain []
 * @return [array]          []
 */
	private function contains($contain) {
		$join = "";
		$fields = array();
		$relationship = false;

		if(isset($contain["contains"])) {
			foreach($contain["contains"] as $header => $value) {
				if(in_array($header, array_keys($this->relationships))
					&& ($this->relationships[$header]["type"] == "HABTM" || $this->relationships[$header]["type"] == "HM")
				) {
					$relationship = true;
				} else {
					if(!empty($value)) {
						$join .= " LEFT JOIN ".strtolower($header)." ON";

						$i = 0;
						foreach($value["relation"] as $key => $va) {
							if($i != 0) {
								$join .= " AND";
							}
							$join .= " ".$key."=".$va;
							$i++;
						}
						$fields = array_values(array_merge($fields, $value['fields']));
					}
				}
			}
		}

		return array(
			"join" 		=> $join,
			"fields" 	=> $fields,
			"relationship" 	=> $relationship
		);
	}

/**
 * [Deletes a entry or group of entries based on given ID's]
 * @param [array]  $queries []
 * @param [boolean] $ignore  []
 */
	public function Delete($queries, $ignore = false) {
		foreach($queries as $table => $query) {
			$arr = array();
			$sql = "DELETE FROM ".strtolower($table)."";

			$returned = $this->conditions($query);
			$where = $returned['where'];
			$arr = array_merge($arr, $returned['arr']);

			if($where != "" && $where != null) {
				$sql .= " WHERE ".$where;
			}

			$sql .= ";";

			$q = array(
				"query" => $sql,
				"params" => $arr
			);

			if(!$ignore){
				if(!empty($this->relationships) && isset($queries[$table]["conditions"]["id"])) {
					foreach($this->relationships as $h => $v) {
						if($v["type"] != "HABTM") continue;
						$this->Delete(array(
							$v["linktable"] => array(
								"conditions" => array(
									$v["baseColumn"] => $queries[$table]["conditions"]["id"]
								)
							)
						), true);
					}
				}
			}

			$this->query($q);
		}
	}

/**
 * [Calls a store prodecure within the system]
 * @param [string] $function []
 * @param [array]  $params   []
 */
	public function Call($function, $params = array()) {

		$arr = array();
		foreach($params as $key => $value) {
			$arr[":key_".$key] = $value;
		}

		$sql_ = "CALL ".$function."(".implode(", ", array_keys($arr)).");";

		$query = array(
			"query" => $sql_,
			"params" => $arr
		);

		if($results = $this->results($this->query($query))) {
			return $results;
		}
	}

/**
 * [Checks to see if the item exists in the database]
 * @param [Mixins] $value []
 */
	public function Exists($value) {
		if(is_array($value)) {
			$where = "WHERE ";
			$i = 0;
			foreach($value as $head => $val) {
				if($i != 0)
					$where .= " OR ";

				$where .= $head."=:".$i.$head;
				$arr[":".$i.$head] = $val;
				$i++;
			}
		} else {
			$where = "WHERE id = :id";
			$arr = array(":id" => $value);
		}

		$class = explode("\\", get_class($this));
		$sql = "SELECT id FROM ".strtolower($class[count($class)-1])." ".$where.";";
		$q = array(
			"query" => $sql,
			"params" => $arr
		);
		return (bool)$this->returnCount($this->query($q));
	}

/**
 * [Gets the current page for pagination by reading the url]
 * @param [string] $page_count []
 */
	public function Page($page_count) {
		$index = count(\Configure::$url['param'])-1;
		if($index != -1) {

			$arr 				= preg_split("/(Pag:|:)/",\Configure::$url['param'][$index]);
			\Configure::$url['param'][$index] .= ":".$page_count;

			$column = (isset($arr[2]))?$arr[2]:null;
			$order = (isset($arr[3]))?$arr[3]:"ASC";
			return array($arr[1],$column,$order);

		}
		\Configure::$url['param'][] .= "Pag:0:".$page_count;
		return array(0,null,null);
	}

/**
 * [method to tackle bad requests by checking the presented access tokens and time stamps]
 * @param  [string] $token        []
 * @param  [array]  $session_data []
 * @return [boolean]               []
 */
	public function auth_check($token, $session_data = array()) {
		if(empty($session_data) || !isset($session_data['access']) || !isset($session_data['time'])) {
			return false;
		}

		if($token != $session_data['access']) {
			return false;
		}

		if((time()+1) < $session_data['time']) {
			return false;
		}

		return true;
	}
}
