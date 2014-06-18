<?php
namespace Frost\Configs;

/*
	@class Response
	@author
	@desc
*/
class Response {
	public static $codes = array(
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
	public static function setResponse($code, $message, $options = array(), $serialize = true) {
		http_response_code($code);

		$defaults = array(
			'status' => self::$codes[$code],
			'code' => $code,
			'message' => $message,
			'data' => null,
			'errors' => null
		);

		return array_merge($defaults, $options);

	}
}
