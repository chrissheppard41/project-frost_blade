<?php
namespace Frost\Controller;


/*
	@class WargearGroupsController
	@author Chris Sheppard
	@desc handles the WargearGroups management section
*/
class WargearGroupsController extends Controller {

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
 * admin_edit method
 * ROUTE: /admin/WargearGroups/edit/:id
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
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Groups', 'action' => 'view', "params" => array($options[1]), 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "WargearGroups" => array( array( "fields" => array( "id", "groups_id", "pts"), "conditions"	=> array( "WargearGroups.id" => $options[0] ), "contains" => array(
							"Wargears" => array(
								"fields" => array(
									"Wargears.name as `name`"
								),
								"relation" => array(
									"WargearGroups.wargears_id" => "Wargears.id"
								)
							)
						) ) ) ) );

		$_POST["data"] = $data;

		/*$dataE = array_merge($data, $this->model->Find("all", array(
			"Groups" => array( array( "fields" => array( "id", "name") ) )
		) ) );*/

		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * admin_delete method
 * ROUTE: /admin/WargearGroups/delete/:id
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
				"WargearGroups" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Groups', 'action' => 'admin_view', "params" => array($options[1]), 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}
}
