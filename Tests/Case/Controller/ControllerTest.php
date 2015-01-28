<?php
DEFINE("LIVE", false);
DEFINE("PATH", "../../");
require PATH."Configs/Core.php";

/**
 *	@class ControllerTest
 *	@author Chris Sheppard
 *	@desc The main controller test handler
 */
class ControllerTest extends PHPUnit_Framework_TestCase
{
	public static $connection = null;

	private static $DB_Test_SERVER = "127.0.0.1";
	private static $DB_Test_NAME = "frost_test";
	private static $DB_Test_USER = "root";
	private static $DB_Test_PASS = "password";

	public static function setUpBeforeClass()
	{
		self::$connection = @new \PDO(
				"mysql:host=".self::$DB_Test_SERVER.";dbname=".self::$DB_Test_NAME,
				self::$DB_Test_USER,
				self::$DB_Test_PASS
			);
		self::$connection->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
	}

	public static function tearDownAfterClass()
	{
		/*$q = self::$connection->prepare("TRUNCATE user_logging");
		$q->execute();
		$q = self::$connection->prepare("TRUNCATE user_done");
		$q->execute();

		$q = self::$connection->prepare("SET FOREIGN_KEY_CHECKS = 0");
		$q->execute();
		$q = self::$connection->prepare("TRUNCATE participants");
		$q->execute();
		$q = self::$connection->prepare("SET FOREIGN_KEY_CHECKS = 1");
		$q->execute();*/
	}

/**
 * Action method
 * Simulates the HTTP request
 *
 * @param $url (string), $options (array)
 * @return (string)
 */
	public function Action($url, $options = array()) {

		if(empty($_SERVER['DOCUMENT_ROOT'])) {
			$_SERVER['DOCUMENT_ROOT'] = "\www\budlight";
		}

		$_SERVER['REQUEST_METHOD'] = "GET";
		$_SERVER['REQUEST_URI'] = $url;
		$_SERVER['REMOTE_ADDR'] = "127.0.0.1";

		if(!empty($options)) {

			$_SERVER['REQUEST_METHOD'] = $options['method'];

			if($options['method'] == "POST") {
				if(!empty($options['data'])) {
			   		$_POST = $options['data'];
				} else {
					$_POST = null;
				}
			}
			if(isset($options['remote_address'])) {
				$_SERVER['REMOTE_ADDR'] = $options['remote_address'];
			}

		}
		$core = new Budlight\Configs\Core();
		return $core->load();

	}
/**
 * awesome <pre> wrapper method
 *
 * @param ( mixed ) $data
 * @param ( bool ) $doDie
 * @return ( bool ) || ( void )
 */
	public function Debug($data, $doDie = true) {
		echo "<pre>";

		if (is_array($data)) {
			print_r($data);
		} else {
			var_dump($data);
		}

		echo "</pre>";

		if ($doDie) {
			die();
		}

		return true;
	}


/**
 * assertMay method
 * The submitted values May contain
 *
 * @param $expected (array), $actual (mixed)
 * @return (bool)
 */
	public function assertMay($expected, $actual) {

		if(in_array($actual, $expected)) {
			$this->assertTrue(true);
			return true;
		}
		$this->assertTrue(false);
		return false;
	}

//
// Action testCase
///
	public function testCase()
	{
		$this->assertTrue(true);
	}
}