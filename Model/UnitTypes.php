<?php
namespace Frost\Model;

/**
 * @class UnitTypes
 * @author Chris Sheppard
 * @description handles all UnitTypes data and information
 */
class UnitTypes extends \Frost\Configs\Database {

	protected $table = "unittypes";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your race name"
			),
			"between" => array(
				"min" => 3,
				"max" => 50,
				"message" => "Between 3 to 50 characters"
			)
		)
	);
	public $post = array();

	protected $relationships = array(
		"units" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "units",
			"leftcols" => array("units.id",/*"units.name",*/"units.created","units.modified"),
			"linkColumn" => "unittypes_id",
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