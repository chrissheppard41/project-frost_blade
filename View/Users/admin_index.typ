<?php

//Configure::pre($typ__passed_params);

?>
<div class="page-header">
    <h1><?php echo $this->Html->__t('Users'); ?></h1>
</div>
<div class="users index">
    <p class="pull-right">
        <?php echo $this->Html->Url($this->Html->__t('Add'), array('controller' => 'users', 'action' => 'add', 'admin' => true), array('class' => 'btn btn-success icon icon-add')); ?>
    </p>
    <table class="table table-striped table-bordered">
        <tr>
            <th class="header"><?php echo $this->Html->Pag_Sort('username'); ?></th>
            <th class="header"><?php echo $this->Html->Pag_Sort('email'); ?></th>
            <th class="header"><?php echo $this->Html->Pag_Sort('email_verified'); ?></th>
            <th class="header"><?php echo $this->Html->Pag_Sort('active'); ?></th>
            <th class="header"><?php echo $this->Html->Pag_Sort('created'); ?></th>
            <th class="header"><?php echo $this->Html->Pag_Sort('modified'); ?></th>
            <th class="actions"><?php echo $this->Html->__t('Actions'); ?></th>
        </tr>
            <?php foreach ($typ__['data']['users'] as $user){ ?>
            <tr>
                <td>
                    <?php echo $user['username']; ?>
                </td>
                <td>
                    <?php echo $user['email']; ?>
                </td>
                <td>
                    <?php echo $user['email_verified'] == 1 ? $this->Html->__t('Yes') : $this->Html->__t('No'); ?>
                </td>
                <td>
                    <?php echo $user['is_admin'] == 1 ? $this->Html->__t('Yes') : $this->Html->__t('No'); ?>
                </td>
                <td>
                    <?php echo $this->Html->Time("TimeAgo", $user['created']); ?>
                </td>
                <td>
                    <?php echo $this->Html->Time("TimeAgo", $user['modified']); ?>
                </td>
                <td class="actions">
                    <?php echo $this->Html->Url($this->Html->__t('View'), array('admin' => true, 'controller' => 'users', 'action'=>'view', 'params' => array($user['id'])), array('class' => 'btn-sm btn-primary')); ?>
                    <?php echo $this->Html->Url($this->Html->__t('Edit'), array('admin' => true, 'controller' => 'users', 'action'=>'edit', 'params' => array($user['id'])), array('class' => 'btn-sm btn-warning')); ?>
                    <?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('admin' => true, 'action' => 'delete', 'params' => array($user['id'])), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
                </td>
            </tr>
        <?php } ?>
    </table>
    <?php echo $this->Html->Pagination("users", 10); ?>
</div>