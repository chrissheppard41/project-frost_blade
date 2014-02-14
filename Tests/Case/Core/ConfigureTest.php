<?php
DEFINE("LIVE", false);
DEFINE("PATH", "../../");
define("CRYPTKEY", "zB8Fznw/");
require PATH."Configs/Libs/Configure.php";
//
//	@class ConfigureTest
//	@author Chris Sheppard
//	@desc The test controller that holds functionality within the framework
///
class ConfigureTest extends PHPUnit_Framework_TestCase
{
//
// Action testConfigureWrite
///
	public function testConfigureWriteAndDelete()
	{
		\Configure::write("Hello.world", "my value");

		$this->assertEquals("my value", \Configure::read("Hello.world"));

		\Configure::delete("Hello.world");

		$this->assertNull(\Configure::read("Hello.world"));

		$value = array("value 1", "value 2");
		\Configure::write("Hello.world", $value);
		$this->assertEquals($value, \Configure::read("Hello.world"));

		\Configure::delete("Hello.world");

		$this->assertNull(\Configure::read("Hello.world"));


		$value = array("mess1" => "value 1", "mess2" => "value 2");
		\Configure::write("Hello.world", $value);
		$this->assertEquals("value 1", \Configure::read("Hello.world.mess1"));
		$this->assertEquals("value 2", \Configure::read("Hello.world.mess2"));

		\Configure::delete("Hello.world");

		$this->assertNull(\Configure::read("Hello.world"));

	}
//
// Action testConfigureAuth
///
	public function testConfigureAuth()
	{
		$value = array("id" => 1, "username" => "value 2");
		\Configure::Auth($value);
		$this->assertTrue(\Configure::Logged());


		$this->assertEquals("value 2", \Configure::User("username"));
		$this->assertNull(\Configure::User("password"));


		\Configure::Auth();
		$this->assertFalse(\Configure::Logged());
	}
//
// Action testConfigurePre
///
	public function Random_generation()
	{
		$this->asserNotNull(\Configure::Random_generation());
	}
}