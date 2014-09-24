<?php
namespace Frost\Model;

/**
 * @class WargearGroups
 * @author Chris Sheppard
 * @description handles all WargearGroups data and information
 */
class WargearGroups extends \Frost\Configs\Database {

	protected $table = "wargeargroups";
	protected $validation = array(
		/*"min_count" => array(
			"notempty" => array(
				"message" => "You must include your min count"
			),
			"numeric" => array(
				"message" => "Your min count value must be a number"
			)
		),
		"max_count" => array(
			"notempty" => array(
				"message" => "You must include your max count"
			),
			"numeric" => array(
				"message" => "Your max count value must be a number"
			)
		),*/
		'pts' => array(
			'numeric' => array(
				"message" => "The points value must be numeric"
			),
			'notempty' => array(
				"message" => "You must include your points value"
			)
		),
	);
	public $post = array();

	protected $relationships = array(
		/*"groups" => array(
			"type" => "HABTM",
			"linktable" => "unitgroups",
			"lefttable" => "groups",
			"leftcols" => array("groups.id","groups.name","groups.created","groups.modified"),
			"linkColumn" => "groups_id",
			"baseColumn" => "squadunits_id"
		)*/
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