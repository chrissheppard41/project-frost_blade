<?php ?>
<div class="page-header">
	<h1><?php echo $this->Html->__t('Units'); ?></h1>
</div>
<div class="Units index">
	<p class="pull-right">
        <?php echo $this->Html->Url($this->Html->__t('Add'), array('action' => 'add', "admin" => true), array('class' => 'btn btn-success')); ?>
    </p>
    <?php if(!empty($typ__['data']["Units"])) { ?>
	<table class="table table-striped table-bordered table-listings">
		<thead>
			<tr>
				<th><?php echo $this->Html->Pag_Sort('name');?></th>

				<th><?php echo $this->Html->Pag_Sort('WS'); ?></th>
				<th><?php echo $this->Html->Pag_Sort('BS'); ?></th>
				<th><?php echo $this->Html->Pag_Sort('S'); ?></th>
				<th><?php echo $this->Html->Pag_Sort('T'); ?></th>
				<th><?php echo $this->Html->Pag_Sort('I'); ?></th>
				<th><?php echo $this->Html->Pag_Sort('W'); ?></th>
				<th><?php echo $this->Html->Pag_Sort('A'); ?></th>
				<th><?php echo $this->Html->Pag_Sort('Ld'); ?></th>
				<th><?php echo $this->Html->Pag_Sort('S'); ?></th>
				<th><?php echo $this->Html->Pag_Sort('Is'); ?></th>
				<th><?php echo $this->Html->Pag_Sort('Pts'); ?></th>

				<th><?php echo $this->Html->Pag_Sort('created');?></th>
				<th><?php echo $this->Html->Pag_Sort('modified');?></th>
				<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
			</tr>
		</thead>
		<tbody>
			<?php foreach ($typ__['data']["Units"] as $unit){ ?>
			<tr id="armyLists-<?php echo $unit['id']; ?>" data-id="<?php echo $unit['id']; ?>">
				<td><?php echo $unit['name']; ?></td>

				<td><?php echo $unit['weapon_skill']; ?></td>
				<td><?php echo $unit['ballistic_skill']; ?></td>
				<td><?php echo $unit['strength']; ?></td>
				<td><?php echo $unit['toughness']; ?></td>
				<td><?php echo $unit['initiative']; ?></td>
				<td><?php echo $unit['wounds']; ?></td>
				<td><?php echo $unit['attacks']; ?></td>
				<td><?php echo $unit['leadership']; ?></td>
				<td><?php echo $unit['armour_save']; ?></td>
				<td><?php echo $unit['invulnerable_save']; ?></td>
				<td><?php echo $unit['pts']; ?></td>

				<td><?php echo $this->Html->Time("TimeAgo", $unit['created']); ?></td>
				<td><?php echo $this->Html->Time("TimeAgo", $unit['modified']); ?></td>
				<td class="actions">
					<?php echo $this->Html->Url($this->Html->__t('View'), array('admin' => true, 'action' => 'view', 'params' => array($unit['id'])), array('class' => 'btn-sm btn-primary')); ?>
					<?php echo $this->Html->Url($this->Html->__t('Edit'), array('admin' => true, 'action' => 'edit', 'params' => array($unit['id'])), array('class' => 'btn-sm btn-warning')); ?>
					<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('admin' => true, 'action' => 'delete', 'params' => array($unit['id'])), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
				</td>
			</tr>
			<?php } ?>
		</tbody>
	</table>
    <?php } else { ?>
        <p>No <?php echo $this->Html->__t('Units');?> available, why not <?php echo $this->Html->Url($this->Html->__t('create one'), array('action' => 'add', "admin" => true)); ?>
</p>
    <?php } ?>
    <?php echo $this->Html->Pagination("users", 10); ?>
</div>
