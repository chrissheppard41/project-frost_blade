<?php
namespace Frost\Configs;
/*
 * @class Email
 * @author Chris Sheppard
 * @description handles the email functionality of the system
 */
class Email {

/**
 * [Sends a mail to a end user]
 * @param  [string] $to      [send to]
 * @param  [string] $subject [subject]
 * @param  [string] $message [set message]
 * @param  [array] $extra   [extra values]
 * @return [mail]          []
 */
	public static function send($to, $subject, $message, $extra = null) {
		return mail ($to, $subject, $message, $extra);
	}

}