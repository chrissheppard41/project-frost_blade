<div class="ang_tool">

	<div ng-view></div>

</div>

<?php
	if(!empty($this->Session->read("Auth.user.id"))) {
		$this->Html->Script(
			'var $sid = '.$this->Session->read("Auth.user.id").';var $suser = "'.$this->Session->read("Auth.user.username").'";'
		);
	} else {
		$this->Html->Script(
			'var $sid = 0;var $suser = "Guest";'
		);
	}

	echo $this->Html->Js(array('build.min.js'), array("inline" => false));
?>
