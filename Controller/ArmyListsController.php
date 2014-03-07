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

		/*$test = $this->model->Find("all",
			array(
				"ArmyLists" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"descr",
							"point_limit",
							"hide",
							"users_id",
							"armies_id",
							"created",
							"modified"
						),
						"contains" => array(
							"Users" => array(
								"fields" => array(
									"Users.id as `user_id`",
									"Users.username"
								),
								"relation" => array(
									"ArmyLists.users_id", "Users.id"
								)
							),
							"Armies" => array(
								"fields" => array(
									"armies.name as `army_name`"
								),
								"relation" => array(
									"ArmyLists.armies_id", "armies.id"
								)
							)
						)
					)
				)
			)
		);*/

		$data = $this->model->Find("pagination",
			array(
				"ArmyLists" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"descr",
							"point_limit",
							"hide",
							"users_id",
							"armies_id",
							"created",
							"modified"
						),
						"pagination" => 10,
						"contains" => array(
							"Users" => array(
								"fields" => array(
									"Users.id as `user_id`",
									"Users.username"
								),
								"relation" => array(
									"ArmyLists.users_id", "Users.id"
								)
							),
							"Armies" => array(
								"fields" => array(
									"armies.name as `army_name`"
								),
								"relation" => array(
									"ArmyLists.armies_id", "armies.id"
								)
							)
						)

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

		$data = $this->model->Find("first",
			array(
				"ArmyLists" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"descr",
							"point_limit",
							"hide",
							"users_id",
							"armies_id",
							"created",
							"modified"
						),
						"condition" => array("id" => $options[0]),
						"contains" => array(
							"Users" => array(
								"fields" => array(
									"Users.id as `user_id`",
									"Users.username"
								),
								"relation" => array(
									"ArmyLists.users_id", "Users.id"
								)
							),
							"Armies" => array(
								"fields" => array(
									"armies.name as `army_name`"
								),
								"relation" => array(
									"ArmyLists.armies_id", "armies.id"
								)
							)
						)
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
			$data = $this->model->Save();
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'ArmyLists', 'action' => 'index', 'admin' => true));
			}
		}

		$data = $this->model->Find("all", array(
			"Users" => array( array( "fields" => array( "id", "username as `name`") ) ),
			"Armies" => array( array( "fields" => array( "id", "name") ) )
		) );

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
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
		$this->model->last_id = $options[0];
		if($this->requestType("POST")) {
			$data = $this->model->Update($this->model->post, array("id" => $options[0]));
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'armylists', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "ArmyLists" => array(
					array(
						"fields" => array( "id", "name", "descr", "point_limit", "hide", "users_id", "armies_id" ),
						"condition" => array("id" => $options[0]),
						"contains" => array(
							"Users" => array( "fields" => array( "Users.id as `user_id`", "Users.username" ), "relation" => array( "ArmyLists.users_id", "Users.id" ) ),
							"Armies" => array( "fields" => array( "armies.name as `army_name`" ), "relation" => array( "ArmyLists.armies_id", "armies.id" ) )
						)
					)
				)
			)
		);

		$dataE = array_merge($data, $this->model->Find("all", array(
			"Users" => array( array( "fields" => array( "id", "username as `name`") ) ),
			"Armies" => array( array( "fields" => array( "id", "name") ) )
		) ) );
		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $dataE, "errors" => null);
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

		$this->model->Delete(
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
