<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class Transports
	@author Chris Sheppard
	@desc handles all Transports data and information
*/
class Transports extends \Frost\Configs\Database {

	protected $table = "Transports";
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
			"linktable" => "unittransports",
			"lefttable" => "squadunits",
			"leftcols" => array("transports.id","transports.name","transports.created","transports.modified"),
			"linkColumn" => "squadunits_id",
			"baseColumn" => "transports_id"
		)
	);

	function __construct($options, $inputted_params){
		parent::__construct();

		if(isset($inputted_params["data"])) {
			$this->post = $inputted_params["data"];
		}
	}

}