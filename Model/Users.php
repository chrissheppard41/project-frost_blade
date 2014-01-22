<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class Users
	@author Chris Sheppard
	@desc handles all user data and information
*/
class Users extends \Frost\Configs\Database {

	private $table = "users";
	private $validation = array(
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
				"message" => "You must include a password"
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
                "message" => "Your field must match the password field"
            )
		)
	);
	protected $post = array();

	function __construct($options, $inputted_params){
		parent::__construct();

		$this->post = $inputted_params;
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

		$crypt_pass = sha1(crypt($this->post['data']['User']['password'], CRYPTKEY.$this->post['data']['User']['email']));

		$query = array(
			"query" => "SELECT id, username, slug, email, last_login, is_admin, created, modified FROM users WHERE email = :email AND password = :password;",
			"params" => array(
				":email" => $this->post['data']['User']['email'],
				":password" => $crypt_pass
			)
		);

		$results = $this->results($this->query($query));

		if(!empty($results)) {
			$queryUpdate = array(
				"Users" => array(
					array(
						"data" => array(
							"last_login" 		=> date("Y-m-d H:i:s"),
							"modified" 			=> date("Y-m-d H:i:s")
						),
						"condition"	=> array(
							"id" 				=> $results[0]['id']
						)
					)
				)
			);
			$this->update($queryUpdate);
			return $results[0];
		}
		return false;
	}

/**
 * reg_user method
 * Registers a user into the website if data is correct
 *
 * @param
 * @return (bool)
 */
	public function reg_user() {
		$validation = \Validation::validate($this->validation, "User");
		if($validation["error"]) {
			return $validation;
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
					"email_verified"	=> 0,
					"created" 			=> date("Y-m-d H:i:s"),
					"modified" 			=> date("Y-m-d H:i:s")
				)
			)
		);
		$this->save($query);
	}
}