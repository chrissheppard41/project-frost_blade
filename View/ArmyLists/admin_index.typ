<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->__t('Army Lists'); ?></h1>
</div>
<div class="armyLists index">
	<p class="pull-right">
        <?php echo $this->Html->Url($this->Html->__t('Add'), array('action' => 'add', "admin" => true), array('class' => 'btn btn-success')); ?>
    </p>
    <?php if(!empty($typ__['data']['armylists'])) { ?>
	<table class="table table-striped table-bordered table-listings">
		<thead>
			<tr>
				<th><?php echo $this->Html->Pag_Sort('name');?></th>
				<th><?php echo $this->Html->Pag_Sort('point_limit');?></th>
				<th><?php echo $this->Html->Pag_Sort('hide');?></th>
				<th><?php echo $this->Html->Pag_Sort("Army type", 'armies_id');?></th>
				<th><?php echo $this->Html->Pag_Sort("Username", 'users_id');?></th>
				<th><?php echo $this->Html->Pag_Sort('created');?></th>
				<th><?php echo $this->Html->Pag_Sort('modified');?></th>
				<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
			</tr>
		</thead>
		<tbody>
			<?php foreach ($typ__['data']['armylists'] as $armyList){ ?>
			<tr id="armyLists-<?php echo $armyList['id']; ?>" data-id="<?php echo $armyList['id']; ?>">
				<td><?php echo $armyList['name']; ?></td>
				<td><?php echo $armyList['point_limit']; ?></td>
				<td><?php echo ($armyList['hide'])?"Private":"Public"; ?></td>
				<td><?php echo $this->Html->Url($armyList['army_name'], array('controller' => 'armies', 'action' => 'view', "params" => array($armyList['armies_id']), "admin" => true)); ?></td>
				<td><?php echo $this->Html->Url($armyList['username'], array('controller' => 'users', 'action' => 'view', "params" => array($armyList['users_id']), "admin" => true)); ?></td>
				<td><?php echo $this->Html->Time("TimeAgo", $armyList['created']); ?></td>
				<td><?php echo $this->Html->Time("TimeAgo", $armyList['modified']); ?></td>
				<td class="actions">
					<?php echo $this->Html->Url($this->Html->__t('View'), array('action' => 'view', "params" => array($armyList['id']), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
					<?php echo $this->Html->Url($this->Html->__t('Edit'), array('action' => 'edit', "params" => array($armyList['id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
					<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('action' => 'delete', "params" => array($armyList['id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
				</td>
			</tr>
			<?php } ?>
		</tbody>
	</table>
    <?php } else { ?>
        <p>No <?php echo $this->Html->__t('Army Lists');?> available, why not <?php echo $this->Html->Url($this->Html->__t('create one'), array('action' => 'add', "admin" => true)); ?>
</p>
    <?php } ?>
    <?php echo $this->Html->Pagination("users", 10); ?>
</div>
