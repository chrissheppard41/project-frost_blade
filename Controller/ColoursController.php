<?php
namespace Frost\Controller;

/**
 * @class ColoursController
 * @author Chris Sheppard
 * @description handles the Colours management section
 */
class ColoursController extends Controller {

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
 * [Index's all the Colours]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_index($options) {
		$this->view = "admin";

		$data = $this->model->Find("pagination",
			array(
				"Colours" => array(
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
 * [Views a Colours]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_view($options) {
		$this->view = "admin";

		$data = $this->model->Find("first",
			array(
				"Colours" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"created",
							"modified"
						),
						"conditions" => array("id" => $options[0]),
					)
				)
			)
		);

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}

/**
 * [Adds a Colours]
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
				\Cache::delete("Colours", "all_colours");
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Colours', 'action' => 'index', 'admin' => true));
			}
		}

		return array("code" => 200, "message" => "User View", "data" => array(), "errors" => null);
	}
/**
 * [Edits a Colours]
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
				\Cache::delete("Colours", "all_colours");
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Colours', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "Colours" => array( array( "fields" => array( "id", "name"), "conditions"	=> array( "id" => $options[0] ) ) ) ) );
		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * [Deletes a Colours]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_delete($options) {
		$this->view = "admin";

		$this->model->Delete(
			array(
				"Colours" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);

		\Cache::delete("Colours", "all_colours");
		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Colours', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}

}
