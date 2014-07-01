<?php

//echo "<pre>".print_r($_SESSION, true)."</pre>";

if(\Configure::Logged()) {
	echo $this->Html->Url($this->Html->__t('Logout'), array('controller' => 'users', 'action' => 'logout'), array('class' => 'btn btn-success icon icon-add'));
	?>
	<p>Want to display a list of armies using Angular server calling, then look at angular's templating</p>

	<div ng-app="tool">

		<div ng-view></div>

	</div>

	<?php



		$this->Html->Script(
			'var $sid = '.$this->Session->read("Auth.user.id")
		);
		echo $this->Html->Js(array('build.min.js'), array("inline" => false));
		/*echo $this->Html->Js(array(
			'build/module/UnitCount.module.js',
			'build/module/Wargear.module.js'
		), array("inline" => false));

		echo $this->Html->Js(array('build/list.module.js'), array("inline" => false));

		echo $this->Html->Js(array('build/class/Squad.class.js'), array("inline" => false));
		echo $this->Html->Js(array('build/class/SquadList.class.js'), array("inline" => false));
		echo $this->Html->Js(array('build/class/Unit.class.js'), array("inline" => false));

		echo $this->Html->Js(array('build/service/filters.module.js'), array("inline" => false));
		echo $this->Html->Js(array('build/service/listServices.module.js'), array("inline" => false));
		echo $this->Html->Js(array('build/service/routeHelper.module.js'), array("inline" => false));
		echo $this->Html->Js(array('build/service/ngConfirmClick.directive.js'), array("inline" => false));
		echo $this->Html->Js(array('build/service/ngDragnDropSort.directive.js'), array("inline" => false));

		echo $this->Html->Js(array('build/controller/Add.ctrl.js'), array("inline" => false));
		echo $this->Html->Js(array('build/controller/Display.ctrl.js'), array("inline" => false));
		echo $this->Html->Js(array('build/controller/Edit.ctrl.js'), array("inline" => false));
		echo $this->Html->Js(array('build/controller/View.ctrl.js'), array("inline" => false));
		echo $this->Html->Js(array('build/controller/Setup.ctrl.js'), array("inline" => false));*/

} else {
	echo $this->Html->Url($this->Html->__t('Login'), array('controller' => 'users', 'action' => 'login'), array('class' => 'btn btn-info icon icon-add'));
	echo $this->Html->Url($this->Html->__t('Register'), array('controller' => 'users', 'action' => 'register'), array('class' => 'btn btn-success icon icon-add'));
}



?>


