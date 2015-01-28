<?php
namespace Frost\Controller;

/**
 * @class TypesController
 * @author Chris Sheppard
 * @description handles the Types management section
 */
class TypesController extends Controller {

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
 * [Index's all the Types]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_index($options) {
		$this->view = "Admin";

		$data = $this->model->Find("pagination",
			array(
				"types" => array(
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
 * [Views a Types]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_view($options) {
		$this->view = "Admin";

		$data = $this->model->Find("first",
			array(
				"types" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"created",
							"modified"
						),
						"conditions" => array("id" => $options[0]),
						"contains" => array( "squads" => array() )
					)
				)
			)
		);

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * [Adds a Types]
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
				\Cache::delete("Types", "all_types");
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Types', 'action' => 'index', 'admin' => true));
			}
		}

		return array("code" => 200, "message" => "User View", "data" => array(), "errors" => null);
	}
/**
 * [Edits a Types]
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
				\Cache::delete("Types", "all_types");
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Types', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "types" => array( array( "fields" => array( "id", "name"), "conditions"	=> array( "id" => $options[0] ) ) ) ) );
		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * [Deletes a Types]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_delete($options) {
		$this->view = "Admin";

		$this->model->Delete(
			array(
				"types" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);

		\Cache::delete("Types", "all_types");
		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Types', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}

/**
 * API endpoints
 */

/**
 * [API unit_types to return all unit types]
 * @return [array]          [response]
 */
    public function unit_types() {
		$this->view = "Empty";
		$this->returnType = "json";

        /*if(!\Configure::Logged()) {
			throw new \WebException("Forbidden: Not logged in", 403);
		}*/

        $data = \Cache::read('Types', 'all_types');
        if(!$data){
			$data = $this->model->Find("all",
				array(
					"types" => array(
						array(
							"fields" => array(
								"id",
								"name",
								"created",
								"modified"
							)
						)
					)
				)
			);
			\Cache::write("Types", 'all_types', $data);
        }

        return \Frost\Configs\Response::setResponse(200, "Types", array("data" => $data));
    }
}
