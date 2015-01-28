<?php
//require PATH."Configs/Libs/Html.php";
//require PATH."Configs/Libs/Session_handler.php";
//
//	@class HtmlTest
//	@author Chris Sheppard
//	@desc The test controller that holds functionality within the framework
///
class HtmlTest extends PHPUnit_Framework_TestCase
{
	private static $Html = null;
	private static $Database = null;

	public static function setUpBeforeClass()
	{
		self::$Database = new \Frost\Configs\Database();
		self::$Html = new \Frost\Configs\Html(self::$Database);

		$query = self::$Database->query(array("query" => "DROP TABLE IF EXISTS test;", "params" => ""));
		$query = self::$Database->query(array("query" => "CREATE TABLE test(
			id INT(11) NOT NULL AUTO_INCREMENT,
			testcol VARCHAR(100) NOT NULL,
			updatehere VARCHAR(100) NULL,
			created DATETIME,
			modified DATETIME,
			PRIMARY KEY ( id )
		);", "params" => ""));
		$query = array(
			"test" => array(
				array("testcol" => "hello"),
				array("testcol" => "hello"),
				array("testcol" => "hello"),
				array("testcol" => "hello"),
				array("testcol" => "hello"),
				array("testcol" => "hello"),
				array("testcol" => "hello"),
				array("testcol" => "hello"),
				array("testcol" => "hello"),
				array("testcol" => "hello"),
				array("testcol" => "hello"),
				array("testcol" => "hello"),
				array("testcol" => "hello"),
				array("testcol" => "hello")
			)
		);

		$results = self::$Database->Save($query);
	}
	public static function tearDownAfterClass()
	{
		$query = self::$Database->query(array("query" => "DROP TABLE test;", "params" => ""));
	}

//
// Action testConstuctor
///
	public function testConstuctor()
	{
		$Html = new \Frost\Configs\Html(new \Frost\Configs\Database());
	}
//
// Action testURL
///
	public function testURL()
	{
		$results = self::$Html->Url('Test', array('controller' => 'test', 'action' => 'index', 'admin' => true), array('class' => 'btn btn-success icon icon-add'));
		$this->assertEquals($results, '<a href="/admin/test/index" class="btn btn-success icon icon-add">Test</a>');

		$resultsB = self::$Html->Url('Test 2', '/', array('class' => 'btn btn-success icon icon-add'));
		$this->assertEquals($resultsB, '<a href="/" class="btn btn-success icon icon-add">Test 2</a>');

		$resultsC = self::$Html->Url('Test', array('controller' => 'test', 'action' => 'index', 'params' => array("hello", "world")), array('class' => 'btn btn-success icon icon-add'));
		$this->assertEquals($resultsC, '<a href="/test/index/hello/world" class="btn btn-success icon icon-add">Test</a>');
	}
//
// Action testUrlPost
///
	public function testUrlPost()
	{
		$results = self::$Html->UrlPost('Test', array('admin' => true, 'controller' => 'users', 'action'=>'delete', 'params' => array(1)), array('class' => 'btn-sm btn-danger'));

		$this->assertTrue((bool)strstr($results, '<form action="/admin/users/delete/1"'));
		$this->assertTrue((bool)strstr($results, '<input type="hidden" name="_method" value="POST">'));
		$this->assertTrue((bool)strstr($results, '<a href="#"  class="btn-sm btn-danger" onclick="if (confirm(\'Are you sure you want to delete this record?\')) {'));

		$results = self::$Html->UrlPost('Test 2', "/", array('class' => 'btn-sm btn-danger'));

		$this->assertTrue((bool)strstr($results, '<form action="/"'));
		$this->assertTrue((bool)strstr($results, '<input type="hidden" name="_method" value="POST">'));
		$this->assertTrue((bool)strstr($results, '<a href="#"  class="btn-sm btn-danger" onclick="if (confirm(\'Are you sure you want to delete this record?\')) {'));

	}

//
// Action testCSS
///
	public function testCSS()
	{
		$results = self::$Html->Css(array("hello/world.css"));

		$expected = '<link href="/Assets/css/hello/world.css" media="all" rel="stylesheet" type="text/css" />';
		$this->assertEquals($expected, $results);


		$results = self::$Html->Css(array("hello/world.css","my/test/css.css"));
		$expected = '<link href="/Assets/css/hello/world.css" media="all" rel="stylesheet" type="text/css" /><link href="/Assets/css/my/test/css.css" media="all" rel="stylesheet" type="text/css" />';
		$this->assertEquals($expected, $results);
	}

//
// Action testScriptInline
///
	public function testScriptInline()
	{
		self::$Html->Js(array("hello/world.js"), array("inline" => false));
		$results = self::$Html->Script();

		$expected = '<script type="text/javascript" src="/Assets/js/hello/world.js"></script>';
		$this->assertEquals($expected, $results);
	}
//
// Action testJS
///
	public function testJS()
	{
		$results = self::$Html->Js(array("hello/world.js"));

		$expected = '<script type="text/javascript" src="/Assets/js/hello/world.js"></script>';
		$this->assertEquals($expected, $results);


		$results = self::$Html->Js(array("hello/world.js", "my/test/js.js"));

		$expected = '<script type="text/javascript" src="/Assets/js/hello/world.js"></script>'."\n".'<script type="text/javascript" src="/Assets/js/my/test/js.js"></script>';

		$this->assertEquals($expected, $results);
	}
//
// Action testScript
///
	public function testScript()
	{
		self::$Html->Script("Hello world");
		$results = self::$Html->Script();

		$expected = '<script type="text/javascript" src="/Assets/js/hello/world.js"></script><script type="text/javascript">Hello world</script>';
		$this->assertEquals($expected, $results);


		self::$Html->Script("My Javascript code");
		$results = self::$Html->Script();

		$expected = '<script type="text/javascript" src="/Assets/js/hello/world.js"></script><script type="text/javascript">Hello world</script><script type="text/javascript">My Javascript code</script>';
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
//
// Action testHighlight
///
	public function testHighlight()
	{
		$_SERVER['REQUEST_URI'] = "/admin/test/index";
		$results = self::$Html->Highlight('/^\/admin\/types/');
		$this->assertEquals("", $results);

		$results = self::$Html->Highlight('/^\/admin\/test/');
		$this->assertEquals(" active", $results);

		$results = self::$Html->Highlight('/^\/admin\//');
		$this->assertEquals(" active", $results);
	}
//
// Action test__t
///
	public function test__t()
	{
		$results = self::$Html->__t("test input");
		$this->assertEquals("test input", $results);
	}
//
// Action testForm
///
	public function testForm()
	{
		$results = self::$Html->Form(array(
					"action" => "/admin/test",
					"class" => "form-vertical",
					"id" => "TestForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				)	);
		$expected = '<form action="/admin/test" class="form-vertical" id="TestForm" method="post" accept-charset="utf-8">';

		$this->assertTrue((bool)strstr($results, $expected));

		$results = self::$Html->Form();
		$this->assertEquals("</form>", $results);

		$results = self::$Html->Form(array(
					"action" => "/admin/test",
					"class" => "form-vertical",
					"id" => "TestForm",
					"method" => "get"
				)	);
		$expected = '<form action="/admin/test" class="form-vertical" id="TestForm" method="get">';

		$this->assertTrue((bool)strstr($results, $expected));

		$results = self::$Html->Form();
		$this->assertEquals("</form>", $results);
	}
//
// Action testInput
///
	public function testInput()
	{
		$results = self::$Html->Input(
			"TestField",
			"Test",
			array(
				'label' => 'TestField',
				'placeholder' => "Test placeholder",
				'class' => "form-control",
				'maxlength' => "255",
				'type' => "text",
				'id' => "TestName"
			)
		);

		$this->assertTrue((bool)strstr($results, '<label for="TestTestField" class="control-label">TestField</label>'));
		$this->assertTrue((bool)strstr($results, '<input name="data[Test][TestField]" placeholder="Test placeholder" class="form-control" maxlength="255" type="text" id="TestName" />'));

		$_POST["data"]["Test"]["Testname"] = "hello world";

		$resultsB = self::$Html->Input(
			"Testname",
			"Test",
			array(
				'label' => 'Testname',
				'placeholder' => "Test placeholder",
				'class' => "form-control",
				'maxlength' => "255",
				'type' => "text",
				'id' => "Testname"
			)
		);
		$this->assertTrue((bool)strstr($resultsB, 'holder="Test placeholder" class="form-control" maxlength="255" type="text" id="Testname" value="hello world" />'));


		$_POST["data"]["Test"]["testname"] = "1";

		$resultsC = self::$Html->Input(
			"Testname",
			"Test",
			array(
				'label' => 'Testname',
				'class' => "form-control",
				'type' => "checkbox",
				'id' => "Testname"
			)
		);

		$this->assertTrue((bool)strstr($resultsC, ' class="form-control" type="checkbox" id="Testname" checked="checked" />'));

		$resultsC = self::$Html->Input(
			"Testcheck",
			"Test",
			array(
				'label' => 'Testcheck',
				'class' => "form-control",
				'type' => "checkbox",
				'id' => "Testcheck"
			)
		);

		$this->assertTrue((bool)strstr($resultsC, ' class="form-control" type="checkbox" id="Testcheck" />'));

		$resultsD = self::$Html->Input(
			"Testcheck",
			"Test",
			array(
				'label' => 'Testcheck',
				'class' => "form-control",
				'type' => "select",
				'id' => "Testselect"
			)
		);

		$this->assertTrue((bool)strstr($resultsD, '<select name="data[Test][Testcheck]" class="form-control" id="Testselect">'));
		$this->assertTrue((bool)strstr($resultsD, '<option value="">Select an option</option>'));

		$resultsE = self::$Html->Input(
			"Testcheck",
			"Test",
			array(
				'label' => 'Testcheck',
				'class' => "form-control",
				'type' => "select",
				'id' => "Testselect",
				"multiple"
			),
			array(array("id" => 1, "name" => "test option 1"),array("id" => 2, "name" => "test option 2"),array("id" => 3, "name" => "test option 3"))
		);

		$this->assertTrue((bool)strstr($resultsE, '<select name="data[Test][Testcheck][]" class="form-control" id="Testselect" multiple>'));
		$this->assertFalse((bool)strstr($resultsE, '<option value="">Select an option</option>'));

		$this->assertTrue((bool)strstr($resultsE, '<option value="1">test option 1</option>'));
		$this->assertTrue((bool)strstr($resultsE, '<option value="2">test option 2</option>'));
		$this->assertTrue((bool)strstr($resultsE, '<option value="3">test option 3</option>'));


		$_POST["data"]["Test"]["Testcheck"] = 1;
		$resultsF = self::$Html->Input(
			"Testcheck",
			"Test",
			array(
				'label' => 'Testcheck',
				'class' => "form-control",
				'type' => "select",
				'id' => "Testselect"
			),
			array(array("id" => 1, "name" => "test option 1"),array("id" => 2, "name" => "test option 2"))
		);

		$this->assertTrue((bool)strstr($resultsF, '<select name="data[Test][Testcheck]" class="form-control" id="Testselect">'));

		$this->assertTrue((bool)strstr($resultsF, '<option value="">Select an option</option>'));

		$resultsG = self::$Html->Input(
			"TestArea",
			"Test",
			array(
				'label' => 'TestArea',
				'placeholder' => "Test placeholder",
				'class' => "form-control",
				'type' => "textarea",
				'id' => "TestName"
			)
		);

		$this->assertTrue((bool)strstr($resultsG, '<label for="TestTestArea" class="control-label">TestArea</label>'));
		$this->assertTrue((bool)strstr($resultsG, '<textarea name="data[Test][TestArea]" placeholder="Test placeholder" class="form-control" id="TestName"></textarea>'));


		$_POST["data"]["Test"]["TestArea"] = "Lorem ispum";
		$resultsH = self::$Html->Input(
			"TestArea",
			"Test",
			array(
				'label' => 'TestArea',
				'placeholder' => "Test placeholder",
				'class' => "form-control",
				'type' => "textarea",
				'id' => "TestName"
			)
		);
		$this->assertTrue((bool)strstr($resultsH, '<label for="TestTestArea" class="control-label">TestArea</label>'));
		$this->assertTrue((bool)strstr($resultsH, '<textarea name="data[Test][TestArea]" placeholder="Test placeholder" class="form-control" id="TestName">Lorem ispum</textarea>'));

	}
//
// Action testSubmit
///
	public function testSubmit()
	{
		$results = self::$Html->Submit(
			"TestButton",
			array('class' => "btn btn-primary")
		);

		$this->assertTrue((bool)strstr($results, '<button class="btn btn-primary">TestButton</button>'));

	}
//
// Action testFlash
///
	public function testFlash()
	{
		\Configure::write("Flash", array("message" => "My test message", "class" => "alert alert-danger"));
		$results = self::$Html->Flash();
		
		$this->assertEquals($results, '<div class="alert alert-danger alert-dismissable"><span>My test message</span><button class="close" data-dismiss="alert" aria-hidden="true">&times;</button></div>');
	}
//
// Action testPagination
///
	public function testPagination()
	{
		\Configure::$url["controller"] = "testController";
		\Configure::$url["action"] = "admin_test";
		\Configure::$url["param"] = array("Pag:0:10");
		$results = self::$Html->Pagination(
			"test"
		);

		$this->assertTrue((bool)strstr($results, '<li class="active"><a href="/admin/test/test/Pag:0">&laquo;</a></li>'));
		$this->assertTrue((bool)strstr($results, '<li class="active"><a href="/admin/test/test/Pag:0">1</a></li>'));
		$this->assertTrue((bool)strstr($results, '<li><a href="/admin/test/test/Pag:1">2</a></li>'));
		$this->assertTrue((bool)strstr($results, '<li><a href="/admin/test/test/Pag:1">&raquo;</a></li>'));

	}
//
// Action testPag_Sort
///
	public function testPag_Sort()
	{
		\Configure::$url["controller"] = "testController";
		\Configure::$url["action"] = "admin_test";
		\Configure::$url["param"] = array("Pag:0:10");
		$results = self::$Html->Pag_Sort(
			"testcol"
		);

		$this->assertEquals($results, '<a href="/admin/test/test/Pag:0:testcol:ASC">Testcol</a>');

	}
//
// Action testTime
///
	public function testTime()
	{
		$results = self::$Html->Time(
			"TimeAgo",
			date("Y-m-d h:i:s", strtotime("last week"))
		);

		$this->assertEquals($results, '1 week ago');

		$results = self::$Html->Time(
			"",
			"2014-01-31 12:05:35"
		);
		$this->assertEquals($results, '');

	}
}