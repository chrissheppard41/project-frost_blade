<?php
namespace Frost\Controller;


/*
	@class ArmiesController
	@author Chris Sheppard
	@desc handles the races management section
*/
class ArmiesController extends Controller {

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
 * ROUTE: /admin/Armies/index
 * Method: GET
 * Index's all the Armies
 *
 * @param
 * @return (array)
 */
	public function admin_index($options) {
		$this->view = "admin";

		$data = $this->model->Find("pagination",
			array(
				"Armies" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"races_id",
							"colours_id",
							"created",
							"modified"
						),
						"contains" => array(
							"Races" => array(
								"fields" => array(
									"races.name as `races_name`"
								),
								"relation" => array(
									"Armies.races_id" => "races.id"
								)
							),
							"Colours" => array(
								"fields" => array(
									"colours.name as `colours_name`"
								),
								"relation" => array(
									"Armies.colours_id" => "colours.id"
								)
							)
						),
						"pagination" => 10
					)
				)
			)
		);
		$dataO = array_merge($data, $this->model->Find("all",
			array(
				"Races" => array(
					array(
						"fields" => array(
							"id",
							"name"
						)
					)
				)
			)
		) );
		return array("code" => 200, "message" => "User Index", "data" => $dataO, "errors" => null);
	}

/**
 * admin_view method
 * ROUTE: /admin/Armies/view/:id
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
				"Armies" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"races_id",
							"colours_id",
							"created",
							"modified"
						),
						"conditions" => array("armies.id" => $options[0]),
						"contains" => array(
							"ArmyCharacteristics" => array(),
							"ArmyLists" => array(),
							"Squads" => array(),
							"Races" => array(
								"fields" => array(
									"races.id as `race_id`",
									"races.name as `race_name`"
								),
								"relation" => array(
									"armies.races_id" => "races.id"
								)
							),
							"Colours" => array(
								"fields" => array(
									"colours.id as `colour_id`",
									"colours.name as `colour_name`"
								),
								"relation" => array(
									"armies.colours_id" => "colours.id"
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
 * admin_add method
 * ROUTE: /admin/Armies/add/:id
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
				\Cache::delete('Races', 'types_all');
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Armies', 'action' => 'index', 'admin' => true));
			}
		}
		$dataO = array("Armies" => array("races_id" => $options[1]));
		$data = array_merge($dataO, $this->model->Find("all", array(
			//"Races" => array( array( "fields" => array( "id", "name") ) ),
			"ArmyCharacteristics" => array( array( "fields" => array( "id", "name") ) ),
			"Colours" => array( array( "fields" => array( "id", "name") ) )
		) ) );



		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * admin_edit method
 * ROUTE: /admin/Armies/edit/:id
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
				\Cache::delete("Squads". DS ."Armies", "_army_".$options[0]);
				\Cache::delete("Squads", "squad_data_".$options[0]);
				\Cache::delete('Races', 'types_all');
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Armies', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "Armies" => array( array( "fields" => array( "id", "name", "races_id", "colours_id"), "conditions"	=> array( "id" => $options[0] ), "contains" => array( "ArmyCharacteristics" => array() ) ) ) ) );
		$dataE = array_merge($data, $this->model->Find("all", array(
			//"Races" => array( array( "fields" => array( "id", "name") ) ),
			"ArmyCharacteristics" => array( array( "fields" => array( "id", "name") ) ),
			"Colours" => array( array( "fields" => array( "id", "name") ) )
		) ) );
		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $dataE, "errors" => null);
	}
/**
 * admin_delete method
 * ROUTE: /admin/Armies/delete/:id
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
				"Armies" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);
		\Cache::delete('Races', 'types_all');
		\Cache::delete("Squads", "squad_data_".$options[0]);
		\Cache::delete("Squads". DS ."Armies", "_army_".$options[0]);

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Armies', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}
}
