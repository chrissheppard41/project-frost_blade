<?php
namespace Frost\Configs;

/**
 *	@class Html
 *	@author Chris Sheppard
 *	@desc handles all the view logic like URLS and the such, helper class
 */
class Html {

	public $script;

	function __construct() {
		$this->script = "";
	}

/**
 * Url method
 * Prints out nicely formatted URL
 *
 * @param $name(string), $url(mixin), $options (array)
 * @return (string)
  **/
	public function Url($name, $url, $options = array()) {
		$url_path = "";
		$attr = "";
		if(is_array($url)) {
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

		return '<a href="'.$url_path.'"'.$attr.'>'.$name.'</a>';
	}


/**
 * css method
 * Prints out nicely formatted css link
 *
 * @param $file(array)
 * @return (string)
  **/
	public function Css($file = array()) {
		$output = "";
		foreach($file as $value) {
			$output .= '<link href="/assets/css/'.$value.'" media="all" rel="stylesheet" type="text/css" />';
		}
		return $output;
	}

/**
 * js method
 * Prints out nicely formatted js link
 *
 * @param $file(array)
 * @return (string)
  **/
	public function Js($file = array()) {
		$output = "";
		foreach($file as $value) {
			$output .= '<script type="text/javascript" src="/assets/js/'.$value.'"></script>';
		}
		return $output;
	}
/**
 * Script method
 * Adds script data to a list to be displays when called by not including the $count;
 *
 * @param $file(array)
 * @return (string)
  **/
	public function Script($content = null) {
		if(isset($content)) {
			$this->script[] = '<script type="text/javascript">'.$content.'</script>'; return ;
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
 * meta method
 * Prints out nicely formatted meta link
 *
 * @param $name(string), $content(string)
 * @return (string)
  **/
	public function Meta($name, $content) {
		$output = '<meta name="'.$name.'" content="'.$content.'" />';
		return $output;
	}

/**
 * Highlight method
 * Prints out nicely formatted meta link
 *
 * @param $name(string), $content(string)
 * @return (string)
  **/
	public function Highlight($pattern) {
		if(preg_match($pattern, $_SERVER['REQUEST_URI']) === 1) {
			return " active";
		}

		return "";
	}

/**
 * __t method
 * Gets the translated phrase from a copy
 *
 * @param $list(string), $phrase(string)
 * @return (string)
  **/
	public function __t($list, $phrase) {
		return $phrase;
	}


/**
 * form method
 * Generates form headers and footers in a nicely formatted way
 *
 * @param $options(array)
 * @return (string)
  **/
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
 * input method
 * Generates a form input field in a nicely formatted way
 *
 * @param $options(array)
 * @return (string)
  **/
	public function Input($name, $model, $options = array()) {
		$nameucf = ucfirst($name);
		$output = '<div class="form-group">';
		if(isset($options['label'])){
			$output .= '	<label for="'.$model.''.$nameucf.'" class="control-label">'.$options['label'].'</label>';
			unset($options['label']);
		}


		if(isset($options)) {
			if(isset($options['name']))
				unset($options['name']);

			$output .= '	<input name="data['.$model.']['.strtolower($name).']"';
			foreach($options as $key => $values) {
				$output .= ' '.$key.'="'.$values.'"';
			}

			if(isset($_POST['data'][$model][strtolower($name)]))
				$output .= ' value="'.$_POST['data'][$model][strtolower($name)].'"';

			$output .= ' />';
		}
		$output .= '</div>';

		return $output;
	}

/**
 * Submit method
 * Generates a form Submit field in a nicely formatted way
 *
 * @param $options(array)
 * @return (string)
  **/
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
 * Flash method
 * Adds a Flash message to the session to be displayed once on call
 *
 * @param $options(array)
 * @return (string)
  **/
	public function Flash($message = "", $class = "alert alert-info") {
		if(isset($message) and $message != "") {
			\Configure::write("Flash.message", $message);
			\Configure::write("Flash.class", $class);
		} else {
			$message = \Configure::read("Flash.message");
			$output = "";
			if(isset($message)) {
				$output = '<div class="'.\Configure::read("Flash.class").' alert-dismissable"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'.\Configure::read("Flash.message").'</div>';
				\Configure::delete("Flash.message");
				\Configure::delete("Flash.class");
			}

			return $output;
		}
	}

}
