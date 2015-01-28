<?php
namespace Frost\Controller;

/**
 * @class RelicsController
 * @author Chris Sheppard
 * @description handles the Relics management section
 */
class RelicsController extends Controller {

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
 * [Index's all the Relics]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_index($options) {
		$this->view = "Admin";

		$data = $this->model->Find("pagination",
			array(
				"relics" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"created",
							"modified"
						),
						"pagination" => 10,
						"contains" => array(
							"armies" => array(
								"fields" => array(
									"armies.id as `army_id`",
									"armies.name as `army_name`"
								),
								"relation" => array(
									"relics.armies_id" => "armies.id"
								)
							)
						)
					)
				)
			)
		);
		$dataO = array_merge($data, $this->model->Find("all",
			array(
				"armies" => array(
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
 * [Views a Relics]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_view($options) {
		$this->view = "Admin";

		$data = $this->model->Find("first",
			array(
				"relics" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"created",
							"modified"
						),
						"conditions" => array("relics.id" => $options[0]),
						"contains" => array(
							"armies" => array(
								"fields" => array(
									"armies.id as `army_id`",
									"armies.name as `army_name`"
								),
								"relation" => array(
									"relics.armies_id" => "armies.id"
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
 * [Adds a Relics]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [array]          [response]
 */
	public function admin_add($options, $methodData) {
		$this->view = "Admin";
		if($this->requestType("POST")) {
			$data = $this->model->Save();
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Relics', 'action' => 'index', 'admin' => true));
			}
		}
		$data = array("relics" => array("armies_id" => $options[1]));
		/*$data = $this->model->Find("all", array(
			"Armies" => array( array( "fields" => array( "id", "name") ) )
		) );*/

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * [Edits a Relics]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [array]          [response]
 */
	public function admin_edit($options, $methodData) {
		$this->view = "Admin";

		if($this->requestType("POST")) {
			$data = $this->model->Update($this->model->post, array("id" => $options[0]));
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Relics', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "relics" => array( array( "fields" => array( "id", "name", "armies_id"), "conditions"	=> array( "id" => $options[0] ) ) ) ) );
		$_POST["data"] = $data;
		/*$dataE = array_merge($data, $this->model->Find("all", array(
			"Armies" => array( array( "fields" => array( "id", "name") ) )
		) ) );*/
		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * [Deletes a Relics]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_delete($options) {
		$this->view = "Admin";

		$data = $this->model->Find("first",
			array(
				"relics" => array(
					array(
						"fields" => array("armies_id"),
						"conditions" => array("relics.id" => $options[0])
					)
				)
			)
		);

		$this->model->Delete(
			array(
				"relics" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Relics', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}
}
