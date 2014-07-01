<?php
namespace Frost\Controller;


/*
	@class GroupsController
	@author Chris Sheppard
	@desc handles the Groups management section
*/
class GroupsController extends Controller {

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
 * ROUTE: /admin/Groups/index
 * Method: GET
 * Index's all the Groups
 *
 * @param
 * @return (array)
 */
	public function admin_index($options) {
		$this->view = "admin";

		$data = $this->model->Find("pagination",
			array(
				"Groups" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"created",
							"modified"
						),
						"pagination" => 10,
						"contains" => array(
							"Armies" => array(
								"fields" => array(
									"armies.id as `army_id`",
									"armies.name as `army_name`"
								),
								"relation" => array(
									"groups.armies_id",
									"armies.id"
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
 * ROUTE: /admin/Groups/view/:id
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
				"Groups" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"created",
							"modified"
						),
						"conditions" => array("groups.id" => $options[0]),
						"contains" => array(
							"Wargears" => array(),
							"SquadUnits" => array(),
							"Armies" => array(
								"fields" => array(
									"armies.id as `army_id`",
									"armies.name as `army_name`"
								),
								"relation" => array(
									"groups.armies_id",
									"armies.id"
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
 * ROUTE: /admin/Groups/add/:id
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
				\Cache::delete("Squads", "squad_data_".$methodData["data"]["Groups"]["armies_id"]);
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Groups', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("all", array(
			"Wargears" => array( array( "fields" => array( "id", "name") ) ),
			"Armies" => array( array( "fields" => array( "id", "name") ) )
		) );

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * admin_edit method
 * ROUTE: /admin/Groups/edit/:id
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
				\Cache::delete("Squads", "squad_data_".$methodData["data"]["Groups"]["armies_id"]);
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Groups', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "Groups" => array( array( "fields" => array( "id", "name", "armies_id"), "conditions"	=> array( "id" => $options[0] ), "contains" => array( "Wargears" => array() ) ) ) ) );
		$dataE = array_merge($data, $this->model->Find("all", array(
			"Wargears" => array( array( "fields" => array( "id", "name"), "conditions" => array("armies_id" => $data["Groups"]["armies_id"]) ) ),
			"Armies" => array( array( "fields" => array( "id", "name") ) )
		) ) );
		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $dataE, "errors" => null);
	}
/**
 * admin_delete method
 * ROUTE: /admin/Groups/delete/:id
 * Method: DELETE
 * Deletes a user
 *
 * @param
 * @return (array)
 */
	public function admin_delete($options) {
		$this->view = "admin";

		$data = $this->model->Find("first",
			array(
				"Groups" => array(
					array(
						"fields" => array("armies_id"),
						"conditions" => array("Groups.id" => $options[0])
					)
				)
			)
		);

		$this->model->Delete(
			array(
				"Groups" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);
		\Cache::delete("Squads", "squad_data_".$data["Groups"]["armies_id"]);

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Groups', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}
}
