<?php
namespace Frost\Model;

/**
 * @class Pages
 * @author Chris Sheppard
 * @description handles all pages data and information
 */
class Pages extends \Frost\Configs\Database {

	protected $table = "";
	protected $validation = array();
	public $post = array();
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