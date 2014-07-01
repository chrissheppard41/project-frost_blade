<?php
namespace Frost\Controller;


/*
	@class RacesController
	@author Chris Sheppard
	@desc handles the races management section
*/
class RacesController extends Controller {

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
 * ROUTE: /admin/Races/index
 * Method: GET
 * Index's all the Races
 *
 * @param
 * @return (array)
 */
	public function admin_index($options) {
		$this->view = "admin";

		$data = $this->model->Find("pagination",
			array(
				"Races" => array(
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
 * admin_view method
 * ROUTE: /admin/Races/view/:id
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
				"Races" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"created",
							"modified"
						),
						"conditions" => array("id" => $options[0]),
						"contains" => array( "Armies" => array() )
					)
				)
			)
		);

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * admin_view admin_add
 * ROUTE: /admin/Races/add/:id
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

				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Races', 'action' => 'index', 'admin' => true));
			}
		}

		return array("code" => 200, "message" => "User View", "data" => array(), "errors" => null);
	}
/**
 * admin_edit method
 * ROUTE: /admin/Races/edit/:id
 * Method: PUT
 * Edits a user
 *
 * @param
 * @return (array)
 */
	public function admin_edit($options, $methodData) {
		$this->view = "admin";

		if($this->requestType("POST")) {
			$data = $this->model->Update($this->model->post, array("id" => $options[0]));
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				\Cache::delete('Races', 'types_all');

				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Races', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "Races" => array( array( "fields" => array( "id", "name"), "conditions"	=> array( "id" => $options[0] ) ) ) ) );
		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * admin_delete method
 * ROUTE: /admin/Races/delete/:id
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
				"Races" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);
		\Cache::delete('Races', 'types_all');

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Races', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}

	/**
     * API endpoints
     */

     /**
     * API racetypes to return a list of army types to choose from
     *
     * @return void
     */

    public function racetypes() {
		$this->view = "Empty";
		$this->returnType = "json";

        $data = \Cache::read('Races', 'types_all');
        if(!$data) {
            $data = $this->model->find(
                'all',
                array(
					"Races" => array(
						array(
							"fields" => array(
								"id",
								"name"
							),
							"contains" => array(
								"Armies" => array()
							)
						)
					)
				)
            );
            \Cache::write('Races', 'types_all', $data);
        }

		return \Frost\Configs\Response::setResponse(200, "Race Types", array("data" => $data));
    }

}
