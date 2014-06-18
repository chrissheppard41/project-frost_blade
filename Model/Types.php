<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class Types
	@author Chris Sheppard
	@desc handles all Types data and information
*/
class Types extends \Frost\Configs\Database {

	protected $table = "Types";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your race name"
			),
			"between" => array(
				"min" => 2,
				"max" => 15,
				"message" => "Between 2 to 15 characters"
			)
		)
	);
	public $post = array();

	protected $relationships = array(
		"Squads" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "squads",
			"leftcols" => array("squads.id","squads.name","squads.created","squads.modified"),
			"linkColumn" => "types_id",
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