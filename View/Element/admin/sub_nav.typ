<?php ?>
<ul class="nav nav-tabs">
        <li class="<?php echo $this->Html->Highlight('/^\/admin\/ArmyLists/'); ?>">
                <?php echo $this->Html->Url('Army Lists', array('plugin' => false, 'controller' => 'ArmyLists', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
        </li>
        <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        Static views <span class="caret"></span>
                </a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
                        <li class="<?php echo $this->Html->Highlight('/^\/admin\/types/'); ?>">
                                <?php echo $this->Html->Url('Types', array('plugin' => false, 'controller' => 'types', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
                        </li>
                        <li class="<?php echo $this->Html->Highlight('/^\/admin\/unitTypes/'); ?>">
                                <?php echo $this->Html->Url('Unit Types', array('plugin' => false, 'controller' => 'unitTypes', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
                        </li>
                        <li class="<?php echo $this->Html->Highlight('/^\/admin\/enhancements/'); ?>">
                                <?php echo $this->Html->Url('Enhancements', array('plugin' => false, 'controller' => 'enhancements', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
                        </li>
                </ul>
        </li>

        <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        Race Control <span class="caret"></span>
                </a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
                        <li class="<?php echo $this->Html->Highlight('/^\/admin\/races/'); ?>">
                                <?php echo $this->Html->Url('Races', array('plugin' => false, 'controller' => 'races', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
                        </li>
                        <li class="<?php echo $this->Html->Highlight('/^\/admin\/RaceTypes/'); ?>">
                                <?php echo $this->Html->Url('Race Types', array('plugin' => false, 'controller' => 'RaceTypes', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
                        </li>
                </ul>
        </li>

        <li class="<?php echo $this->Html->Highlight('/^\/admin\/specialRules/'); ?>">
                <?php echo $this->Html->Url('Special Rules', array('plugin' => false, 'controller' => 'specialRules', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
        </li>

        <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        Additions <span class="caret"></span>
                </a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
                        <li class="<?php echo $this->Html->Highlight('/^\/admin\/groups/'); ?>">
                                <?php echo $this->Html->Url('Groups', array('plugin' => false, 'controller' => 'groups', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
                        </li>
                        <li class="<?php echo $this->Html->Highlight('/^\/admin\/options/'); ?>">
                                <?php echo $this->Html->Url('Options', array('plugin' => false, 'controller' => 'options', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
                        </li>
                        <li class="<?php echo $this->Html->Highlight('/^\/admin\/optionUpgrades/'); ?>">
                                <?php echo $this->Html->Url('Option Upgrades', array('plugin' => false, 'controller' => 'optionUpgrades', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
                        </li>
                </ul>
        </li>

        <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        Squad management <span class="caret"></span>
                </a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
                        <li class="<?php echo $this->Html->Highlight('/^\/admin\/squads/'); ?>">
                                <?php echo $this->Html->Url('Squads', array('plugin' => false, 'controller' => 'squads', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
                        </li>
                        <li class="<?php echo $this->Html->Highlight('/^\/admin\/units/'); ?>">
                                <?php echo $this->Html->Url('Units', array('plugin' => false, 'controller' => 'units', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt1')); ?>
                        </li>
                </ul>
        </li>

</ul>