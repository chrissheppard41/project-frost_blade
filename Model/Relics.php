<?php
namespace Frost\Model;

/**
 * @class Relics
 * @author Chris Sheppard
 * @description handles all Relics data and information
 */
class Relics extends \Frost\Configs\Database {

	protected $table = "Relics";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your race name"
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
			"type" => "HABTM",
			"linktable" => "unitrelics",
			"lefttable" => "squadunits",
			"leftcols" => array("relics.id","relics.name","relics.created","relics.modified"),
			"linkColumn" => "squadunits_id",
			"baseColumn" => "relics_id"
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