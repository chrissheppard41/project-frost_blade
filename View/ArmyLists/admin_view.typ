<?php ?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Army Lists'), array('action' => 'index', "admin" => true)); ?> - <?php echo $typ__["data"]['armylists']['name']; ?></h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
	  	<div class="panel-heading">
	  		<?php echo $this->Html->__t('Army Lists view'); ?>
	  		<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t('Edit'), array('action' => 'edit', "params" => array($typ__["data"]['armylists']['id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('action' => 'delete', "params" => array($typ__["data"]['armylists']['id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
	  		</span>
	  	</div>
	  	<div class="panel-body">
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('Name'); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]['armylists']['name']; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('Description'); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]['armylists']['descr']; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('Point Limit'); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]['armylists']['point_limit']; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('Hidden'); ?></span>
	  			<span class="col-md-9"><?php echo ($typ__["data"]['armylists']['hide'])?"Private":"Public"; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('Army type'); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Url($typ__["data"]['armylists']['army_name'], array('controller' => 'armies', 'action' => 'view', "params" => array($typ__["data"]['armylists']['armies_id']), "admin" => true)); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('User'); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Url((($typ__["data"]['armylists']['username'])?$typ__["data"]['armylists']['username']:$typ__["data"]['armylists']['email']), array('controller' => 'users', 'action' => 'view', "params" => array($typ__["data"]['armylists']['users_id']), "admin" => true)); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('Created'); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]['armylists']['created']); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t('Modified'); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]['armylists']['modified']); ?></span>
	  		</div>
	  	</div>
	</div>
</div>