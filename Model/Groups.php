<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class Groups
	@author Chris Sheppard
	@desc handles all Groups data and information
*/
class Groups extends \Frost\Configs\Database {

	protected $table = "Groups";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your race name"
			),
			"between" => array(
				"min" => 3,
				"max" => 100,
				"message" => "Between 3 to 100 characters"
			)
		)
	);
	public $post = array();

	protected $relationships = array(
		"Wargears" => array(
			"type" => "HABTM",
			"linktable" => "wargeargroups",
			"lefttable" => "wargears",
			"leftcols" => array("wargears.id","wargears.name","wargears.created","wargears.modified"),
			"linkColumn" => "wargears_id",
			"baseColumn" => "groups_id"
		),
		"SquadUnits" => array(
			"type" => "HABTM",
			"linktable" => "unitgroups",
			"lefttable" => "squadunits",
			"leftcols" => array("squadunits.id","squadunits.squads_id","squadunits.created","squadunits.modified, squads.name"),
			"linkColumn" => "squadunits_id",
			"baseColumn" => "groups_id",
			"Join" => array(
				array(
					"lefttable" => "squads",
					"linkColumn" => "squads_id"
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