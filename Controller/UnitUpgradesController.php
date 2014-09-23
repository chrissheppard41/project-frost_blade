<?php
namespace Frost\Controller;

/**
 * @class UnitUpgradesController
 * @author Chris Sheppard
 * @description handles the UnitUpgrades management section
 */
class UnitUpgradesController extends Controller {

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
 * [Index's all the UnitUpgrades]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_view($options) {
		$this->view = "admin";

		$data = $this->model->Find("first",
			array(
				"UnitUpgrades" => array(
					array(
						"fields" => array(
							"id",
							"factor",
							"created",
							"modified"
						),
						"conditions" => array("unitupgrades.id" => $options[0]),
						"contains" => array(
							"Enhancements" => array(
								"fields" => array(
									"enhancements.id as `enhancement_id`",
									"enhancements.name as `enhancement_name`"
								),
								"relation" => array(
									"unitupgrades.enhancements_id",
									"enhancements.id"
								)
							),
							"Operations" => array(
								"fields" => array(
									"operations.id as `operation_id`",
									"operations.name as `operation_name`"
								),
								"relation" => array(
									"unitupgrades.operations_id",
									"operations.id"
								)
							),
							"Wargears" => array(
								"fields" => array(
									"wargears.id as `wargear_id`",
									"wargears.name as `wargear_name`"
								),
								"relation" => array(
									"unitupgrades.wargears_id",
									"wargears.id"
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
 * [Views a UnitUpgrades]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_add($options, $methodData) {
		$this->view = "admin";
		if($this->requestType("POST")) {
			$data = $this->model->Save();
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'wargears', 'action' => 'view', 'params' => array($options[0]), 'admin' => true));
			}
		}

		$data = array_merge(array("wargears_id" => $options[0]), $this->model->Find("all", array(
			"Enhancements" => array( array( "fields" => array( "id", "name") ) ),
			"Operations" => array( array( "fields" => array( "id", "name") ) )
		) ) );

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * [Edits a UnitUpgrades]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [array]          [response]
 */
	public function admin_edit($options, $methodData) {
		$this->view = "admin";

		if($this->requestType("POST")) {
			$data = $this->model->Update($this->model->post, array("id" => $options[0]));
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'wargears', 'action' => 'view', "params" => array($options[1]), 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "UnitUpgrades" => array( array( "fields" => array( "id", "enhancements_id", "operations_id", "factor", "wargears_id"), "conditions"	=> array( "id" => $options[0] ) ) ) ) );
		$_POST["data"] = $data;
		$data = array_merge($data, array_merge(array("wargears_id" => $options[1]), $this->model->Find("all", array(
			"Enhancements" => array( array( "fields" => array( "id", "name") ) ),
			"Operations" => array( array( "fields" => array( "id", "name") ) )
		) ) ) );
		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * [Deletes a UnitUpgrades]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_delete($options) {
		$this->view = "admin";

		$this->model->Delete(
			array(
				"UnitUpgrades" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'UnitUpgrades', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}
}
