<?php ?>
<div class="page-header">
	<h1><?php echo $this->Html->__t('Army Lists'); ?></h1>
</div>
<div class="armyLists index">
	<p class="pull-right">
        <?php echo $this->Html->Url($this->Html->__t('Add'), array('action' => 'add', "admin" => true), array('class' => 'btn btn-success')); ?>
    </p>
    <?php if(!empty($typ__['data'])) { ?>
	<table class="table table-striped table-bordered table-listings" data-sort-url="<?php echo Router::url(array('controller' => 'armyLists', 'action' => 'save_order')); ?>">
		<thead>
			<tr>
				<th><?php echo $this->Html->Pag_Sort('id');?></th>
				<th><?php echo $this->Html->Pag_Sort('name');?></th>
				<th><?php echo $this->Html->Pag_Sort('point_limit');?></th>
				<th><?php echo $this->Html->Pag_Sort('hide');?></th>
				<th><?php echo $this->Html->Pag_Sort('races_id');?></th>
				<th><?php echo $this->Html->Pag_Sort('users_id');?></th>
				<th><?php echo $this->Html->Pag_Sort('created');?></th>
				<th><?php echo $this->Html->Pag_Sort('modified');?></th>
				<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
			</tr>
		</thead>
		<tbody>
			<?php foreach ($typ__['data'] as $armyList){ ?>
			<tr id="armyLists-<?php echo $armyList['id']; ?>" data-id="<?php echo $armyList['id']; ?>">
				<td><?php echo h($armyList['id']); ?></td>
				<td><?php echo h($armyList['name']); ?></td>
				<td><?php echo h($armyList['point_limit']); ?></td>
				<td><?php echo h(($armyList['hide'])?"Private":"Public"); ?></td>
				<td><?php echo $this->Html->Url($armyList['Races']['name'], array('controller' => 'races', 'action' => 'view', $armyList['Races']['id'])); ?></td>
				<td><?php echo $this->Html->Url((($armyList['Users']['username'])?$armyList['Users']['username']:$armyList['Users']['email']), array('controller' => 'users', 'action' => 'view', $armyList['Users']['id'])); ?></td>
				<td><?php echo h($this->Time->timeAgoInWords($armyList['created'])); ?></td>
				<td><?php echo h($this->Time->timeAgoInWords($armyList['modified'])); ?></td>
				<td class="actions">
					<?php echo $this->Html->Url($this->Html->__t('View'), array('action' => 'view', $armyList['id']), array('class' => 'btn-sm btn-primary')); ?>
					<?php echo $this->Html->Url($this->Html->__t('Edit'), array('action' => 'edit', $armyList['id']), array('class' => 'btn-sm btn-warning')); ?>
					<?php echo $this->Form->UrlPost($this->Html->__t('Delete'), array('action' => 'delete', $armyList['id']), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
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
