<?php
namespace Frost\Model;

/**
 * @class Armies
 * @author Chris Sheppard
 * @description handles all Armies data and information
 */
class Armies extends \Frost\Configs\Database {

	protected $table = "Armies";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your army name"
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
		"ArmyCharacteristics" => array(
			"type" => "HABTM",
			"linktable" => "armyraces",
			"lefttable" => "armycharacteristics",
			"leftcols" => array("armycharacteristics.id","armycharacteristics.name","armycharacteristics.created","armycharacteristics.modified"),
			"linkColumn" => "armycharacteristics_id",
			"baseColumn" => "armies_id"
		),
		"ArmyLists" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "armylists",
			"leftcols" => array("armylists.id","armylists.name","armylists.created","armylists.modified"),
			"linkColumn" => "armies_id",
			"baseColumn" => "id"
		),
		"Squads" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "squads",
			"leftcols" => array("squads.id","squads.name","squads.created","squads.modified"),
			"linkColumn" => "armies_id",
			"baseColumn" => "id"
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