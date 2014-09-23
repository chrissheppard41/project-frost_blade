<?php
namespace Frost\Model;

/**
 * @class Units
 * @author Chris Sheppard
 * @description handles all Units data and information
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
				"max" => 45,
				"message" => "Between 3 to 45 characters"
			)
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

		'front_armour' => array(
			'numeric' => array(
				"message" => "The front armour value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your front armour value"
			)
		),
		'side_armour' => array(
			'numeric' => array(
				"message" => "The side armour value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your side armour value"
			)
		),
		'rear_armour' => array(
			'numeric' => array(
				"message" => "The rear armour value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your rear armour value"
			)
		),
		'hull_hitpoints' => array(
			'numeric' => array(
				"message" => "The hull hitpoints value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your hull hitpoints value"
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
		'unitTypes_id' => array(
			'notempty' => array(
				"message" => "You must include your unit type value"
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

/**
 * [constructor]
 * @param  [array] $options [contains url input]
 * @param  [array] $inputted_params [form data]
 * @return [array]          [response]
 */
	function __construct($options, $inputted_params){
		parent::__construct();

		if(isset($inputted_params["data"])) {
			$this->post = $inputted_params["data"];
		}
	}

}