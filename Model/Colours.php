<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class Colours
	@author Chris Sheppard
	@desc handles all Colours data and information
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

	function __construct($options, $inputted_params){
		parent::__construct();

		if(isset($inputted_params["data"])) {
			$this->post = $inputted_params["data"];
		}
	}

}