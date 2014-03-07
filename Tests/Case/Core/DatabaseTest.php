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
		self::$Database = new Test();
		self::$date = date("Y-m-d H:i:s");

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
				array("testcol" => "hello"),
				array("testcol" => "hello")
			)
		);
		$results = self::$Database->Save($query);

		$queryB = self::$Database->query(array("query" => "DROP TABLE IF EXISTS next;", "params" => ""));
		$queryB = self::$Database->query(array("query" => "CREATE TABLE next(
			id INT(11) NOT NULL AUTO_INCREMENT,
			tests_id INT(11) NOT NULL,
			name VARCHAR(100) NULL,
			created DATETIME,
			modified DATETIME,
			PRIMARY KEY ( id )
		);", "params" => ""));
		$queryB = array(
			"next" => array(
				array("tests_id" => 1, "name" => "test"),
				array("tests_id" => 2, "name" => "test2")
			)
		);
		$results = self::$Database->Save($queryB);


		$queryC = self::$Database->query(array("query" => "DROP TABLE IF EXISTS prev;", "params" => ""));
		$queryC = self::$Database->query(array("query" => "CREATE TABLE prev(
			id INT(11) NOT NULL AUTO_INCREMENT,
			tests_id INT(11) NOT NULL,
			name VARCHAR(100) NULL,
			created DATETIME,
			modified DATETIME,
			PRIMARY KEY ( id )
		);", "params" => ""));
		$queryC = array(
			"prev" => array(
				array("tests_id" => 1, "name" => "test"),
				array("tests_id" => 2, "name" => "test2")
			)
		);
		$results = self::$Database->Save($queryC);



		$queryD = self::$Database->query(array("query" => "DROP TABLE IF EXISTS relations;", "params" => ""));
		$queryD = self::$Database->query(array("query" => "CREATE TABLE relations(
			id INT(11) NOT NULL AUTO_INCREMENT,
			name VARCHAR(100) NOT NULL,
			created DATETIME,
			modified DATETIME,
			PRIMARY KEY ( id )
		);", "params" => ""));
		$queryD = array(
			"relations" => array(
				array("name" => "hello"),
			)
		);
		$results = self::$Database->Save($queryD);




		$queryE = self::$Database->query(array("query" => "DROP TABLE IF EXISTS testRelations;", "params" => ""));
		$queryE = self::$Database->query(array("query" => "CREATE TABLE testRelations(
			id INT(11) NOT NULL AUTO_INCREMENT,
			relations_id INT(11) NOT NULL,
			tests_id INT(11) NOT NULL,
			created DATETIME,
			modified DATETIME,
			PRIMARY KEY ( id )
		);", "params" => ""));
		$queryE = array(
			"testRelations" => array(
				array("relations_id" => "1","tests_id" => "1"),
			)
		);
		$results = self::$Database->Save($queryE);



		$queryF = self::$Database->query(array("query" => "DROP TABLE IF EXISTS company;", "params" => ""));
		$queryF = self::$Database->query(array("query" => "CREATE TABLE company(
			id INT(11) NOT NULL AUTO_INCREMENT,
			name VARCHAR(100) NOT NULL,
			created DATETIME,
			modified DATETIME,
			PRIMARY KEY ( id )
		);", "params" => ""));
		$queryF = array(
			"company" => array(
				array("name" => "test name"),
			)
		);
		$results = self::$Database->Save($queryF);

		$queryG = self::$Database->query(array("query" => "DROP TABLE IF EXISTS employee;", "params" => ""));
		$queryG = self::$Database->query(array("query" => "CREATE TABLE employee(
			id INT(11) NOT NULL AUTO_INCREMENT,
			name VARCHAR(100) NOT NULL,
			companys_id INT(11) NOT NULL,
			created DATETIME,
			modified DATETIME,
			PRIMARY KEY ( id )
		);", "params" => ""));
		$queryG = array(
			"employee" => array(
				array("name" => "employee 1","companys_id" => "1"),
				array("name" => "employee 2","companys_id" => "1"),
				array("name" => "employee 3","companys_id" => "1"),
			)
		);
		$results = self::$Database->Save($queryG);


	}
	public static function tearDownAfterClass()
	{
		$query = self::$Database->query(array("query" => "DROP TABLE test;", "params" => ""));
		$query = self::$Database->query(array("query" => "DROP TABLE next;", "params" => ""));
		$query = self::$Database->query(array("query" => "DROP TABLE prev;", "params" => ""));
		$query = self::$Database->query(array("query" => "DROP TABLE relations;", "params" => ""));
		$query = self::$Database->query(array("query" => "DROP TABLE testRelations;", "params" => ""));
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
				"testcol" 			=> "world",
				"updatehere" 		=> "hello"
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
						"conditions" => array("id" => $last_id)
					)
				)
			)
		);
		$this->assertEquals($results['test']['testcol'], "world");
		$this->assertEquals($results['test']['updatehere'], "hello");

		$query = array(
			"test" => array(
				"conditions" => array(
					"id" => $last_id
				)
			)
		);
		self::$Database->Delete($query);


		$queryB = array(
			"test" => array(
				"testcol" 			=> "world_the_second",
				"updatehere" 		=> "hello_the_second"
			),
			"TEST" => array(
				"testcol" 			=> "world_the_third",
				"updatehere" 		=> "hello_the_third"
			)
		);


		$resultsB = self::$Database->Save($queryB);

		$resultsC = self::$Database->Find("first",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id"
						),
						"conditions" => array("testcol" => "world_the_second")
					)
				),
				"TEST" => array(
					array(
						"fields" => array(
							"id"
						),
						"conditions" => array("testcol" => "world_the_third")
					)
				)
			)
		);

		$queryD = array(
			"test" => array(
				"conditions" => array(
					"or" => array("id" => array($resultsC["test"]["id"], $resultsC["TEST"]["id"]))
				)
			)
		);
		self::$Database->Delete($queryD);

		$queryE = array(
			"test" => array(
				array(
					"testcol" 			=> "world_the_forth",
					"updatehere" 		=> "hello_the_forth"
				),
				array(
					"testcol" 			=> "world_the_fifth",
					"updatehere" 		=> "hello_the_fifth"
				)
			)
		);


		$resultsE = self::$Database->Save($queryE);

		$resultsF = self::$Database->Find("first",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id"
						),
						"conditions" => array("testcol" => "world_the_forth")
					)
				),
				"TEST" => array(
					array(
						"fields" => array(
							"id"
						),
						"conditions" => array("testcol" => "world_the_fifth")
					)
				)
			)
		);

		$queryG = array(
			"test" => array(
				"conditions" => array(
					"or" => array("id" => array($resultsF["test"]["id"], $resultsF["TEST"]["id"]))
				)
			)
		);
		self::$Database->Delete($queryG);

		$queryH = array(
			"test" => array(
				array(
					"causeerror" 			=> null
				)
			)
		);
		$prev = new Prev();

		$resultsE = $prev->Save($queryH);

		$expectedE = array(
			'error' => true,
			'field' => "causeerror",
			'message' => "error",
			'value' => NULL,
			'skip' => false
		);

		$this->assertEquals($expectedE, $resultsE);



		$queryF = array(
			"test" => array(
				"testcol" 			=> "worldA",
				"updatehere" 		=> "helloA",
				"Relation" 			=> array(1)
			)
		);


		$resultsF = self::$Database->Save($queryF);
		$this->assertTrue($resultsF);

		$resultsG = self::$Database->Find("first",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"contains" => array( "Relation" => array() ),
						"conditions" => array("testcol" => "worldA")
					)
				)
			)
		);

		$this->assertEquals($resultsG['test']['testcol'], "worldA");
		$this->assertEquals($resultsG['test']['updatehere'], "helloA");

		$this->assertEquals($resultsG['test']['Relation'][0]["name"], "hello");

		$queryH = array(
			"test" => array(
				"conditions" => array(
					"or" => array("id" => $resultsG['test']["id"])
				)
			)
		);
		self::$Database->Delete($queryH);


	}

//
// Action testValidation
///
	public function testValidation()
	{
		$prev = new Prev();
		$query = array(
			"prev" => array(
				"tests_id" 		=> "1",
				"name" 			=> "test",
				"confirm_name" 	=> "test"
			)
		);

		$results = $prev->Save($query);

		$resultsF = self::$Database->Find("first",
			array(
				"prev" => array(
					array(
						"fields" => array(
							"id"
						),
						"conditions" => array("name" => "test")
					)
				)
			)
		);

		$queryG = array(
			"prev" => array(
				"conditions" => array(
					"id" => $resultsF["prev"]["id"]
				)
			)
		);
		self::$Database->Delete($queryG);
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
				"data" => $data_array,
				"conditions" => array("id" => 15)
			),
			"TEST" => array(
				"data" => $data_array,
				"conditions" => array("id" => 14)
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
						"conditions" => array("id" => 15)
					)
				),
				"TEST" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"conditions" => array("id" => 14)
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
				"data" => $data_array,
				"conditions" => array("id" => 15, "testcol" => "testing")
			),
			"TEST" => array(
				"data" => $data_array,
				"conditions" => array("id" => 14)
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
						"conditions" => array(
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
				"data" => $data_array,
				"conditions" => array("or" => array("id" => array(14,15)))
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
						"conditions" => array(
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


		$queryF = array(
			"test" => array(
				"data" => $data_array,
				"conditions" => array("id" => 15)
			)
		);


		self::$Database->Update(
			array(
				"test" => array(
					"testcol" => "Derpieder"
				)
			),
			array(
				"or" => array(
					"id" => array(14,15)
				)
			)
		);

		$resultsF = self::$Database->Find("all",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"conditions" => array(
							"or" => array(
								"id" => array(14,15)
							)

						)
					)
				)
			)
		);

		foreach($resultsF["test"] as $values) {
			$this->assertEquals($values['testcol'], "Derpieder");
		}


		self::$Database->Update(
			array(
				array(
					"test" => array(
						"data" => array("testcol" => "Or Changed"),
						"conditions" => array("id" => 15)
					)
				),
				array(
					"test" => array(
						"data" => array("testcol" => "Or Changed"),
						"conditions" => array("id" => 14)
					)
				)
			)
		);

		$resultsG = self::$Database->Find("all",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"conditions" => array(
							"or" => array(
								"id" => array(14,15)
							)

						)
					)
				)
			)
		);

		foreach($resultsG["test"] as $values) {
			$this->assertEquals($values['testcol'], "Or Changed");
		}





		self::$Database->Update(
			array(
				array(
					"test" => array(
						"data" => array("testcol" => "Or Changed", "Relation" => array(1)),
						"conditions" => array("id" => 15),

					)
				),
				array(
					"test" => array(
						"data" => array("testcol" => "Or Changed", "Relation" => array(2)),
						"conditions" => array("id" => 14)
					)
				)
			)
		);

		$resultsH = self::$Database->Find("all",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"conditions" => array(
							"or" => array(
								"id" => array(14,15)
							)

						),
						"contains" => array( "Relation" => array() )
					)
				)
			)
		);
		$expectedHa = array(
			array(
				"id" => null,
				"name" => null
			)
		);
		$expectedHb = array(
			array(
				"id" => 1,
				"name" => "hello"
			)
		);
		$this->assertEquals($resultsH["test"][0]["Relation"], $expectedHa);
		$this->assertEquals($resultsH["test"][1]["Relation"], $expectedHb);

	}


//
// Action testHasManyFind
///
	public function testHasManyFind()
	{
		$company = new Company();
		$results = $company->Find("all",
			array(
				"company" => array(
					array(
						"fields" => array(
							"id",
							"name"
						),
						"contains" => array( "Employee" => array() )
					)
				)
			)
		);
		$expected = array(
			"company" => array(
				array(
					"id" => 1,
					"name" => "test name",
					"Employee" => array(
						array(
							"id" => 1,
							"name" => "employee 1"
						),
						array(
							"id" => 2,
							"name" => "employee 2"
						),
						array(
							"id" => 3,
							"name" => "employee 3"
						)
					)
				)
			)
		);
		$this->assertEquals($expected, $results);

		$resultsB = $company->Find("first",
			array(
				"company" => array(
					array(
						"fields" => array(
							"id",
							"name"
						),
						"contains" => array( "Employee" => array() )
					)
				)
			)
		);

		$expectedB = array(
			"company" => array(
				"id" => 1,
				"name" => "test name",
				"Employee" => array(
					array(
						"id" => 1,
						"name" => "employee 1"
					),
					array(
						"id" => 2,
						"name" => "employee 2"
					),
					array(
						"id" => 3,
						"name" => "employee 3"
					)
				)
			)
		);
		$this->assertEquals($expectedB, $resultsB);

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
						"conditions" => array(
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
						"conditions" => array(
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




		$resultsG = self::$Database->Find("all",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"contains" => array( "Relation" => array() )
					)
				)
			)
		);

		$expectedE = array(
			"id" => 2,
			"testcol" => "hello",
			"updatehere" => null
		);

		$this->assertEquals("15", $resultsG["test"][14]["id"]);
		$this->assertEquals("Or Changed", $resultsG["test"][14]["testcol"]);
		$this->assertEquals(array(array("id" => 1,"name" => "hello")), $resultsG["test"][14]["Relation"]);

		$this->assertEquals($expectedE, $resultsB["test"][1]);

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
						"conditions" => array("id" => 1)
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


		$results = self::$Database->Find("first",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"conditions" => array("id" => array(1,2,3))
					)
				)
			)
		);
		;
		$this->assertEmpty($results["test"]);


	}

//
// Action testFindContains
///
	public function testFindContains()
	{
		$results = self::$Database->Find("all",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"contains" => array(
							"next" => array(
								"fields" => array(
									"next.name"
								),
								"relation" => array(
									"test.id",
									"next.tests_id"
								)
							)
						),
						"conditions" => array("test.id" => 1)
					)
				)
			)
		);

		$expected = array(
			"test" => array(
				array(
					"id" 			=> 1,
					"testcol" 		=> "hello",
					"updatehere" 	=> null,
					"name" 			=> "test"
				)
			)
		);

		$this->assertEquals($expected, $results);

	}
//
// Action testDeleteContains
///
	public function testDeleteContains()
	{
		$query = array(
			"test" => array(
				"conditions" => array(
					"id" => 15
				)
			)
		);
		self::$Database->Delete($query);


		$results = self::$Database->Find("first",
			array(
				"test" => array(
					array(
						"fields" => array(
							"id",
							"testcol",
							"updatehere"
						),
						"contains" => array(
							"Relation" => array()
						),
						"conditions" => array("test.id" => 15)
					)
				)
			)
		);

		$this->assertEmpty($results["test"]);
	}
//
// Action testExists
///
	public function testExists()
	{
		$results = self::$Database->Exists(1);
		$this->assertTrue($results);

		$resultsB = self::$Database->Exists(array("testcol" => "hello"));
		$this->assertTrue($resultsB);

		$resultsC = self::$Database->Exists(0);
		$this->assertFalse($resultsC);
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
				"data" => array("something"),
				"conditions" => array("id" => 15)
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
				"conditions" => array(
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
						"conditions" => array("id" => 1)
					)
				)
			)
		);
	}
}


class Test extends \Frost\Configs\Database {
	function __construct() {
		parent::__construct();
	}

	protected $table = "test";

	protected $relationships = array(
		"Relation" => array(
			"type" => "HABTM",
			"linktable" => "testRelations",
			"lefttable" => "relations",
			"leftcols" => array("relations.id","relations.name"),
			"linkColumn" => "relations_id",
			"baseColumn" => "tests_id"
		)
	);
}
class Company extends \Frost\Configs\Database {
	function __construct() {
		parent::__construct();
	}

	protected $table = "company";

	protected $relationships = array(
		"Employee" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "employee",
			"leftcols" => array("employee.id","employee.name"),
			"linkColumn" => "companys_id",
			"baseColumn" => "id"
		)
	);
}
class Prev extends \Frost\Configs\Database {
	function __construct() {
		parent::__construct();
	}

	protected $table = "prev";
	protected $validation = array(
		"confirm_name" => array(
			"match" => array(
				"value" => "name",
				"message" => "Your field must match the name field",
				"ignore" => array("edit","add")
			)
		),
		"causeerror" => array(
			"notempty" => array(
				"message" => "error"
			)
		)
	);
}