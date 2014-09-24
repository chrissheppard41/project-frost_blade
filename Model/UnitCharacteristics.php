<?php
namespace Frost\Model;

/**
 * @class UnitCharacteristics
 * @author Chris Sheppard
 * @description handles all UnitCharacteristics data and information
 */
class UnitCharacteristics extends \Frost\Configs\Database {

	protected $table = "unitcharacteristics";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your unit characteristic"
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
		"units" => array(
			"type" => "HABTM",
			"linktable" => "unitqualities",
			"lefttable" => "units",
			"leftcols" => array("units.id","units.name","units.created","units.modified"),
			"linkColumn" => "units_id",
			"baseColumn" => "unitcharacteristics_id"
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