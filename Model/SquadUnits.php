<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class SquadUnits
	@author Chris Sheppard
	@desc handles all SquadUnits data and information
*/
class SquadUnits extends \Frost\Configs\Database {

	protected $table = "SquadUnits";
	protected $validation = array(
		"min_count" => array(
			"notempty" => array(
				"message" => "You must include your min count"
			),
			"numeric" => array(
				"message" => "Your min count value must be a number"
			)
		),
		"max_count" => array(
			"notempty" => array(
				"message" => "You must include your max count"
			),
			"numeric" => array(
				"message" => "Your max count value must be a number"
			)
		)
	);
	public $post = array();

	protected $relationships = array(
		"Groups" => array(
			"type" => "HABTM",
			"linktable" => "unitgroups",
			"lefttable" => "groups",
			"leftcols" => array("groups.id","groups.name","groups.created","groups.modified"),
			"linkColumn" => "groups_id",
			"baseColumn" => "squadunits_id"
		)
	);

	function __construct($options, $inputted_params){
		parent::__construct();

		if(isset($inputted_params["data"])) {
			$this->post = $inputted_params["data"];
		}
	}

}