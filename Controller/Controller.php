<?php
namespace Frost\Controller;

/*
	@class Controller
	@author Chris Sheppard
	@desc handles the routing control mapping the url to a controller/action
*/
class Controller {

	public $pass_back 			= null;
	public $requestData 		= null;
	public $return_request 		= null;
	public $view_vendor 		= array();


/**
 * __construct method
 * Launches the correct controller and matches the action against a method, passes the params into that method and listens for the $_post
 *
 * @param $name (string), $action (string), $params (array), methodData (array),
 * @return (bool)
 */
	function __construct($name, $action, $params = array(), $methodData = array()) {

		$model_name = str_replace("Controller","", $name);
		if($name == "Controller" || !isset($action)) {
			throw new \WebException(sprintf("API controller or action or both have not been set"), 404);
		}

		$this->requestData = $methodData;

		if(!class_exists("\Frost\Controller\\".$name)) {
			if(!file_exists($_SERVER['DOCUMENT_ROOT'].DS."Controller".DS.ucfirst($name).".php")) {
				throw new \WebException(sprintf("File %s does not exist within Controller list", $name), 404);
			}
			require $name.".php";
		}

		if(!class_exists("\Frost\Controller\\".$name)) {
			throw new \WebException(sprintf("Controller %s does not exist within Controller list", $name), 404);
		}
        $class = "\Frost\Controller\\".$name;
        $conAct = new $class();

        if(method_exists($conAct,$action)) {
        	$this->pass_back = $conAct->$action($params, $methodData);
        } else {
        	throw new \WebException(sprintf("Action %s does not exist within Controller %s", $action, $name), 404);
        }

		if($this->pass_back == null) {
			throw new \WebException('API Controller ('.$name.') or Action ('.$action.') is missing data.', 400);
		}
		$this->return_request = $conAct->returnType;

		if(!file_exists($_SERVER['DOCUMENT_ROOT'].DS."View".DS."Layout".DS.$conAct->view.".typ")) {
			throw new \WebException(sprintf("Layout file %s does not exist within View list", $conAct->view), 404);
		}
		if(!file_exists($_SERVER['DOCUMENT_ROOT'].DS."View".DS.$model_name.DS.$action.".typ")) {
			throw new \WebException(sprintf("Layout file %s does not exist within %s list", $action, $model_name), 404);
		}

		$this->view_vendor = array(
			"view" => $conAct->view,
			"model_name" => $model_name,
			"action" => $action
		);
	}

/**
 * LoadClass method
 * tries and loads a Model class safely within the system not reusing existing resources
 *
 * @param $method (string)
 * @return (bool)
 */
	public function LoadClass($class, $url_options, $inputted_values) {
		$class_name = "\Budlight\Model\\".$class;
		if(!class_exists("\Budlight\Model\\".$class)) {
			if(!file_exists($_SERVER['DOCUMENT_ROOT'].DS."Model".DS.ucfirst($class).".php")) {
				throw new \WebException(sprintf("File %s does not exist within Model list", $class), 404);
			}
			require PATH."Model/".ucfirst($class).".php";
		}
		return new $class_name($url_options, $inputted_values);
	}

/**
 * requestType method
 * Checks to see if the request method type matches the one expected
 *
 * @param $method (string)
 * @return (bool)
 */
	public function requestType($method = "GET") {
		if($_SERVER['REQUEST_METHOD'] == $method) {
			return true;
		}
		return false;
	}

}
