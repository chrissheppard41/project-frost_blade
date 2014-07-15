<?php
namespace Frost\Configs;

/*
	@class Route
	@author Chris Sheppard
	@desc handles all routing within the system
*/
class Route {

	private static $route = array();
	private static $url = array();
/**
 * Routing method
 * Index's all the Races
 *
 * @param
 * @return (array)
 */
	private static function Routing() {
		self::$route = array(
			'armytypes' 			=> array("controller" => "RacesController", "action" => "racetypes", "param" => array()),
			'access' 				=> array("controller" => "SocialsController", "action" => "generate", "param" => array()),
			'squads/:?/:?' 			=> array("controller" => "SquadsController", "action" => "squads_race", "param" => array()),
			'squads_units/:?/:?' 	=> array("controller" => "SquadsController", "action" => "squads_units", "param" => array()),
			'armies/:?' 			=> array("controller" => "ArmyListsController", "action" => "armies", "param" => array()),
			'armies_all' 			=> array("controller" => "ArmyListsController", "action" => "armies_all", "param" => array()),
			'add/save' 				=> array("controller" => "ArmyListsController", "action" => "save_army", "param" => array()),
			'view_army/:?'			=> array("controller" => "ArmyListsController", "action" => "view_army", "param" => array()),
			'delete_army/:?'		=> array("controller" => "ArmyListsController", "action" => "delete_army", "param" => array()),
			'edit/save/:?'			=> array("controller" => "ArmyListsController", "action" => "edit_save_army", "param" => array()),
			'save_units/:?'			=> array("controller" => "ArmyListsController", "action" => "save_units", "param" => array()),
			'get_army/:?'			=> array("controller" => "ArmyListsController", "action" => "get_army", "param" => array()),
			'vote/:?/:?' 			=> array("controller" => "ArmyListsController", "action" => "vote", "param" => array()),
			'types'					=> array("controller" => "TypesController", "action" => "unit_types", "param" => array())
		);
	}
/**
 * getRoute method
 * Index's all the Races
 *
 * @param
 * @return (array)
 */
	public static function getRoute($url) {
		self::Routing();

		$urldata = self::stripUrlElements($url);
		if($urldata != null) {
			$url = self::$route[$urldata];
		} else {
			$url = self::baseUrl($url);
		}

		return $url;
	}
/**
 * stripUrlElements method
 *
 *
 * @param $url (array)
 * @return (array)
 */
	private static function baseUrl($url) {
		$url = explode("/", $url);

		$append = "";
		if($url[0] == "admin") {
			$append = "admin_";
			unset($url[0]);
			$url = array_values($url);
		}

		$i = 0;
		$output["controller"] = ucfirst($url[$i]) . "Controller";
		unset($url[$i]);
		$i++;
		$output["action"] = (isset($url[$i]))?$append.$url[$i]:null;
		unset($url[$i]);
		$i++;
		$output["param"] = (!empty($url))?array_values($url):array();

		return $output;
	}

/**
 * stripUrlElements method
 *
 *
 * @param $url (array)
 * @return (array)
 */
	private static function stripUrlElements($url) {

		$routeURL = array_keys(self::$route);
		$routeInd = 0;
		$routeMax = count($routeURL);

		$currentURL = explode("/", $url);
		$currentInd = 0;
		$currentMax = count($currentURL)-1;


		return self::findUrl($routeURL, $routeInd, $routeMax, $currentURL, $currentInd, $currentMax);
	}


/**
 * findUrl method
 *
 *
 * @param $_r_url (array)
 * @param $_$_r_id (int)
 * @param $_r_max (int)
 * @param $_c_url (array)
 * @param $_c_id (int)
 * @param $_c_max (int)
 * @return (array)
 */
	private static function findUrl($_r_url, $_r_id, $_r_max, $_c_url, $_c_id, $_c_max) {
		if($_r_id >= $_r_max) {
			return null;
		}
		$split_route = explode("/", $_r_url[$_r_id]);
		if($split_route[$_c_id] == $_c_url[$_c_id] || ($split_route[$_c_id] == ":?" && isset($_c_url[$_c_id])) && $_c_max == count($split_route)-1) {
			$index = $_r_url[$_r_id];
			if($split_route[$_c_id] == ":?") {
				self::$route[$index]["param"][] = $_c_url[$_c_id];
			}

			if($_c_id >= $_c_max){
				return $index;
			}

			$_c_id++;
			return self::findUrl($_r_url, $_r_id, $_r_max, $_c_url, $_c_id, $_c_max);
		}

		$_r_id++;
		return self::findUrl($_r_url, $_r_id, $_r_max, $_c_url, $_c_id, $_c_max);
	}



}
