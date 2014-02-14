<?php
require PATH."Configs/Libs/Validation.php";
//
//	@class ValidationTest
//	@author Chris Sheppard
//	@desc The test controller that holds functionality within the framework
///
class ValidationTest extends PHPUnit_Framework_TestCase
{
	private static $validation = array(
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
                "message" => "Between 5 to 50 characters"
            )
		),
		"username" => array(
			"notempty" => array(
				"message" => "You must include a username"
			),
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
		)
	);

//
// Action testValidationEmail
///
	public function testValidationEmail()
	{
		$_POST["data"]["Test"]["email"] = "bad_email.com";
		$results = \Validation::validate(self::$validation, "Test", "edit");
		$expected = array(
			'error' => true,
		  	'field' => "email",
			'message' => "Your email address is not valid"
		);
		$this->assertEquals($expected, $results);

		$_POST["data"]["Test"]["email"] = "good@email.com";
		$results = \Validation::validate(self::$validation, "Test", "edit");

		$expected = array(
			'error' => false,
			'field' => NULL,
			'message' => NULL
		);
		$this->assertEquals($expected, $results);
	}

//
// Action testValidationNotempty
///
	public function testValidationNotempty()
	{
		$_POST["data"]["Test"]["username"] = "";
		$results = \Validation::validate(self::$validation, "Test", "edit");
		$expected = array(
			'error' => true,
		  	'field' => "username",
			'message' => "You must include a username"
		);
		$this->assertEquals($expected, $results);

		$_POST["data"]["Test"]["username"] = "Good string";
		$results = \Validation::validate(self::$validation, "Test", "edit");

		$expected = array(
			'error' => false,
			'field' => NULL,
			'message' => NULL
		);
		$this->assertEquals($expected, $results);
	}

//
// Action testValidationBetween
///
	public function testValidationBetween()
	{
		$_POST["data"]["Test"]["username"] = "bad";
		$results = \Validation::validate(self::$validation, "Test", "edit");
		$expected = array(
			'error' => true,
		  	'field' => "username",
			'message' => "Between 5 to 50 characters"
		);
		$this->assertEquals($expected, $results);

		$_POST["data"]["Test"]["username"] = "Good string";
		$results = \Validation::validate(self::$validation, "Test", "edit");

		$expected = array(
			'error' => false,
			'field' => NULL,
			'message' => NULL
		);
		$this->assertEquals($expected, $results);

		$_POST["data"]["Test"]["username"] = "bad01234567890123456789012345678901234567890123456789";
		$results = \Validation::validate(self::$validation, "Test", "edit");
		$expected = array(
			'error' => true,
		  	'field' => "username",
			'message' => "Between 5 to 50 characters"
		);
		$this->assertEquals($expected, $results);
	}
//
// Action testValidationMatch
///
	public function testValidationMatch()
	{
		$_POST["data"]["Test"]["password"] = "bad_string";
		$_POST["data"]["Test"]["confirm_password"] = "very_bad";
		$results = \Validation::validate(self::$validation, "Test", "edit");
		$expected = array(
			'error' => true,
		  	'field' => "confirm_password",
			'message' => "Your field must match the password field"
		);
		$this->assertEquals($expected, $results);

		$_POST["data"]["Test"]["password"] = "Good string";
		$_POST["data"]["Test"]["confirm_password"] = "Good string";
		$results = \Validation::validate(self::$validation, "Test", "edit");

		$expected = array(
			'error' => false,
			'field' => NULL,
			'message' => NULL
		);
		$this->assertEquals($expected, $results);

	}
//
// Action testValidationSpecialChar
///
	public function testValidationSpecialChar()
	{
		$_POST["data"]["Test"]["username"] = "*&^£(&*£$&*()£$&*()";
		$results = \Validation::validate(self::$validation, "Test", "edit");
		$expected = array(
			'error' => true,
		  	'field' => "username",
			'message' => "You must not include special characters within your username"
		);
		$this->assertEquals($expected, $results);
	}
}