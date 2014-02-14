<?php

?>
<div class="page-header">
	<h2><?php echo $this->Html->Url($this->Html->__t('Users'), array('controller' => 'users', 'action' => 'index', 'admin' => true)); ?> - <?php echo $typ__["data"]["Users"]["username"]; ?></h2>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
	  	<div class="panel-heading">
	  		<?php echo $this->Html->__t('Army Lists view'); ?>
	  		<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t('Edit'), array('admin' => true, 'controller' => 'users', 'action'=>'edit', 'params' => array($typ__["data"]["Users"]['id'])), array('class' => 'btn-sm btn-warning')); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('admin' => true, 'controller' => 'users', 'action'=>'delete', 'params' => array($typ__["data"]["Users"]['id'])), array('class' => 'btn-sm btn-danger')); ?>
	  		</span>
	  	</div>
	  	<div class="panel-body">
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('Id'); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Users"]['id']; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('Slug'); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Users"]['slug']; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('Username'); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Users"]['username']; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('Email'); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Users"]['email']; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('email_verified'); ?></span>
	  			<span class="col-md-9"><?php echo ($typ__["data"]["Users"]['email_verified'] == 1)?"Yes":"No"; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('is_admin'); ?></span>
	  			<span class="col-md-9"><?php echo ($typ__["data"]["Users"]['is_admin'] == 1)?"Yes":"No"; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('last_login'); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["Users"]['last_login']); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('Created'); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["Users"]['created']); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('Modified'); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["Users"]['modified']); ?></span>
	  		</div>
	  	</div>
	</div>
</div>