<?php
namespace Frost\Controller;

/**
 * @class SquadsController
 * @author Chris Sheppard
 * @description handles the Squads management section
 */
class SquadsController extends Controller {

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
 * [Index's all the Squads]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_index($options) {
		$this->view = "admin";

		$data = $this->model->Find("pagination",
			array(
				"squads" => array(
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
									"squads.armies_id" => "armies.id"
								)
							),
							"types" => array(
								"fields" => array(
									"types.id as `type_id`",
									"types.name as `type_name`"
								),
								"relation" => array(
									"squads.types_id" => "types.id"
								)
							),
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
 * [Views a Squads]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_view($options) {
		$this->view = "admin";

		$data = $this->model->Find("first",
			array(
				"squads" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"created",
							"modified"
						),
						"conditions" => array("squads.id" => $options[0]),
						"contains" => array(
							"armies" => array(
								"fields" => array(
									"armies.id as `army_id`",
									"armies.name as `army_name`"
								),
								"relation" => array(
									"squads.armies_id" => "armies.id"
								)
							),
							"types" => array(
								"fields" => array(
									"types.id as `type_id`",
									"types.name as `type_name`"
								),
								"relation" => array(
									"squads.types_id" => "types.id"
								)
							),
							"units" => array(),
							"squadunits" => array()
						)
					)
				)
			)
		);
//\Configure::pre($data);
		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * [Adds a Squads]
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
				\Cache::delete("Squads". DS ."Armies", "_army_".$methodData["data"]["Squads"]["armies_id"]);
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Squads', 'action' => 'view', 'params' => array($this->model->last_id), 'admin' => true));
			}
		}

		$dataE = array("squads" => array("armies_id" => $options[1]));

		$join = '*, CONCAT(unittypes.name," - ",weapon_skill,"/",ballistic_skill,"/",strength,"/",toughness,"/",wounds,"/",initiative,"/",attacks,"/",leadership,"/",armour_save,"+/",invulnerable_save,"+ - ",front_armour,"/",side_armour,"/",rear_armour,"/",hull_hitpoints) as `name`';

		$data = array_merge($dataE, $this->model->Find("all", array(
			//"Armies" => array( array( "fields" => array( "id", "name") ) ),
			"units" => array( array( "fields" => array( "id", $join), /*"conditions" => array("armies_id" => $options[1]),*/ "contains" => array( "unittypes" => array( "fields" => array( "unittypes.name as `unittypes_name`" ), "relation" => array( "units.unittypes_id" => "unittypes.id" ) ) ), "order" => array("unittypes.name", "unittypes.weapon_skill") ) ),
			"types" => array( array( "fields" => array( "id", "name") ) )
		) ) );

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * [Edits a Squads]
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
				\Cache::delete("Squads". DS ."Armies", "_army_".$methodData["data"]["Squads"]["armies_id"]);
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Squads', 'action' => 'view', 'params' => array($this->model->last_id), 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "squads" => array( array( "fields" => array( "id", "name", "armies_id", "types_id"), "conditions"	=> array( "id" => $options[0] ), "contains" => array( "units" => array() ) ) ) ) );
		$_POST["data"] = $data;

		$join = '*, CONCAT(unittypes.name," - ",weapon_skill,"/",ballistic_skill,"/",strength,"/",toughness,"/",wounds,"/",initiative,"/",attacks,"/",leadership,"/",armour_save,"+/",invulnerable_save,"+ - ",front_armour,"/",side_armour,"/",rear_armour,"/",hull_hitpoints) as `name`';

		$dataE = array_merge($data, $this->model->Find("all", array(
			//"Armies" => array( array( "fields" => array( "id", "name") ) ),
			"units" => array( array( "fields" => array( "id", $join), /*"conditions" => array("armies_id" => $data["squads"]["armies_id"]),*/ "contains" => array( "unittypes" => array( "fields" => array( "unittypes.name as `unittypes_name`" ), "relation" => array( "units.unittypes_id" => "unittypes.id" ) ) ), "order" => array("unittypes.name") ) ),
			"types" => array( array( "fields" => array( "id", "name") ) )
		) ) );

		return array("code" => 200, "message" => "User Edit", "data" => $dataE, "errors" => null);
	}
/**
 * [Deletes a Squads]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_delete($options) {
		$this->view = "admin";

		$data = $this->model->Find("first",
			array(
				"squads" => array(
					array(
						"fields" => array("armies_id"),
						"conditions" => array("squads.id" => $options[0])
					)
				)
			)
		);
		$this->model->Delete(
			array(
				"squads" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);
		\Cache::delete("Squads". DS ."Armies", "_army_".$data["squads"]["armies_id"]);

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Squads', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}

/**
 * API endpoints
 */

/**
 * [API squads_race to return a list of squads related to race]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 *
 * @throws   If [missing access from the request]
 * @throws   If [access is incorrect with session access]
 * @throws   If [not logged in]
 *
 * @return [array]          [response]
 */
	public function squads_race($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		$requiredParams = array(
			'access' => null
		);

		// check that all required params have been supplied
		if ($this->_hasRequiredParams($requiredParams, array('access' => $options[1]))) {
			throw new \WebException("Incorrect parameters supplied", 400);
		}

		if(!$this->model->auth_check($options[1], \Configure::read("Token"))) {
			throw new \WebException("Forbidden: Bad request", 400);
		}

		if(!\Configure::Logged()) {
			throw new \WebException("Forbidden: Not logged in", 403);
		}

		$data = \Cache::read("Squads". DS ."Armies", "_army_".$options[0]);
		if(!$data) {
			$data = $this->model->Find(
				"all",
				array(
					"squads" => array(
						array(
							"fields" => array(
								"id",
								"name",
								"created",
								"modified"
							),
							"conditions" => array("squads.armies_id" => $options[0]),
							"contains" => array(
								"types" => array(
									"fields" => array(
										"types.name as `type_name`"
									),
									"relation" => array(
										"squads.types_id" => "types.id"
									)
								)
							)
						)
					)
				)
			);
			\Cache::write("Squads". DS ."Armies", "_army_".$options[0], $data);
		}

		return \Frost\Configs\Response::setResponse(200, "Squads", array("data" => $data));
	}

/**
 * [API squads_unit to return a list of squads related to race with one exception, you don't need to be logged in (for public)]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 *
 * @throws   If [missing access from the request]
 * @throws   If [access is incorrect with session access]
 *
 * @return [array]          [response]
 */
	public function squads_units($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		$requiredParams = array(
			'access' => null
		);
		// check that all required params have been supplied
		if ($this->_hasRequiredParams($requiredParams, array('access' => $options[1]))) {
			throw new \WebException("Incorrect parameters supplied", 400);
		}

		if(!$this->model->auth_check($options[1], \Configure::read("Token"))) {
			throw new \WebException("Forbidden: Bad request", 400);
		}

		/*if(!\Configure::Logged()) {
			throw new \WebException("Forbidden: Not logged in", 403);
		}*/

		$data = \Cache::read("Squads", "squad_data_".$options[0]);
		if(!$data) {
			$data = $this->model->Find(
				"all",
				array(
					"squads" => array(
						array(
							"fields" => array(
								"id",
								"name",
								"created",
								"modified"
							),
							"conditions" => array("squads.armies_id" => $options[0]),
							"contains" => array(
								"types" => array(
									"fields" => array(
										"types.name as `type_name`"
									),
									"relation" => array(
										"squads.types_id" => "types.id"
									)
								),
								"squadunits" => array(
								)
							)
						)
					)
				)
			);
			\Cache::write("Squads", "squad_data_".$options[0], $data);
		}

		return \Frost\Configs\Response::setResponse(200, "Squads", array("data" => $data));
	}
}
