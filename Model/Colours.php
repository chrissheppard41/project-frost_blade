<?php
namespace Frost\Model;

/**
 * @class Colours
 * @author Chris Sheppard
 * @description handles all Colours data and information
 */
class Colours extends \Frost\Configs\Database {

	protected $table = "Colours";
	protected $validation = array(
		"name" => array(
			"notempty" => array(
				"message" => "You must include your colour name"
			)
		)
	);
	public $post = array();

	protected $relationships = array(
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