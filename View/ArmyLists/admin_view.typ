<div class="page-header">
	<h1><?php echo $this->Html->link(__('Army Lists'), array('action' => 'index')); ?> - <?php echo h($armyList['ArmyList']['name']); ?></h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
	  	<div class="panel-heading">
	  		<?php echo __('Army Lists view'); ?>
	  		<span class="pull-right">
				<?php echo $this->Html->link(__('Edit'), array('action' => 'edit', $armyList['ArmyList']['id']), array('class' => 'btn-sm btn-warning')); ?>
				<?php echo $this->Form->postLink(__('Delete'), array('controller' => 'squads', 'action' => 'delete', $armyList['ArmyList']['id']), array('class' => 'btn-sm btn-danger'), __('Are you sure you want to delete this record?')); ?>
	  		</span>
	  	</div>
	  	<div class="panel-body">
	  		<div class="row">
	  			<span class="col-md-3"><?php echo __('Id'); ?></span>
	  			<span class="col-md-9"><?php echo h($armyList['ArmyList']['id']); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo __('Name'); ?></span>
	  			<span class="col-md-9"><?php echo h($armyList['ArmyList']['name']); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo __('Description'); ?></span>
	  			<span class="col-md-9"><?php echo h($armyList['ArmyList']['descr']); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo __('Point Limit'); ?></span>
	  			<span class="col-md-9"><?php echo h($armyList['ArmyList']['point_limit']); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo __('Hidden'); ?></span>
	  			<span class="col-md-9"><?php echo h(($armyList['ArmyList']['hide'])?"Private":"Public"); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo __('Race'); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->link($armyList['Races']['name'], array('controller' => 'races', 'action' => 'view', $armyList['Races']['id'])); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo __('User'); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->link((($armyList['Users']['username'])?$armyList['Users']['username']:$armyList['Users']['email']), array('controller' => 'users', 'action' => 'view', $armyList['Users']['id'])); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo __('Created'); ?></span>
	  			<span class="col-md-9"><?php echo h($this->Time->timeAgoInWords($armyList['ArmyList']['created'])); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo __('Modified'); ?></span>
	  			<span class="col-md-9"><?php echo h($this->Time->timeAgoInWords($armyList['ArmyList']['modified'])); ?></span>
	  		</div>
	  	</div>
	</div>
</div>