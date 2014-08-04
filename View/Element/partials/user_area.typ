<div ng-controller="UserManageCtrl">


	<p ng-show="logged_in">
		<span class="button">
			<?php
				echo $this->Html->Url($this->Html->__t('Logout'), array('controller' => 'users', 'action' => 'logout'), array('class' => 'red'));
				echo $this->Html->Url($this->Html->__t('Profile'), "#/user/profile", array('class' => 'orange'));
			?>
		</span>
		<span class="user">Welcome: {{user_name}}</span>
	</p>

	<p ng-hide="logged_in">
		<span class="button">
			<?php
				echo $this->Html->Url($this->Html->__t('Login'), "#/user/login", array('class' => 'blue'));
				echo $this->Html->Url($this->Html->__t('Register'), "#/user/register", array('class' => 'green'));
			?>
		</span>
		<span class="user">Welcome: {{user_name}}</span>
	</p>



</div>