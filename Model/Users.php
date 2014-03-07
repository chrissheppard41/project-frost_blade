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
		$validation = \Validation::validate("email", $this->post['Users'], $this->validation, $this->table);
		if($validation["error"]) {
			return $validation;
		}
		$validation = \Validation::validate("password", $this->post['Users'], $this->validation, $this->table);
		if($validation["error"]) {
			return $validation;
		}

		$crypt_pass = sha1(crypt($this->post['Users']['password'], CRYPTKEY.$this->post['Users']['email']));

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
							"email" => $this->post['Users']['email'],
							"password" => $crypt_pass
						)
					)
				)
			)
		);

		if(!empty($data['Users'])) {
			$queryUpdate = array(
				"Users" => array(
					"data" => array(
						"last_login" 		=> date("Y-m-d H:i:s"),
						"modified" 			=> date("Y-m-d H:i:s")
					),
					"condition"	=> array(
						"slug" 				=> $data['Users']['slug']
					)
				)
			);
			$this->Update($queryUpdate);
			return $data["Users"];
		}
		return false;
	}
}