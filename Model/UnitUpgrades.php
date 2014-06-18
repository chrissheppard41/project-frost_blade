<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class UnitUpgrades
	@author Chris Sheppard
	@desc handles all UnitUpgrades data and information
*/
class UnitUpgrades extends \Frost\Configs\Database {

	protected $table = "UnitUpgrades";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your race name"
			),
			"between" => array(
				"min" => 3,
				"max" => 45,
				"message" => "Between 3 to 45 characters"
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