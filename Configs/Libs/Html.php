<?php
namespace Frost\Configs;

/**
 *	@class Html
 *	@author Chris Sheppard
 *	@description handles all the view logic like URLS and the such, helper class
 */
class Html {

	public $script;
	private $Database;

	function __construct(Database $db) {
		$this->script = array();
		$this->Database = $db;
	}

/**
 * [Prints out nicely formatted URL]
 * @param [string] $name    []
 * @param [mixin] $url     []
 * @param [array]  $options []
 */
	public function Url($name, $url, $options = array()) {
		$url_path = "";
		$attr = "";
		if(is_array($url)) {
			if(!isset($url['controller']))
				$url['controller'] = str_replace("Controller", "", \Configure::$url['controller']);

			if(isset($url['admin']) && $url['admin'] === true) {
				$url_path = "/admin";
			}
			$url_path .= "/".strtolower($url['controller'])."/".$url['action'];
			if(isset($url['params'])) {
				foreach($url['params'] as $values) {
					$url_path .= "/".$values;
				}
			}
		} else {
			$url_path = $url;
		}

		foreach($options as $key => $value) {
			$attr .= ' '.$key.'="'.$value.'"';
		}

		return '<a href="'.$url_path.'"'.$attr.'>'.$name.'</a>';
	}

/**
 * [UrlPost out nicely formatted URL within a form post, used for deleting]
 * @param [string] $name    []
 * @param [string] $url     []
 * @param [array]  $options []
 * @return [string]
 */
	public function UrlPost($name, $url, $options = array()) {

		$url_path = "";
		$attr = "";
		if(is_array($url)) {
			if(!isset($url['controller']))
				$url['controller'] = str_replace("Controller", "", \Configure::$url['controller']);

			if(isset($url['admin']) && $url['admin'] === true) {
				$url_path = "/admin/";
			}
			$url_path .= $url['controller']."/".$url['action'];
			if(isset($url['params'])) {
				foreach($url['params'] as $values) {
					$url_path .= "/".$values;
				}
			}
		} else {
			$url_path = $url;
		}

		foreach($options as $key => $value) {
			$attr .= ' '.$key.'="'.$value.'"';
		}

		$rand = \Configure::Random_generation();

		$output = '
<form action="'.$url_path.'" name="post_'.$rand.'" id="post_'.$rand.'" style="display:none;" method="post">
	<input type="hidden" name="_method" value="POST">
</form>
<a href="#" '.$attr.' onclick="if (confirm(\'Are you sure you want to delete this record?\')) { document.post_'.$rand.'.submit(); } event.returnValue = false; return false;">Delete</a>
';

		return $output;
	}

/**
 * [Prints out nicely formatted css link]
 * @param [array] $file []
 * @return [string]
 */
	public function Css($file = array()) {
		$output = "";
		foreach($file as $value) {
			$output .= '<link href="/Assets/css/'.$value.'" media="all" rel="stylesheet" type="text/css" />';
		}
		return $output;
	}

/**
 * [Prints out nicely formatted js link]
 * @param [array]  $file    []
 * @param [array] $options []
 * @return [string]
 */
	public function Js($file = array(), $options = null) {
		$output = array();
		foreach($file as $value) {
			$output[] = '<script type="text/javascript" src="/Assets/js/'.$value.'"></script>';
		}

		if(isset($options["inline"]) && $options["inline"] === false) {
			$this->script = array_merge($this->script, $output);
			return ;
		}

		return implode("\n", $output);
	}

/**
 * [Adds script data to a list to be displays when called by not including the $count]
 * @param [string] $content []
 */
	public function Script($content = null) {
		//\Configure::pre($this->script);
		if(isset($content)) {
			$this->script[] = '<script type="text/javascript">'.$content.'</script>';
			return ;
		}
		$output = "";
		if(isset($this->script) && is_array($this->script)) {
			foreach($this->script as $key => $value) {
				$output .= $value;
			}
		}
		return $output;
	}

/**
 * [Prints out nicely formatted meta link]
 * @param [string] $name    []
 * @param [string] $content []
 * @return [string]
 */
	public function Meta($name, $content) {
		$output = '<meta name="'.$name.'" content="'.$content.'" />';
		return $output;
	}

/**
 * [Prints out nicely formatted meta link]
 * @param [string] $pattern []
 * @return [string]
 */
	public function Highlight($pattern) {
		if(preg_match($pattern, $_SERVER['REQUEST_URI']) === 1) {
			return " active";
		}

		return "";
	}

/**
 * [Gets the translated phrase from a copy]
 * @param  [string] $phrase []
 * @return [string]         []
 */
	public function __t($phrase) {
		return $phrase;
	}

/**
 * [Generates form headers and footers in a nicely formatted way]
 * @param [array] $options []
 * @return [string]         []
 */
	public function Form($options = array()) {

		if(isset($options) && !empty($options)) {
			$output = "<form";
			foreach($options as $key => $values) {
				$output .= ' '.$key.'="'.$values.'"';
			}
			$output .= ">";

			$tokenKey = preg_replace('/[^A-Za-z0-9\-]/', '', crypt(sha1(time()), CRYPTKEY));
			$tokenValue = sha1(time());
			\Configure::write("Token.Token".$tokenKey, $tokenValue);

			$output .= '
				<div style="display:none;">
					<input type="hidden" name="_method" value="'.strtoupper($options['method']).'"/>
					<input type="hidden" name="data[_Token][val]" value="'.$tokenValue.'" id="Token'.$tokenKey.'"/>
					<input type="hidden" name="data[_Token][key]" value="'.$tokenKey.'" id="Token"/>
				</div>
			';
		} else {
			$output = "</form>";
		}



		return $output;
	}

/**
 * [Generates a form input field in a nicely formatted way]
 * @param [string]  $name    []
 * @param [string]  $model   []
 * @param [array]   $options []
 * @param [array]   $list    []
 * @param [boolean] $angular []
 * @return [string]
 */
	public function Input($name, $model, $options = array(), $list = array(), $angular = false) {
		$_name = $name;
		$nameucf = ucfirst($name);
		$output = '<div class="form-group">';
		$outputExra = '';
		$radio = '';
		if(isset($options['label'])){
			$output .= '	<label for="'.$model.''.$nameucf.'" class="control-label">'.$options['label'].'</label>';
			unset($options['label']);
		}

		if(isset($options)) {
			if(isset($options['name']))
				unset($options['name']);

			if(!$angular) {
				$name = 'data['.$model.']['.$name.']';
			}
			if($options['type'] == "select") {
				if(!in_array("multiple", $options))
					$output .= '<select name="'.$name.'"';
				else
					$output .= '<select name="'.$name.'[]"';
			} else if($options['type'] == "textarea") {
				$output .= '<textarea name="'.$name.'"';
			} else if($options['type'] == "radio") {

			} else {
				if($options['type'] == "checkbox")
					$outputExra = '<input name="'.$name.'" type="hidden" value="" />';

				$output .= $outputExra.'<input name="'.$name.'"';
			}


			foreach($options as $key => $values) {
				if($key == "type" && $values == "select" || $values == "textarea") continue;
				if($key == 0 && $values == "multiple") {
					$output .= ' multiple';
				} else if($options["type"] == "radio") {
					$radio .= ' '.$key.'="'.$values.'"';
				} else {
					$output .= ' '.$key.'="'.$values.'"';
				}
			}

			if($options['type'] == "select") {
				$output .= '>';

				if(!in_array("multiple", $options))
					$output .= '<option value="">Select an option</option>';
				foreach($list as $key => $values) {
					$found = false;

					if(isset($_POST) && !empty($_POST) && isset($_POST['data'][$model][$_name])) {
						if($values["id"] == $_POST['data'][$model][$_name]) $found = true;
						else if(\Configure::in_array_r($values["id"], $_POST['data'][$model][$_name], "id")) $found = true;
					}

					$output .= '<option value="'.$values["id"].'"'.(($found)?" selected='selected'":"").'>'.$values["name"].'</option>';
				}
				$output .= '</select>';
			} else if($options['type'] == "textarea") {
				$output .= '>';
				if(isset($_POST['data'][$model][$_name])) $output .= $_POST['data'][$model][$_name];
				$output .= '</textarea>';
			} else if($options['type'] == "radio") {

				foreach($list as $key => $values) {
					$found = false;
					if(isset($_POST) && !empty($_POST) && isset($_POST['data'][$model][$_name])) {
						if($values["id"] == $_POST['data'][$model][$_name]) $found = true;
						else if(\Configure::in_array_r($values["id"], $_POST['data'][$model][$_name])) $found = true;
					}

					$output .= '<input name="'.$name.'" value="'.$values["id"].'"'.$radio.''.(($found)?" selected='selected'":"").' /> '.$values["name"].'<br />';
				}


			} else {
				if(isset($_POST['data'][$model][$_name])) {
					if($options['type'] == "checkbox") {
						if((bool)$_POST['data'][$model][$_name] === true)
							$output .= ' checked="checked"';
					} else {
						$output .= ' value="'.$_POST['data'][$model][$_name].'"';
					}
				}

				$output .= ' />';
			}
		}
		$output .= '</div>';
				return $output;
	}

/**
 * [Generates a form multi select field in a nicely formatted way along with a search]
 * @param [string]  $name    []
 * @param [string]  $model   []
 * @param [array]   $options []
 * @param [array]   $list    []
 * @param [boolean] $angular []
 * @return [string]
 */
	public function MultiSearch($name, $model, $options = array(), $list = array(), $angular = false) {
		$_name = $name;
		$nameucf = ucfirst($name);
		$output = '<div class="form-group">';
		$outputExra = '';
		$radio = '';
		$id = "";
		if(isset($options['label'])){
			$output .= '	<label for="'.$model.''.$nameucf.'" class="control-label">'.$options['label'].'</label>';
			unset($options['label']);
		}

		if(isset($options)) {
			if(isset($options['name']))
				unset($options['name']);

			if(!$angular) {
				$name = 'data['.$model.']['.$name.']';
			}
			if($options['type'] == "select") {
				if(!in_array("multiple", $options))
					$output .= '<select name="'.$name.'"';
				else
					$output .= '<select name="'.$name.'[]"';
			}


			foreach($options as $key => $values) {
				if($key == "type" && $values == "select" || $values == "textarea") continue;
				if($key == 0 && $values == "multiple") {
					$output .= ' multiple';
				} else {
					$output .= ' '.$key.'="'.$values.'"';
					if($key == "id") {
						$id = $values;
					}
				}
			}

			if($options['type'] == "select") {
				$output .= '>';

				if(!in_array("multiple", $options))
					$output .= '<option value="">Select an option</option>';
				foreach($list as $key => $values) {
					$found = false;

					if(isset($_POST) && !empty($_POST) && isset($_POST['data'][$model][$_name])) {
						if($values["id"] == $_POST['data'][$model][$_name]) $found = true;
						else if(\Configure::in_array_r($values["id"], $_POST['data'][$model][$_name], "id")) $found = true;
					}

					$output .= '<option value="'.$values["id"].'"'.(($found)?" selected='selected'":"").'>'.$values["name"].'</option>';
				}
				$output .= '</select>';
			}
		}
		$output .= '</div>';
		if($id != "") {
			$output .= '<script>
		        $("#'.$id.'").chosen({
		            disable_search_threshold: 10,
		            no_results_text: "Oops, nothing found!",
		            width: "100%"
		        });
	        </script>';
		}

		return $output;
	}

/**
 * [Generates a form Submit field in a nicely formatted way]
 * @param [string] $name    []
 * @param [array]  $options []
 * @return [string]
 */
	public function Submit($name, $options = array()) {
		$output = '<button';

		if(isset($options)) {
			foreach($options as $key => $values) {
				$output .= ' '.$key.'="'.$values.'"';
			}
		}
		$output .= '>'.$name.'</button>';
		return $output;
	}

/**
 * [Adds a Flash message to the session to be displayed once on call]
 * @param [string] $message []
 * @param [string] $class   []
 * @return [string]
 */
	public function Flash($message = "", $class = "alert alert-info") {
		$output = "";
		if($message == "" && !empty(\Configure::read("Flash.message"))) {
			$message = \Configure::read("Flash.message");
			$class = \Configure::read("Flash.class");

			if(isset($message)) {
				$output = '<div class="'.$class.' alert-dismissable"><span>'.$message.'</span><button class="close" data-dismiss="alert" aria-hidden="true">&times;</button></div>';
				\Configure::delete("Flash");
			}
		}
		return $output;
	}

/**
 * [Displays a nice pagination button format]
 * @param [string] $model []
 * @return [string]
 */
	public function Pagination($model) {
		$index	= count(\Configure::$url['param'])-1;
		$arr 	= preg_split("/(Pag:|:)/",\Configure::$url['param'][$index]);

		$last_item = $arr[(count($arr)-1)];

		$output = "";
		$q = array(
			"query" => "SELECT count(*) as `count` FROM ".$model,
			"params" => null
		);
		$results = $this->Database->results($this->Database->query($q));

		if($results[0]['count'] > $last_item) {
			$output = '
			<ul class="pagination">
				'.$this->Pagionation_url($arr, 0, "&laquo;").'
				';
			for($i = 0; $i < ($results[0]['count']/$last_item); $i++) {
				$output .= $this->Pagionation_url($arr, $i);
			}
			$output .= ''.$this->Pagionation_url($arr, floor($results[0]['count']/$last_item), "&raquo;").'
			</ul>
			';
		}
		return $output;
	}

/**
 * [Displays a nice pagination button format]
 * @param [array] $arr   []
 * @param [string] $index []
 * @param string $name  []
 * @return [string]
 */
	private function Pagionation_url($arr, $index, $name = "") {
		return '<li'.
		(($index == $arr[1])?' class="active"':'').'><a href="/'.
		(((bool)strstr(\Configure::$url['action'], "admin_") == true)?"admin/":"").
		str_replace("controller","",strtolower(\Configure::$url['controller'])).'/'.
		str_replace("admin_","",\Configure::$url['action']).'/Pag:'.
		$index.
		((isset($arr[2]) && !is_numeric($arr[2]))?":".$arr[2]:"").
		((isset($arr[3]))?":".$arr[3]:"").'">'.
		(($name != "")?$name:($index+1)).
		'</a></li>
		';
	}

/**
 * [The ability to trigger a sort on pagination headers]
 * @param [string] $pagination []
 * @param [string] $column     []
 * @return [string]
 */
	public function Pag_Sort($pagination, $column = null) {
		$index	= count(\Configure::$url['param'])-1;
		$arr 	= preg_split("/(Pag:|:)/",\Configure::$url['param'][$index]);

		$column = ((isset($column) && $column != null)?$column:$pagination);

		$output = '<a href="/'.
		(((bool)strstr(\Configure::$url['action'], "admin_") == true)?"admin/":"").
		str_replace("controller","",strtolower(\Configure::$url['controller'])).'/'.
		str_replace("admin_","",\Configure::$url['action']).'/Pag:'.
		$arr[1].
		":".$column.
		":".((isset($arr[3]) && $arr[3] == "ASC" && $arr[2] == $column)?"DESC":"ASC").
		'">'.ucfirst($pagination).'</a>';


		return $output;
	}

/**
 * [Outputs time method based on a string input]
 * @param [string]  $type  []
 * @param [string]  $input []
 * @param [boolean] $full  []
 */
	public function Time($type, $input = null, $full = false) {
		$output = "";
		$time = strtotime($input);

		if($type == "TimeAgo") {
			$now = new \DateTime;
			$ago = new \DateTime($input);
			$diff = $now->diff($ago);

			$diff->w = floor($diff->d / 7);
			$diff->d -= $diff->w * 7;

			$string = array(
				'y' => 'year',
				'm' => 'month',
				'w' => 'week',
				'd' => 'day',
				'h' => 'hour',
				'i' => 'minute',
				's' => 'second',
			);
			foreach ($string as $k => &$v) {
				if ($diff->$k) {
					$v = $diff->$k . ' ' . $v . ($diff->$k > 1 ? 's' : '');
				} else {
					unset($string[$k]);
				}
			}

			if (!$full) $string = array_slice($string, 0, 1);
			return $string ? implode(', ', $string) . ' ago' : 'just now';
		}

		return $output;
	}
}
