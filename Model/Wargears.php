<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class Wargears
	@author Chris Sheppard
	@desc handles all Wargears data and information
*/
class Wargears extends \Frost\Configs\Database {

	protected $table = "Wargears";
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
		),
		"pts" => array(
			'numeric' => array(
				"message" => "The points value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your points value"
			)
		)
	);
	public $post = array();

	protected $relationships = array(
		"Units" => array(
			"type" => "HABTM",
			"linktable" => "unitwargears",
			"lefttable" => "units",
			"leftcols" => array("units.id","units.name","units.created","units.modified"),
			"linkColumn" => "units_id",
			"baseColumn" => "wargears_id"
		),
		"Groups" => array(
			"type" => "HABTM",
			"linktable" => "wargeargroups",
			"lefttable" => "groups",
			"leftcols" => array("groups.id","groups.name","groups.created","groups.modified"),
			"linkColumn" => "groups_id",
			"baseColumn" => "wargears_id"
		),
		"UnitUpgrades" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "unitupgrades",
			"leftcols" => array(
				"unitupgrades.id",
				"unitupgrades.enhancements_id",
				"unitupgrades.operations_id",
				"unitupgrades.factor",
				"unitupgrades.wargears_id",
				"unitupgrades.created",
				"unitupgrades.modified",

				"enhancements.name as `enhancements_name`",
				"operations.name as `operations_name`"
			),
			"linkColumn" => "wargears_id",
			"baseColumn" => "id",
			"Join" => array(
				array(
					"lefttable" => "enhancements",
					"linkColumn" => "enhancements_id"
				),
				array(
					"lefttable" => "operations",
					"linkColumn" => "operations_id"
				)
			)
		)
	);

	function __construct($options, $inputted_params){
		parent::__construct();

		if(isset($inputted_params["data"])) {
			$this->post = $inputted_params["data"];
		}
	}

}