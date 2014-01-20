<?php
namespace Frost\Configs;

/*
	@class Route
	@author Chris Sheppard
	@desc handles all routing within the system
*/
class Route {

	public static $route = array();

	public static function Routing() {
		self::$route[] = array('/retrieveCanLocations', array('controller' => 'illustrations', 'action' => 'canCoordiates'));
	}


}
