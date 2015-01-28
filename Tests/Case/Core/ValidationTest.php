<?php
//require PATH."Configs/Libs/Validation.php";
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
			),
			"password" => array(
				"cryptwith" => "username"
			),
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
		),
		"bool" => array(
			"tinyint" => array(
				"default" => false
			)
		),
		"slug" => array(
			"slug" => array(
				"cryptwith" => "username"
			),
		),
		"number" => array(
			"numeric" => array(
				"message" => "The field must be a numeric value"
			),
		)
	);

//
// Action testValidationEmail
///
	public function testValidationEmail()
	{
		$arr["email"] = "bad_email.com";
		$results = \Validation::validate("email", $arr, self::$validation, "Test");
		$expected = array(
			'error' => true,
		  	'field' => "email",
			'message' => "Your email address is not valid",
			"value" => "bad_email.com",
			"skip" => false
		);
		$this->assertEquals($expected, $results);

		$arr["email"] = "good@email.com";
		$results = \Validation::validate("email", $arr, self::$validation, "Test");
		$expected = array(
			'error' => false,
			'field' => "email",
			'message' => NULL,
			"value" => "good@email.com",
			"skip" => false
		);
		$this->assertEquals($expected, $results);
	}

//
// Action testValidationNotempty
///
	public function testValidationNotempty()
	{
		$arr["username"] = "";
		$results = \Validation::validate("username", $arr, self::$validation, "Test");
		$expected = array(
			'error' => true,
		  	'field' => "username",
			'message' => "You must include a username",
			"value" => "",
			"skip" => false
		);
		$this->assertEquals($expected, $results);

		$arr["username"] = "Good string";
		$results = \Validation::validate("username", $arr, self::$validation, "Test");

		$expected = array(
			'error' => false,
			'field' => "username",
			'message' => NULL,
			"value" => "Good string",
			"skip" => false
		);
		$this->assertEquals($expected, $results);
	}

//
// Action testValidationBetween
///
	public function testValidationBetween()
	{
		$arr["username"] = "bad";
		$results = \Validation::validate("username", $arr, self::$validation, "Test");
		$expected = array(
			'error' => true,
		  	'field' => "username",
			'message' => "Between 5 to 50 characters",
			"value" => "bad",
			"skip" => false
		);
		$this->assertEquals($expected, $results);

		$arr["username"] = "Good string";
		$results = \Validation::validate("username", $arr, self::$validation, "Test");
		$expected = array(
			'error' => false,
			'field' => "username",
			'message' => NULL,
			"value" => "Good string",
			"skip" => false
		);
		$this->assertEquals($expected, $results);

		$arr["username"] = "bad01234567890123456789012345678901234567890123456789";
		$results = \Validation::validate("username", $arr, self::$validation, "Test");
		$expected = array(
			'error' => true,
		  	'field' => "username",
			'message' => "Between 5 to 50 characters",
			"value" => "bad01234567890123456789012345678901234567890123456789",
			"skip" => false
		);
		$this->assertEquals($expected, $results);
	}
//
// Action testValidationMatch
///
	public function testValidationMatch()
	{
		$arr["password"] = "bad_string";
		$arr["confirm_password"] = "very_bad";
		$results = \Validation::validate("confirm_password", $arr, self::$validation, "Test");
		$expected = array(
			'error' => true,
		  	'field' => "confirm_password",
			'message' => "Your field must match the password field",
			"value" => "very_bad",
			"skip" => false
		);
		$this->assertEquals($expected, $results);

		$arr["password"] = "Good string";
		$arr["confirm_password"] = "Good string";
		$results = \Validation::validate("confirm_password", $arr, self::$validation, "Test");
		$expected = array(
			'error' => false,
			'field' => "confirm_password",
			'message' => NULL,
			"value" => "Good string",
			"skip" => true
		);
		$this->assertEquals($expected, $results);

	}
//
// Action testValidationSpecialChar
///
	public function testValidationSpecialChar()
	{
		$arr["username"] = "*&^£(&*£$&*()£$&*()";
		$results = \Validation::validate("username", $arr, self::$validation, "Test");
		$expected = array(
			'error' => true,
		  	'field' => "username",
			'message' => "You must not include special characters within your username",
			"value" => "*&^£(&*£$&*()£$&*()",
			"skip" => false
		);
		$this->assertEquals($expected, $results);
	}

//
// Action testValidationTinyInt
///
	public function testValidationTinyInt()
	{
		$arr["bool"] = "1";
		$results = \Validation::validate("bool", $arr, self::$validation, "Test");
		$expected = array(
			'error' => false,
		  	'field' => "bool",
			'message' => null,
			"value" => 1,
			"skip" => false
		);
		$this->assertEquals($expected, $results);

		$arrA["bool"] = "0";
		$results = \Validation::validate("bool", $arrA, self::$validation, "Test");
		$expected = array(
			'error' => false,
		  	'field' => "bool",
			'message' => null,
			"value" => 0,
			"skip" => false
		);
		$this->assertEquals($expected, $results);

		$arr["bool"] = "10";
		$results = \Validation::validate("bool", $arr, self::$validation, "Test");
		$expected = array(
			'error' => false,
		  	'field' => "bool",
			'message' => null,
			"value" => 1,
			"skip" => false
		);
		$this->assertEquals($expected, $results);
	}

//
// Action testValidationPassword
///
	public function testValidationPassword()
	{
		$arr["password"] = "password";
		$arr["username"] = "password";
		$results = \Validation::validate("password", $arr, self::$validation, "Test");
		$expected = array(
			'error' => false,
		  	'field' => "password",
			'message' => null,
			"value" => "ad462c3e84992a2fc88ac37e0dbe9bbd0280fd56",
			"skip" => false
		);
		$this->assertEquals($expected, $results);

	}
//
// Action testValidationSlug
///
	public function testValidationSlug()
	{
		$arr["slug"] = "password";
		$arr["username"] = "password";
		$results = \Validation::validate("slug", $arr, self::$validation, "Test");
		$this->assertEquals(16, strlen($results["value"]));
		$this->assertEquals(false, $results["error"]);
		$this->assertEquals("slug", $results["field"]);
		$this->assertEquals(null, $results["message"]);
		$this->assertFalse($results["skip"]);

	}
//
// Action testValidationSkip
///
	public function testValidationSkip()
	{
		$arr["password"] = "";
		$arr["confirm_password"] = "";
		$results = \Validation::validate("confirm_password", $arr, self::$validation, "Test", "edit");
		$expected = array(
			'error' => false,
		  	'field' => "confirm_password",
			'message' => null,
			"value" => "",
			"skip" => true
		);
		$this->assertEquals($expected, $results);


		$arr["password"] = "asdasdasdasda";
		$arr["confirm_password"] = "";
		$results = \Validation::validate("confirm_password", $arr, self::$validation, "Test", "edit");
		$expected = array(
			'error' => true,
		  	'field' => "confirm_password",
			'message' => "Your field must match the password field",
			"value" => "",
			"skip" => false
		);
		$this->assertEquals($expected, $results);

	}
//
// Action testValidationNumeric
///
	public function testValidationNumeric()
	{
		$arr["number"] = "abc";
		$results = \Validation::validate("number", $arr, self::$validation, "Test", "edit");
		$expected = array(
			'error' => true,
		  	'field' => "number",
			'message' => "The field must be a numeric value",
			"value" => "abc",
			"skip" => false
		);
		$this->assertEquals($expected, $results);

		$arr["number"] = 12345;
		$results = \Validation::validate("number", $arr, self::$validation, "Test", "edit");
		$expected = array(
			'error' => false,
		  	'field' => "number",
			'message' => null,
			"value" => 12345,
			"skip" => false
		);
		$this->assertEquals($expected, $results);

	}
}