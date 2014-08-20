<?php
namespace Frost\Controller;


/*
	@class UsersController
	@author Chris Sheppard
	@desc handles the user management section
*/
class UsersController extends Controller {

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
 * ROUTE: /admin/users/index
 * Method: GET
 * Index's all the users
 *
 * @param
 * @return (array)
 */
	public function admin_index($options) {
		$this->view = "admin";

		$data = $this->model->Find("pagination",
			array(
				"Users" => array(
					array(
						"fields" => array(
							"id",
							"username",
							"slug",
							"email",
							"email_verified",
							"is_admin",
							"last_login",
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
 * admin_dashboard method
 * ROUTE: /admin/users/dashboard
 * Method: GET
 * Index's all the users
 *
 * @param
 * @return (array)
 */
	public function admin_dashboard($options) {
		$this->view = "admin";

		return array("code" => 200, "message" => "User Index", "data" => null, "errors" => null);
	}

/**
 * admin_view method
 * ROUTE: /admin/users/view/:id
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
				"Users" => array(
					array(
						"fields" => array(
							"id",
							"username",
							"slug",
							"email",
							"email_verified",
							"is_admin",
							"last_login",
							"created",
							"modified"
						),
						"conditions" => array("id" => $options[0])
					)
				)
			)
		);

		return array("code" => 200, "message" => "User View", "data" => $data, "errors" => null);
	}
/**
 * admin_view admin_add
 * ROUTE: /admin/users/add/:id
 * Method: GET
 * Adds a user
 *
 * @param
 * @return (array)
 */
	public function admin_add($options, $methodData) {
		$this->view = "admin";
		if($this->requestType("POST")) {
			if($this->model->Exists(array("email" => $this->model->post["Users"]["email"], "username" => $this->model->post["Users"]["username"]))) {
				$this->Flash("<strong>User already exists</strong> The Email/Username you provided is currently being used", "alert alert-danger");
			} else {
				$data = $this->model->Save();
				if($data["error"] === true) {
					$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
				} else {
					$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'users', 'action' => 'index', 'admin' => true));
				}
			}
		}

		return array("code" => 200, "message" => "User View", "data" => array(), "errors" => null);
	}
/**
 * admin_edit method
 * ROUTE: /admin/users/edit/:id
 * Method: PUT
 * Edits a user
 *
 * @param
 * @return (array)
 */
	public function admin_edit($options, $methodData) {
		$this->view = "admin";
		$data = $this->model->Find("first", array( "Users" => array( array( "fields" => array( "id", "username", "email", "email_verified", "is_admin" ), "conditions"	=> array( "id" => $options[0] ) ) ) ) );

		if($this->requestType("POST")) {
			if($data["Users"]["username"] != $this->model->post["Users"]["username"] || $data["Users"]["email"] != $this->model->post["Users"]["email"]
			&&  $this->model->Exists(array("email" => $this->model->post["Users"]["email"], "username" => $this->model->post["Users"]["username"]))) {
				$this->Flash("<strong>User already exists</strong> The Email/Username you provided is currently being used", "alert alert-danger");
			} else {
				$data = $this->model->Update($this->model->post, array("id" => $options[0]));
				if($data["error"] === true) {
					$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
				} else {
					$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'users', 'action' => 'index', 'admin' => true));
				}
			}
		}

		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * admin_delete method
 * ROUTE: /admin/users/delete/:id
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
				"Users" => array(
					"conditions" => array(
						"id" => $options[0]
					)
				)
			)
		);

		$this->Flash("You have successfully deleted item(s)", "alert alert-success", array('controller' => 'users', 'action' => 'admin_index', 'admin' => true));

		return array("code" => 200, "message" => "User Index", "data" => array(), "errors" => null);
	}


/**
 * Login method
 * ROUTE: /users/login
 * Allows a user to register with fb and log in
 *
 * @param
 * @return (array)
 */
	public function login($options, $methodData) {
		if($this->requestType("POST")) {
			$data = $this->model->log_user();

			if($data["error"] === true) {
				$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
			} else {
				if($data) {
					\Configure::Auth($data);
					$this->Flash("You have successfully logged in", "alert alert-success", '/');
				} else {
					$this->Flash("<strong>Fail</strong> Incorrect log in details", "alert alert-danger");
				}

			}

			return array("code" => 200, "message" => "User Log in", "data" => array(), "errors" => null);
		}
		return array("code" => 200, "message" => "User Log in", "data" => array(), "errors" => null);
	}
/**
 * logout method
 * ROUTE: /users/login
 * Allows a user to register with fb and log in
 *
 * @param
 * @return (array)
 */
	public function logout($options, $methodData) {
		\Configure::Auth(null);
		$this->Flash("You have successfully logged out", "alert alert-success", '/');
	}

/**
 * Register method
 * ROUTE: /users/register
 * Allows a user to register with fb and log in
 *
 * @param
 * @return (array)
 */
	public function register($options, $methodData) {
		if($this->requestType("POST")) {
			if($this->model->Exists(array("email" => $this->model->post["Users"]["email"], "username" => $this->model->post["Users"]["username"]))) {
				$this->Flash("<strong>User already exists</strong> The Email/Username you provided is currently being used", "alert alert-danger");
			} else {
				$data = $this->model->Save();
				if($data["error"] === true) {
					$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
				} else {
					$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-success", array('controller' => 'users', 'action' => 'login'));
				}
			}

			return array("code" => 200, "message" => "User Register", "data" => $data, "errors" => null);
		}
		return array("code" => 200, "message" => "User Register", "data" => array(), "errors" => null);
	}

/**
 * profile method
 * ROUTE: /users/profile
 * Allows a user change their profile details
 *
 * @param
 * @return (array)
 */
	public function profile($options, $methodData) {
		$data = $this->model->Find("first", array( "Users" => array( array( "fields" => array( "id", "username", "email", "email_verified", "is_admin" ), "conditions"	=> array( "id" => \Configure::User("id") ) ) ) ) );

		if($this->requestType("POST")) {
			if($data["Users"]["username"] != $this->model->post["Users"]["username"] || $data["Users"]["email"] != $this->model->post["Users"]["email"]
			&&  $this->model->Exists(array("email" => $this->model->post["Users"]["email"], "username" => $this->model->post["Users"]["username"]))) {
				$this->Flash("<strong>User already exists</strong> The Email/Username you provided is currently being used", "alert alert-danger");
			} else {
				$data = $this->model->Update($this->model->post, array("id" => $options[0]));
				if($data["error"] === true) {
					$this->Flash("<strong>".ucfirst($data['field'])."</strong> ".$data['message'], "alert alert-danger");
				} else {
					$this->Flash("<strong>Success</strong> Item has been saved", "alert alert-success", array('controller' => 'users', 'action' => 'index', 'admin' => true));
				}
			}
		}

		$_POST["data"] = $data;
		return array("code" => 200, "message" => "User Edit", "data" => $data, "errors" => null);
	}
/**
 * reset_password method
 * ROUTE: /users/reset_password
 * Allows a guest to challenge for a lost password
 *
 * @param
 * @return (array)
 */
	public function reset_password($options, $methodData) {
		return array("code" => 200, "message" => "User Edit", "data" => null, "errors" => null);
	}
/**
 * verified method
 * ROUTE: /users/verified/:slug
 * Verifies a users account
 *
 * @param
 * @return (array)
 */
	public function verified($options, $methodData) {
		$this->view = "Empty";
		$data = $this->model->Find("first",
			array(
				"Users" => array(
					array(
						"fields" => array(
							"email_verified"
						),
						"conditions" => array("slug" => $options[0])
					)
				)
			)
		);

		if(!empty($data["Users"]) && $data["Users"]["email_verified"] == 0) {
			$this->model->Update(array("Users" => array("email_verified" => 1)), array("slug" => $options[0]));
			$this->Flash("<strong>Success</strong>: Your account is now active, please log in.", "alert alert-success", "/");
		}
		$this->Flash("<strong>Failure</strong>: There was a problem activiting your account, please try again.", "alert alert-danger", "/");
	}
// API methods


/**
 * login_api method
 * ROUTE: /user/login
 * Allows a user to register with fb and log in
 *
 * @param
 * @return (array)
 */
	public function login_api($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		if(!$this->requestType("POST")) {
			throw new \WebException("Wrong method request", 405);
		}

		$data = $this->model->log_user();

		if(isset($data["error"]) && $data["error"] === true) {
			return array("code" => 403, "message" => "User Log in", "data" => null, "errors" => array(array(ucfirst($data['field']), $data['message'])));
		} else {
			if($data) {
				\Configure::Auth($data);
				return array("code" => 200, "message" => "User Log in", "data" => array("user_id"=>$data["id"], "username"=>$data["username"]), "errors" => null);
			} else {
				return array("code" => 403, "message" => "User Log in", "data" => array(), "errors" => array(array("Failure", "Incorrect log in details")));
			}
		}
	}

/**
 * Register_api method
 * ROUTE: /user/register
 * Allows a user to register with fb and log in
 *
 * @param
 * @return (array)
 */
	public function register_api($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		if(!$this->requestType("POST")) {
			throw new \WebException("Wrong method request", 405);
		}

		if($this->model->Exists(array("email" => $this->model->post["Users"]["email"], "username" => $this->model->post["Users"]["username"]))) {
			return array("code" => 409, "message" => "User Register", "data" => null, "errors" => array(array("User already exists", "The Email/Username you provided is currently being used")));
		} else {
			$data = $this->model->Save();

			if($data["error"] === true) {
				return array("code" => 403, "message" => "User Log in", "data" => null, "errors" => array(array(ucfirst($data['field']), $data['message'])));
			} else {
				$dataS = $this->model->Find("first",
					array(
						"Users" => array(
							array(
								"fields" => array(
									"slug",
								),
								"conditions" => array("id" => $this->model->last_id)
							)
						)
					)
				);

				$message = "Dear user,\n\nTo activate your Army display tool account please click this link below and then log in.\n\n".HOST_URL."user/register_verify/".$dataS["Users"]["slug"]."\n\nRegards\nArmy display tool team";
				//\Frost\Configs\Email::send("chrissheppard@rehabstudio.com", "Army display tool verification", $message, "From: do-not-reply@armydisplaytool.com");

				return array("code" => 200, "message" => "User Log in", "errors" => null, "data" => null);
			}
		}
	}
/**
 * reset_password_api method
 * ROUTE: /user/lost_password
 * Allows a guest to challenge for a lost password
 *
 * @param
 * @return (array)
 */
	public function lost_password_api($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		if(!$this->requestType("POST")) {
			throw new \WebException("Wrong method request", 405);
		}

		$data = $this->model->Find("first",
			array(
				"Users" => array(
					array(
						"fields" => array(
							"id",
						),
						"conditions" => array("email" => $this->model->post["Users"]["email"])
					)
				)
			)
		);

		if(!isset($data["Users"])) {
			return array("code" => 404, "message" => "User lost password", "data" => null, "errors" => array(array("Email", "The email you provided does not exist")));
		}
		$words = array(
			"iimlrap",
			"cosha",
			"lkaeddrar",
			"relad",
			"recnon",
			"srsetis",
			"tnqrusoii",
		);
		$password = $words[mt_rand(0, (count($words)-1))].microtime();
		$crypt_pass = sha1(crypt($password, CRYPTKEY.$this->model->post["Users"]["email"]));
		$this->model->Update(array("Users" => array("password" => $crypt_pass, "email" => $this->model->post["Users"]["email"])), array("email" => $this->model->post["Users"]["email"]));

		$message = "Dear user,\n\nYour new password is: ".$password."\n\nRegards\nArmy display tool team";
		//\Frost\Configs\Email::send("chrissheppard@rehabstudio.com", "Army display tool lost password", $message, "From: do-not-reply@armydisplaytool.com");

		return array("code" => 200, "message" => "User lost password", "data" => null, "errors" => null);
	}

/**
 * profile_api method
 * ROUTE: /user/profile_api
 * Allows a user to update their profile
 *
 * @param
 * @return (array)
 */
	public function profile_api($options, $methodData) {
		$this->view = "Empty";
		$this->returnType = "json";

		if($this->requestType("POST")) {
			$data = $this->model->Update($this->model->post, array("id" => \Configure::User("id")));
			if($data["error"] === true) {
				return array("code" => 200, "message" => "Profile", "data" => null, "errors" => array(array(ucfirst($data['field']), $data['message'])));
			} else {
				return array("code" => 200, "message" => "Profile", "data" => null, "errors" => null);
			}
		} else if($this->requestType("GET")) {
			$data = $this->model->Find("first",
				array(
					"Users" => array(
						array(
							"fields" => array(
								"id",
								"email"
							),
							"conditions" => array("id" => \Configure::User("id"))
						)
					)
				)
			);
			return array("code" => 200, "message" => "Profile", "data" => $data, "errors" => null);
		} else {
			throw new \WebException("Wrong method request", 405);
		}
	}
}
