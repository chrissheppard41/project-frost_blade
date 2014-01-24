<?php

//Configure::pre($typ__passed_params);

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
            <th class="header"><?php echo $this->Html->Pag_Sort('username'); ?></th>
            <th class="header"><?php echo $this->Html->Pag_Sort('email'); ?></th>
            <th class="header"><?php echo $this->Html->Pag_Sort('email_verified'); ?></th>
            <th class="header"><?php echo $this->Html->Pag_Sort('active'); ?></th>
            <th class="header"><?php echo $this->Html->Pag_Sort('created'); ?></th>
            <th class="actions"><?php echo $this->Html->__t('users', 'Actions'); ?></th>
        </tr>
            <?php foreach ($typ__passed_params['data']['Users'] as $user){ ?>
            <tr>
                <td>
                    <?php echo $user['username']; ?>
                </td>
                <td>
                    <?php echo $user['email']; ?>
                </td>
                <td>
                    <?php echo $user['email_verified'] == 1 ? $this->Html->__t('users', 'Yes') : $this->Html->__t('users', 'No'); ?>
                </td>
                <td>
                    <?php echo $user['is_admin'] == 1 ? $this->Html->__t('users', 'Yes') : $this->Html->__t('users', 'No'); ?>
                </td>
                <td>
                    <?php echo $this->Html->Time("TimeAgo", $user['created']); ?>
                </td>
                <td class="actions">
                    <?php echo $this->Html->Url($this->Html->__t('users', 'View'), array('admin' => true, 'controller' => 'users', 'action'=>'view', 'params' => array($user['id'])), array('class' => 'btn-sm btn-primary')); ?>
                    <?php echo $this->Html->Url($this->Html->__t('users', 'Edit'), array('admin' => true, 'controller' => 'users', 'action'=>'edit', 'params' => array($user['id'])), array('class' => 'btn-sm btn-warning')); ?>
                    <?php echo $this->Html->UrlPost($this->Html->__t('users', 'Delete'), array('admin' => true, 'controller' => 'users', 'action'=>'delete', 'params' => array($user['id'])), array('class' => 'btn-sm btn-danger')); ?>
                </td>
            </tr>
        <?php } ?>
    </table>
    <?php echo $this->Html->Pagination("users", 5); ?>
</div>