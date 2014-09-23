<?php
namespace Frost\Controller;

/**
 * @class PagesController
 * @author Chris Sheppard
 * @description handles the user management section
 */
class PagesController extends Controller {

	public $returnType = "text";
	public $view = "Default";

	function __construct()
    {
        //parent::__construct(null,null);
    }

    function __destruct()
    {
    }

/**
 * [Allows a user to register with fb and log in]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [array]          [response]
 */
	public function index($options, $methodData) {
		return array("code" => 200, "message" => "Page default", "data" => array(), "errors" => null);
	}
/**
 * [gets the partial templates for angularjs]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [array]          [response]
 */
	public function partials($options, $methodData) {
		$this->view = "Empty";

		return array("code" => 200, "message" => "Page default", "data" => $options, "errors" => null);
	}
}
