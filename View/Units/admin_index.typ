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
			<?php foreach ($typ__['data']["Units"] as $race){ ?>
			<tr id="armyLists-<?php echo $race['id']; ?>" data-id="<?php echo $race['id']; ?>">
				<td><?php echo $race['name']; ?></td>

				<td><?php echo $race['weapon_skill']; ?></td>
				<td><?php echo $race['ballistic_skill']; ?></td>
				<td><?php echo $race['strength']; ?></td>
				<td><?php echo $race['toughness']; ?></td>
				<td><?php echo $race['initiative']; ?></td>
				<td><?php echo $race['wounds']; ?></td>
				<td><?php echo $race['attacks']; ?></td>
				<td><?php echo $race['leadership']; ?></td>
				<td><?php echo $race['armour_save']; ?></td>
				<td><?php echo $race['invulnerable_save']; ?></td>
				<td><?php echo $race['pts']; ?></td>

				<td><?php echo $this->Html->Time("TimeAgo", $race['created']); ?></td>
				<td><?php echo $this->Html->Time("TimeAgo", $race['modified']); ?></td>
				<td class="actions">
					<?php echo $this->Html->Url($this->Html->__t('View'), array('admin' => true, 'action' => 'view', 'params' => array($race['id'])), array('class' => 'btn-sm btn-primary')); ?>
					<?php echo $this->Html->Url($this->Html->__t('Edit'), array('admin' => true, 'action' => 'edit', 'params' => array($race['id'])), array('class' => 'btn-sm btn-warning')); ?>
					<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('admin' => true, 'action' => 'delete', 'params' => array($race['id'])), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
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
