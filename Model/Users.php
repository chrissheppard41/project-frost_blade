<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class Users
	@author Chris Sheppard
	@desc handles all user data and information
*/
class Users extends \Frost\Configs\Database {

	protected $table = "Users";
	protected $validation = array(
		"email" => array(
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
				"message" => "Between 5 to 50 characters",
				"ignore" => array("edit")
			),
			"password" => array(
				"cryptwith" => "email"
			),
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
		),
		"is_admin" => array(
			"tinyint" => array(
				"default" => false
			)
		),
		"email_verified" => array(
			"tinyint" => array(
				"default" => false
			)
		),
		"slug" => array(
			"slug" => array(
				"cryptwith" => "username"
			)
		)
	);

	function __construct($options, $inputted_params){
		parent::__construct();

		if(isset($inputted_params["data"]))
			$this->post = $inputted_params["data"];
	}

/**
 * log_user method
 * Logs a user into the website if data is correct
 *
 * @param
 * @return (bool)
 */
	public function log_user() {
		$validation = \Validation::validate($this->validation, "User");
		if($validation["error"]) {
			return $validation;
		}

		$crypt_pass = sha1(crypt($this->post['User']['password'], CRYPTKEY.$this->post['User']['email']));

		$data = $this->Find("first",
			array(
				"Users" => array(
					array(
						"fields" => array(
							"id",
							"username",
							"slug",
							"email",
							"is_admin",
							"last_login",
							"created",
							"modified"
						),
						"condition"	=> array(
							"email" => $this->post['User']['email'],
							"password" => $crypt_pass
						)
					)
				)
			)
		);

		if(!empty($data['Users'])) {
			$queryUpdate = array(
				"Users" => array(
					array(
						"data" => array(
							"last_login" 		=> date("Y-m-d H:i:s"),
							"modified" 			=> date("Y-m-d H:i:s")
						),
						"condition"	=> array(
							"slug" 				=> $data['Users']['slug']
						)
					)
				)
			);
			$this->Update($queryUpdate);
			return $data["Users"];
		}
		return false;
	}

/**
 * save_user method
 * Registers a user into the website if data is correct
 *
 * @param
 * @return (bool)
 */
	public function save_user() {
		$validation = \Validation::validate($this->validation, "Users");
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
								"username" => $this->post['User']['username'],
								"email" => $this->post['User']['email']
							)
						)
					)
				)
			)
		);

		if(isset($data['Users']) && !empty($data['Users'])) {
			$head = "";
			if($this->post['User']['username'] == $data['Users']['username']) {
				$head = "Username";
			}
			if($this->post['User']['email'] == $data['Users']['email']) {
				if(strlen($head) > 0)
					$head .= "/";

				$head .= "Email";
			}
			return \Validation::response($head,"The information you provided is currently being used, please choose a different ".$head);
		}

		$crypt_pass = sha1(crypt($this->post['User']['password'], CRYPTKEY.$this->post['User']['email']));
		$slug = crypt($this->post['User']['username'], CRYPTKEY.$this->post['User']['email']);

		$query = array(
			"Users" => array(
				array(
					"username" 			=> $this->post['User']['username'],
					"slug" 				=> $slug,
					"password" 			=> $crypt_pass,
					"email" 			=> $this->post['User']['email'],
					"email_verified"	=> (int)((isset($this->post['User']['email_verified']))?(bool)$this->post['User']['email_verified']:false),
					"is_admin"			=> (int)((isset($this->post['User']['is_admin']))?(bool)$this->post['User']['is_admin']:false),
					"created" 			=> date("Y-m-d H:i:s"),
					"modified" 			=> date("Y-m-d H:i:s")
				)
			)
		);
		$this->Save($query);
	}

/**
 * update_user method
 * Updates a current user withint he system
 *
 * @param
 * @return (bool)
 */
	public function update_user() {
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