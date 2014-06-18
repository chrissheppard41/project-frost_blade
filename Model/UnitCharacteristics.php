<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class UnitCharacteristics
	@author Chris Sheppard
	@desc handles all UnitCharacteristics data and information
*/
class UnitCharacteristics extends \Frost\Configs\Database {

	protected $table = "UnitCharacteristics";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your unit characteristic"
			),
			"between" => array(
				"min" => 3,
				"max" => 45,
				"message" => "Between 3 to 45 characters"
			)
		)
	);
	public $post = array();

	protected $relationships = array(
		"Units" => array(
			"type" => "HABTM",
			"linktable" => "unitqualities",
			"lefttable" => "units",
			"leftcols" => array("units.id","units.name","units.created","units.modified"),
			"linkColumn" => "units_id",
			"baseColumn" => "unitcharacteristics_id"
		)
	);

	function __construct($options, $inputted_params){
		parent::__construct();

		if(isset($inputted_params["data"])) {
			$this->post = $inputted_params["data"];
		}
	}

}