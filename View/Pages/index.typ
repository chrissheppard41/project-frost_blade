<?php

echo "<pre>".print_r($_SESSION, true)."</pre>";

if(\Configure::Logged()) {
	echo $this->Html->Url($this->Html->__t('Logout'), array('controller' => 'users', 'action' => 'logout'), array('class' => 'btn btn-success icon icon-add'));
} else {
	echo $this->Html->Url($this->Html->__t('Login'), array('controller' => 'users', 'action' => 'login'), array('class' => 'btn btn-info icon icon-add'));
	echo $this->Html->Url($this->Html->__t('Register'), array('controller' => 'users', 'action' => 'register'), array('class' => 'btn btn-success icon icon-add'));
}



?>


