<?php
/**
 *  @class WebException
 *  @author Chris Sheppard
 *  @desc creates a Web exception class based off the core Exception class adding a new web http status code parameter
 */
class WebException extends \Exception
{
    protected $webCode = 400;

    public function __construct($message = null, $wCode = null, $code = 0, Exception $previous = null) {
        // make sure everything is assigned properly
        parent::__construct($message, $code, $previous);

        $this->webCode = $wCode;
    }

    final public function getWebCode() {
        return $this->webCode;
    }
}
