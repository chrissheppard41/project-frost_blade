<?php
namespace Frost\Controller;


/*
	@class ArmyListsController
	@author Chris Sheppard
	@desc handles the army list management section
*/
class ArmyListsController extends Controller {

	public $returnType = "text";
	public $view = "Default";

	function __construct()
    {
        //parent::__construct(null,null);
    }

    function __destruct()
    {
    }

    public $access = array(
    	"deny" => array()
    );

/**
 * admin_index method
 * ROUTE: /admin/ArmyLists/index
 * Method: GET
 * Index's all the ArmyLists
 *
 * @param
 * @return (array)
 */
	public function admin_index($options) {
		$this->view = "admin";

		$user = $this->LoadClass("ArmyLists");
		$data = $user->Find("pagination",
			array(
				"ArmyLists" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"descr",
							"point_limit",
							"users_id",
							"armytypes_id",
							"created",
							"modified"
						),
						"pagination" => 10
					)
				)
			)
		);

		return array("code" => 200, "message" => "User Index", "data" => $data, "errors" => null);
	}

/**
 * admin_view method
 * ROUTE: /admin/ArmyLists/view/:id
 * Method: GET
 * Views a user
 *
 * @param
 * @return (array)
 */
	public function admin_view($options) {
		$this->view = "admin";

		$user = $this->LoadClass("ArmyLists");
		$data = $user->Find("first",
			array(
				"ArmyLists" => array(
					array(
						"fields" => array(
							"id",
							"username",
							"slug",
							"email",
							"email_verified",
							"is_admin",
							"last_login",
							"created",
							"modified"
						),
						"condition" => array("id" => $options[0])
					)
				)
			)
		);

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * admin_view admin_add
 * ROUTE: /admin/ArmyLists/add/:id
 * Method: GET
 * Adds a user
 *
 * @param
 * @return (array)
 */
	public function admin_add($options, $methodData) {
		$this->view = "admin";
		if($this->requestType("POST")) {
			$user = $this->LoadClass("ArmyLists", array(), $methodData);
			$data = $user->save_army();
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-success", array('controller' => 'ArmyLists', 'action' => 'index', 'admin' => true));
			}
		}

		return array("code" => 200, "message" => "User View", "data" => array(), "errors" => null);
	}
/**
 * admin_edit method
 * ROUTE: /admin/ArmyLists/edit/:id
 * Method: PUT
 * Edits a user
 *
 * @param
 * @return (array)
 */
	public function admin_edit($options, $methodData) {
		$this->view = "admin";
		$user = $this->LoadClass("ArmyLists", array(), $methodData);

		if($this->requestType("POST")) {
			$data = $user->update_army();
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-success", array('controller' => 'ArmyLists', 'action' => 'index', 'admin' => true));
			}
		}

		$data = $user->Find("first", array( "ArmyLists" => array( array( "fields" => array( "id", "username", "email", "email_verified", "is_admin" ), "condition"	=> array( "id" => $options[0] ) ) ) ) );
		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * admin_delete method
 * ROUTE: /admin/ArmyLists/delete/:id
 * Method: DELETE
 * Deletes a user
 *
 * @param
 * @return (array)
 */
	public function admin_delete($options) {
		$this->view = "admin";

		$user = $this->LoadClass("ArmyLists");
		$user->Delete(
			array(
				"ArmyLists" => array(
					"condition" => array(
						"id" => $options[0]
					)
				)
			)
		);

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'ArmyLists', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}
}
