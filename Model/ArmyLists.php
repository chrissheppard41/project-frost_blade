<?php
namespace Frost\Model;

/**
 * @class ArmyLists
 * @author Chris Sheppard
 * @description handles all ArmyLists data and information
 */
class ArmyLists extends \Frost\Configs\Database {

	protected $table = "ArmyLists";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include an army name"
			),
			"between" => array(
				"min" => 3,
				"max" => 100,
				"message" => "Between 3 to 100 characters"
			)
		),
		"descr" => array(
			"notempty" => array(
				"message" => "You must include an army description"
			),
			"between" => array(
				"min" => 5,
				"max" => 255,
				"message" => "Between 5 to 255 characters"
			)
		),
		"points_limit" => array(
			"notempty" => array(
				"message" => "You must include an Points limit"
			),
			"numeric" => array(
				"message" => "Points limit must be an number"
			)
		),
		"hide" => array(
			"tinyint" => array(
				"default" => false
			)
		),
		"armies_id" => array(
			"notempty" => array(
				"message" => "You must include an army type"
			)
		),
		"users_id" => array(
			"notempty" => array(
				"message" => "You must include an username"
			)
		),
	);
	public $post = array();

	protected $relationships = array(
		"ArmySquads" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "armysquads",
			"leftcols" => array(
				"ArmySquads.id",
				"ArmySquads.position",
				"ArmySquads.squads_id",
				"ArmySquads.armylists_id",
				"ArmySquads.created",
				"ArmySquads.modified"
			),
			"linkColumn" => "armylists_id",
			"baseColumn" => null,
			"dataColumn" => "id",
			"Connect" => array(
				"ArmyUnits" => array(
					"type" => "HM",
					"linktable" => null,
					"lefttable" => "armyunits",
					"leftcols" => array(
						"ArmyUnits.id",
						"ArmyUnits.count",
						"ArmyUnits.units_id",
						"ArmyUnits.armysquads_id",
						"ArmyUnits.created",
						"ArmyUnits.modified"
					),
					"linkColumn" => "armysquads_id",
					"baseColumn" => null,
					"dataColumn" => "id",
					"Connect" => array(
						"ArmyWargears" => array(
							"type" => "HM",
							"linktable" => null,
							"lefttable" => "armywargears",
							"leftcols" => array(
								"ArmyWargears.id",
								"ArmyWargears.wargears_id",
								"ArmyWargears.armyunits_id",
								"ArmyWargears.created",
								"ArmyWargears.modified"
							),
							"linkColumn" => "armyunits_id",
							"baseColumn" => null,
							"dataColumn" => "id",

						)
					)
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

/**
 * [_generateCode to saves a submitted army]
 * @param  [string] $id [the inputted generation code based on the $id]
 * @return [string]     [generated hash string]
 */
	public function _generateCode($id) {
		$salt = substr(md5(uniqid(rand(), true)), 0, 9);
		return $salt . sha1($salt . time() . $id);
	}

/**
 * [returns the army lists]
 * @param  [string] $type    [whether it be public, personal or top]
 * @param  [int] $user_id [currently logged in user/0 = guest]
 * @return [array]          [the returning armies]
 */
	public function army_lists($type, $user_id) {

		if($type == "public") {
			$conditions = array("armylists.hide" => 0);
			$order = array("id DESC");

			$count = $this->find(
				'first',
				array(
					"ArmyLists" => array(
						array(
							"fields" => array(
								"COUNT(*) as `count`"
							),
							"conditions" => $conditions
						)
					)
				)
			);

		} else if($type == "top") {
			$conditions = array("armylists.hide" => 0);
			$order = array("score DESC");
		} else {
			if(!\Configure::Logged()) {
				throw new \WebException("Forbidden: Not logged in", 403);
			}
			$conditions = array("ArmyLists.users_id" => $user_id);
			$order = array();

			$count = $this->find(
				'first',
				array(
					"ArmyLists" => array(
						array(
							"fields" => array(
								"COUNT(*) as `count`"
							),
							"conditions" => $conditions
						)
					)
				)
			);
		}

		$data = $this->find(
			'all',
			array(
				"ArmyLists" => array(
					array(
						"fields" => array(
							"id",
							"code",
							"name",
							"descr",
							"point_limit",
							"hide",
							"score",
							"users_id",
							"armies_id",
							"created",
							"modified"
						),
						"conditions" => $conditions,
						"order" => $order,
						"limit" => 5,
						"contains" => array(
							"Users" => array(
								"fields" => array(
									"Users.username"
								),
								"relation" => array(
									"ArmyLists.users_id" => "Users.id"
								)
							),
							"Armies" => array(
								"fields" => array(
									"armies.name as `army_name`"
								),
								"relation" => array(
									"ArmyLists.armies_id" => "armies.id"
								)
							),
							"Races" => array(
								"fields" => array(
									"races.name as `races_name`",
									"races.icon"
								),
								"relation" => array(
									"Armies.races_id" => "races.id"
								)
							),
							"Colours" => array(
								"fields" => array(
									"colours.name as `colours_name`"
								),
								"relation" => array(
									"Armies.colours_id" => "colours.id"
								)
							),
							"Votes" => array(
								"fields" => array(
									"votes.vote"
								),
								"relation" => array(
									"Votes.armylists_id" => "ArmyLists.id",
									"Votes.users_id" => $user_id
								)
							)
						)
					)
				)
			)
		);

		if(isset($count["ArmyLists"]["count"])) {
			$data["count"] = $count["ArmyLists"]["count"];
		}
		return $data;
	}

}