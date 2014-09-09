<?php ?>
<div class="page-header">
	<h1><?php echo $this->Html->__t('Relics'); ?></h1>
</div>
<div class="Relics index">
	<p class="pull-right1">
        <?php if(!empty($typ__['data']["Armies"])) { ?>
			<?php foreach ($typ__['data']["Armies"] as $armies){ ?>
				<?php echo $this->Html->Url($armies["name"]." ".$this->Html->__t('add'), array('action' => 'add', "params" => array(0, $armies["id"]), "admin" => true), array('class' => 'btn btn-success')); ?>
			<?php } ?>
		<?php } ?>
    </p>
    <?php if(!empty($typ__['data']['Relics'])) { ?>
	<table class="table table-striped table-bordered table-listings">
		<thead>
			<tr>
				<th><?php echo $this->Html->Pag_Sort('name');?></th>
				<!--th><?php //echo $this->Html->Pag_Sort('pts');?></th-->
				<th><?php echo $this->Html->Pag_Sort('army');?></th>
				<th><?php echo $this->Html->Pag_Sort('created');?></th>
				<th><?php echo $this->Html->Pag_Sort('modified');?></th>
				<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
			</tr>
		</thead>
		<tbody>
			<?php foreach ($typ__['data']["Relics"] as $wargear){ ?>
			<tr id="armyLists-<?php echo $wargear['id']; ?>" data-id="<?php echo $wargear['id']; ?>">
				<td><?php echo $wargear['name']; ?></td>
				<!--td><?php //echo $wargear['pts']; ?></td-->
				<td><?php echo $this->Html->Url($wargear["army_name"], array("controller" => "armies", "action" => "view", "admin" => true, "params" => array($wargear["army_id"]))); ?></td>
				<td><?php echo $this->Html->Time("TimeAgo", $wargear['created']); ?></td>
				<td><?php echo $this->Html->Time("TimeAgo", $wargear['modified']); ?></td>
				<td class="actions">
					<?php echo $this->Html->Url($this->Html->__t('View'), array('admin' => true, 'action' => 'view', 'params' => array($wargear['id'])), array('class' => 'btn-sm btn-primary')); ?>
					<?php echo $this->Html->Url($this->Html->__t('Edit'), array('admin' => true, 'action' => 'edit', 'params' => array($wargear['id'])), array('class' => 'btn-sm btn-warning')); ?>
					<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('admin' => true, 'action' => 'delete', 'params' => array($wargear['id'])), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
				</td>
			</tr>
			<?php } ?>
		</tbody>
	</table>
    <?php } else { ?>
        <p>No <?php echo $this->Html->__t('Relics');?> available, why not <?php echo $this->Html->Url($this->Html->__t('create one'), array('action' => 'add', "admin" => true)); ?>
</p>
    <?php } ?>
    <?php echo $this->Html->Pagination("Relics", 10); ?>
</div>
