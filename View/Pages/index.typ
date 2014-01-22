<?php

echo "<pre>".print_r($_SESSION, true)."</pre>";

if(\Configure::Logged()) {
	echo $this->Html->Url($this->Html->__t('users', 'Logout'), array('controller' => 'users', 'action' => 'logout'), array('class' => 'btn btn-success icon icon-add'));
} else {
	echo $this->Html->Url($this->Html->__t('users', 'Login'), array('controller' => 'users', 'action' => 'login'), array('class' => 'btn btn-success icon icon-add'));
}



?>


