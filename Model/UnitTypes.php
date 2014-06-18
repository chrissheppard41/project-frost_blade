<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class UnitTypes
	@author Chris Sheppard
	@desc handles all UnitTypes data and information
*/
class UnitTypes extends \Frost\Configs\Database {

	protected $table = "UnitTypes";
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

	protected $relationships = array(
		"Units" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "units",
			"leftcols" => array("units.id","units.name","units.created","units.modified"),
			"linkColumn" => "unitTypes_id",
			"baseColumn" => "id"
		)
	);

	function __construct($options, $inputted_params){
		parent::__construct();

		if(isset($inputted_params["data"])) {
			$this->post = $inputted_params["data"];
		}
	}

}