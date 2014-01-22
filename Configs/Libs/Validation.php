<?php

/**
 *	@class Validation
 *	@author Chris Sheppard
 *	@desc handles the validation within the webpage
 */
class Validation {

	public static function validate($rules, $model) {

		//echo "<pre>".print_r($rules, true)."</pre>";
		//echo "<pre>".print_r($_POST['data']['User'], true)."</pre>";

		$output = array(
			"error" => false,
			"field" => null,
			"message" => null
		);

		foreach($rules as $key => $value) {

			if(isset($value['notempty']) && array_keys($value['notempty']) == true) {
				if(in_array($key, array_keys($_POST['data'][$model]))) {

					if($_POST['data'][$model][$key] == "") {
						$output = self::response($key, $value["notempty"]["message"]);
						break;
					}

				}
			}

			if(isset($_POST['data'][$model][$key])) {
				foreach($value as $key2 => $value2) {
					if($key2 == "email" && !self::is_email($_POST['data'][$model][$key])) {
						$output = self::response($key, $value["email"]["message"]);
						break;
					}
					if($key2 == "between" && !self::is_between($_POST['data'][$model][$key], $value["between"]["min"], $value["between"]["max"])) {
						$output = self::response($key, $value["between"]["message"]);
						break;
					}
					if($key2 == "nospecial" && !self::has_no_special($_POST['data'][$model][$key])) {
						$output = self::response($key, $value["nospecial"]["message"]);
						break;
					}
					if($key2 == "match" && !self::match($_POST['data'][$model][$key], $_POST['data'][$model][$value2['value']])) {
						$output = self::response($key, $value["match"]["message"]);
						break;
					}
				}
			}
		}

		return $output;
	}

	private static function response($key, $message) {
		return array(
			"error" => true,
			"field" => $key,
			"message" => $message
		);
	}

	private static function is_email($string) {
		if (filter_var($string, FILTER_VALIDATE_EMAIL)) {
			return true;
		}
		return false;
	}
	private static function is_between($string, $min, $max) {
		$strlen = strlen ($string);
		if ($min < $strlen && $strlen < $max) {
			return true;
		}
		return false;
	}
	private static function has_no_special($string) {
		if (!preg_match("/[\"'^£$%&*()}{@#~?><>,|=_+¬-]/", $string)) {
			return true;
		}
		return false;
	}
	private static function match($string, $string2) {
		if ($string == $string2) {
			return true;
		}
		return false;
	}

}
