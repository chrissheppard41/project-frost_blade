<?php
namespace Frost\Model;

/**
 * @class Types
 * @author Chris Sheppard
 * @description handles all Types data and information
 */
class Types extends \Frost\Configs\Database {

	protected $table = "types";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your race name"
			),
			"between" => array(
				"min" => 2,
				"max" => 21,
				"message" => "Between 2 to 21 characters"
			)
		)
	);
	public $post = array();

	protected $relationships = array(
		"squads" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "squads",
			"leftcols" => array("squads.id","squads.name","squads.created","squads.modified"),
			"linkColumn" => "types_id",
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