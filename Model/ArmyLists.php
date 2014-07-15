<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class ArmyLists
	@author Chris Sheppard
	@desc handles all user data and information
*/
class ArmyLists extends \Frost\Configs\Database {

	protected $table = "ArmyLists";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include an army name"
			),
			"between" => array(
				"min" => 3,
				"max" => 100,
				"message" => "Between 3 to 100 characters"
			)
		),
		"descr" => array(
			"notempty" => array(
				"message" => "You must include an army description"
			),
			"between" => array(
				"min" => 5,
				"max" => 255,
				"message" => "Between 5 to 255 characters"
			)
		),
		"points_limit" => array(
			"notempty" => array(
				"message" => "You must include an Points limit"
			),
			"numeric" => array(
				"message" => "Points limit must be an number"
			)
		),
		"hide" => array(
			"tinyint" => array(
				"default" => false
			)
		),
		"armies_id" => array(
			"notempty" => array(
				"message" => "You must include an army type"
			)
		),
		"users_id" => array(
			"notempty" => array(
				"message" => "You must include an username"
			)
		),
	);
	public $post = array();

	protected $relationships = array(
		"ArmySquads" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "armysquads",
			"leftcols" => array(
				"ArmySquads.id",
				"ArmySquads.position",
				"ArmySquads.squads_id",
				"ArmySquads.armylists_id",
				"ArmySquads.created",
				"ArmySquads.modified"
			),
			"linkColumn" => "armylists_id",
			"baseColumn" => null,
			"dataColumn" => "id",
			"Connect" => array(
				"ArmyUnits" => array(
					"type" => "HM",
					"linktable" => null,
					"lefttable" => "armyunits",
					"leftcols" => array(
						"ArmyUnits.id",
						"ArmyUnits.count",
						"ArmyUnits.units_id",
						"ArmyUnits.armysquads_id",
						"ArmyUnits.created",
						"ArmyUnits.modified"
					),
					"linkColumn" => "armysquads_id",
					"baseColumn" => null,
					"dataColumn" => "id",
					"Connect" => array(
						"ArmyWargears" => array(
							"type" => "HM",
							"linktable" => null,
							"lefttable" => "armywargears",
							"leftcols" => array(
								"ArmyWargears.id",
								"ArmyWargears.wargears_id",
								"ArmyWargears.armyunits_id",
								"ArmyWargears.created",
								"ArmyWargears.modified"
							),
							"linkColumn" => "armyunits_id",
							"baseColumn" => null,
							"dataColumn" => "id",

						)
					)
				)
			)
		)
	);

	function __construct($options, $inputted_params){
		parent::__construct();

		if(isset($inputted_params["data"])) {
			$this->post = $inputted_params["data"];
		}
	}

/**
 * save_army method
 * saves an army against the validation
 *
 * @param
 * @return (bool)
 */
	public function save_army() {
		$validation = \Validation::validate($this->validation, "User");
		if($validation["error"]) {
			return $validation;
		}

		$data = $this->Find("first",
			array(
				"Users" => array(
					array(
						"fields" => array(
							"slug",
							"username",
							"email"
						),
						"condition"	=> array(
							"or" => array(
								"username" => $this->post['data']['User']['username'],
								"email" => $this->post['data']['User']['email']
							)
						)
					)
				)
			)
		);

		if(isset($data['Users']) && !empty($data['Users'])) {
			$head = "";
			if($this->post['data']['User']['username'] == $data['Users']['username']) {
				$head = "Username";
			}
			if($this->post['data']['User']['email'] == $data['Users']['email']) {
				if(strlen($head) > 0)
					$head .= "/";

				$head .= "Email";
			}
			return \Validation::response($head,"The information you provided is currently being used, please choose a different ".$head);
		}

		$crypt_pass = sha1(crypt($this->post['data']['User']['password'], CRYPTKEY.$this->post['data']['User']['email']));
		$slug = crypt($this->post['data']['User']['username'], CRYPTKEY.$this->post['data']['User']['email']);

		$query = array(
			"Users" => array(
				array(
					"username" 			=> $this->post['data']['User']['username'],
					"slug" 				=> $slug,
					"password" 			=> $crypt_pass,
					"email" 			=> $this->post['data']['User']['email'],
					"email_verified"	=> (int)((isset($this->post['data']['User']['email_verified']))?(bool)$this->post['data']['User']['email_verified']:false),
					"is_admin"			=> (int)((isset($this->post['data']['User']['is_admin']))?(bool)$this->post['data']['User']['is_admin']:false),
					"created" 			=> date("Y-m-d H:i:s"),
					"modified" 			=> date("Y-m-d H:i:s")
				)
			)
		);
		$this->Save($query);
	}

/**
 * update_army method
 * Updates a current army within the system
 *
 * @param
 * @return (bool)
 */
	public function update_army() {
		$validation = \Validation::validate($this->validation, "Users", "edit");
		if($validation["error"]) {
			return $validation;
		}
		$pass = array();
		if(isset($this->post['data']['Users']['password']) && !empty($this->post['data']['Users']['password'])) {
			$crypt_pass = sha1(crypt($this->post['data']['Users']['password'], CRYPTKEY.$this->post['data']['Users']['email']));
			$pass = array("password" 		=> $crypt_pass);
		}

		$data_array = array_merge($pass,array(
			"username" 			=> $this->post['data']['Users']['username'],
			"email" 			=> $this->post['data']['Users']['email'],
			"email_verified"	=> (int)((isset($this->post['data']['Users']['email_verified']))?(bool)$this->post['data']['Users']['email_verified']:false),
			"is_admin"			=> (int)((isset($this->post['data']['Users']['is_admin']))?(bool)$this->post['data']['Users']['is_admin']:false),
			"modified" 			=> date("Y-m-d H:i:s")
		));

		$query = array(
			"Users" => array(
				array(
					"data" => $data_array,
					"condition" => array("id" => $this->post['data']['Users']['id'])
				)
			)
		);

		$this->Update($query);
	}

/**
 * _generateCode to saves a submitted army
 *
 * @return hash (string)
 */

	public function _generateCode($id) {
		$salt = substr(md5(uniqid(rand(), true)), 0, 9);
		return $salt . sha1($salt . time() . $id);
	}


/**
 * army_lists method
 * returns the army lists
 *
 * @param
 * @return (bool)
 */
	public function army_lists($type, $user_id) {

		if($type == "public") {
			$conditions = array("armylists.hide" => 0);
			$order = array();

			$count = $this->find(
				'first',
				array(
					"ArmyLists" => array(
						array(
							"fields" => array(
								"COUNT(*) as `count`"
							),
							"conditions" => $conditions
						)
					)
				)
			);

		} else if($type == "top") {
			$conditions = array("armylists.hide" => 0);
			$order = array("score ASC");
		} else {
			if(!\Configure::Logged()) {
				throw new \WebException("Forbidden: Not logged in", 403);
			}
			$conditions = array("ArmyLists.users_id" => $user_id);
			$order = array();

			$count = $this->find(
				'first',
				array(
					"ArmyLists" => array(
						array(
							"fields" => array(
								"COUNT(*) as `count`"
							),
							"conditions" => $conditions
						)
					)
				)
			);
		}

		$data = $this->find(
			'all',
			array(
				"ArmyLists" => array(
					array(
						"fields" => array(
							"id",
							"code",
							"name",
							"descr",
							"point_limit",
							"hide",
							"score",
							"users_id",
							"armies_id",
							"created",
							"modified"
						),
						"conditions" => $conditions,
						"order" => $order,
						"limit" => 5,
						"contains" => array(
							"Armies" => array(
								"fields" => array(
									"armies.name as `army_name`"
								),
								"relation" => array(
									"ArmyLists.armies_id" => "armies.id"
								)
							),
							"Races" => array(
								"fields" => array(
									"races.name as `races_name`",
									"races.icon"
								),
								"relation" => array(
									"Armies.races_id" => "races.id"
								)
							),
							"Colours" => array(
								"fields" => array(
									"colours.name as `colours_name`"
								),
								"relation" => array(
									"Armies.colours_id" => "colours.id"
								)
							),
							"Votes" => array(
								"fields" => array(
									"votes.vote"
								),
								"relation" => array(
									"Votes.armylists_id" => "ArmyLists.id",
									"Votes.users_id" => $user_id
								)
							)
						)
					)
				)
			)
		);

		if(isset($count["ArmyLists"]["count"])) {
			$data["count"] = $count["ArmyLists"]["count"];
		}
		return $data;
	}

}