<?php ?>
<div class="page-header">
	<h1><?php echo $this->Html->__t('Groups'); ?></h1>
</div>
<div class="Groups index">
	<p class="pull-right">
        <?php echo $this->Html->Url($this->Html->__t('Add'), array('action' => 'add', "admin" => true), array('class' => 'btn btn-success')); ?>
    </p>
    <?php if(!empty($typ__['data']['Groups'])) { ?>
	<table class="table table-striped table-bordered table-listings">
		<thead>
			<tr>
				<th><?php echo $this->Html->Pag_Sort('name');?></th>
				<th><?php echo $this->Html->Pag_Sort('armies');?></th>
				<th><?php echo $this->Html->Pag_Sort('created');?></th>
				<th><?php echo $this->Html->Pag_Sort('modified');?></th>
				<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
			</tr>
		</thead>
		<tbody>
			<?php foreach ($typ__['data']["Groups"] as $group){ ?>
			<tr id="armyLists-<?php echo $group['id']; ?>" data-id="<?php echo $group['id']; ?>">
				<td><?php echo $group['name']; ?></td>
				<td><?php echo $this->Html->Url($group["army_name"], array("controller" => "armies", "action" => "view", "admin" => true, "params" => array($group["army_id"]))); ?></td>
				<td><?php echo $this->Html->Time("TimeAgo", $group['created']); ?></td>
				<td><?php echo $this->Html->Time("TimeAgo", $group['modified']); ?></td>
				<td class="actions">
					<?php echo $this->Html->Url($this->Html->__t('View'), array('admin' => true, 'action' => 'view', 'params' => array($group['id'])), array('class' => 'btn-sm btn-primary')); ?>
					<?php echo $this->Html->Url($this->Html->__t('Edit'), array('admin' => true, 'action' => 'edit', 'params' => array($group['id'])), array('class' => 'btn-sm btn-warning')); ?>
					<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('admin' => true, 'action' => 'delete', 'params' => array($group['id'])), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
				</td>
			</tr>
			<?php } ?>
		</tbody>
	</table>
    <?php } else { ?>
        <p>No <?php echo $this->Html->__t('Groups');?> available, why not <?php echo $this->Html->Url($this->Html->__t('create one'), array('action' => 'add', "admin" => true)); ?>
</p>
    <?php } ?>
    <?php echo $this->Html->Pagination("groups", 10); ?>
</div>
