<?php
namespace Frost\Controller;

/**
 * @class WarlordsController
 * @author Chris Sheppard
 * @description handles the Warlords management section
 */
class WarlordsController extends Controller {

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
 * [Index's all the Warlords]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_index($options) {
		$this->view = "admin";

		$data = $this->model->Find("pagination",
			array(
				"Warlords" => array(
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
									"Warlords.armies_id" => "armies.id"
								)
							)
						)
					)
				)
			)
		);
		$dataO = array_merge($data, $this->model->Find("all",
			array(
				"Armies" => array(
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
 * [Views a Warlords]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_view($options) {
		$this->view = "admin";

		$data = $this->model->Find("first",
			array(
				"Warlords" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"created",
							"modified"
						),
						"conditions" => array("Warlords.id" => $options[0]),
						"contains" => array(
							"Armies" => array(
								"fields" => array(
									"armies.id as `army_id`",
									"armies.name as `army_name`"
								),
								"relation" => array(
									"Warlords.armies_id" => "armies.id"
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
 * [Adds a Warlords]
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
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Warlords', 'action' => 'index', 'admin' => true));
			}
		}
		$data = array("Warlords" => array("armies_id" => $options[1]));
		/*$data = $this->model->Find("all", array(
			"Armies" => array( array( "fields" => array( "id", "name") ) )
		) );*/

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * [Edits a Warlords]
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
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Warlords', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "Warlords" => array( array( "fields" => array( "id", "name", "armies_id"), "conditions"	=> array( "id" => $options[0] ) ) ) ) );
		$_POST["data"] = $data;
		/*$dataE = array_merge($data, $this->model->Find("all", array(
			"Armies" => array( array( "fields" => array( "id", "name") ) )
		) ) );*/
		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * [Deletes a Warlords]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_delete($options) {
		$this->view = "admin";

		$data = $this->model->Find("first",
			array(
				"Warlords" => array(
					array(
						"fields" => array("armies_id"),
						"conditions" => array("Warlords.id" => $options[0])
					)
				)
			)
		);

		$this->model->Delete(
			array(
				"Warlords" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Warlords', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}
}
