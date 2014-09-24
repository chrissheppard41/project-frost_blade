<?php ?>
<div class="page-header">
	<h1><?php echo $this->Html->__t('Types'); ?></h1>
</div>
<div class="Types index">
	<p class="pull-right">
        <?php echo $this->Html->Url($this->Html->__t('Add'), array('action' => 'add', "admin" => true), array('class' => 'btn btn-success')); ?>
    </p>
    <?php if(!empty($typ__['data']['types'])) { ?>
	<table class="table table-striped table-bordered table-listings">
		<thead>
			<tr>
				<th><?php echo $this->Html->Pag_Sort('name');?></th>
				<th><?php echo $this->Html->Pag_Sort('created');?></th>
				<th><?php echo $this->Html->Pag_Sort('modified');?></th>
				<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
			</tr>
		</thead>
		<tbody>
			<?php foreach ($typ__['data']["types"] as $type){ ?>
			<tr id="armyLists-<?php echo $type['id']; ?>" data-id="<?php echo $type['id']; ?>">
				<td><?php echo $type['name']; ?></td>
				<td><?php echo $this->Html->Time("TimeAgo", $type['created']); ?></td>
				<td><?php echo $this->Html->Time("TimeAgo", $type['modified']); ?></td>
				<td class="actions">
					<?php echo $this->Html->Url($this->Html->__t('View'), array('admin' => true, 'action' => 'view', 'params' => array($type['id'])), array('class' => 'btn-sm btn-primary')); ?>
					<?php echo $this->Html->Url($this->Html->__t('Edit'), array('admin' => true, 'action' => 'edit', 'params' => array($type['id'])), array('class' => 'btn-sm btn-warning')); ?>
					<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('admin' => true, 'action' => 'delete', 'params' => array($type['id'])), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
				</td>
			</tr>
			<?php } ?>
		</tbody>
	</table>
    <?php } else { ?>
        <p>No <?php echo $this->Html->__t('Types');?> available, why not <?php echo $this->Html->Url($this->Html->__t('create one'), array('action' => 'add', "admin" => true)); ?>
</p>
    <?php } ?>
    <?php echo $this->Html->Pagination("users", 10); ?>
</div>
