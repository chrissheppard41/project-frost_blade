<?php

print_r($typ__passed_params);

?>

<div class="users index">
    <div class="row">
        <h2 class="col-md-11"><?php echo $this->Html->__t('users', 'Users'); ?></h2>
        <div class="col-md-1 pull-right text-right">
            <?php echo $this->Html->Url($this->Html->__t('users', 'Add'), array('controller' => 'users', 'action' => 'add', 'admin' => true), array('class' => 'btn btn-success icon icon-add')); ?>
        </div>
    </div>
    <table class="table table-striped table-bordered">
        <tr>
            <th class="header"><?php //echo $this->Paginator->sort('username'); ?></th>
            <th class="header"><?php //echo $this->Paginator->sort('email'); ?></th>
            <th class="header"><?php //echo $this->Paginator->sort('email_verified'); ?></th>
            <th class="header"><?php //echo $this->Paginator->sort('active'); ?></th>
            <th class="header"><?php //echo $this->Paginator->sort('created'); ?></th>
            <th class="actions"><?php //echo $this->Html->__t('users', 'Actions'); ?></th>
        </tr>
            <?php //foreach ($users as $user){ ?>
            <tr>
                <td>
                    <?php //echo $user[$model]['username']; ?>
                </td>
                <td>
                    <?php //echo $user[$model]['email']; ?>
                </td>
                <td>
                    <?php //echo $user[$model]['email_verified'] == 1 ? $this->Html->__t('users', 'Yes') : $this->Html->__t('users', 'No'); ?>
                </td>
                <td>
                    <?php //echo $user[$model]['active'] == 1 ? $this->Html->__t('users', 'Yes') : $this->Html->__t('users', 'No'); ?>
                </td>
                <td>
                    <?php //echo $this->Time->timeAgoInWords($user[$model]['created']); ?>
                </td>
                <td class="actions">
                    <?php //echo $this->Html->link($this->Html->__t('users', 'View'), array('admin' => true, 'plugin' => 'users', 'controller' => 'users', 'action'=>'view', $user[$model]['id'])); ?>
                    <?php //echo $this->Html->link($this->Html->__t('users', 'Edit'), array('action'=>'edit', $user[$model]['id'])); ?>
                    <?php //echo $this->Html->link($this->Html->__t('users', 'Delete'), array('action'=>'delete', $user[$model]['id']), null, sprintf($this->Html->__t('users', 'Are you sure you want to delete # %s?'), $user[$model]['id'])); ?>
                </td>
            </tr>
        <?php //} ?>
    </table>
    <?php //echo $this->element('pagination'); ?>
</div>