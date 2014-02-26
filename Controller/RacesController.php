<?php
namespace Frost\Controller;


/*
	@class RacesController
	@author Chris Sheppard
	@desc handles the races management section
*/
class RacesController extends Controller {

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
 * ROUTE: /admin/Races/index
 * Method: GET
 * Index's all the Races
 *
 * @param
 * @return (array)
 */
	public function admin_index($options) {
		$this->view = "admin";

		$data = $this->model->Find("pagination",
			array(
				"Races" => array(
					array(
						"fields" => array(
							"id",
							"name",
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
 * ROUTE: /admin/Races/view/:id
 * Method: GET
 * Views a user
 *
 * @param
 * @return (array)
 */
	public function admin_view($options) {
		$this->view = "admin";

		$data = $this->model->Find("first",
			array(
				"Races" => array(
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
 * ROUTE: /admin/Races/add/:id
 * Method: GET
 * Adds a user
 *
 * @param
 * @return (array)
 */
	public function admin_add($options, $methodData) {
		$user = $this->LoadClass("Races", array(), $methodData);
		//\Configure::pre($user->Exists(1));

		$this->view = "admin";
		if($this->requestType("POST")) {
			$data = $this->model->Save();
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-success", array('controller' => 'Races', 'action' => 'index', 'admin' => true));
			}
		}

		return array("code" => 200, "message" => "User View", "data" => array(), "errors" => null);
	}
/**
 * admin_edit method
 * ROUTE: /admin/Races/edit/:id
 * Method: PUT
 * Edits a user
 *
 * @param
 * @return (array)
 */
	public function admin_edit($options, $methodData) {
		$this->view = "admin";
		$user = $this->LoadClass("Races", array(), $methodData);


		if($this->requestType("POST")) {
			$data = $this->model->Update($this->model->post, array("id" => $options[0]));
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-success", array('controller' => 'Races', 'action' => 'index', 'admin' => true));
			}
		}

		$data = $user->Find("first", array( "Races" => array( array( "fields" => array( "id", "name"), "condition"	=> array( "id" => $options[0] ) ) ) ) );
		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * admin_delete method
 * ROUTE: /admin/Races/delete/:id
 * Method: DELETE
 * Deletes a user
 *
 * @param
 * @return (array)
 */
	public function admin_delete($options) {
		$this->view = "admin";

		$user = $this->LoadClass("Races");
		$user->Delete(
			array(
				"Races" => array(
					"condition" => array(
						"id" => $options[0]
					)
				)
			)
		);

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Races', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}
}
