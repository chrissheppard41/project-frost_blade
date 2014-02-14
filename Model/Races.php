<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class Races
	@author Chris Sheppard
	@desc handles all user data and information
*/
class Races extends \Frost\Configs\Database {

	protected $table = "Races";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your name"
			),
			"between" => array(
				"min" => 3,
				"max" => 100,
				"message" => "Between 3 to 100 characters"
			)
		)
	);
	public $post = array();

	function __construct($options, $inputted_params){
		parent::__construct();

		if(isset($inputted_params["data"])) {
			$this->post = $inputted_params["data"];
		}
	}

}