<div class="page-header">
	<h1><?php echo $this->Html->link(__('Army Lists'), array('action' => 'index')); ?> - Admin Add</h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Form->create('ArmyList');
		echo $this->Form->input('name', array('label' => 'Name'));
		echo $this->Form->input('descr', array('label' => 'Description'));
		echo $this->Form->input('point_limit', array('label' => 'Point Limit'));
		echo $this->Form->input('hide', array('label' => 'Hide', 'type' => 'checkbox'));
		echo $this->Form->input('races_id', array('label' => 'Race'));
		echo $this->Form->input('users_id', array('label' => 'Username'));
		echo $this->Form->submit(__('Save'));
		echo $this->Form->end();
	?>
</div>