<?php
namespace Frost\Controller;


/*
	@class WargearsController
	@author Chris Sheppard
	@desc handles the Wargears management section
*/
class WargearsController extends Controller {

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
 * ROUTE: /admin/Wargears/index
 * Method: GET
 * Index's all the Wargears
 *
 * @param
 * @return (array)
 */
	public function admin_index($options) {
		$this->view = "admin";

		$data = $this->model->Find("pagination",
			array(
				"Wargears" => array(
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
									"wargears.armies_id" => "armies.id"
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
 * ROUTE: /admin/Wargears/view/:id
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
				"Wargears" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"created",
							"modified"
						),
						"conditions" => array("wargears.id" => $options[0]),
						"contains" => array(
							"Units" => array(),
							"Groups" => array(),
							"UnitUpgrades" => array(),
							"Armies" => array(
								"fields" => array(
									"armies.id as `army_id`",
									"armies.name as `army_name`"
								),
								"relation" => array(
									"wargears.armies_id" => "armies.id"
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
 * ROUTE: /admin/Wargears/add/:id
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


				if(isset($options[0])) {
					$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Groups', 'action' => 'view', 'params' => array($options[0]), 'admin' => true));
				} else {
					$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Wargears', 'action' => 'index', 'admin' => true));
				}
			}
		}
		$data = $this->model->Find("all", array(
			"Armies" => array( array( "fields" => array( "id", "name") ) )
		) );
		if(isset($options[0])) {
			$data["Groups"]["id"] = $options[0];
		}

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * admin_edit method
 * ROUTE: /admin/Wargears/edit/:id
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
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Wargears', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "Wargears" => array( array( "fields" => array( "id", "name", "armies_id"), "conditions"	=> array( "id" => $options[0] ) ) ) ) );
		$_POST["data"] = $data;
		$dataE = array_merge($data, $this->model->Find("all", array(
			"Armies" => array( array( "fields" => array( "id", "name") ) )
		) ) );
		return array("code" => 200, "message" => "User Edit", "data" => $dataE, "errors" => null);
	}
/**
 * admin_delete method
 * ROUTE: /admin/Wargears/delete/:id
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
				"Wargears" => array(
					array(
						"fields" => array("armies_id"),
						"conditions" => array("Wargears.id" => $options[0])
					)
				)
			)
		);

		$this->model->Delete(
			array(
				"Wargears" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);
		\Cache::delete("Squads", "squad_data_".$data["Wargears"]["armies_id"]);

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Wargears', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}
}
