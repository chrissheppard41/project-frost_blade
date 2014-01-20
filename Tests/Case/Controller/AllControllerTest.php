<?php
require "ControllerTest.php";

//
//	@class BudControllerTest
//	@author Chris Sheppard
//	@desc The test controller that holds all the tests for the controller
///
class AllControllerTest extends ControllerTest
{
	private $crypt;
	private $id = 0;
	function __constuct() {
		parent::__construct();
	}


//
// Action testLive
///
	public function testLive()
	{
		$results = $this->Action("/bud/live.json");
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$expected = $this->crypt->encrypt(
			json_encode(
				array(
					"status" => "OK",
					"code" => 200,
					"message" => "Bud API: Live",
					"data" => array(
						"live" => true
					),
					"errors" => null
				)
			)
		);

		$this->assertEquals($expected, $results);

	}

//
// Action testUsers
///
	public function testUsers() {

		$results = $this->Action(
			"/bud/user/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array("method" => "POST")
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$this->assertEquals($this->crypt->decrypt("NV6jBki5DWmbkPqO965zFQ=="), $arrayResult['data']['User']['fb_id']);
		$this->assertEquals(0, $arrayResult['data']['User']['distance']);
		//$this->assertEquals(time(), $arrayResult['data']['User']['starttime']); //the timestamp doesn't need to be checked so make sure it exists
		$this->assertFalse(empty($arrayResult['data']['User']['starttime']));
		$this->assertEquals(0, $arrayResult['data']['User']['progress']);

		//make sure there are 288 level objects
		$this->assertEquals(384, count($arrayResult['data']['Level']));

	}

//
// Action testUsersNoFBIDException, no fb_ID
// @exception Exception (404, not found)
///
	public function testUsersNoFBIDException() {

		$results = $this->Action(
			"/bud/user.json",
			array("method" => "POST")
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);

		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1anphbYzt4RV91vSkUeHEZjLjb9ZOJkmaQA==";


		$this->assertEquals($expected, $results);
	}

//
// Action testUsersBadFBIDException, bad decrypted fb_ID
// @exception Exception (404, not found)
///
	public function testUsersBadFBIDException() {

		$results = $this->Action(
			"/bud/user/123456789.json",
			array("method" => "POST")
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);

		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1anphbYzt4RV91vSkUeHEZjLjb9ZOJkmaQA==";


		$this->assertEquals($expected, $results);
	}


//
// Action testUsersBadMethodException, Request set to GET will return an error
// @exception Exception (405, Bad Request)
///
	public function testUsersBadRequestException() {

		$results = $this->Action(
			"/bud/user/123456789.json"
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = $this->crypt->decrypt($results);

		$expected = "YvrLH6n6I3/+QEg/uncH6OcYLgCMHoImafCSLevDmqaHXf4J0voGFOPqQ51dQoONNkd8qQBp6JSCBo2Ha9XkL87cQQ/PucuiFCPj+5c3hsOXv3J3FLxkbZjEjfKyq4rMqg/+O5yesgPf9AFrAyu9/ESTt0BWDrxXSGht4IVrLMJ3FFTZxCWAOPnB013gV1sU";

		$this->assertEquals($expected, $results);
	}


//
// Action testProgress, Returns the first set of hard coded obscales
///
	public function testProgress() {

		$results = $this->Action(
			"/bud/progress/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5p8+8ODSWCkAhuEXNqquIUcxZshjmvJzU8="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = array(
			array("id" => 2, "distance" => 675, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 626, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 578, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 529, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 4, "distance" => 476, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 431, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 2, "distance" => 382, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 336, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 289, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 2, "distance" => 237, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 4, "distance" => 186, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 157, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 107, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 6, "distance" => 65, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 7, "name" => "hardcoded", "type" => "hardcoded")
		);

		$this->assertEquals(array_reverse($expected), $arrayResult['data']['objects']);

	}

//
// Action testProgressNext, Returns the second set of hard coded obscales
///
	public function testProgressNext() {

		$results = $this->Action(
			"/bud/progress/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5q/j9zqgrK05vTrh1W64pwFmF5x0eWvq45n5xSVSkm2Jg=="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = array(
			array("id" => 3, "distance" => 1340, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 1284, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 4, "distance" => 1236, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 1193, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 2, "distance" => 1144, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 1095, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 1026, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 4, "distance" => 972, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 930, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 873, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 829, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 2, "distance" => 780, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 725, "name" => "hardcoded", "type" => "hardcoded")
		);

		$this->assertEquals(array_reverse($expected), $arrayResult['data']['objects']);

	}


//
// Action testProgressThird, Returns the third set of hard coded obscales
///
	public function testProgressThird() {

		$results = $this->Action(
			"/bud/progress/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5r+JNX4LwlL0hi+7pLEIkWpYx/txZLp/FB76Va6EizUoA=="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = array(
			array("id" => 4, "distance" => 2042, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2014, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 1959, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 1910, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 1857, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 1805, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 4, "distance" => 1756, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 7, "distance" => 1707, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 4, "distance" => 1654, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 1604, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 1556, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 1491, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 1439, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 2, "distance" => 1392, "name" => "hardcoded", "type" => "hardcoded")
		);

		$this->assertEquals(array_reverse($expected), $arrayResult['data']['objects']);

	}

//
// Action testProgressForth, Returns the torth set of hard coded obscales
///
	public function testProgressForth() {

		$results = $this->Action(
			"/bud/progress/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5rJjm/eiSxZqX0GlrKdme+8++2vD/0S5Z976Va6EizUoA=="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = array(
			array("id" => 3, "distance" => 2716, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2671, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2615, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2561, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2514, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2464, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2422, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2371, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 4, "distance" => 2343, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2294, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2250, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 2, "distance" => 2201, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2145, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2091, "name" => "hardcoded", "type" => "hardcoded")
		);

		$this->assertEquals(array_reverse($expected), $arrayResult['data']['objects']);

	}

//
// Action testProgressFifth, Returns the fifth set of hard coded obscales
///
	public function testProgressFifth() {

		$results = $this->Action(
			"/bud/progress/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5qS0cXPmCVCQX0GlrKdme+8vNkrDOCqBmaIK4O8sOtbHw=="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = array(
			array("id" => 8, "distance" => 3351, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 3305, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 3255, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 3211, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 3163, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 3107, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 3052, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 3003, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2961, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2913, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2866, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2813, "name" => "hardcoded", "type" => "hardcoded"),
			array("id" => 3, "distance" => 2762, "name" => "hardcoded", "type" => "hardcoded")
		);

		$this->assertEquals(array_reverse($expected), $arrayResult['data']['objects']);

	}

//
// Action testProgressRandomStateOne, Returns a normal random set of obscales/powerups, total of 8
///
	public function testProgressRandomStateOne() {

		$results = $this->Action(
			"/bud/progress/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5onp8eimniJ1A0TqmBM0edZIMkRfWWGWCWIK4O8sOtbHw=="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$rock = 0;
		$whirlpool = 0;
		$monster = 0;

		foreach($arrayResult['data']['objects'] as $values) {

			if($values['name'] == "rock") {
				$rock++;
			} else if($values['name'] == "whirlpool") {
				$whirlpool++;
			} else if($values['name'] == "monster") {
				$monster++;
			}
		}

		//$this->assertEquals(8, count($arrayResult['data']['objects']));
		$this->assertContains($rock, array(9,10));
		$this->assertContains($whirlpool, array(0,1));
		$this->assertContains($monster, array(0,1));

	}

//
// Action testProgressRandom, Returns a normal random set of obscales/powerups, total of 9 (including powerup on this chain)
///
	public function testProgressRandom() {

		$results = $this->Action(
			"/bud/progress/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					'encrypt' => 'Jk5KZ8m1C5onp8eimniJ1A0TqmBM0edZIMkRfWWGWCV76Va6EizUoA=='
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$rock = 0;
		$boat = 0;

		foreach($arrayResult['data']['objects'] as $values) {
			//print_r($values);
			if($values['name'] == "rock") {
				$rock++;
			} else if($values['name'] == "boat") {
				$boat++;
			}
		}

		//$this->assertEquals(8, count($arrayResult['data']['objects']));
		$this->assertEquals(6, $rock);
		$this->assertEquals(4, $boat);

	}

//
// Action testProgressRandomPowerup, Returns a normal random set of obscales/powerups, total of 8 and 1 powerup
///
	public function testProgressRandomPowerup() {

		$results = $this->Action(
			"/bud/progress/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5rcVhjav/FMQg0TqmBM0edZtNyks/tgZOZ76Va6EizUoA=="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$rock = 0;
		$boat = 0;

		foreach($arrayResult['data']['objects'] as $values) {
			if($values['name'] == "rock") {
				$rock++;
			} else if($values['name'] == "boat") {
				$boat++;
			}
		}

		$count = count($arrayResult['data']['objects']);
		$this->assertEquals(11, $count);
		$this->assertEquals("powerup", $arrayResult['data']['objects'][($count-1)]['type']);
		$this->assertEquals(6, $rock);
		$this->assertEquals(4, $boat);

	}



//
// Action testProgressnoFBIDException, Returns a error based on no fb_id set
// @exception Exception (403, forbidden)
///
	public function testProgressnoFBIDException() {

		$results = $this->Action(
			"/bud/progress.json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5oLjfhc0re1dn0GlrKdme+8BgHPnxwDN1p76Va6EizUoA=="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1anphbYzt4RV91vSkUeHEZjLjb9ZOJkmaQA==";

		$this->assertEquals($expected, $results);

		$this->assertEquals($arrayResult['code'], 403);
		$this->assertTrue(!empty($arrayResult));
		$this->assertEquals($arrayResult['errors']["message"], "FB_ID was not set");
	}

//
// Action testProgressnoDistanceException, Returns a error based on no distance set
// @exception Exception (403, forbidden)
///
	public function testProgressnoDistanceException() {

		$results = $this->Action(
			"/bud/progress/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1aiZOSmfJtQuaji9FY2daX8SAX+G+G2Y5gQ==";

		$this->assertEquals($expected, $results);

		$this->assertEquals($arrayResult['code'], 403);
		$this->assertTrue(!empty($arrayResult));
		$this->assertEquals($arrayResult['errors']["message"], "distance was not set");
	}

//
// Action testProgressnoProgressException, Returns a error based on no progress set
// @exception Exception (403, forbidden)
///
	public function testProgressnoProgressException() {

		$results = $this->Action(
			"/bud/progress/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5pVSFllhynzdw=="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1ap+c/FDBTishji9FY2daX8SAX+G+G2Y5gQ==";

		$this->assertEquals($expected, $results);

		$this->assertEquals($arrayResult['code'], 403);
		$this->assertTrue(!empty($arrayResult));
		$this->assertEquals($arrayResult['errors']["message"], "progress was not set");
	}

//
// Action testProgressnoStateException, Returns a error based on no progress set
// @exception Exception (403, forbidden)
///
	public function testProgressnoStateException() {

		$results = $this->Action(
			"/bud/progress/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5oLjfhc0re1dn0GlrKdme+8IPOzbogS2TU="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1agqyRmV9f86L1vSkUeHEZjLjb9ZOJkmaQA==";

		$this->assertEquals($expected, $results);

		$this->assertEquals($arrayResult['code'], 403);
		$this->assertTrue(!empty($arrayResult));
		$this->assertEquals($arrayResult['errors']["message"], "state was not set");
	}

//
// Action testProgressBadException, Returns a error based on no GET request
// @exception Exception (400, bad request)
///
	public function testProgressBadException() {

		$results = $this->Action(
			"/bud/progress/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5oLjfhc0re1dn0GlrKdme+8IPOzbogS2TU="
				),
				"method" => "GET"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I3/+QEg/uncH6OcYLgCMHoImafCSLevDmqaHXf4J0voGFOPqQ51dQoONNkd8qQBp6JSCBo2Ha9XkL87cQQ/PucuiFCPj+5c3hsOXv3J3FLxkbZjEjfKyq4rMqg/+O5yesgPf9AFrAyu9/ESTt0BWDrxXSGht4IVrLMJ3FFTZxCWAOPnB013gV1sU";

		$this->assertEquals($expected, $results);


	}

//
// Action testEnd, Returns the submission from the end user.
///
	public function testEnd() {

		$results = $this->Action(
			"/bud/end/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5oA9e/8Lqcq45+c/FDBTish3V2IoSmmSuLGHUhKAQeO/xsdjWaB73lyYeQoYyECu1Gtu8WB7Ir7BO/kCpZ/jB89PY83HDNs7C42jwpLwvIQ+DbetASaQQ96qdo2hsMmFik="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I39dhl93cy+iyG/AstRE7sg/JnJuVSIANtCTb0BlbVkubB0KN3PvM/zcQAkK5HA1DdIhL2m9ZO6YZI6QgGhv8qpOrHmfrSGbcP5fgaASi4Fu4NWPEoC8bksnzXZFEM1QX2UOAGgRmxMMY73ZtKN8WyLQyNjBYeQSlrd0uSHQqKq5dmt9j7fW7SHTMapO2e0Y+Qw+eUP/xZzAJTsh20SRj5Zg62ocrbu2AYD2ZyJTgmWtgzImohvAiKaiDib/iTpmrn76YDfz7UTfT/k4TBe4cVYvBWI2Nl0ZUNVu02PKlARMig==";

		$this->assertEquals($expected, $results);

	}

//
// Action testEndNoFBIDException, Returns a error based on no fb_id set
// @exception Exception (403, forbidden)
///
	public function testEndNoFBIDException() {

		$results = $this->Action(
			"/bud/end.json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5pmPtRABXsOSKGGKpVQACFSp2AFmyWjelQTbm52+m5VUdfOo4PUdC6qaf1TtMmVR/KMAAyNjUWvHXxNADNicaw7Uj0pRJVnTvqH0svCIZpXf4fVEq7R0ZIhFpohYFi0umQ="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1anphbYzt4RV91vSkUeHEZjLjb9ZOJkmaQA==";

		$this->assertEquals($expected, $results);

		$this->assertEquals($arrayResult['code'], 403);
		$this->assertTrue(!empty($arrayResult));
		$this->assertEquals($arrayResult['errors']["message"], "FB_ID was not set");
	}

//
// Action testEndNoDistanceException, Returns a error based on no distance set
// @exception Exception (403, forbidden)
///
	public function testEndNoDistanceException() {

		$results = $this->Action(
			"/bud/end/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => ""
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1aiZOSmfJtQuaji9FY2daX8SAX+G+G2Y5gQ==";

		$this->assertEquals($expected, $results);

		$this->assertEquals($arrayResult['code'], 403);
		$this->assertTrue(!empty($arrayResult));
		$this->assertEquals($arrayResult['errors']["message"], "distance was not set");
	}

//
// Action testEndNoProgressException, Returns a error based on no progress set
// @exception Exception (403, forbidden)
///
	public function testEndNoProgressException() {

		$results = $this->Action(
			"/bud/end/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5pmPtRABXsOSG7TY8qUBEyK"
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1ap+c/FDBTishji9FY2daX8SAX+G+G2Y5gQ==";

		$this->assertEquals($expected, $results);

		$this->assertEquals($arrayResult['code'], 403);
		$this->assertTrue(!empty($arrayResult));
		$this->assertEquals($arrayResult['errors']["message"], "progress was not set");
	}

//
// Action testEndNoNameException, Returns a error based on no name set
// @exception Exception (403, forbidden)
///
	public function testEndNoNameException() {

		$results = $this->Action(
			"/bud/end/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5pmPtRABXsOSKGGKpVQACFShV94z2DCIb0="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1auH1giDky4KCRbkmIr+BRvu5lnxqM6ogVg==";

		$this->assertEquals($expected, $results);

		$this->assertEquals($arrayResult['code'], 403);
		$this->assertTrue(!empty($arrayResult));
		$this->assertEquals($arrayResult['errors']["message"], "name was not set");
	}

//
// Action testEndNoAgeException, Returns a error based on no age set
// @exception Exception (403, forbidden)
///
	public function testEndNoAgeException() {

		$results = $this->Action(
			"/bud/end/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5pmPtRABXsOSKGGKpVQACFSp2AFmyWjelQTbm52+m5VUdfOo4PUdC6qX6kmkAKbuyQ="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1avmIK6DX02KqHj7yyfHwl6q78Tu15dtB3Q==";

		$this->assertEquals($expected, $results);

		$this->assertEquals($arrayResult['code'], 403);
		$this->assertTrue(!empty($arrayResult));
		$this->assertEquals($arrayResult['errors']["message"], "age was not set");
	}

//
// Action testEndNoLocationException, Returns a error based on no location set
// @exception Exception (403, forbidden)
///
	public function testEndNoLocationException() {

		$results = $this->Action(
			"/bud/end/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5pmPtRABXsOSKGGKpVQACFSp2AFmyWjelQTbm52+m5VUdfOo4PUdC6qaf1TtMmVR/JbEgtJvaoGQg=="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1aloomW/E56+Rji9FY2daX8SAX+G+G2Y5gQ==";

		$this->assertEquals($expected, $results);

		$this->assertEquals($arrayResult['code'], 403);
		$this->assertTrue(!empty($arrayResult));
		$this->assertEquals($arrayResult['errors']["message"], "location was not set");
	}

//
// Action testEndNoEmailException, Returns a error based on no email set
// @exception Exception (403, forbidden)
///
	public function testEndNoEmailException() {

		$results = $this->Action(
			"/bud/end/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5pmPtRABXsOSKGGKpVQACFSp2AFmyWjelQTbm52+m5VUdfOo4PUdC6qaf1TtMmVR/KMAAyNjUWvHXxNADNicaw7/M+L3mXuH1w="
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1ahU9XdSzBq7R1vSkUeHEZjLjb9ZOJkmaQA==";

		$this->assertEquals($expected, $results);

		$this->assertEquals($arrayResult['code'], 403);
		$this->assertTrue(!empty($arrayResult));
		$this->assertEquals($arrayResult['errors']["message"], "email was not set");
	}

//
// Action testEndBadException, Returns a error based on no GET request
// @exception Exception (400, bad request)
///
	public function testEndBadException() {

		$results = $this->Action(
			"/bud/end/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5oA9e/8Lqcq45+c/FDBTish3V2IoSmmSuLGHUhKAQeO/xsdjWaB73lyYeQoYyECu1Gtu8WB7Ir7BO/kCpZ/jB89PY83HDNs7C42jwpLwvIQ+DbetASaQQ96qdo2hsMmFik="
				),
				"method" => "GET"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$expected = "YvrLH6n6I3/+QEg/uncH6OcYLgCMHoImafCSLevDmqaHXf4J0voGFOPqQ51dQoONNkd8qQBp6JSCBo2Ha9XkL87cQQ/PucuiFCPj+5c3hsOXv3J3FLxkbZjEjfKyq4rMqg/+O5yesgPf9AFrAyu9/ESTt0BWDrxXSGht4IVrLMJ3FFTZxCWAOPnB013gV1sU";

		$this->assertEquals($expected, $results);


	}


//
// Action testResetUser, Resets a users score to try again
///
	public function testResetUser() {

		$results = $this->Action(
			"/bud/user/".base64_encode("NV6jBki5DWmbkPqO965zFQ==").".json",
			array(
				"data" => array(
					"encrypt" => "MkBxvViGb48+AfHUIH81M27TY8qUBEyK"
				),
				"method" => "POST"
			)
		);
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		$arrayResult = json_decode($this->crypt->decrypt($results), true);

		$this->assertEquals($this->crypt->decrypt("NV6jBki5DWmbkPqO965zFQ=="), $arrayResult['data']['User']['fb_id']);
		$this->assertEquals(0, $arrayResult['data']['User']['distance']);
		//$this->assertEquals(time(), $arrayResult['data']['User']['starttime']); //the timestamp doesn't need to be checked so make sure it exists
		$this->assertFalse(empty($arrayResult['data']['User']['starttime']));
		$this->assertEquals(0, $arrayResult['data']['User']['progress']);

		//make sure there are 384 level objects
		$this->assertEquals(384, count($arrayResult['data']['Level']));
	}

//
// Action testCSVExtract, Tests the csv extract response
///
	public function testCSVExtract() {

		$results = $this->Action(
			"/csv/extract.csv",
			array(
				"method" => "GET",
				"remote_address" => "217.35.85.137"
			)
		);
		$arr = array();
		foreach(explode("\n", $results) as $values) {
			$mini = explode("\",\"", $values);
			if(count($mini) == 11) {
				$arr[] = $mini;
			}
		}
		$expected = 2;
		$this->assertEquals($expected, count($arr));

		$this->assertEquals("\"001655898751", $arr[1][0]);
		$this->assertEquals("SUSPICIOUS", $arr[1][1]);
		$this->assertEquals("374400", $arr[1][4]);
		$this->assertEquals("36543", $arr[1][3]);


		$this->assertEquals("Chris Sheppard", $arr[1][5]);
		$this->assertEquals("chris@rehab.com", $arr[1][6]);
		$this->assertEquals("27", $arr[1][7]);
		$this->assertEquals("New York", $arr[1][8]);

	}

//
// Action testSecondUser, adds second user in checks csv exporter
///
	public function testSecondUser() {

		$results = $this->Action(
			"/bud/user/".base64_encode("MaWPg3hZH20qIwmoasnGLw==").".json",
			array("method" => "POST")
		);

		$results = $this->Action(
			"/bud/end/".base64_encode("MaWPg3hZH20qIwmoasnGLw==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5oiOm/R9Mh3BslibUzGY9uIYgcXlkQFCL8PJtX4Rm2nXz/M8O3X1l1dKrjvGwBq+EHRS9M+Y+e/3W4BicXMO2eg16PoJtpXe+o6JKVU47dO5Q=="
				),
				"method" => "POST"
			)
		);

		$results = $this->Action(
			"/csv/extract.csv",
			array(
				"method" => "GET",
				"remote_address" => "217.35.85.137"
			)
		);

		$arr = array();
		foreach(explode("\n", $results) as $values) {
			$mini = explode("\",\"", $values);
			if(count($mini) == 11) {
				$arr[] = $mini;
			}
		}

		$expected = 3;
		$this->assertEquals($expected, count($arr));

		$this->assertEquals("\"100004051182031", $arr[2][0]);
		$this->assertEquals("-", $arr[2][1]);
		$this->assertEquals("45500", $arr[2][4]);
		$this->assertEquals("15200", $arr[2][3]);


		$this->assertEquals("Joe Blogs", $arr[2][5]);
		$this->assertEquals("joe@rehab.com", $arr[2][6]);
		$this->assertEquals("18", $arr[2][7]);
		$this->assertEquals("Boston", $arr[2][8]);

	}


//
// Action testThirdUser, adds third user in checks csv exporter
///
	public function testThirdUser() {

		$results = $this->Action(
			"/bud/user/".base64_encode("3N3gfkbeNx/HfcpuIuRdhA==").".json",
			array("method" => "POST")
		);

		$results = $this->Action(
			"/bud/end/".base64_encode("3N3gfkbeNx/HfcpuIuRdhA==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5py0DQLuZvBtJ+c/FDBTish3V2IoSmmSuIm5Vh2V8sLVManCN2o3NomUE5bl5Yhkqopj87BL6rUEDw52CvoDlyZdBtm4WaKCxE23rQEmkEPeqnaNobDJhYp"
				),
				"method" => "POST"
			)
		);

		$results = $this->Action(
			"/csv/extract.csv",
			array(
				"method" => "GET",
				"remote_address" => "217.35.85.137"
			)
		);
		$arr = array();
		foreach(explode("\n", $results) as $values) {
			$mini = explode("\",\"", $values);
			if(count($mini) == 11) {
				$arr[] = $mini;
			}
		}

		$expected = 4;
		$this->assertEquals($expected, count($arr));

		$this->assertEquals("\"556891464861323", $arr[3][0]);
		$this->assertEquals("SUSPICIOUS", $arr[3][1]);
		$this->assertEquals("690000", $arr[3][4]);
		$this->assertEquals("36543", $arr[3][3]);


		$this->assertEquals("Sue Blogs", $arr[3][5]);
		$this->assertEquals("sue@rehab.com", $arr[3][6]);
		$this->assertEquals("34", $arr[3][7]);
		$this->assertEquals("Florida", $arr[3][8]);
	}

//
// Action testSpecialCharacterData, adds forth user in checks csv exporter for special characters
///
	public function testSpecialCharacterData() {

		$results = $this->Action(
			"/bud/user/".base64_encode("950WRP4NBZSlunQc9WQq+Q==").".json",
			array("method" => "POST")
		);

		$results = $this->Action(
			"/bud/end/".base64_encode("950WRP4NBZSlunQc9WQq+Q==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5oA9e/8Lqcq45+c/FDBTish3V2IoSmmSuIspUPMGMv2oXA7EU6qpmEnxqqfmMVBGaqgb3pdTbLY7p7Bj2VonUyZcZCr3IMcezusjB90trJQTSkmqOlGdN4XQ/VM4NEu5s6Ss2P4SpozBg=="
				),
				"method" => "POST"
			)
		);

		$results = $this->Action(
			"/csv/extract.csv",
			array(
				"method" => "GET",
				"remote_address" => "217.35.85.137"
			)
		);
		$arr = array();
		foreach(explode("\n", $results) as $values) {
			$mini = explode("\",\"", $values);
			if(count($mini) == 11) {
				$arr[] = $mini;
			}
		}

		$expected = 5;
		$this->assertEquals($expected, count($arr));

		$this->assertEquals("αυτός είναι", $arr[4][5]);
		$this->assertEquals("ο θεός", $arr[4][8]);
	}

//
// Action testCSVExtractNoAccess, Tests the csv extract response when the IP doesn't match internal
///
	public function testCSVExtractNoAccess() {

		$results = $this->Action(
			"/csv/extract.csv",
			array(
				"method" => "GET"
			)
		);
		$expected = "No access";
		$this->assertEquals($expected, $results);

	}
//
// Action testNothingSet, Tests if no controller or action have been set that the system handles it
///
	public function testNothingSet() {

		$results = $this->Action(
			"",
			array(
				"method" => "GET"
			)
		);
		$expected = "YvrLH6n6I38gVKOhBnHrUTCP9h7j3cKgf7mrGMMn/iK2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1asyxBATmIDkgonyNT4OOIvA4mExJZs/dQeJH+rP0TG8zAurBuuLYaL30huVJMt8EcdaK1AImsupU";
		$this->assertEquals($expected, $results);

	}

//
// Action testNoAction, Tests if no action have been set that the system handles it
///
	public function testNoAction() {

		$results = $this->Action(
			"/Bud",
			array(
				"method" => "GET"
			)
		);
		$expected = "YvrLH6n6I38gVKOhBnHrUTCP9h7j3cKgf7mrGMMn/iK2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1aq4zm3e+AWVFL+jSD3jmSwy2xZuSBFJ4EjNX0EfuEBESa3mciUVgk8uW0usrPbhFf9hP5bW8k3sxm75VnY03BFk=";
		$this->assertEquals($expected, $results);

	}

//
// Action testNoController, Tests if no controller have been set that the system handles it
///
	public function testNoController() {

		$results = $this->Action(
			"/asdasdsda",
			array(
				"method" => "GET"
			)
		);
		$expected = "YvrLH6n6I38gVKOhBnHrUTCP9h7j3cKgf7mrGMMn/iK2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1al+We3wI9jtGU6NWA6yYa+RreZyJRWCTy5nH8MW3wsp2ZsJOrBMGBVNilpqpfMllPmVVO8sIOZrLR1o7k2FWZ4WbvlWdjTcEWQ==";
		$this->assertEquals($expected, $results);

	}





//
// Action testUsersDump, Tests the user data dump for the current logs
///
	public function testUsersDump() {

		$results = $this->Action(
			"/users/dump.csv",
			array(
				"method" => "GET",
				"remote_address" => "217.35.85.137"
			)
		);

		$arr = array();
		foreach(explode("\n", $results) as $values) {
			$mini = explode("\",\"", $values);
			if(count($mini) == 7) {
				$arr[] = $mini;
			}
		}

		$this->assertEquals(18, count($arr));


		$this->assertEquals("\"1655898751", $arr[1][0]);
		$this->assertEquals("BudController", $arr[1][3]);
		$this->assertEquals("user", $arr[1][4]);

		$this->assertEquals("\"1655898751", $arr[2][0]);
		$this->assertEquals("BudController", $arr[2][3]);
		$this->assertEquals("progress", $arr[2][4]);

		$this->assertEquals("\"1655898751", $arr[10][0]);
		$this->assertEquals("BudController", $arr[10][3]);
		$this->assertEquals("endgame", $arr[10][4]);

		$this->assertEquals("\"1655898751", $arr[11][0]);
		$this->assertEquals("BudController", $arr[11][3]);
		$this->assertEquals("user", $arr[11][4]);

		$this->assertEquals("\"100004051182031", $arr[12][0]);
		$this->assertEquals("BudController", $arr[12][3]);
		$this->assertEquals("user", $arr[12][4]);

		$this->assertEquals("\"100004051182031", $arr[13][0]);
		$this->assertEquals("BudController", $arr[13][3]);
		$this->assertEquals("endgame", $arr[13][4]);

		$this->assertEquals("\"468564891354565", $arr[17][0]);
		$this->assertEquals("BudController", $arr[17][3]);
		$this->assertEquals("endgame", $arr[17][4]);

	}
//
// Action testUsersDumpNoAccess, Tests the user dump response when the IP doesn't match internal
///
	public function testUsersDumpNoAccess() {

		$results = $this->Action(
			"/users/dump.csv",
			array(
				"method" => "GET"
			)
		);
		$expected = "No access";
		$this->assertEquals($expected, $results);

	}

//
// Action testWinnerDump, Tests the winner data dump for the current logs
///
	public function testWinnerDump() {

		$results = $this->Action(
			"/users/winner/1655898751.csv",
			array(
				"method" => "GET",
				"remote_address" => "217.35.85.137"
			)
		);

		$arr = array();
		foreach(explode("\n", $results) as $values) {
			$mini = explode("\",\"", $values);
			if(count($mini) == 7) {
				$arr[] = $mini;
			}
		}

		$this->assertEquals(12, count($arr));

		$this->assertEquals("\"1655898751", $arr[1][0]);
		$this->assertEquals("BudController", $arr[1][3]);
		$this->assertEquals("user", $arr[1][4]);


		$this->assertEquals("\"1655898751", $arr[2][0]);
		$this->assertEquals("BudController", $arr[2][3]);
		$this->assertEquals("progress", $arr[2][4]);


		$this->assertEquals("\"1655898751", $arr[10][0]);
		$this->assertEquals("BudController", $arr[10][3]);
		$this->assertEquals("endgame", $arr[10][4]);

	}

//
// Action testWinnerDumpException, Tests the winner data dump for the current logs but with invalid user fb_id
///
	public function testWinnerDumpException() {

		$results = $this->Action(
			"/users/winner.csv",
			array(
				"method" => "GET",
				"remote_address" => "217.35.85.137"
			)
		);
		$expected = "YvrLH6n6I3+31I/cGshDijrj+LFAN+pVm7mgkJUmrWe2F1u5wWef1Ehqbft2qU9cq8u/elW8PORB1T6VVBdkp6tryu4X/jEH33K01uV1YzRO6XZh+KZ1anphbYzt4RV91vSkUeHEZjLjb9ZOJkmaQA==";
		$this->assertEquals($expected, $results);

	}
//
// Action testWinnerDumpExceptionNoAccess, Tests the winner data dump for the current logs but with invalid user ip
///
	public function testWinnerDumpExceptionNoAccess() {

		$results = $this->Action(
			"/users/winner.csv",
			array(
				"method" => "GET"
			)
		);
		$expected = "No access";
		$this->assertEquals($expected, $results);

	}

//
// Action testSimulateUserjourney, Tests the full journey for a user within the game and read the logs
///
	public function testSimulateUserjourney() {
		$this->crypt = new \Budlight\Configs\Crypt(CRYPTKEY);
		//create user
		$resultsuser = $this->Action(
			"/bud/user/".base64_encode("jGs744TT4BTF1gdtdLYZCQ==").".json",
			array("method" => "POST")
		);
		//array to run though the natural loops
		$interval = 682;
		$distance = 0;
		for($i = 0; $i < 5; $i++) {

			$encrypt = $this->crypt->encrypt("distance=".$distance."&progress=".$distance."&state=0");
			//echo "Distance --> ".$distance." | encryption --> ".$encrypt."\n";

			$resultsprogress = $this->Action(
				"/bud/progress/".base64_encode("jGs744TT4BTF1gdtdLYZCQ==").".json",
				array(
					"data" => array(
						"encrypt" => $encrypt
					),
					"method" => "POST"
				)
			);

			$distance += $interval;
		}



		//end game
		$resultsend = $this->Action(
			"/bud/end/".base64_encode("jGs744TT4BTF1gdtdLYZCQ==").".json",
			array(
				"data" => array(
					"encrypt" => "Jk5KZ8m1C5qy5m7VwACNT21SciaoHM8DYSeB7+/QuJp3XOK+FoHLbh3nURsBS0/YWrjdKHx89OkubloLXlDuANaFV9DlUSJEczrcUEp7enO4/m/uxqfFD5KzY/hKmjMG"
				),
				"method" => "POST"
			)
		);


		//check logs for that user

		$resultswinner = $this->Action(
			"/users/winner/123559900059645.csv",
			array(
				"method" => "GET",
				"remote_address" => "217.35.85.137"
			)
		);

		$arr = array();
		foreach(explode("\n", $resultswinner) as $values) {
			$mini = explode("\",\"", $values);
			if(count($mini) == 7) {
				$arr[] = $mini;
			}
		}

		$this->assertEquals("user", $arr[1][4]);
		$this->assertEquals("progress", $arr[2][4]);
		$this->assertEquals("progress", $arr[3][4]);
		$this->assertEquals("progress", $arr[4][4]);
		$this->assertEquals("progress", $arr[5][4]);
		$this->assertEquals("progress", $arr[6][4]);
		$this->assertEquals("endgame", $arr[7][4]);



		$results = $this->Action(
			"/csv/extract.csv",
			array(
				"method" => "GET",
				"remote_address" => "217.35.85.137"
			)
		);
		$csv = array();
		foreach(explode("\n", $results) as $values) {
			$mini = explode("\",\"", $values);
			if(count($mini) == 11) {
				$csv[] = $mini;
			}
		}


		$csvcount = count($csv) - 1;

		$this->assertEquals("\"123559900059645", $csv[$csvcount][0]);
		$this->assertEquals("-", $csv[$csvcount][1]);

		$this->assertEquals("3410", $csv[$csvcount][3]);
		$this->assertEquals("3410", $csv[$csvcount][4]);
		$this->assertEquals("Simulated User", $csv[$csvcount][5]);
		$this->assertEquals("sim@rehab.com", $csv[$csvcount][6]);
		$this->assertEquals("30", $csv[$csvcount][7]);
		$this->assertEquals("Florida", $csv[$csvcount][8]);


	}
}