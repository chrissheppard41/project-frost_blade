<?php
namespace Frost\Model;

/**
 * @class Squads
 * @author Chris Sheppard
 * @description handles all Squads data and information
 */
class Squads extends \Frost\Configs\Database {

	protected $table = "squads";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your squad name"
			),
			"between" => array(
				"min" => 3,
				"max" => 99,
				"message" => "Between 3 to 99 characters"
			)
		)
	);
	public $post = array();

	protected $relationships = array(
		"squadunits" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "squadunits",
			"leftcols" => array(
				"squadunits.min_count",
				"squadunits.max_count",
				"squadunits.id",
				"squadunits.name",
				"squadunits.pts",
				"squadunits.squads_id",
				"squadunits.units_id",
				"squadunits.created",
				"squadunits.modified"
			),
			"linkColumn" => "squads_id",
			"baseColumn" => null,
			"Connect" => array(
				"unitcharacteristics" => array(
					"type" => "HABTM",
					"linktable" => "unitqualities",
					"lefttable" => "unitcharacteristics",
					"leftcols" => array(
						"unitcharacteristics.id",
						"unitcharacteristics.name"
					),
					"linkColumn" => "unitcharacteristics_id",
					"baseColumn" => "squadunits_id",
					"dataColumn" => "id"
				),
				"units" => array(
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
				"wargears" => array(
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
						"unitupgrades" => array(
							"type" => "belongs",
							"linktable" => null,
							"lefttable" => "unitupgrades",
							"leftcols" => array(
								"unitupgrades.enhancements_id",
								"unitupgrades.operations_id",
								"unitupgrades.factor",
								"unitupgrades.wargears_id",
								"unitupgrades.created",
								"unitupgrades.modified",

								"operations.name as `op_name`",
								"operations.operation",

								"enhancements.name as `en_name`",
								"enhancements.effected_column"
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
				"groups" => array(
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
						"wargears" => array(
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
								"unitupgrades" => array(
									"type" => "belongs",
									"linktable" => null,
									"lefttable" => "unitupgrades",
									"leftcols" => array(
										"unitupgrades.enhancements_id",
										"unitupgrades.operations_id",
										"unitupgrades.factor",
										"unitupgrades.wargears_id",
										"unitupgrades.created",
										"unitupgrades.modified",

										"operations.name as `op_name`",
										"operations.operation",

										"enhancements.name as `en_name`",
										"enhancements.effected_column"
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
				"psykers" => array(
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
				"warlords" => array(
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
				"relics" => array(
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
				"transports" => array(
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
		"units" => array(
			"type" => "HABTM",
			"linktable" => "squadunits",
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

				"squadunits.min_count",
				"squadunits.max_count",
				"squadunits.id as `squadunits_id`"
			),
			"linkColumn" => "units_id",
			"baseColumn" => "squads_id"
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