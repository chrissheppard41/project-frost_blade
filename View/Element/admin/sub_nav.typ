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
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/types/'); ?>">
				<?php echo $this->Html->Url('Types', array('controller' => 'types', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/unitTypes/'); ?>">
				<?php echo $this->Html->Url('Unit Types', array('controller' => 'unitTypes', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/enhancements/'); ?>">
				<?php echo $this->Html->Url('Enhancements', array('controller' => 'enhancements', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/operations/'); ?>">
				<?php echo $this->Html->Url('Operations', array('controller' => 'operations', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/colours/'); ?>">
				<?php echo $this->Html->Url('Colours', array('controller' => 'colours', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
		</ul>
	</li>

	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#">
			Race Control <span class="caret"></span>
		</a>
		<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/races/'); ?>">
				<?php echo $this->Html->Url('Races', array('controller' => 'races', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/armies/'); ?>">
				<?php echo $this->Html->Url('Armies', array('controller' => 'armies', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/armycharacteristics/'); ?>">
				<?php echo $this->Html->Url('Army characteristics', array('controller' => 'armycharacteristics', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
		</ul>
	</li>

	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#">
			Squad management <span class="caret"></span>
		</a>
		<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/squads/'); ?>">
				<?php echo $this->Html->Url('Squads', array('controller' => 'squads', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/units/'); ?>">
				<?php echo $this->Html->Url('Units', array('controller' => 'units', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
		</ul>
	</li>

	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#">
			Unit management <span class="caret"></span>
		</a>
		<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/unitcharacteristics/'); ?>">
				<?php echo $this->Html->Url('Characteristics', array('controller' => 'unitcharacteristics', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
		</ul>
	</li>

	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#">
			Wargear management <span class="caret"></span>
		</a>
		<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/wargears/'); ?>">
				<?php echo $this->Html->Url('Wargear', array('controller' => 'wargears', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
			<li class="<?php echo $this->Html->Highlight('/^\/admin\/groups/'); ?>">
				<?php echo $this->Html->Url('Groups', array('controller' => 'groups', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
			</li>
		</ul>

	</li>

</ul>