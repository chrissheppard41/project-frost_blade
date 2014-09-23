<?php

/**
 *	@class Validation
 *	@author Chris Sheppard
 *	@description handles the validation within the webpage
 */
class Validation {

/**
 * [method to handle the valdation when trying to save to the database using the valdiation array in the model]
 * @param  [int] $p_index []
 * @param  [string] $p_value []
 * @param  [array] $p_rules []
 * @param  [string] $p_model []
 * @param  [string] $p_type  []
 * @return [array]          []
 */
	public static function validate($p_index, $p_value, $p_rules, $p_model, $p_type = "add") {
//\Configure::pre($p_rules, false);
		$output = self::response(false, $p_index, null, $p_value[$p_index], false);
		//id should never be part of any save/update query
		if($p_index == "id")
			return self::response(false, $p_index, null, $p_value[$p_index], true);

		if(isset($p_rules[$p_index])){
			foreach($p_rules[$p_index] as $head => $value) {
//\Configure::pre($p_index, false);
//\Configure::pre($value, false);
				if(isset($value['ignore']) && in_array($p_type, $value['ignore'])) {

					if($p_value[$p_index] == "") {
						if($head == "match"
						&& $p_value[$p_index] == ""
						&& $p_value[$value['value']] != "") {
						} else {
							$output = self::response(false, $p_index, null, $p_value[$p_index], true);
							break;
						}

					}
				}

				if($head == "notempty"
				&& !isset($value['notempty']['ignore'])
				&& $p_value[$p_index] == ""
				) {
					$output = self::response(true, $p_index, $value["message"], $p_value[$p_index]);
					break;
				}
				if($head == "between" && !self::is_between($p_value[$p_index], $value["min"], $value["max"])) {
					$output = self::response(true, $p_index, $value["message"], $p_value[$p_index]);
					break;
				}
				if($head == "nospecial" && !self::has_no_special($p_value[$p_index])) {
					$output = self::response(true, $p_index, $value["message"], $p_value[$p_index]);
					break;
				}
				if($head == "match" && !self::match($p_value[$p_index], $p_value[$value['value']])) {
					$output = self::response(true, $p_index, $value["message"], $p_value[$p_index]);
					break;
				}
				if($head == "email" && !self::is_email($p_value[$p_index])) {
					$output = self::response(true, $p_index, $value["message"], $p_value[$p_index]);
					break;
				}
				if($head == "tinyint") {
					$output['value'] = (int)((isset($p_value[$p_index]))?(bool)$p_value[$p_index]:false);
					break;
				}
				if($head == "password") {
					$output['value'] = sha1(crypt($p_value[$p_index], CRYPTKEY.$p_value[$value['cryptwith']]));
					break;
				}
				if($head == "slug") {
					$output['value'] = substr(md5(uniqid(mt_rand()+$p_value[$value['cryptwith']], true)), 0, 16);
					break;
				}
				if($head == "match" && !$output["error"]) {
					$output = self::response(false, $p_index, null, $p_value[$p_index], true);
				}
				if($head == "numeric" && !self::numeric($p_value[$p_index])) {
					$output = self::response(true, $p_index, $value["message"], $p_value[$p_index]);
//\Configure::pre($output, false);
					break;
				}
			}
		}

		return $output;
	}

/**
 * [taking the response and posting it back to the validate]
 * @param  [string]  $error   []
 * @param  [int]  $key     []
 * @param  [string]  $message []
 * @param  [string]  $value   []
 * @param  [boolean] $skip    []
 * @return [array]           []
 */
	public static function response($error, $key, $message, $value, $skip = false) {
		return array(
			"error" => $error,
			"field" => $key,
			"message" => $message,
			"value" => $value,
			"skip" => $skip
		);
	}

/**
 * [is_email description]
 * @param  [string]  $string []
 * @return [boolean]         []
 */
	private static function is_email($string) {
		if (filter_var($string, FILTER_VALIDATE_EMAIL)) {
			return true;
		}
		return false;
	}
/**
 * [is_between description]
 * @param  [string]  $string []
 * @param  [int]  $min    []
 * @param  [int]  $max    []
 * @return [boolean]         []
 */
	private static function is_between($string, $min, $max) {
		$strlen = strlen ($string);
		if ($min <= $strlen && $strlen <= $max) {
			return true;
		}
		return false;
	}
/**
 * [has_no_special description]
 * @param  [string]  $string []
 * @return [boolean]         []
 */
	private static function has_no_special($string) {
		if (!preg_match("/[\"'^£$%&*()}{@#~?><>,|=_+¬-]/", $string)) {
			return true;
		}
		return false;
	}
/**
 * [match description]
 * @param  [string] $string  []
 * @param  [string] $string2 []
 * @return [boolean]          []
 */
	private static function match($string, $string2) {
		if ($string == $string2) {
			return true;
		}
		return false;
	}
/**
 * [numeric description]
 * @param  [int] $int []
 * @return [boolean]      []
 */
	private static function numeric($int) {
		if (is_numeric($int)) {
			return true;
		}
		return false;
	}

}
