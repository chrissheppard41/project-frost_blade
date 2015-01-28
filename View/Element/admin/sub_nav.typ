<?php ?>
<ul class="nav nav-tabs" style="margin-top: 55px;">
	<li class="<?php echo $this->Html->Highlight('/^\/admin\/ArmyLists/'); ?>">
		<?php echo $this->Html->Url('Army Lists', array('controller' => 'ArmyLists', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
	</li>
	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#">
			Static views <span class="caret"></span>
		</a>
		<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Types/'); ?>">
				<?php echo $this->Html->Url('Types', array('controller' => 'Types', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/UnitTypes/'); ?>">
				<?php echo $this->Html->Url('Unit Types', array('controller' => 'UnitTypes', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Enhancements/'); ?>">
				<?php echo $this->Html->Url('Enhancements', array('controller' => 'Enhancements', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Operations/'); ?>">
				<?php echo $this->Html->Url('Operations', array('controller' => 'Operations', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Colours/'); ?>">
				<?php echo $this->Html->Url('Colours', array('controller' => 'Colours', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
		</ul>
	</li>

	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#">
			Race Control <span class="caret"></span>
		</a>
		<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Races/'); ?>">
				<?php echo $this->Html->Url('Races', array('controller' => 'Races', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Armies/'); ?>">
				<?php echo $this->Html->Url('Armies', array('controller' => 'Armies', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/ArmyCharacteristics/'); ?>">
				<?php echo $this->Html->Url('Army characteristics', array('controller' => 'ArmyCharacteristics', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
		</ul>
	</li>

	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#">
			Squad management <span class="caret"></span>
		</a>
		<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Squads/'); ?>">
				<?php echo $this->Html->Url('Squads', array('controller' => 'Squads', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Units/'); ?>">
				<?php echo $this->Html->Url('Units', array('controller' => 'Units', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
		</ul>
	</li>

	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#">
			Unit management <span class="caret"></span>
		</a>
		<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/UnitCharacteristics/'); ?>">
				<?php echo $this->Html->Url('Characteristics', array('controller' => 'UnitCharacteristics', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Psykers/'); ?>">
				<?php echo $this->Html->Url('Psykers', array('controller' => 'Psykers', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Relics/'); ?>">
				<?php echo $this->Html->Url('Race Relics', array('controller' => 'Relics', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Warlords/'); ?>">
				<?php echo $this->Html->Url('Warlord traits', array('controller' => 'Warlords', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Transports/'); ?>">
				<?php echo $this->Html->Url('Transport capacity', array('controller' => 'Transports', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
		</ul>
	</li>

	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#">
			Wargear management <span class="caret"></span>
		</a>
		<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Wargears/'); ?>">
				<?php echo $this->Html->Url('Wargear', array('controller' => 'Wargears', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/Groups/'); ?>">
				<?php echo $this->Html->Url('Groups', array('controller' => 'Groups', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
		</ul>

	</li>

</ul>