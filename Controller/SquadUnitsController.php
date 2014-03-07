<?php
namespace Frost\Controller;


/*
	@class SquadUnitsController
	@author Chris Sheppard
	@desc handles the SquadUnits management section
*/
class SquadUnitsController extends Controller {

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
 * admin_view method
 * ROUTE: /admin/SquadUnits/view/:id
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
				"SquadUnits" => array(
					array(
						"fields" => array(
							"id",
							"min_count",
							"max_count",
							"units_id",
							"squads_id",
							"created",
							"modified"
						),
						"conditions" => array("SquadUnits.id" => $options[0]),
						"contains" => array(
							"Squads" => array(
								"fields" => array(
									"Squads.name as `squads_name`"
								),
								"relation" => array(
									"SquadUnits.Squads_id", "Squads.id"
								)
							),
							"Units" => array(
								"fields" => array(
									"Units.name as `units_name`"
								),
								"relation" => array(
									"SquadUnits.units_id", "Units.id"
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
 * admin_edit method
 * ROUTE: /admin/SquadUnits/edit/:id
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
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'SquadUnits', 'action' => 'view', "params" => array($options[0]), 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "SquadUnits" => array( array( "fields" => array( "id", "min_count", "max_count"), "conditions"	=> array( "id" => $options[0] ) ) ) ) );

		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * admin_delete method
 * ROUTE: /admin/SquadUnits/delete/:id
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
				"SquadUnits" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'SquadUnits', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}
}
