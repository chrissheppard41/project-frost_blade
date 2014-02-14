<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class ArmyLists
	@author Chris Sheppard
	@desc handles all user data and information
*/
class ArmyLists extends \Frost\Configs\Database {

	private $table = "armylists";
	private $validation = array(
		/*"email" => array(
			"email" => array(
				"message" => "Your email address is not valid"
			),
			"notempty" => array(
				"message" => "You must include your email"
			)
		),
		"password" => array(
			"notempty" => array(
				"message" => "You must include a password",
				"ignore" => array("edit")
			),
			"between" => array(
				"min" => 5,
				"max" => 50,
                "message" => "Between 5 to 50 characters"
            )
		),
		"username" => array(
			"between" => array(
				"min" => 5,
				"max" => 50,
                "message" => "Between 5 to 50 characters"
            ),
			"nospecial" => array(
                "message" => "You must not include special characters within your username"
            )
		),
		"confirm_password" => array(
			"match" => array(
				"value" => "password",
                "message" => "Your field must match the password field",
				"ignore" => array("edit")
            )
		)*/
	);
	protected $post = array();

	function __construct($options, $inputted_params){
		parent::__construct();

		$this->post = $inputted_params;
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