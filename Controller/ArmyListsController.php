<?php
namespace Frost\Controller;

/**
 * @class ArmyListsController
 * @author Chris Sheppard
 * @description handles the army list management section
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
 * [Index's all the ArmyLists]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_index($options) {
		$this->view = "admin";

		$data = $this->model->Find("pagination",
			array(
				"armylists" => array(
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
							"users" => array(
								"fields" => array(
									"users.id as `user_id`",
									"users.username"
								),
								"relation" => array(
									"armylists.users_id" => "users.id"
								)
							),
							"armies" => array(
								"fields" => array(
									"armies.name as `army_name`"
								),
								"relation" => array(
									"armylists.armies_id" => "armies.id"
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
 * [Views a ArmyLists]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_view($options) {
		$this->view = "admin";

		$data = $this->model->Find("first",
			array(
				"armylists" => array(
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
						"conditions" => array("armylists.id" => $options[0]),
						"contains" => array(
							"users" => array(
								"fields" => array(
									"users.id as `user_id`",
									"users.username"
								),
								"relation" => array(
									"armylists.users_id" => "users.id"
								)
							),
							"armies" => array(
								"fields" => array(
									"armies.name as `army_name`"
								),
								"relation" => array(
									"armylists.armies_id" => "armies.id"
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
 * [Adds a ArmyLists]
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
				\Cache::delete('ArmyLists', "private");
				\Cache::delete('ArmyLists', "public");
				\Cache::delete('ArmyLists', "top");
				$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'ArmyLists', 'action' => 'index', 'admin' => true));
			}
		}

		$data = $this->model->Find("all", array(
			"users" => array( array( "fields" => array( "id", "username as `name`") ) ),
			"armies" => array( array( "fields" => array( "id", "name") ) )
		) );

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}

/**
 * [Edits a ArmyLists]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [array]          [response]
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
		$data = $this->model->Find("first", array( "armylists" => array(
					array(
						"fields" => array( "id", "name", "descr", "point_limit", "hide", "users_id", "armies_id" ),
						"conditions" => array("armylists.id" => $options[0]),
						"contains" => array(
							"users" => array( "fields" => array( "users.id as `user_id`", "users.username" ), "relation" => array( "armylists.users_id", "Users.id" ) ),
							"armies" => array( "fields" => array( "armies.name as `army_name`" ), "relation" => array( "armylists.armies_id", "armies.id" ) )
						)
					)
				)
			)
		);

		$dataE = array_merge($data, $this->model->Find("all", array(
			"users" => array( array( "fields" => array( "id", "username as `name`") ) ),
			"armies" => array( array( "fields" => array( "id", "name") ) )
		) ) );
		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $dataE, "errors" => null);
	}

/**
 * [Deletes a ArmyLists]
 * @param  [array] $options [contains url input]
 * @return [array]          [response]
 */
	public function admin_delete($options) {
		$this->view = "admin";

		$this->model->Delete(
			array(
				"armylists" => array(
					"conditions" => array(
						"armylists.id" => $options[0]
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
 * [API armies to return a list of public/personal army lists]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [type]             [response]
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
					"armylists" => array(
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
			$conditions = array("armylists.users_id" => $user_id);
			$order = array();

			$count = $this->model->find(
				'first',
				array(
					"armylists" => array(
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
					"armylists" => array(
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
								"users" => array(
									"fields" => array(
										"users.username"
									),
									"relation" => array(
										"armylists.users_id" => "users.id"
									)
								),
								"armies" => array(
									"fields" => array(
										"armies.name as `army_name`"
									),
									"relation" => array(
										"armylists.armies_id" => "armies.id"
									)
								),
								"races" => array(
									"fields" => array(
										"races.name as `races_name`",
										"races.icon"
									),
									"relation" => array(
										"armies.races_id" => "races.id"
									)
								),
								"colours" => array(
									"fields" => array(
										"colours.name as `colours_name`"
									),
									"relation" => array(
										"armies.colours_id" => "colours.id"
									)
								),
								"votes" => array(
									"fields" => array(
										"votes.vote"
									),
									"relation" => array(
										"votes.armylists_id" => "armylists.id",
										"votes.users_id" => $user_id
									)
								)
							)
						)
					)
				)
			);
			\Cache::write('ArmyLists', $cache, $data);
		}
		if(isset($count["armylists"]["count"])) {
			$data["count"] = $count["armylists"]["count"];
		}

		return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => $data));
	}

/**
 * [API armies_all to return a list of public/personal/top army lists in 1 api call]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [type]             [response]
 */
	public function armies_all($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		$user_id = (int)(\Configure::User("id") != null)?\Configure::User("id"):0;

		//$data = \Cache::read('ArmyLists'.DS.'Users', "armies_".$user_id);
		//if(!$data){
			$data["top"] = $this->model->army_lists("top", $user_id);
			$data["public"] = $this->model->army_lists("public", $user_id);
			if($user_id != 0) {
				$data["private"] = $this->model->army_lists("private", $user_id);
			}
		//	\Cache::write('ArmyLists'.DS.'Users', "armies_".$user_id, $data);
		//}

		return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => $data));
	}

/**
 * [API save_army to saves a submitted army]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [type]             [response]
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
		if ($this->_hasRequiredParams($requiredParams, $methodData["armylists"])) {
			throw new \WebException("Incorrect parameters supplied", 400);
		}
		if(!\Configure::Logged()) {
			throw new \WebException("Forbidden: Not logged in", 403);
		}

		$methodData["armylists"]['code'] = $this->model->_generateCode(\Configure::User('id'));
		$methodData["armylists"]['users_id'] = \Configure::User('id');
//\Configure::pre($methodData);
		$data = $this->model->Save($methodData);

		if($data["error"] === true) {
			return \Frost\Configs\Response::setResponse(400, "Army Lists", array("errors" => array(array(ucfirst($data['field']), $data['message']))));
		} else {
			\Cache::delete('ArmyLists', "private");
			\Cache::delete('ArmyLists', "public");
			\Cache::delete('ArmyLists', "top");
			return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => array("id" => $this->model->last_id)));
		}
	}

/**
 * [API view_army to view an existing army]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [type]             [response]
 */
	public function view_army($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		if(is_numeric($options[0])) {
			$conditions = array(
				"armylists.id" => (int)$options[0],
				"armylists.users_id" => \Configure::User("id")
			);
		} else {
			$conditions = array(
				"armylists.code" => preg_replace('/[^0-9a-z]+/', '', $options[0]),
				"armylists.hide" => 0
			);
		}

		$user_id = (int)(\Configure::User("id") != null)?\Configure::User("id"):0;
		$data = \Cache::read('ArmyLists', '_army_'.$options[0].'_'.$user_id);
		if(!$data){
			$data = $this->model->Find("first",
				array(
					"armylists" => array(
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
								"users" => array(
									"fields" => array(
										"users.id as `user_id`",
										"users.username"
									),
									"relation" => array(
										"armylists.users_id" => "users.id"
									)
								),
								"armies" => array(
									"fields" => array(
										"armies.name as `army_name`"
									),
									"relation" => array(
										"armylists.armies_id" => "armies.id"
									)
								),
								"races" => array(
									"fields" => array(
										"races.name as `races_name`",
										"races.icon"
									),
									"relation" => array(
										"armies.races_id" => "races.id"
									)
								),
								"colours" => array(
									"fields" => array(
										"colours.name as `colours_name`"
									),
									"relation" => array(
										"armies.colours_id" => "colours.id"
									)
								),
								"votes" => array(
									"fields" => array(
										"votes.vote"
									),
									"relation" => array(
										"votes.armylists_id" => "armylists.id",
										"votes.users_id" => $user_id
									)
								),
								"armysquads" => array(
									array(
										"fields" => array(
											"id",
											"position",
											"squads_id"
										),
										"contains" => array(
											"armylists" => array(
												"fields" => array(
													"armylists.id as `armyunits_id`",
													"armylists.count",
													"armylists.units_id"
												),
												"contains" => array(
													"armywargears" => array(
														"fields" => array(
															"armywargears.id as `armywargears_id`",
															"armywargears.wargears_id"
														),
														"contains" => array(
															"wargears" => array()
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
			\Cache::write('ArmyLists', '_army_'.$options[0].'_'.$user_id, $data);
		}

		if((int)$data["armylists"]["hide"] === 1) {
			if(!\Configure::Logged()) {
				throw new \WebException("Forbidden: Not logged in", 403);
			}
		}

		return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => $data));
	}

/**
 * [API delete_army to delete an existing army]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [type]             [response]
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
				"armylists" => array(
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
				"armylists" => array(
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
 * [API save_army to saves a submitted army]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [type]             [response]
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
				"armylists" => array(
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

		$data = $this->model->Update(array("armylists" => $methodData), array("id" => $options[0]));
		if($data["error"] === true) {
			return \Frost\Configs\Response::setResponse(400, "Army Lists", array("errors" => $data["error"]));
		} else {
			/*\Cache::delete('ArmyLists', "private");
			\Cache::delete('ArmyLists', "public");
			\Cache::delete('ArmyLists', "top");
			\Cache::delete('ArmyLists', "_army_".$options[0]);*/
			\Cache::deleteDir('ArmyLists');
			return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => null));
		}
	}

/**
 * [API save_units to saves a submitted army]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [type]             [response]
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
				"armylists" => array(
					array(
						"fields" => array(
							"id",
							"code"
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
				"armysquads" => array(
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

			\Cache::deleteWildcard('ArmyLists', "_army_".$options[0]."_*");
			\Cache::deleteWildcard('ArmyLists', "_army_".$user_army["armylists"]["code"]."_*");

			return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => null));
		}
	}

/**
 * [API get_army to retrieve my army]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [type]             [response]
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
				"armylists" => array(
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
				"armysquads" => array(
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
				"armysquads" => array(
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
							"armyunits" => array(
								"fields" => array(
									"armyunits.id as `armyunits_id`",
									"armyunits.count",
									"armyunits.units_id"
								),
								"contains" => array(
									"armywargears" => array(
										"fields" => array(
											"armywargears.id as `armywargears_id`",
											"armywargears.wargears_id"
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
 * [API armies_public to retrieve my army]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [type]             [response]
 */
	public function armies_public($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		$user_id = (int)(\Configure::User("id") != null)?\Configure::User("id"):0;
		$data = $this->model->find(
			"all",
			array(
				"armylists" => array(
					array(
						"fields" => array(
							"name",
							"descr",
							"point_limit",
							"score",
							"code",
							"created",
							"modified"
						),
						"conditions" => array(
							"hide" => 0
						),
						"contains" => array(
							"users" => array(
								"fields" => array(
									"users.username"
								),
								"relation" => array(
									"armylists.users_id" => "users.id"
								)
							),
							"armies" => array(
								"fields" => array(
									"armies.name as `army_name`"
								),
								"relation" => array(
									"armylists.armies_id" => "armies.id"
								)
							),
							"races" => array(
								"fields" => array(
									"races.name as `races_name`",
									"races.icon"
								),
								"relation" => array(
									"armies.races_id" => "races.id"
								)
							),
							"colours" => array(
								"fields" => array(
									"colours.name as `colours_name`"
								),
								"relation" => array(
									"armies.colours_id" => "colours.id"
								)
							),
							"votes" => array(
								"fields" => array(
									"votes.vote"
								),
								"relation" => array(
									"votes.armylists_id" => "armylists.id",
									"votes.users_id" => $user_id
								)
							)
						)
					)
				)
			)
		);

		return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => $data));
	}

/**
 * [API armies_personal to retrieve my army]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [type]             [response]
 */
	public function armies_personal($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		$user_id = (int)(\Configure::User("id") != null)?\Configure::User("id"):0;
		$data = $this->model->find(
			"all",
			array(
				"armylists" => array(
					array(
						"fields" => array(
							"name",
							"descr",
							"point_limit",
							"score",
							(($user_id != 0)?"id":"code"),
							"hide",
							"created",
							"modified"
						),
						"conditions" => array(
							"armylists.users_id" => (int)$user_id
						),
						"contains" => array(
							"users" => array(
								"fields" => array(
									"users.username"
								),
								"relation" => array(
									"armylists.users_id" => "users.id"
								)
							),
							"armies" => array(
								"fields" => array(
									"armies.name as `army_name`"
								),
								"relation" => array(
									"armylists.armies_id" => "armies.id"
								)
							),
							"races" => array(
								"fields" => array(
									"races.name as `races_name`",
									"races.icon"
								),
								"relation" => array(
									"armies.races_id" => "races.id"
								)
							),
							"colours" => array(
								"fields" => array(
									"colours.name as `colours_name`"
								),
								"relation" => array(
									"armies.colours_id" => "colours.id"
								)
							),
							"votes" => array(
								"fields" => array(
									"votes.vote"
								),
								"relation" => array(
									"votes.armylists_id" => "armylists.id",
									"votes.users_id" => $user_id
								)
							)
						)
					)
				)
			)
		);

		return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => $data));
	}

/**
 * [API vote to give opinion on a army]
 * @param  [array] $options [contains url input]
 * @param  [array] $methodData [form data]
 * @return [type]             [response]
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

		/*\Cache::delete('ArmyLists', "private");
		\Cache::delete('ArmyLists', "public");
		\Cache::delete('ArmyLists', "top");

		\Cache::delete('ArmyLists', "_army_".$data[0]["army_id"]."_".\Configure::User("id"));
		\Cache::delete('ArmyLists', "_army_".$data[0]["army_code"]."_".\Configure::User("id"));

		\Cache::deleteDir('ArmyLists' . DS . 'Users');*/
		\Cache::deleteDir('ArmyLists');

		return \Frost\Configs\Response::setResponse(200, "Army Lists", array("data" => null));

	}

}