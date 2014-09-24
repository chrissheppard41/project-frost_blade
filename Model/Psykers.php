<?php
namespace Frost\Model;

/**
 * @class Psykers
 * @author Chris Sheppard
 * @description handles all Psykers data and information
 */
class Psykers extends \Frost\Configs\Database {

	protected $table = "psykers";
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
		"squadunits" => array(
			"type" => "HABTM",
			"linktable" => "unitpsykers",
			"lefttable" => "squadunits",
			"leftcols" => array("psykers.id","psykers.name","psykers.created","psykers.modified"),
			"linkColumn" => "squadunits_id",
			"baseColumn" => "psykers_id"
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