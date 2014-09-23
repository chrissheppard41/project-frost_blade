<?php
namespace Frost\Model;

/**
 * @class SquadUnits
 * @author Chris Sheppard
 * @description handles all SquadUnits data and information
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
		),
		'pts' => array(
			'numeric' => array(
				"message" => "The points value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your points value"
			)
		),
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
		),
		"UnitCharacteristics" => array(
			"type" => "HABTM",
			"linktable" => "unitqualities",
			"lefttable" => "unitcharacteristics",
			"leftcols" => array("unitcharacteristics.id","unitcharacteristics.name","unitcharacteristics.created","unitcharacteristics.modified"),
			"linkColumn" => "unitcharacteristics_id",
			"baseColumn" => "squadunits_id"
		),
		"Psykers" => array(
			"type" => "HABTM",
			"linktable" => "unitpsykers",
			"lefttable" => "psykers",
			"leftcols" => array("psykers.id","psykers.name","psykers.created","psykers.modified"),
			"linkColumn" => "psykers_id",
			"baseColumn" => "squadunits_id"
		),
		"Relics" => array(
			"type" => "HABTM",
			"linktable" => "unitrelics",
			"lefttable" => "relics",
			"leftcols" => array("relics.id","relics.name","relics.created","relics.modified"),
			"linkColumn" => "relics_id",
			"baseColumn" => "squadunits_id"
		),
		"Warlords" => array(
			"type" => "HABTM",
			"linktable" => "unitwarlords",
			"lefttable" => "warlords",
			"leftcols" => array("warlords.id","warlords.name","warlords.created","warlords.modified"),
			"linkColumn" => "warlords_id",
			"baseColumn" => "squadunits_id"
		),
		"Transports" => array(
			"type" => "HABTM",
			"linktable" => "unittransports",
			"lefttable" => "transports",
			"leftcols" => array("transports.id","transports.name","transports.created","transports.modified"),
			"linkColumn" => "transports_id",
			"baseColumn" => "squadunits_id"
		),
		"Wargears" => array(
			"type" => "HABTM",
			"linktable" => "unitwargears",
			"lefttable" => "wargears",
			"leftcols" => array("wargears.id","wargears.name","wargears.created","wargears.modified"),
			"linkColumn" => "wargears_id",
			"baseColumn" => "squadunits_id"
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