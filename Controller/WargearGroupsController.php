<?php
namespace Frost\Controller;

/**
 * @class WargearGroupsController
 * @author Chris Sheppard
 * @description handles the WargearGroups management section
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
 * [Edits a WargearGroups]
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
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Groups', 'action' => 'view', "params" => array($options[1]), 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "wargeargroups" => array( array( "fields" => array( "id", "groups_id", "pts"), "conditions"	=> array( "wargeargroups.id" => $options[0] ), "contains" => array(
							"wargears" => array(
								"fields" => array(
									"wargears.name as `name`"
								),
								"relation" => array(
									"wargeargroups.wargears_id" => "wargears.id"
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
 * [Deletes a WargearGroups]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_delete($options) {
		$this->view = "admin";

		$this->model->Delete(
			array(
				"wargeargroups" => array(
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
