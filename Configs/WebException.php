<?php

/**
 * @class WebException
 * @author Chris Sheppard
 * @description creates a Web exception class based off the core Exception class adding a new web http status code parameter
 */
class WebException extends \Exception
{
    protected $webCode = 400;

/**
 * [constructor]
 * @param [string]  $message  [description]
 * @param [int]  $wCode    [description]
 * @param integer $code     [description]
 * @param [string]  $previous [description]
 */
    public function __construct($message = null, $wCode = null, $code = 0, Exception $previous = null) {
        // make sure everything is assigned properly
        parent::__construct($message, $code, $previous);

        $this->webCode = $wCode;
    }
/**
 * [getWebCode description]
 * @return [int] []
 */
    final public function getWebCode() {
        return $this->webCode;
    }
}
