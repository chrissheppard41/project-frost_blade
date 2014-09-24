<?php
namespace Frost\Controller;

/**
 * @class UnitsController
 * @author Chris Sheppard
 * @description handles the Units management section
 */
class UnitsController extends Controller {

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
 * [Index's all the Units]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_index($options) {
		$this->view = "admin";

		$data = $this->model->Find("pagination",
			array(
				"units" => array(
					array(
						"fields" => array(
							"id",
							//"name",
							"weapon_skill",
							"ballistic_skill",
							"strength",
							"toughness",
							"initiative",
							"wounds",
							"attacks",
							"leadership",
							"armour_save",
							"invulnerable_save",
							"front_armour",
							"side_armour",
							"rear_armour",
							"hull_hitpoints",
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
 * [Views a Units]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_view($options) {
		$this->view = "admin";

		$data = $this->model->Find("first",
			array(
				"units" => array(
					array(
						"fields" => array(
							"id",
							//"name",
							"weapon_skill",
							"ballistic_skill",
							"strength",
							"toughness",
							"initiative",
							"wounds",
							"attacks",
							"leadership",
							"front_armour",
							"side_armour",
							"rear_armour",
							"hull_hitpoints",
							"armour_save",
							"invulnerable_save",
							"created",
							"modified"
						),
						"conditions" => array("units.id" => $options[0]),
						"contains" => array(
							"squads" => array(),
							"unittypes" => array(
								"fields" => array(
									"unittypes.id as `unittype_id`",
									"unittypes.name as `unittype_name`"
								),
								"relation" => array(
									"units.unittypes_id" => "unittypes.id"
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
 * [Adds a Units]
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
				\Cache::delete("squads", "squad_data_".$methodData["data"]["Units"]["armies_id"]);
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Units', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("all", array(
			"unittypes" => array( array( "fields" => array( "id", "name") ) ),
			"squads" => array( array( "fields" => array( "id", "name") ) )
		) ) ;



		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * [Edits a Units]
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
				\Cache::delete("squads", "squad_data_".$methodData["data"]["Units"]["armies_id"]);
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'Units', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "units" => array( array( "fields" => array( "id", /*"name", */"weapon_skill", "ballistic_skill", "strength", "toughness", "initiative", "wounds", "attacks", "leadership", "armour_save", "invulnerable_save", "front_armour", "side_armour", "rear_armour", "hull_hitpoints", "unitTypes_id"), "conditions"	=> array( "id" => $options[0] ), "contains" => array( "unitcharacteristics" => array(), "wargears" => array() ) ) ) ) );
		$dataE = array_merge($data, $this->model->Find("all", array(
			"unittypes" => array( array( "fields" => array( "id", "name") ) ),
			"squads" => array( array( "fields" => array( "id", "name") ) )
		) ) );
		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $dataE, "errors" => null);
	}
/**
 * [Deletes a Units]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_delete($options) {
		$this->view = "admin";

		$data = $this->model->Find("first",
			array(
				"units" => array(
					array(
						"fields" => array("armies_id"),
						"conditions" => array("units.id" => $options[0])
					)
				)
			)
		);

		$this->model->Delete(
			array(
				"units" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);
		\Cache::delete("squads", "squad_data_".$data["units"]["armies_id"]);

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'Units', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}
}
