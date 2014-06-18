<?php
namespace Frost\Controller;
/**
* Socials Controller
*
*/
class SocialsController extends Controller {

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
	 * generate creates an access token for the user when making API requests
	 **/
	public function generate() {
		$this->view = "Empty";
		$this->returnType = "json";

		if(!\Configure::Logged()) {
			throw new \WebException("Forbidden: Not logged in", 403);
		}

		$time = time();
		$nonce = time() . rand(1000, 9999);

		$salt = substr(md5(uniqid(rand(), true)), 0, 9);
		$access = $salt . sha1($salt . time() . $nonce);

        \Configure::write("Token", array("time" => $time, "access" => $access));

		return \Frost\Configs\Response::setResponse(200, "Token", array("data" => $access));
	}
}