<?php
namespace Frost\Model;

/**
 * @class ArmyCharacteristics
 * @author Chris Sheppard
 * @description handles all ArmyCharacteristics data and information
 */
class ArmyCharacteristics extends \Frost\Configs\Database {

	protected $table = "armycharacteristics";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your army characteristic"
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
		"armies" => array(
			"type" => "HABTM",
			"linktable" => "armyraces",
			"lefttable" => "armies",
			"leftcols" => array("armies.id","armies.name","armies.created","armies.modified"),
			"linkColumn" => "armies_id",
			"baseColumn" => "armycharacteristics_id"
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