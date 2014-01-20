<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">

                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                </button>

                <a class="navbar-brand" href="/"><?php //echo Configure::read('Company.name');?></a>

                <div class="nav-collapse navbar-responsive-collapse">
                        <ul class="nav navbar-nav">
                                <li class="<?php echo $this->Html->Highlight('/^\/admin$/'); ?>">
                                        <?php echo $this->Html->Url('Home', array('controller' => 'users', 'action' => 'dashboard', 'admin' => true), array('class' => 'icon icon-home')); ?>
                                </li>
                                <li class="<?php echo $this->Html->Highlight('/^\/admin\/users/'); ?>">
                                        <?php echo $this->Html->Url('Users', array('plugin' => 'users', 'controller' => 'users', 'action' => 'index', 'admin' => true), array('class' => 'icon icon-users-alt')); ?>
                                </li>
                        </ul>


                        <?php if (/*$this->Session->check('Auth.User.id')*/true) { ?>
                        <ul class="nav navbar-nav pull-right">
                                <li class="dropdown">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                                <span class="glyphicon glyphicon-star"></span>
                                                Account <span class="caret"></span>
                                        </a>
                                        <ul class="dropdown-menu">
                                                <li><?php echo $this->Html->Url('Edit', array('plugin' => 'users', 'controller' => 'users', 'action' => 'edit'), array('class' => 'icon icon-edit')); ?></li>
                                                <li><?php echo $this->Html->Url('Logout', array('plugin' => 'users', 'controller' => 'users', 'action' => 'logout'), array('class' => 'icon icon-logout')); ?></li>
                                        </ul>
                                </li>
                        </ul>
                        <?php } ?>
                </div>
        </div>
</nav>