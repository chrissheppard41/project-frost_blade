<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class Units
	@author Chris Sheppard
	@desc handles all Units data and information
*/
class Units extends \Frost\Configs\Database {

	protected $table = "Units";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your unit name"
			),
			"between" => array(
				"min" => 3,
				"max" => 100,
				"message" => "Between 3 to 100 characters"
			),
		'weapon_skill' => array(
			'numeric' => array(
				"message" => "The weapon skill value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your weapon skill value"
			)
		),
		'ballistic_skill' => array(
			'numeric' => array(
				"message" => "The ballistic skill value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your ballistic skill value"
			)
		),
		'strength' => array(
			'numeric' => array(
				"message" => "The strength value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your strength value"
			)
		),
		'toughness' => array(
			'numeric' => array(
				"message" => "The toughness value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your toughness value"
			)
		),
		'initiative' => array(
			'numeric' => array(
				"message" => "The initiative value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your initiative value"
			)
		),
		'wounds' => array(
			'numeric' => array(
				"message" => "The wounds value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your wounds value"
			)
		),
		'attacks' => array(
			'numeric' => array(
				"message" => "The attacks value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your attacks value"
			)
		),
		'leadership' => array(
			'numeric' => array(
				"message" => "The leadership value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your leadership value"
			)
		),
		'armour_save' => array(
			'numeric' => array(
				"message" => "The armour save value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your armour save value"
			)
		),
		'invulnerable_save' => array(
			'numeric' => array(
				"message" => "The invulnerable save value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your invulnerable save value"
			)
		),
		'pts' => array(
			'numeric' => array(
				"message" => "The points value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your points value"
			)
		)
		)
	);
	public $post = array();

	protected $relationships = array(
		"Squads" => array(
			"type" => "HABTM",
			"linktable" => "squadunits",
			"lefttable" => "squads",
			"leftcols" => array("squads.id","squads.name","squads.created","squads.modified"),
			"linkColumn" => "squads_id",
			"baseColumn" => "units_id"
		)
	);

	function __construct($options, $inputted_params){
		parent::__construct();

		if(isset($inputted_params["data"])) {
			$this->post = $inputted_params["data"];
		}
	}

}