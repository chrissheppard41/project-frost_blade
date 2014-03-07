<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class Squads
	@author Chris Sheppard
	@desc handles all Squads data and information
*/
class Squads extends \Frost\Configs\Database {

	protected $table = "Squads";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your squad name"
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
		"Units" => array(
			"type" => "HABTM",
			"linktable" => "squadunits",
			"lefttable" => "units",
			"leftcols" => array(
				"units.id",
				"units.name",

				"units.weapon_skill",
				"units.ballistic_skill",
				"units.strength",
				"units.toughness",
				"units.initiative",
				"units.wounds",
				"units.attacks",
				"units.leadership",
				"units.armour_save",
				"units.invulnerable_save",
				"units.pts",

				"units.created",
				"units.modified"
			),
			"linkColumn" => "units_id",
			"baseColumn" => "squads_id"
		)
	);

	function __construct($options, $inputted_params){
		parent::__construct();

		if(isset($inputted_params["data"])) {
			$this->post = $inputted_params["data"];
		}
	}

}