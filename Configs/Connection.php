<?php
namespace Frost\Configs;

/**
 *	@class Connection
 *	@author Chris Sheppard
 *	@description handles the connection init to the mysql server
 */
class Connection {
	private static $DB_SERVER = "127.0.0.1";
	private static $DB_NAME = "frost";
	private static $DB_USER = "root";
	private static $DB_PASS = "password";

	private static $DB_Test_SERVER = "127.0.0.1";
	private static $DB_Test_NAME = "frost_test";
	private static $DB_Test_USER = "root";
	private static $DB_Test_PASS = "password";

/**
 * [constructor]
 * @return [object]          [pdo connection]
 */
	public static function PDO() {
		if(LIVE) {
			return @new \PDO(
				"mysql:host=".self::$DB_SERVER.";dbname=".self::$DB_NAME,
				self::$DB_USER,
				self::$DB_PASS
			);
		} else {
			return @new \PDO(
				"mysql:host=".self::$DB_Test_SERVER.";dbname=".self::$DB_Test_NAME,
				self::$DB_Test_USER,
				self::$DB_Test_PASS
			);
		}

	}
}
