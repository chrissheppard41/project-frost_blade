<?php
namespace Frost\Model;

/**
 * @class Groups
 * @author Chris Sheppard
 * @description handles all Groups data and information
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
			"leftcols" => array("wargears.id","wargears.name","wargears.created","wargears.modified","wargeargroups.id as `wargeargroups_id`","wargeargroups.pts"),
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
		),
		/*"WargearGroups" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "wargeargroups",
			"leftcols" => array(
				"WargearGroups.id",
				"WargearGroups.groups_id",
				"WargearGroups.wargears_id",
			),
			"linkColumn" => "groups_id",
			"baseColumn" => null,
		)*/
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