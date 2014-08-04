<?php
namespace Frost\Configs;
/*
	@class Email
	@author Chris Sheppard
	@desc handles the email functionality of the system
*/
class Email {

/**
 * send method
 * Sends a mail to a end user
 *
 * @param $to (string), $subject (string), $message (string)
 * @return (Bool)
 */
	public static function send($to, $subject, $message, $extra = null) {
		return mail ($to, $subject, $message, $extra);
	}

}