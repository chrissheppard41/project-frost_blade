<?php
namespace Frost\Controller;


/*
	@class ArmyListsController
	@author Chris Sheppard
	@desc handles the army list management section
*/
class ArmyListsController extends Controller {

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
 * ROUTE: /admin/ArmyLists/index
 * Method: GET
 * Index's all the ArmyLists
 *
 * @param
 * @return (array)
 */
	public function admin_index($options) {
		$this->view = "admin";

		$data = $this->model->Find("pagination",
			array(
				"ArmyLists" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"descr",
							"point_limit",
							"hide",
							"users_id",
							"armies_id",
							"created",
							"modified"
						),
						"pagination" => 10,
						"contains" => array(
							"Users" => array(
								"fields" => array(
									"Users.id as `user_id`",
									"Users.username"
								),
								"relation" => array(
									"ArmyLists.users_id", "Users.id"
								)
							),
							"Armies" => array(
								"fields" => array(
									"armies.name as `army_name`"
								),
								"relation" => array(
									"ArmyLists.armies_id", "armies.id"
								)
							)
						)

					)
				)
			)
		);

		return array("code" => 200, "message" => "User Index", "data" => $data, "errors" => null);
	}

/**
 * admin_view method
 * ROUTE: /admin/ArmyLists/view/:id
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
				"ArmyLists" => array(
					array(
						"fields" => array(
							"id",
							"name",
							"descr",
							"point_limit",
							"hide",
							"users_id",
							"armies_id",
							"created",
							"modified"
						),
						"conditions" => array("ArmyLists.id" => $options[0]),
						"contains" => array(
							"Users" => array(
								"fields" => array(
									"Users.id as `user_id`",
									"Users.username"
								),
								"relation" => array(
									"ArmyLists.users_id", "Users.id"
								)
							),
							"Armies" => array(
								"fields" => array(
									"armies.name as `army_name`"
								),
								"relation" => array(
									"ArmyLists.armies_id", "armies.id"
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
 * admin_view admin_add
 * ROUTE: /admin/ArmyLists/add/:id
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
				\Cache::delete('ArmyLists', "private");
				\Cache::delete('ArmyLists', "public");
				\Cache::delete('ArmyLists', "top");
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'ArmyLists', 'action' => 'index', 'admin' => true));
			}
		}

		$data = $this->model->Find("all", array(
			"Users" => array( array( "fields" => array( "id", "username as `name`") ) ),
			"Armies" => array( array( "fields" => array( "id", "name") ) )
		) );

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * admin_edit method
 * ROUTE: /admin/ArmyLists/edit/:id
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
			$data = $this->model->Update($this->model->post, array("ArmyLists.id" => $options[0]));
			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				\Cache::delete('ArmyLists', "private");
				\Cache::delete('ArmyLists', "public");
				\Cache::delete('ArmyLists', "top");
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'armylists', 'action' => 'index', 'admin' => true));
			}
		}
		$data = $this->model->Find("first", array( "ArmyLists" => array(
					array(
						"fields" => array( "id", "name", "descr", "point_limit", "hide", "users_id", "armies_id" ),
						"conditions" => array("ArmyLists.id" => $options[0]),
						"contains" => array(
							"Users" => array( "fields" => array( "Users.id as `user_id`", "Users.username" ), "relation" => array( "ArmyLists.users_id", "Users.id" ) ),
							"Armies" => array( "fields" => array( "armies.name as `army_name`" ), "relation" => array( "ArmyLists.armies_id", "armies.id" ) )
						)
					)
				)
			)
		);

		$dataE = array_merge($data, $this->model->Find("all", array(
			"Users" => array( array( "fields" => array( "id", "username as `name`") ) ),
			"Armies" => array( array( "fields" => array( "id", "name") ) )
		) ) );
		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $dataE, "errors" => null);
	}
/**
 * admin_delete method
 * ROUTE: /admin/ArmyLists/delete/:id
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
				"ArmyLists" => array(
					"conditions" => array(
						"ArmyLists.id" => $options[0]
					)
				)
			)
		);
		\Cache::delete('ArmyLists', "private");
		\Cache::delete('ArmyLists', "public");
		\Cache::delete('ArmyLists', "top");
		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'ArmyLists', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}

/**
 * armies method
 * ROUTE: /armies
 * Method: GET
 * API armies to return a list of public/personal army lists
 *
 * @param
 * @return (array)
 */
	public function armies($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		$user_id = (int)(\Configure::User("id") != null)?\Configure::User("id"):0;

		$cache = "private";
		if($options[0] == "public") {
			$cache = "public";
			$conditions = array("armylists.hide" => 0);
			$order = array();

			$count = $this->model->find(
				'first',
				array(
					"ArmyLists" => array(
						array(
							"fields" => array(
								"COUNT(*) as `count`"
							),
							"conditions" => $conditions
						)
					)
				)
			);

		} else if($options[0] == "top") {
			$cache = "top";
			$conditions = array("armylists.hide" => 0);
			$order = array("score ASC");
		} else {
			if(!\Configure::Logged()) {
				throw new \WebException("Forbidden: Not logged in", 403);
			}
			$conditions = array("ArmyLists.users_id" => $user_id);
			$order = array();

			$count = $this->model->find(
				'first',
				array(
					"ArmyLists" => array(
						array(
							"fields" => array(
								"COUNT(*) as `count`"
							),
							"conditions" => $conditions
						)
					)
				)
			);
		}

		$data = \Cache::read('ArmyLists', $cache);
		if(!$data){
			$data = $this->model->find(
				'all',
				array(
					"ArmyLists" => array(
						array(
							"fields" => array(
								"id",
								"code",
								"name",
								"descr",
								"point_limit",
								"hide",
								"score",
								"users_id",
								"armies_id",
								"created",
								"modified"
							),
							"conditions" => $conditions,
							"order" => $order,
							"limit" => 5,
							"contains" => array(
								"Armies" => array(
									"fields" => array(
										"armies.name as `army_name`"
									),
									"relation" => array(
										"ArmyLists.armies_id" => "armies.id"
									)
								),
								"Races" => array(
									"fields" => array(
										"races.name as `races_name`",
										"races.icon"
									),
									"relation" => array(
										"Armies.races_id" => "races.id"
									)
								),
								"Colours" => array(
									"fields" => array(
										"colours.name as `colours_name`"
									),
									"relation" => array(
										"Armies.colours_id" => "colours.id"
									)
								),
								"Votes" => array(
									"fields" => array(
										"votes.vote"
									),
									"relation" => array(
										"Votes.armylists_id" => "ArmyLists.id",
										"Votes.users_id" => $user_id
									)
								)
							)
						)
					)
				)
			);
			\Cache::write('ArmyLists', $cache, $data);
		}
		if(isset($count["ArmyLists"]["count"])) {
			$data["count"] = $count["ArmyLists"]["count"];
		}

		return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => $data));
	}

/**
 * armies_all method
 * ROUTE: /armies_all
 * Method: GET
 * API armies_all to return a list of public/personal/top army lists in 1 api call
 *
 * @param
 * @return (array)
 */
	public function armies_all($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		$user_id = (int)(\Configure::User("id") != null)?\Configure::User("id"):0;

		$data = \Cache::read('ArmyLists'.DS.'Users', "armies_".$user_id);
		if(!$data){
			$data["top"] = $this->model->army_lists("top", $user_id);
			$data["public"] = $this->model->army_lists("public", $user_id);
			if($user_id != 0) {
				$data["private"] = $this->model->army_lists("private", $user_id);
			}
			\Cache::write('ArmyLists'.DS.'Users', "armies_".$user_id, $data);
		}

		return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => $data));
	}
/**
 * API save_army to saves a submitted army
 *
 * @return void
 */

	public function save_army($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		if(!$this->requestType("POST")) {
			throw new \WebException("Wrong method request", 405);
		}

		$requiredParams = array(
			'armies_id' => null,
			'name' => null,
			'descr' => null,
			'point_limit' => null
		);

		// check that all required params have been supplied
		if ($this->_hasRequiredParams($requiredParams, $methodData["ArmyLists"])) {
			throw new \WebException("Incorrect parameters supplied", 400);
		}
		if(!\Configure::Logged()) {
			throw new \WebException("Forbidden: Not logged in", 403);
		}

		$methodData["ArmyLists"]['code'] = $this->model->_generateCode(\Configure::User('id'));
		$methodData["ArmyLists"]['users_id'] = \Configure::User('id');

		$data = $this->model->Save($methodData);
		if($data["error"] === true) {
			return \Frost\Configs\Response::setResponse(400, "Army Lists", array("errors" => $data["error"]));
		} else {
			\Cache::delete('ArmyLists', "private");
			\Cache::delete('ArmyLists', "public");
			\Cache::delete('ArmyLists', "top");
			return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => $data));
		}
	}

/**
	 * API view_army to view an existing army
	 *
	 * @return void
	 */

	public function view_army($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		if(is_numeric($options[0])) {
			$conditions = array(
				"ArmyLists.id" => (int)$options[0],
				"ArmyLists.users_id" => \Configure::User("id")
			);
		} else {
			$conditions = array(
				"ArmyLists.code" => preg_replace('/[^0-9a-z]+/', '', $options[0]),
				"ArmyLists.hide" => 0
			);
		}

		$user_id = (int)(\Configure::User("id") != null)?\Configure::User("id"):0;
		$data = \Cache::read('ArmyLists', '_army_'.$user_id);
		if(!$data){
			$data = $this->model->Find("first",
				array(
					"ArmyLists" => array(
						array(
							"fields" => array(
								"id",
								"code",
								"name",
								"descr",
								"point_limit",
								"score",
								"hide",
								"users_id",
								"armies_id",
								"created",
								"modified"
							),
							"conditions" => $conditions,
							"contains" => array(
								"Users" => array(
									"fields" => array(
										"Users.id as `user_id`",
										"Users.username"
									),
									"relation" => array(
										"ArmyLists.users_id" => "Users.id"
									)
								),
								"Armies" => array(
									"fields" => array(
										"armies.name as `army_name`"
									),
									"relation" => array(
										"ArmyLists.armies_id" => "armies.id"
									)
								),
								"Races" => array(
									"fields" => array(
										"races.name as `races_name`",
										"races.icon"
									),
									"relation" => array(
										"Armies.races_id" => "races.id"
									)
								),
								"Colours" => array(
									"fields" => array(
										"colours.name as `colours_name`"
									),
									"relation" => array(
										"Armies.colours_id" => "colours.id"
									)
								),
								"Votes" => array(
									"fields" => array(
										"votes.vote"
									),
									"relation" => array(
										"Votes.armylists_id" => "ArmyLists.id",
										"Votes.users_id" => $user_id
									)
								),
								"ArmySquads" => array(
									array(
										"fields" => array(
											"id",
											"position",
											"squads_id"
										),
										"contains" => array(
											"ArmyUnits" => array(
												"fields" => array(
													"ArmyUnits.id as `armyunits_id`",
													"ArmyUnits.count",
													"ArmyUnits.units_id"
												),
												"contains" => array(
													"ArmyWargears" => array(
														"fields" => array(
															"ArmyWargears.id as `armywargears_id`",
															"ArmyWargears.wargears_id"
														),
														"contains" => array(
															"Wargears" => array()
														)

													)
												)
											)
										)
									)
								)
							)
						)
					)
				)
			);
			\Cache::write('ArmyLists', '_army_'.$user_id, $data);
		}

		if((int)$data["ArmyLists"]["hide"] === 1) {
			if(!\Configure::Logged()) {
				throw new \WebException("Forbidden: Not logged in", 403);
			}
		}

		return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => $data));
	}

	/**
	 * API delete_army to delete an existing army
	 *
	 * @return void
	 */

	public function delete_army($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		if(!$this->requestType("DELETE")) {
			throw new \WebException("Wrong method request", 405);
		}

		if(!\Configure::Logged()) {
			throw new \WebException("Forbidden: Not logged in", 403);
		}

		$user_army = $this->model->find(
			"first",
			array(
				"ArmyLists" => array(
					array(
						"fields" => array(
							"id",
							"hide"
						),
						"conditions" => array(
							"users_id" => \Configure::User("id"),
							"id" => $options[0]
						)
					)
				)
			)
		);

		if(empty($user_army)) {
			throw new \WebException("Forbidden: Army does not belong to you", 403);
		}

		$this->model->Delete(
			array(
				"ArmyLists" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);
		\Cache::delete('ArmyLists', "private");
		\Cache::delete('ArmyLists', "public");
		\Cache::delete('ArmyLists', "top");

		return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => null));
	}

	/**
	 * API save_army to saves a submitted army
	 *
	 * @return void
	 */

	public function edit_save_army($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		if(!$this->requestType("POST")) {
			throw new \WebException("Wrong method request", 405);
		}

		if(!\Configure::Logged()) {
			throw new \WebException("Forbidden: Not logged in", 403);
		}

		$requiredParams = array(
			'name' => null,
			'descr' => null,
			'point_limit' => null
		);

		// check that all required params have been supplied
		if ($this->_hasRequiredParams($requiredParams, $methodData)) {
			throw new \WebException("Incorrect parameters supplied", 400);
		}
		$this->model->last_id = $options[0];

		$user_army = $this->model->find(
			"first",
			array(
				"ArmyLists" => array(
					array(
						"fields" => array(
							"id"
						),
						"conditions" => array(
							"users_id" => \Configure::User("id"),
							"id" => $options[0]
						)
					)
				)
			)
		);

		if(empty($user_army)) {
			throw new \WebException("Forbidden: Army does not belong to you", 403);
		}

		$data = $this->model->Update(array("ArmyLists" => $methodData), array("id" => $options[0]));
		if($data["error"] === true) {
			return \Frost\Configs\Response::setResponse(400, "Army Lists", array("errors" => $data["error"]));
		} else {
			\Cache::delete('ArmyLists', "private");
			\Cache::delete('ArmyLists', "public");
			\Cache::delete('ArmyLists', "top");
			\Cache::delete('ArmyLists', "_army_".$options[0]);
			return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => null));
		}
	}

	/**
	 * API save_units to saves a submitted army
	 *
	 * @return void
	 */

	public function save_units($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		if(!$this->requestType("POST")) {
			throw new \WebException("Wrong method request", 405);
		}

		if(!\Configure::Logged()) {
			throw new \WebException("Forbidden: Not logged in", 403);
		}

		$user_army = $this->model->find(
			"first",
			array(
				"ArmyLists" => array(
					array(
						"fields" => array(
							"id"
						),
						"conditions" => array(
							"users_id" => \Configure::User("id"),
							"id" => $options[0]
						)
					)
				)
			)
		);

		if(empty($user_army)) {
			throw new \WebException("Forbidden: Army does not belong to you", 403);
		}

		$this->model->Delete(
			array(
				"ArmySquads" => array(
					"conditions" => array(
						"armylists_id" => $options[0]
					)
				)
			)
		);

		$data = $this->model->Save($methodData);
		if($data["error"] === true) {
			return \Frost\Configs\Response::setResponse(400, "Army Lists", array("errors" => $data["error"]));
		} else {
			\Cache::delete('ArmyLists', "private");
			\Cache::delete('ArmyLists', "public");
			\Cache::delete('ArmyLists', "top");
			return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => null));
		}
	}

	/**
	 * API get_army to retrieve my army
	 *
	 * @return void
	 */

	public function get_army($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		if(!\Configure::Logged()) {
			throw new \WebException("Forbidden: Not logged in", 403);
		}

		$user_army = $this->model->find(
			"first",
			array(
				"ArmyLists" => array(
					array(
						"fields" => array(
							"id"
						),
						"conditions" => array(
							"users_id" => \Configure::User("id"),
							"id" => $options[0]
						)
					)
				)
			)
		);

		if(empty($user_army)) {
			throw new \WebException("Forbidden: Army does not belong to you", 403);
		}

		$this->model->Delete(
			array(
				"ArmySquads" => array(
					"conditions" => array(
						"armylists_id" => $options[0]
					)
				)
			)
		);


		//$data = Cache::read('_army_'.$id, 'army_lists');
		//if(!$data){
			$data = $this->model->Find("first",
			array(
				"ArmySquads" => array(
					array(
						"fields" => array(
							"id",
							"position",
							"squads_id"
						),
						"conditions" => array(
							"armylists_id" => $options[0]
						),
						"contains" => array(
							"ArmyUnits" => array(
								"fields" => array(
									"ArmyUnits.id as `armyunits_id`",
									"ArmyUnits.count",
									"ArmyUnits.units_id"
								),
								"contains" => array(
									"ArmyWargears" => array(
										"fields" => array(
											"ArmyWargears.id as `armywargears_id`",
											"ArmyWargears.wargears_id"
										)

									)
								)
							)
						)
					)
				)
			)
		);
        //    if(!empty($data)) {
        //        Cache::write('_army_'.$id, $data, 'army_lists');
        //    }
		//}


		return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => $data));
	}

	/**
	 * API vote to give opinion on a army
	 *
	 * @return void
	 */

	public function vote($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";


		if(!\Configure::Logged()) {
			$this->Flash("<strong>Error</strong> You must log in first to complete this action", "alert alert-danger");
			throw new \WebException("Forbidden: Not logged in", 403);
		}

		if(!$this->requestType("PUT")) {
			throw new \WebException("Wrong method request", 405);
		}

		$data = $this->model->Call('votesystem', array($options[0], \Configure::User("id"), $options[1]));

		\Cache::delete('ArmyLists', "private");
		\Cache::delete('ArmyLists', "public");
		\Cache::delete('ArmyLists', "top");

		\Cache::delete('ArmyLists', "_army_".$data[0]["army_id"]);

		\Cache::deleteDir('ArmyLists' . DS . 'Users');

		return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => null));

	}

}