<?php
namespace Frost\Model;

//require PATH."Model/Interface.php";
/*
	@class Socials
	@author Chris Sheppard
	@desc handles all Socials data and information
*/
class Socials extends \Frost\Configs\Database {

	protected $table = "";
	protected $validation = array();
	public $post = array();

	protected $relationships = array();

	function __construct($options, $inputted_params){
		parent::__construct();

		if(isset($inputted_params["data"])) {
			$this->post = $inputted_params["data"];
		}
	}

}