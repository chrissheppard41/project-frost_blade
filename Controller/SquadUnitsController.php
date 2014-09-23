<?php
namespace Frost\Controller;

/**
 * @class SquadUnitsController
 * @author Chris Sheppard
 * @description handles the SquadUnits management section
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
 * [Edits a SquadUnits]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [array]          [response]
 */
	public function admin_edit($options, $methodData) {
		$this->view = "admin";
		$this->model->last_id = $options[0];
		if($this->requestType("POST")) {
			$data = $this->model->Update($this->model->post, array("id" => $options[0]));
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Squads', 'action' => 'view', "params" => array($options[1]), 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "SquadUnits" => array( array( "fields" => array( "id", "squads_id", "min_count", "max_count", "pts", "name"), "conditions"	=> array( "id" => $options[0] ), "contains" => array("Groups" => array(), "Wargears" => array(), "UnitCharacteristics" => array(), "Psykers" => array(), "Warlords" => array(), "Relics" => array(), "Transports" => array() ) ) ) ) );

		$_POST["data"] = $data;

		$dataE = array_merge($data, $this->model->Find("all", array(
			"Groups" => array( array( "fields" => array( "id", "name"), "order" => array("name") ) ),
			"UnitCharacteristics" => array( array( "fields" => array( "id", "name"), "order" => array("name") ) ),
			"Wargears" => array( array( "fields" => array( "id", "name"), "order" => array("name") ) ),
			"Psykers" => array( array( "fields" => array( "id", "name"), "order" => array("name") ) ),
			"Relics" => array( array( "fields" => array( "id", "name"), "order" => array("name") ) ),
			"Warlords" => array( array( "fields" => array( "id", "name"), "order" => array("name") ) ),
			"Transports" => array( array( "fields" => array( "id", "name"), "order" => array("name") ) )
		) ) );

		return array("code" => 200, "message" => "User Edit", "data" => $dataE, "errors" => null);
	}
/**
 * [Deletes a SquadUnits]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
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

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Squads', 'action' => 'admin_view', "params" => array($options[1]), 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}
}
