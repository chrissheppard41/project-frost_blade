<?php
namespace Frost\Controller;


/*
	@class PagesController
	@author Chris Sheppard
	@desc handles the user management section
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
 * Register method
 * ROUTE: /users/register
 * Allows a user to register with fb and log in
 *
 * @param
 * @return (array)
 */
	public function index($options, $methodData) {
		return array("code" => 200, "message" => "Page default", "data" => array(), "errors" => null);
	}
}
