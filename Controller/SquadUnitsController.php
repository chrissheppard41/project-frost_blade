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
		$this->view = "Admin";
		$this->model->last_id = $options[0];
		if($this->requestType("POST")) {
			$data = $this->model->Update($this->model->post, array("id" => $options[0]));
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Squads', 'action' => 'view', "params" => array($options[1]), 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "squadunits" => array( array( "fields" => array( "id", "squads_id", "min_count", "max_count", "pts", "name"), "conditions"	=> array( "squadunits.id" => $options[0] ), "contains" => array("squads" => array("fields" => array( "squads.armies_id as `armies_id`" ), "relation" => array( "squads.id" => "squadunits.squads_id") ), "groups" => array(), "wargears" => array(), "unitcharacteristics" => array(), "psykers" => array(), "warlords" => array(), "relics" => array(), "transports" => array() ) ) ) ) );

		$_POST["data"] = $data;

		$dataE = array_merge($data, $this->model->Find("all", array(
			"groups" => array( array( "fields" => array( "id", "name"), "order" => array("name"), "conditions" => array("armies_id" => $data["squadunits"]["armies_id"]) ) ),
			"unitcharacteristics" => array( array( "fields" => array( "id", "name"), "order" => array("name") ) ),
			"wargears" => array( array( "fields" => array( "id", "name"), "order" => array("name") ) ),
			"psykers" => array( array( "fields" => array( "id", "name"), "order" => array("name") ) ),
			"relics" => array( array( "fields" => array( "id", "name"), "order" => array("name") ) ),
			"warlords" => array( array( "fields" => array( "id", "name"), "order" => array("name") ) ),
			"transports" => array( array( "fields" => array( "id", "name"), "order" => array("name") ) )
		) ) );

		return array("code" => 200, "message" => "User Edit", "data" => $dataE, "errors" => null);
	}
/**
 * [Deletes a SquadUnits]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_delete($options) {
		$this->view = "Admin";

		$this->model->Delete(
			array(
				"squadunits" => array(
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
