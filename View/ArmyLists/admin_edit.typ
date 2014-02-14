<div class="page-header">
	<h1><?php echo $this->Html->link(__('Army Lists'), array('action' => 'index')); ?> - Admin Edit</h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Form->create('ArmyList');
		//echo $this->Form->input('id');
		echo $this->Form->input('name', array('label' => 'Name'));
		echo $this->Form->input('descr', array('label' => 'Description'));
		echo $this->Form->input('point_limit', array('label' => 'Point limit'));
		echo $this->Form->input('hide', array('label' => 'Hide'));
		echo $this->Form->input('races_id', array('label' => 'Race'));
		echo $this->Form->input('users_id', array('label' => 'Username'));
		echo $this->Form->submit(__('Save'));
		echo $this->Form->end();
	?>
</div>