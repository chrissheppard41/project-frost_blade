<?php
namespace Frost\Model;

/**
 * @class Warlords
 * @author Chris Sheppard
 * @description handles all Warlords data and information
 */
class Warlords extends \Frost\Configs\Database {

	protected $table = "Warlords";
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
			"linktable" => "unitwarlords",
			"lefttable" => "squadunits",
			"leftcols" => array("warlords.id","warlords.name","warlords.created","warlords.modified"),
			"linkColumn" => "squadunits_id",
			"baseColumn" => "warlords_id"
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