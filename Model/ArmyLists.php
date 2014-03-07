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
							"or" => array (
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
}