<?php
namespace Frost\Controller;

/**
 * @class WargearsController
 * @author Chris Sheppard
 * @description handles the Wargears management section
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
 * [Index's all the Wargears]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
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
						"pagination" => 10
					)
				)
			)
		);

		return array("code" => 200, "message" => "User Index", "data" => $data, "errors" => null);
	}

/**
 * [Views a Wargears]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
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
							"UnitUpgrades" => array()
						)
					)
				)
			)
		);

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * [Adds a Wargears]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [array]          [response]
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
		if(isset($options[0])) {
			$data["Groups"]["id"] = $options[0];
		}

		return array("code" => 200, "message" => "User View", "data" => array(), "errors" => null);
	}
/**
 * [Edits a Wargears]
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
				\Cache::delete("Squads", "squad_data_".$methodData["data"]["Groups"]["armies_id"]);
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Wargears', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "Wargears" => array( array( "fields" => array( "id", "name"), "conditions"	=> array( "id" => $options[0] ) ) ) ) );
		$_POST["data"] = $data;

		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * [Deletes a Wargears]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
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
