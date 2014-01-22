<?php

namespace Frost\Configs;
session_start();

define('DS', DIRECTORY_SEPARATOR);

require "Libs/Database.php";
require "Libs/Logging.php";
require "WebException.php";
require "Libs/Crypt.php";
require "Libs/Html.php";
require "Libs/Session_handler.php";
require "Libs/Session.php";
require "Libs/Configure.php";
require "Libs/Validation.php";
require "Bootstrap.php";
require (PATH."Controller/Controller.php");

/**
 *	@class Core
 *	@author Chris Sheppard
 *	@desc The main driver for this mvc type framework
 */
class Core {
	private $database 	= null;
	private $url 		= null;
	private $codes = array(
		200 => 'OK',
		400 => 'Bad Request',
		401 => 'Unauthorized',
		402 => 'Payment Required',
		403 => 'Forbidden',
		404 => 'Not Found',
		405 => 'Method Not Allowed',
		406 => 'Not Acceptable',
		407 => 'Proxy Authentication Required',
		408 => 'Request Time-out',
		500 => 'Internal Server Error',
		501 => 'Not Implemented',
		502 => 'Bad Gateway',
		503 => 'Service Unavailable',
		504 => 'Gateway Time-out',
	);
	private $exception 		= null;
	private $crypt 			= null;
	public $Html 			= null;
	public $Session 		= null;

	function __construct() {
		$this->crypt = new Crypt(CRYPTKEY);
		$this->Html = new Html();
		$this->Session = new Session();

		$this->url = $this->urlParsing();
	}

/**
 * load method
 * The main method of the framework. Creates the connection to the database, maps the path to take to the controller/action. generates the JSON response, logs all traffic and errors
 *
 * @param
 * @return (string)
 */
	public function load() {
		$action_data = array(
			"code" => 200,
			"message" => "Stand API",
			"data" => array(),
			"errors" => array()
		);
		$request = "text";
		$view = array(
			"view" => "Default",
			"model_name" => null,
			"action" => null
		);

		try {
			$this->database = new Database();

			//if(LIVE)
			//	Logging::Access();

			$controller = new \Frost\Controller\Controller(
				$this->url['controller'],
				isset($this->url['action']) ? $this->url['action'] : '',
				$this->url['param'],
				$_POST
			);

			$action_data = $controller->pass_back;

			$request = $controller->return_request;
			$view = $controller->view_vendor;

		} catch(\WebException $webEx) {
			$action_data = array(
				"code" 			=> $webEx->getWebCode(),
				"message" 		=> "Web system error",
				"errors" 		=> array("message" => $webEx->getMessage()),
				"trace" 		=> $webEx->getTraceAsString()
			);
			$request = "error";
			if(LIVE == "core")
				Logging::Error($webEx->getMessage(), $webEx->getWebCode(), $webEx->getTraceAsString());
		} catch(\Exception $ex) {
			$action_data = array(
				"code" 			=> 400,
				"message" 		=> "System error",
				"errors" 		=> array("message" => $ex->getMessage()),
				"trace" 		=> $ex->getTraceAsString()
			);
			$request = "error";
			if(LIVE == "core")
				Logging::Error($ex->getMessage(), 400, $ex->getTraceAsString());
		} catch(\PDOException $pdoEx) {
			$action_data = array(
				"code" 			=> 500,
				"message" 		=> "Database error",
				"errors" 		=> array("message" => $pdoEx->getMessage()),
				"trace" 		=> $pdoEx->getTraceAsString()
			);
			$request = "error";
			if(LIVE == "core")
				Logging::Error($pdoEx->getMessage(), 500, $pdoEx->getTraceAsString());
		} finally {
			return $this->output($action_data, $request, $view);
		}
	}


/**
 * urlParsing method
 * breaks the URL string apart to figure out what controller to open, whate mthod to run, what paramters to pass
 *
 * @param
 * @return (string)
 */
	private function urlParsing() {

		$params    							= explode('?', substr($_SERVER['REQUEST_URI'], 1));
		$parsedURLParams 					= explode('/', $params[0]);
		$output 							= array();

		$urlmax 							= count($parsedURLParams)-1;
		$info 								= pathinfo($parsedURLParams[$urlmax]);
		$parsedURLParams[$urlmax] 			= isset($info['filename']) ? $info['filename'] : '';
		$output['ext'] 						= isset($info['extension']) ? $info['extension'] : '';

		$append = "";
		if($parsedURLParams[0] == "admin") {
			$append = "admin_";
			unset($parsedURLParams[0]);
			$parsedURLParams = array_values($parsedURLParams);
		}

		foreach($parsedURLParams as $key => $values) {

			if($key == 0) {
				$output['controller'] 		= ucfirst($values) . "Controller";
			} else if($key == 1) {
				$output['action'] 			= $append.$values;
			} else {
				$output['param'][] 			= $values;
			}

		}
		if(empty($output['param'])) {
			$output['param'] 				= array();
		}

		return $output;
	}

/**
 * response method
 * Creates a JSON response to be outputted and passed to the front end
 *
 * @param $code (int), $message (string), $options (array)
 * @return (string)
 */
	public function response($code, $message, $options = array()) {
		http_response_code($code);

		$defaults = array(
			'status' => $this->codes[$code],
			'code' => $code,
			'message' => $message,
			'data' => null,
			'errors' => null
		);

		$response = array_merge($defaults, $options);

		return json_encode($response);

	}

/**
 * output method
 * Sets the header for the response to the front end.
 *
 * @param $response (string)
 * @return (string)
 */
	private function output($action_data, $request, $view) {
		$output = "";
		if(LIVE) {
			switch($this->url['ext']) {
				case "json":
					header('Content-type: application/json');
				break;
				default:
					header('Content-type: text/html');
				break;
			}
		}

		switch($request) {
			case "json":
				//$output = $this->crypt->encrypt($this->response($action_data['code'], $action_data['message'], $action_data));
			break;
			case "error":
				$output = $this->Render(
					$_SERVER['DOCUMENT_ROOT'].DS."View".DS."Layout".DS.$view['view'].".typ",
					$action_data,
					$_SERVER['DOCUMENT_ROOT'].DS."View".DS."Layout".DS."ext".DS."error.typ"
				);
			break;
			default:
				$output = $this->Render(
					$_SERVER['DOCUMENT_ROOT'].DS."View".DS."Layout".DS.$view['view'].".typ",
					$action_data,
					$_SERVER['DOCUMENT_ROOT'].DS."View".DS.$view['model_name'].DS.$view['action'].".typ"
				);
			break;
		}

		return $output;
	}

/**
 * Render method
 * renders a layout file
 *
 * @param $template (string), $param (string),
 * @return (string)
  **/
	public function Render($typ__layout, $typ__passed_params, $typ__template) {
		ob_start();
		include($typ__template);
		$typ__view = ob_get_contents();
		ob_end_clean();


		ob_start();
		include($typ__layout);
		$ret = ob_get_contents();
		ob_end_clean();
		return $ret;
	}

/**
 * Element method
 * breaks styles into elements
 *
 * @param $typ__element (string)
 * @return (string)
  **/
	public function Element($typ__element) {
		ob_start();
		include($_SERVER['DOCUMENT_ROOT'].DS."View".DS."Element".DS.$typ__element.".typ");
		$ret = ob_get_contents();
		ob_end_clean();
		return $ret;
	}
/**
  * decr method
  *
  * provide public decrypt method for debugging
 *
 * @param $v (string)
 * @return (string)
  **/
	public function decr($v) {
		return (LIVE) ? $v : $this->crypt->decrypt($v);
	}
}
