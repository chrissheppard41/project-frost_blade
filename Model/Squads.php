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
				"max" => 45,
				"message" => "Between 3 to 45 characters"
			)
		)
	);
	public $post = array();

	protected $relationships = array(
		"SquadUnits" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "squadunits",
			"leftcols" => array(
				"SquadUnits.min_count",
				"SquadUnits.max_count",
				"SquadUnits.id",
				"SquadUnits.name",
				"SquadUnits.pts",
				"SquadUnits.squads_id",
				"SquadUnits.units_id",
				"SquadUnits.created",
				"SquadUnits.modified"
			),
			"linkColumn" => "squads_id",
			"baseColumn" => null,
			"Connect" => array(
				"UnitCharacteristics" => array(
					"type" => "HABTM",
					"linktable" => "unitqualities",
					"lefttable" => "UnitCharacteristics",
					"leftcols" => array(
						"UnitCharacteristics.id",
						"UnitCharacteristics.name"
					),
					"linkColumn" => "unitcharacteristics_id",
					"baseColumn" => "squadunits_id",
					"dataColumn" => "id"
				),
				"Units" => array(
					"type" => "belongs",
					"linktable" => null,
					"lefttable" => "units",
					"leftcols" => array(
						"units.id",
						//"units.name",

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
						//"units.pts",

						"units.front_armour",
						"units.side_armour",
						"units.rear_armour",
						"units.hull_hitpoints",

						"units.created",
						"units.modified",

						"unittypes.name as `unittype`"
					),
					"linkColumn" => "id",
					"baseColumn" => null,
					"dataColumn" => "units_id",
					"Join" => array(
						array(
							"lefttable" => "unittypes",
							"linkColumn" => "unittypes_id"
						)
					)/*,
					"Connect" => array(

					)*/
				),
				"Wargears" => array(
					"type" => "HABTM",
					"linktable" => "unitwargears",
					"lefttable" => "wargears",
					"leftcols" => array(
						"wargears.id",
						"wargears.name"
					),
					"linkColumn" => "wargears_id",
					"baseColumn" => "squadunits_id",
					"dataColumn" => "id",
					"Connect" => array(
						"UnitUpgrades" => array(
							"type" => "belongs",
							"linktable" => null,
							"lefttable" => "unitupgrades",
							"leftcols" => array(
								"UnitUpgrades.enhancements_id",
								"UnitUpgrades.operations_id",
								"UnitUpgrades.factor",
								"UnitUpgrades.wargears_id",
								"UnitUpgrades.created",
								"UnitUpgrades.modified",

								"Operations.name as `op_name`",
								"Operations.operation",

								"Enhancements.name as `en_name`",
								"Enhancements.effected_column"
							),
							"linkColumn" => "wargears_id",
							"baseColumn" => null,
							"dataColumn" => "id",
							"Join" => array(
								array(
									"lefttable" => "operations",
									"linkColumn" => "operations_id"
								),
								array(
									"lefttable" => "enhancements",
									"linkColumn" => "enhancements_id"
								)
							)
						)
					)
				),
				"Groups" => array(
					"type" => "HABTM",
					"linktable" => "unitgroups",
					"lefttable" => "groups",
					"leftcols" => array(
						"groups.id",
						"groups.name",

						"unitgroups.id as `unitgroups_id`",
						"unitgroups.min_count",
						"unitgroups.max_count"
					),
					"linkColumn" => "groups_id",
					"baseColumn" => "squadunits_id",
					"dataColumn" => "id",
					"Connect" => array(
						"Wargears" => array(
							"type" => "HABTM",
							"linktable" => "wargeargroups",
							"lefttable" => "wargears",
							"leftcols" => array(
								"wargears.id",
								"wargears.name",
								"wargeargroups.pts"
							),
							"linkColumn" => "wargears_id",
							"baseColumn" => "groups_id",
							"dataColumn" => "id",
							"Connect" => array(
								"UnitUpgrades" => array(
									"type" => "belongs",
									"linktable" => null,
									"lefttable" => "unitupgrades",
									"leftcols" => array(
										"UnitUpgrades.enhancements_id",
										"UnitUpgrades.operations_id",
										"UnitUpgrades.factor",
										"UnitUpgrades.wargears_id",
										"UnitUpgrades.created",
										"UnitUpgrades.modified",

										"Operations.name as `op_name`",
										"Operations.operation",

										"Enhancements.name as `en_name`",
										"Enhancements.effected_column"
									),
									"linkColumn" => "wargears_id",
									"baseColumn" => null,
									"dataColumn" => "id",
									"Join" => array(
										array(
											"lefttable" => "operations",
											"linkColumn" => "operations_id"
										),
										array(
											"lefttable" => "enhancements",
											"linkColumn" => "enhancements_id"
										)
									)
								)
							)
						)
					)
				),
				"Psykers" => array(
					"type" => "HABTM",
					"linktable" => "unitpsykers",
					"lefttable" => "psykers",
					"leftcols" => array(
						"psykers.id",
						"psykers.name"
					),
					"linkColumn" => "psykers_id",
					"baseColumn" => "squadunits_id",
					"dataColumn" => "id"
				),
				"Warlords" => array(
					"type" => "HABTM",
					"linktable" => "unitwarlords",
					"lefttable" => "warlords",
					"leftcols" => array(
						"warlords.id",
						"warlords.name"
					),
					"linkColumn" => "warlords_id",
					"baseColumn" => "squadunits_id",
					"dataColumn" => "id"
				),
				"Relics" => array(
					"type" => "HABTM",
					"linktable" => "unitrelics",
					"lefttable" => "relics",
					"leftcols" => array(
						"relics.id",
						"relics.name"
					),
					"linkColumn" => "relics_id",
					"baseColumn" => "squadunits_id",
					"dataColumn" => "id"
				),
				"Transports" => array(
					"type" => "HABTM",
					"linktable" => "unittransports",
					"lefttable" => "transports",
					"leftcols" => array(
						"transports.id",
						"transports.name"
					),
					"linkColumn" => "transports_id",
					"baseColumn" => "squadunits_id",
					"dataColumn" => "id"
				),
			)
		),
		"Units" => array(
			"type" => "HABTM",
			"linktable" => "SquadUnits",
			"lefttable" => "units",
			"leftcols" => array(
				"units.id",
				//"units.name",

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
				//"units.pts",

				"units.created",
				"units.modified",

				"SquadUnits.min_count",
				"SquadUnits.max_count",
				"SquadUnits.id as `squadunits_id`"
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