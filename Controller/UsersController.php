<?php
namespace Frost\Controller;


/*
	@class UsersController
	@author Chris Sheppard
	@desc handles the user management section
*/
class UsersController extends Controller {

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
 * admin_index method
 * ROUTE: /admin/users/index
 * Method: GET
 * Index's all the users
 *
 * @param
 * @return (array)
 */
	public function admin_index() {
		$this->view = "admin";

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}

/**
 * admin_view method
 * ROUTE: /admin/users/view/:id
 * Method: GET
 * Views a user
 *
 * @param
 * @return (array)
 */
	public function admin_view($options) {
		$this->view = "admin";

		return array("code" => 200, "message" => "User View", "data" => array(), "errors" => null);
	}
/**
 * admin_view admin_add
 * ROUTE: /admin/users/add/:id
 * Method: GET
 * Adds a user
 *
 * @param
 * @return (array)
 */
	public function admin_add($options) {
		$this->view = "admin";

		return array("code" => 200, "message" => "User View", "data" => array(), "errors" => null);
	}
/**
 * admin_edit method
 * ROUTE: /admin/users/edit/:id
 * Method: PUT
 * Edits a user
 *
 * @param
 * @return (array)
 */
	public function admin_edit($options) {
		$this->view = "admin";

		return array("code" => 200, "message" => "User Edit", "data" => array(), "errors" => null);
	}
/**
 * admin_delete method
 * ROUTE: /admin/users/delete/:id
 * Method: DELETE
 * Deletes a user
 *
 * @param
 * @return (array)
 */
	public function admin_delete($options) {
		$this->view = "admin";

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}


/**
 * Login method
 * ROUTE: /users/login
 * Allows a user to register with fb and log in
 *
 * @param
 * @return (array)
 */
	public function login($options) {

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}
}
