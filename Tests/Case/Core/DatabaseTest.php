<?php
require PATH."Configs/Libs/Database.php";
define('DS', DIRECTORY_SEPARATOR);
//
//	@class DatabaseTest
//	@author Chris Sheppard
//	@desc The test controller that holds functionality within the framework
///
class DatabaseTest extends PHPUnit_Framework_TestCase
{
	private static $Database = null;
	private static $date = null;

	public static function setUpBeforeClass()
	{
		self::$Database = new \Frost\Configs\Database();
		self::$date = date("Y-m-d H:i:s");

		$query = self::$Database->query(array("query" => "CREATE TABLE test(
			id INT(11) NOT NULL AUTO_INCREMENT,
			testcol VARCHAR(100) NOT NULL,
			updatehere VARCHAR(100) NULL,
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
		$Database = new \Frost\Configs\Database();
	}
//
// Action testConfigureWrite
///
	public function testQuery()
	{
		$this->assertTrue((bool)self::$Database->query(array("query" => "SELECT * FROM test;", "params" => "")));
		$this->assertTrue((bool)self::$Database->query(array("query" => "SELECT * FROM test WHERE id = :id;", "params" => array(":id" => "1"))));
	}
/**
 * Action testBadQueryMissingTable
 * @expectedException PDOException
 */
	public function testBadQueryMissingTable()
	{
		$this->assertTrue((bool)self::$Database->query(array("query" => "SELECT * FROM tests;", "params" => "")));
	}
/**
 * Action testBadQueryMissingParams
 * @expectedException PDOException
 */
	public function testBadQueryMissingParams()
	{
		$this->assertTrue((bool)self::$Database->query(array("query" => "SELECT * FROM tests;", "params" => array("something"))));
	}
/**
 * Action testBadQuery
 * @expectedException PDOException
 */
	public function testBadQuery()
	{
		$this->assertTrue((bool)self::$Database->query(array("query" => "SELECT * FROM tests a;", "params" => array("something"))));
	}
//
// Action testQueryReturnCount
///
	public function testQueryReturnCount()
	{
		$query = self::$Database->query(array("query" => "SELECT * FROM test;", "params" => ""));
		$this->assertTrue((bool)self::$Database->returnCount($query));
	}
//
// Action testQueryReturnLastId
///
	public function testQueryReturnLastId()
	{
		$query = self::$Database->query(array("query" => "INSERT INTO test (testcol) VALUES (:val);", "params" => array(":val" => "test")));
		$id = self::$Database->returnLastId();
		$this->assertTrue((bool)$id);

		$this->assertTrue((bool)self::$Database->query(array("query" => "DELETE FROM test WHERE id = :id;", "params" => array(":id" => $id))));
	}
//
// Action testQueryResults
///
	public function testQueryResults()
	{
		$query = self::$Database->query(array("query" => "SELECT * FROM test;", "params" => array()));
		$results = self::$Database->results($query);


		$this->assertEquals(count($results), 15);
		$this->assertTrue(is_array($results));
	}
//
// Action testSave
///
	public function testSave()
	{
		$query = array(
			"test" => array(
				array(
					"testcol" 			=> "world",
					"updatehere" 		=> "hello"
				)
			)
		);


		$results = self::$Database->Save($query);
		$this->assertTrue($results);

		$last_id = self::$Database->returnLastId();

		$results = self::$Database->Find("first",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"condition" => array("id" => $last_id)
					)
				)
			)
		);
		$this->assertEquals($results['test']['testcol'], "world");
		$this->assertEquals($results['test']['updatehere'], "hello");

		$query = array(
			"test" => array(
				"condition" => array(
					"id" => $last_id
				)
			)
		);
		self::$Database->Delete($query);
	}

//
// Action testUpdate
///
	public function testUpdate()
	{
		$data_array = array(
			"testcol" 		=> "testing",
			"updatehere" 	=> self::$date
		);

		$query = array(
			"test" => array(
				array(
					"data" => $data_array,
					"condition" => array("id" => 15)
				)
			),
			"TEST" => array(
				array(
					"data" => $data_array,
					"condition" => array("id" => 14)
				)
			)
		);

		$results = self::$Database->Update($query);

		$this->assertTrue($results);

		$results = self::$Database->Find("first",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"condition" => array("id" => 15)
					)
				),
				"TEST" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"condition" => array("id" => 14)
					)
				)
			)
		);
		foreach($results as $values) {
			$this->assertEquals($values['testcol'], "testing");
			$this->assertEquals($values['updatehere'], self::$date);
		}

		$data_array = array(
			"testcol" 		=> "Changed",
			"updatehere" 	=> self::$date
		);

		$queryB = array(
			"test" => array(
				array(
					"data" => $data_array,
					"condition" => array("id" => 15, "testcol" => "testing")
				)
			),
			"TEST" => array(
				array(
					"data" => $data_array,
					"condition" => array("id" => 14)
				)
			)
		);
		$resultsB = self::$Database->Update($queryB);

		$this->assertTrue($resultsB);

		$resultsC = self::$Database->Find("all",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"condition" => array(
							"or" => array(
								"id" => array(14,15)
							)

						)
					)
				)
			)
		);

		foreach($resultsC["test"] as $values) {

			$this->assertEquals($values['testcol'], "Changed");
			$this->assertEquals($values['updatehere'], self::$date);
		}

		$data_array = array(
			"testcol" 		=> "Or Changed",
			"updatehere" 	=> self::$date
		);
		$queryD = array(
			"test" => array(
				array(
					"data" => $data_array,
					"condition" => array("or" => array("id" => array(14,15)))
				)
			)
		);
		$resultsD = self::$Database->Update($queryD);
		$this->assertTrue($resultsD);

		$resultsE = self::$Database->Find("all",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"condition" => array(
							"or" => array(
								"id" => array(14,15)
							)

						)
					)
				)
			)
		);

		foreach($resultsE["test"] as $values) {
			$this->assertEquals($values['testcol'], "Or Changed");
			$this->assertEquals($values['updatehere'], self::$date);
		}

	}
//
// Action testFindAll
///
	public function testFindAll()
	{
		$results = self::$Database->Find("all",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						)
					)
				)
			)
		);

		$resultsB = self::$Database->Find("all",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"condition" => array(
							"or" => array(
								"testcol" => "hello",
								"updatehere" => self::$date
							)
						)
					)
				)
			)
		);

		$resultsC = self::$Database->Find("all",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"condition" => array(
							"testcol" => "Or Changed",
							"updatehere" => self::$date
						)
					)
				)
			)
		);

		$expected = array(
			"test" => array(
				array("id" => 1,"testcol" => "hello","updatehere" => null),
				array("id" => 2,"testcol" => "hello","updatehere" => null),
				array("id" => 3,"testcol" => "hello","updatehere" => null),
				array("id" => 4,"testcol" => "hello","updatehere" => null),
				array("id" => 5,"testcol" => "hello","updatehere" => null),
				array("id" => 6,"testcol" => "hello","updatehere" => null),
				array("id" => 7,"testcol" => "hello","updatehere" => null),
				array("id" => 8,"testcol" => "hello","updatehere" => null),
				array("id" => 9,"testcol" => "hello","updatehere" => null),
				array("id" => 10,"testcol" => "hello","updatehere" => null),
				array("id" => 11,"testcol" => "hello","updatehere" => null),
				array("id" => 12,"testcol" => "hello","updatehere" => null),
				array("id" => 13,"testcol" => "hello","updatehere" => null),
				array("id" => 14,"testcol" => "Or Changed","updatehere" => self::$date),
				array("id" => 15,"testcol" => "Or Changed","updatehere" => self::$date)
			)
		);
		$expectedC = array(
			"test" => array(
				array("id" => 14,"testcol" => "Or Changed","updatehere" => self::$date),
				array("id" => 15,"testcol" => "Or Changed","updatehere" => self::$date)
			)
		);

		$this->assertEquals(count($results["test"]), 15);
		$this->assertTrue(is_array($results));
		$this->assertEquals($expected, $results);
		$this->assertEquals($expected, $resultsB);
		$this->assertEquals($expectedC, $resultsC);

	}
//
// Action testFindFirst
///
	public function testFindFirst()
	{
		$results = self::$Database->Find("first",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"condition" => array("id" => 1)
					)
				)
			)
		);

		$expected = array(
			"test" => array(
				"id" => 1,
				"testcol" => "hello",
				"updatehere" => null
			)
		);

		$this->assertTrue(is_array($results));
		$this->assertEquals($expected, $results);

	}
//
// Action testFindPagination
///
	public function testFindPagination()
	{
		\Configure::$url["controller"] = "testController";
		\Configure::$url["action"] = "admin_test";
		\Configure::$url["param"] = array("Pag:0");
		$results = self::$Database->Find("pagination",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"pagination" => 5
					)
				)
			)
		);

		$expected = array(
			"test" => array(
				array("id" => 1,"testcol" => "hello","updatehere" => null),
				array("id" => 2,"testcol" => "hello","updatehere" => null),
				array("id" => 3,"testcol" => "hello","updatehere" => null),
				array("id" => 4,"testcol" => "hello","updatehere" => null),
				array("id" => 5,"testcol" => "hello","updatehere" => null)
			)
		);

		$this->assertTrue(is_array($results));
		$this->assertEquals($expected, $results);

		$expectedB = array(
			"test" => array(
				array("id" => 9,"testcol" => "hello","updatehere" => null),
				array("id" => 8,"testcol" => "hello","updatehere" => null),
				array("id" => 7,"testcol" => "hello","updatehere" => null),
				array("id" => 6,"testcol" => "hello","updatehere" => null),
				array("id" => 5,"testcol" => "hello","updatehere" => null)
			)
		);
		\Configure::$url["param"] = array("Pag:1:testcol:ASC");
		$resultsB = self::$Database->Find("pagination",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"pagination" => 5
					)
				)
			)
		);

		$this->assertTrue(is_array($resultsB));
		$this->assertEquals($expectedB, $resultsB);

	}


//
// Action testPage
///
	public function testPage()
	{
		\Configure::$url["param"] = array();
		$results = self::$Database->Page(0);

		$expected = array(
			0,
			null,
			null
		);

		$this->assertEquals($expected, $results);
		$this->assertEquals("Pag:0:0", \Configure::$url["param"][0]);

		\Configure::$url["param"] = array("Pag:0");
		$results = self::$Database->Page(0);

		$expected = array(
		    0,
		   	null,
		    "ASC"
		);

		$this->assertEquals($expected, $results);
		$this->assertEquals("Pag:0:0", \Configure::$url["param"][0]);

		\Configure::$url["param"] = array("Pag:1:test:ASC");
		$results = self::$Database->Page(2);

		$expected = array(
		    1,
		   	"test",
		    "ASC"
		);

		$this->assertEquals($expected, $results);
		$this->assertEquals("Pag:1:test:ASC:2", \Configure::$url["param"][0]);

		\Configure::$url["param"] = array("Pag:2:testcol");
		$results = self::$Database->Page(2);

		$expected = array(
		    2,
		   	"testcol",
		    "ASC"
		);

		$this->assertEquals($expected, $results);
		$this->assertEquals("Pag:2:testcol:2", \Configure::$url["param"][0]);

		\Configure::$url["param"] = array("Pag:3:testcol:DESC");
		$results = self::$Database->Page(3);

		$expected = array(
		    3,
		   	"testcol",
		    "DESC"
		);

		$this->assertEquals($expected, $results);
		$this->assertEquals("Pag:3:testcol:DESC:3", \Configure::$url["param"][0]);

	}
//
// Action testPage
///
	public function testCache()
	{
		self::delete_directory("tmp" . DS . "cache" . DS . "test");

		$results = self::$Database->c_read("test", "file");
		$this->assertEmpty($results);

		$expected = array("My data here");
		self::$Database->c_write("test", "file", $expected);
		$results = self::$Database->c_read("test", "file");

		$this->assertEquals($results, $expected);

		self::$Database->c_delete("test", "file");
		$results = self::$Database->c_read("test", "file");
		$this->assertEmpty($results);

		self::delete_directory("tmp" . DS . "cache" . DS . "test");
	}
	private static function delete_directory($dirname) {
		$dir_handle = null;
		if (is_dir($dirname))
			$dir_handle = opendir($dirname);

		if (!$dir_handle)
			return false;

		while($file = readdir($dir_handle)) {
			   if ($file != "." && $file != "..") {
					if (!is_dir($dirname."/".$file))
						unlink($dirname."/".$file);
					else
						delete_directory($dirname.'/'.$file);
			   }
		}
		closedir($dir_handle);
		rmdir($dirname);
		return true;
	}

/**
 * Action testSaveException
 * @expectedException PDOException
 */
	public function testSaveException()
	{
		$query = array(
			"test_no_table" => array(
				array(
					"testcol" 			=> "world",
					"updatehere" 		=> "hello"
				)
			)
		);


		$results = self::$Database->Save($query);
	}
/**
 * Action testUpdateException
 * @expectedException PDOException
 */
	public function testUpdateException()
	{
		$query = array(
			"test_no_table" => array(
				array(
					"data" => array("something"),
					"condition" => array("id" => 15)
				)
			)
		);

		$results = self::$Database->Update($query);
	}
/**
 * Action testDeleteException
 * @expectedException PDOException
 */
	public function testDeleteException()
	{
		$query = array(
			"test_no_table" => array(
				"condition" => array(
					"id" => 1
				)
			)
		);
		self::$Database->Delete($query);
	}
/**
 * Action testFindException
 * @expectedException PDOException
 */
	public function testFindException()
	{
		$results = self::$Database->Find("first",
			array(
				"test_no_table" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"condition" => array("id" => 1)
					)
				)
			)
		);
	}
}