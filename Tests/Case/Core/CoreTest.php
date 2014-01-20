<?php
DEFINE("PATH", "../../");
require PATH."Configs/Libs/Html.php";
//
//	@class CoreTest
//	@author Chris Sheppard
//	@desc The test controller that holds functionality within the framework
///
class CoreTest extends PHPUnit_Framework_TestCase
{
	private static $Html = null;

	public static function setUpBeforeClass()
    {
		self::$Html = new \Frost\Configs\Html();
    }

/////
// Section Html
/////
//
// Action testCSS
///
	public function testCSS()
	{
		$results = self::$Html->Css(array("hello/world.css"));

		$expected = '<link href="/assets/css/hello/world.css" media="all" rel="stylesheet" type="text/css" />';
		$this->assertEquals($expected, $results);


		$results = self::$Html->Css(array("hello/world.css","my/test/css.css"));
		$expected = '<link href="/assets/css/hello/world.css" media="all" rel="stylesheet" type="text/css" /><link href="/assets/css/my/test/css.css" media="all" rel="stylesheet" type="text/css" />';
		$this->assertEquals($expected, $results);
	}
//
// Action testJS
///
	public function testJS()
	{
		$results = self::$Html->Js(array("hello/world.js"));

		$expected = '<script type="text/javascript" src="/assets/js/hello/world.js"></script>';
		$this->assertEquals($expected, $results);


		$results = self::$Html->Js(array("hello/world.js","my/test/js.js"));
		$expected = '<script type="text/javascript" src="/assets/js/hello/world.js"></script><script type="text/javascript" src="/assets/js/my/test/js.js"></script>';
		$this->assertEquals($expected, $results);
	}
//
// Action testScript
///
	public function testScript()
	{
		self::$Html->Script("Hello world");
		$results = self::$Html->Script();

		$expected = '<script type="text/javascript">Hello world</script>';
		$this->assertEquals($expected, $results);


		self::$Html->Script("My Javascript code");
		$results = self::$Html->Script();

		$expected = '<script type="text/javascript">Hello world</script><script type="text/javascript">My Javascript code</script>';
		$this->assertEquals($expected, $results);
	}
//
// Action testMeta
///
	public function testMeta()
	{
		$results = self::$Html->Meta('robots', 'noindex, nofollow');

		$expected = '<meta name="robots" content="noindex, nofollow" />';
		$this->assertEquals($expected, $results);
	}
}