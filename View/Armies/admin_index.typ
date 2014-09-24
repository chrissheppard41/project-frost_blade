<?php ?>
<div class="page-header">
	<h1><?php echo $this->Html->__t('Armies'); ?></h1>
</div>
<div class="Armies index">
	<p class="pull-right1">
        <?php if(!empty($typ__['data']["races"])) { ?>
			<?php foreach ($typ__['data']["races"] as $races){ ?>
				<?php echo $this->Html->Url($races["name"]." ".$this->Html->__t('add'), array('action' => 'add', "params" => array(0, $races["id"]), "admin" => true), array('class' => 'btn btn-success')); ?>
			<?php } ?>
		<?php } ?>
    </p>
    <?php if(!empty($typ__['data']["armies"])) { ?>
	<table class="table table-striped table-bordered table-listings">
		<thead>
			<tr>
				<th><?php echo $this->Html->Pag_Sort('name');?></th>
				<th><?php echo $this->Html->Pag_Sort('races');?></th>
				<th><?php echo $this->Html->Pag_Sort('colours_id');?></th>
				<th><?php echo $this->Html->Pag_Sort('created');?></th>
				<th><?php echo $this->Html->Pag_Sort('modified');?></th>
				<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
			</tr>
		</thead>
		<tbody>
			<?php foreach ($typ__['data']["armies"] as $army){ ?>
			<tr id="armyLists-<?php echo $army['id']; ?>" data-id="<?php echo $army['id']; ?>">
				<td><?php echo $army['name']; ?></td>
				<td><?php echo $this->Html->Url($army['races_name'], array('controller' => 'races', 'action' => 'view', "params" => array($army['races_id']), "admin" => true)); ?></td>
				<td><?php echo $this->Html->Url($army['colours_name'], array('controller' => 'colours', 'action' => 'view', "params" => array($army['colours_id']), "admin" => true)); ?></td>
				<td><?php echo $this->Html->Time("TimeAgo", $army['created']); ?></td>
				<td><?php echo $this->Html->Time("TimeAgo", $army['modified']); ?></td>
				<td class="actions">
					<?php echo $this->Html->Url($this->Html->__t('View'), array('admin' => true, 'action' => 'view', 'params' => array($army['id'])), array('class' => 'btn-sm btn-primary')); ?>
					<?php echo $this->Html->Url($this->Html->__t('Edit'), array('admin' => true, 'action' => 'edit', 'params' => array($army['id'])), array('class' => 'btn-sm btn-warning')); ?>
					<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('admin' => true, 'action' => 'delete', 'params' => array($army['id'])), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
				</td>
			</tr>
			<?php } ?>
		</tbody>
	</table>
    <?php } else { ?>
        <p>No <?php echo $this->Html->__t('Armies');?> available, why not <?php echo $this->Html->Url($this->Html->__t('create one'), array('action' => 'add', "admin" => true)); ?>
</p>
    <?php } ?>
    <?php echo $this->Html->Pagination("users", 10); ?>
</div>
