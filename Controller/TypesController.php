<?php
namespace Frost\Controller;


/*
	@class TypesController
	@author Chris Sheppard
	@desc handles the Types management section
*/
class TypesController extends Controller {

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
 * ROUTE: /admin/Types/index
 * Method: GET
 * Index's all the Types
 *
 * @param
 * @return (array)
 */
	public function admin_index($options) {
		$this->view = "admin";

		$data = $this->model->Find("pagination",
			array(
				"Types" => array(
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
 * ROUTE: /admin/Types/view/:id
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
				"Types" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"created",
							"modified"
						),
						"conditions" => array("id" => $options[0]),
						"contains" => array( "Squads" => array() )
					)
				)
			)
		);

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * admin_view admin_add
 * ROUTE: /admin/Types/add/:id
 * Method: GET
 * Adds a user
 *
 * @param
 * @return (array)
 */
	public function admin_add($options, $methodData) {
		$this->view = "admin";
		if($this->requestType("POST")) {
			$data = $this->model->Save();
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				\Cache::delete("Types", "all_types");
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Types', 'action' => 'index', 'admin' => true));
			}
		}

		return array("code" => 200, "message" => "User View", "data" => array(), "errors" => null);
	}
/**
 * admin_edit method
 * ROUTE: /admin/Types/edit/:id
 * Method: PUT
 * Edits a user
 *
 * @param
 * @return (array)
 */
	public function admin_edit($options, $methodData) {
		$this->view = "admin";

		if($this->requestType("POST")) {
			$data = $this->model->Update($this->model->post, array("id" => $options[0]));
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				\Cache::delete("Types", "all_types");
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Types', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "Types" => array( array( "fields" => array( "id", "name"), "conditions"	=> array( "id" => $options[0] ) ) ) ) );
		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * admin_delete method
 * ROUTE: /admin/Types/delete/:id
 * Method: DELETE
 * Deletes a user
 *
 * @param
 * @return (array)
 */
	public function admin_delete($options) {
		$this->view = "admin";

		$this->model->Delete(
			array(
				"Types" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);

		\Cache::delete("Types", "all_types");
		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Types', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}

/**
 * API endpoints
 */

 /**
 * API unit_types to return all unit types
 *
 * @return void
 */
    public function unit_types() {
		$this->view = "Empty";
		$this->returnType = "json";

        /*if(!\Configure::Logged()) {
			throw new \WebException("Forbidden: Not logged in", 403);
		}*/

        $data = \Cache::read('Types', 'all_types');
        if(!$data){
			$data = $this->model->Find("all",
				array(
					"Types" => array(
						array(
							"fields" => array(
								"id",
								"name",
								"created",
								"modified"
							)
						)
					)
				)
			);
			\Cache::write("Types", 'all_types', $data);
        }

        return \Frost\Configs\Response::setResponse(200, "Types", array("data" => $data));
    }
}
