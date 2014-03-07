<?php

//Configure::pre($typ__passed_params);

?>
<div class="users overview">
    <h2><?php echo $this->Html->__t('Welcome'); ?> <?php echo \Configure::User('username'); ?></h2>

    <div class="row">
        <div class="span6">
            <h3><?php echo $this->Html->__t('Popular content'); ?></h3>
            <div class="well">
            ...
            </div>
        </div>
        <div class="span6">
            <h3><?php echo $this->Html->__t('Recent news'); ?></h3>
            <div class="well">
            ...
            </div>
        </div>
    </div>
</div>