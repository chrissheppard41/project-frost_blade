<?php
namespace Frost\Model;

/**
 * @class Enhancements
 * @author Chris Sheppard
 * @description handles all Enhancements data and information
 */
class Enhancements extends \Frost\Configs\Database {

	protected $table = "enhancements";
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
		"armies" => array(
			"type" => "HM",
			"linktable" => null,
			"lefttable" => "armies",
			"leftcols" => array("armies.id","armies.name","armies.created","armies.modified"),
			"linkColumn" => "races_id",
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