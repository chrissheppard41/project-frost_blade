<?php
namespace Frost\Controller;

/**
 * @class Controller
 * @author Chris Sheppard
 * @description handles the routing control mapping the url to a controller/action
 */
class Controller {

	public $pass_back 			= null;
	public $requestData 		= null;
	public $return_request 		= null;
	public $view_vendor 		= array();
	public $model 				= null;


/**
 * [Launches the correct controller and matches the action against a method, passes the params into that method and listens for the $_post]
 * @param [string] $name       [name of the controller/model]
 * @param [string] $action     [name of the method]
 * @param [array]  $params     [contains url input]
 * @param [array]  $methodData [form data]
 *
 * @throws   If [no $name set] - WebException
 * @throws   If [no file exists] - WebException
 * @throws   If [no class exists] - WebException
 * @throws   If [no method exists] - WebException
 * @throws   If [method doesn't pass back response] - WebException
 * @throws   If [layout doesn't exist] - WebException
 * @throws   If [json layout doesn't exist] - WebException
 */
	function __construct($name, $action, $params = array(), $methodData = array()) {

		if($name == "Controller") {
			$name = "PagesController";
			$action = "index";
		}
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
        $conAcc = ((isset($conAct->access))?$conAct->access:null);

        $conAct->Before($action, $conAcc);

        if(method_exists($conAct,$action)) {
			$conAct->model = $this->LoadClass(ucfirst($model_name), $params, $methodData);
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
		if(!file_exists($_SERVER['DOCUMENT_ROOT'].DS."View".DS.$model_name.DS.$action.".typ") && $this->return_request != "json") {
			throw new \WebException(sprintf("Layout file %s does not exist within %s list", $action, $model_name), 404);
		}

		$this->view_vendor = array(
			"view" => $conAct->view,
			"model_name" => $model_name,
			"action" => $action
		);
	}

/**
 * [Actions to be executed before page loads]
 * @param  [string] $action [method in requestion]
 * @param  [array] $access [used for auth]
 */
    public function before($action, $access) {
    	if((bool)strstr($action, "admin_") == true && !(bool)\Configure::User("is_admin")) {
    		$this->Flash("You are not allowed to access this part of the site", "alert alert-danger", '/');
    	}
    	if(isset($access) && !empty($access)) {
	    	if(in_array($action,$access['deny']) && !\Configure::Logged()) {
	    		$this->Flash("You must log in to see this part of the site", "alert alert-info", array('controller' => 'users', 'action' => 'login'));
	    	}
	    }

	    if(\Configure::Logged() && ((bool)strstr($action, "login") == true || (bool)strstr($action, "register") == true)) {
	    	$this->Flash("You are currently logged in", "alert alert-info", '/');
	    }
    }

/**
 * [tries and loads a Model class safely within the system not reusing existing resources]
 * @param [string] $class           [name of the class]
 * @param [array]  $url_options     [contains url input]
 * @param [array]  $inputted_values [form data]
 * @return   [object]          [response]
 */
	public function LoadClass($class, $url_options = array(), $inputted_values = array()) {
		$class_name = "\Frost\Model\\".$class;
		if(!class_exists("\Frost\Model\\".$class)) {
			if(!file_exists($_SERVER['DOCUMENT_ROOT'].DS."Model".DS.ucfirst($class).".php")) {
				throw new \WebException(sprintf("File %s does not exist within Model list", $class), 404);
			}
			require PATH."Model/".ucfirst($class).".php";
		}
		return new $class_name($url_options, $inputted_values);
	}

/**
 * [Checks to see if the request method type matches the one expected]
 * @param  [string] $method [get the method type]
 * @return [bool]         []
 */
	public function requestType($method = "GET") {
		if($_SERVER['REQUEST_METHOD'] == $method) {
			/*$token = \Configure::read("Token");
			if($_SERVER['REQUEST_METHOD'] == "POST" && isset($token)) {
				if($token["Token".$_POST['data']["_Token"]["key"]] != $_POST['data']["_Token"]["val"]) {
					return false;
				}
				\Configure::delete("Token");
			}*/
			return true;
		}
		return false;
	}

/**
 * [Writes an flash message to appear on the site]
 * @param [string] $message  [the message to be outputed]
 * @param [string] $class  [css styles]
 * @param [array] $redirect [the redirect url]
 */
	public function Flash($message, $class = "alert alert-info", $redirect = null) {
		//if($this->requestType("POST")) return ;
		$path = $redirect;
		\Configure::write("Flash", array("message" => $message, "class" => $class));
		if(is_array($redirect)) {
			if(isset($redirect) && !empty($redirect)) {
				if($redirect['admin'] == true) {
					$redirect['controller'] = "admin/".$redirect['controller'];
					$redirect['action'] = str_replace("admin_","",$redirect['action']);
				}
				$params = "";
				if(isset($redirect['params'])) {
					foreach($redirect['params'] as $value)
						$params .= "/".$value;
				}

				$path = "/".$redirect['controller']."/".$redirect['action'].$params;
			}
		}
		if(isset($path)) {
			header("Location: ".$path);
			die;
		}
	}

/**
 * [check that required params have been supplied and generate response for an invalid request]
 * @param  [array]  $suppliedParams [the submitted array of items]
 * @param  [array]  $requiredParams [the base array of required items]
 * @return boolean                 []
 */
	protected function _hasRequiredParams($suppliedParams, $requiredParams) {
		$diff = array_diff_key($suppliedParams, $requiredParams);
		return !empty($diff);
	}
}
