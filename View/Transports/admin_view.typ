<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t("Transports capacity"), array("action" => "index", "admin" => true)); ?> - <?php echo $typ__["data"]["Transports"]["name"]; ?></h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
	  	<div class="panel-heading">
	  		<?php echo $this->Html->__t("Transports view"); ?>
	  		<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("action" => "edit", "admin" => true, "params" => array($typ__["data"]["Transports"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "action" => "delete", "params" => array($typ__["data"]["Transports"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
	  		</span>
	  	</div>
	  	<div class="panel-body">
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Name"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Transports"]["name"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Army"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Url($typ__["data"]["Transports"]["army_name"], array("controller" => "armies", "action" => "view", "admin" => true, "params" => array($typ__["data"]["Transports"]["army_id"]))); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["Transports"]["created"]); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["Transports"]["modified"]); ?></span>
	  		</div>
	  	</div>
	</div>
</div>


<div class="related">
	<div class="panel panel-info">
	  	<div class="panel-heading">
			<?php echo $this->Html->__t('Units Upgrades');?>
			<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Add"), array("controller" => "unitupgrades", "action" => "add", "admin" => true, "params" => array($typ__["data"]["Transports"]["id"])), array("class" => "btn-sm btn-success")); ?>
	  		</span>
	  	</div>
			<?php if (!empty($typ__["data"]["Transports"]["UnitUpgrades"])) { ?>
				<table class="table table-striped table-bordered table-listings">
				<tr>
					<th><?php echo $this->Html->__t('Enhancement', 'enhancements_id'); ?></th>
					<th><?php echo $this->Html->__t('Operation', 'operations_id'); ?></th>
					<th><?php echo $this->Html->__t('Factor'); ?></th>
					<th><?php echo $this->Html->__t('Created'); ?></th>
					<th><?php echo $this->Html->__t('Modified'); ?></th>
					<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
				</tr>
				<?php
					foreach ($typ__["data"]["Transports"]["UnitUpgrades"] as $unitupgrades){ ?>
					<tr>
						<td><?php echo $this->Html->Url($unitupgrades["enhancements_name"], array("controller" => "enhancements", "action" => "view", "admin" => true, "params" => array($unitupgrades["enhancements_id"]))); ?></td>
						<td><?php echo $this->Html->Url($unitupgrades["operations_name"], array("controller" => "enhancements", "action" => "view", "admin" => true, "params" => array($unitupgrades["operations_id"]))); ?></td>
						<td><?php echo $unitupgrades['factor']; ?></td>
						<td><?php echo $this->Html->Time("TimeAgo", $unitupgrades['created']);?></td>
						<td><?php echo $this->Html->Time("TimeAgo", $unitupgrades['modified']);?></td>
						<td class="actions">
							<?php echo $this->Html->Url($this->Html->__t('View'), array('controller' => 'unitupgrades', 'action' => 'view', "params" => array($unitupgrades['id'], $typ__["data"]["Transports"]["id"]), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
							<?php echo $this->Html->Url($this->Html->__t('Edit'), array('controller' => 'unitupgrades', 'action' => 'edit', "params" => array($unitupgrades['id'], $typ__["data"]["Transports"]["id"]), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
							<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('controller' => 'unitupgrades', 'action' => 'delete', "params" => array($unitupgrades['id'], $typ__["data"]["Transports"]["id"]), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
						</td>
					</tr>
				<?php } ?>
				</table>
			<?php } ?>
	</div>
</div>

<div class="related">
	<h3><?php echo $this->Html->__t('Related Units');?></h3>
	<?php if (!empty($typ__["data"]["Transports"]["Units"])){ ?>
	<table class="table table-striped table-bordered table-listings">
	<tr>
		<th><?php echo $this->Html->__t('Name'); ?></th>
		<th><?php echo $this->Html->__t('Created'); ?></th>
		<th><?php echo $this->Html->__t('Modified'); ?></th>
		<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
	</tr>
	<?php
		foreach ($typ__["data"]["Transports"]["Units"] as $units){ ?>
		<tr>
			<td><?php echo $units['name'];?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $units['created']);?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $units['modified']);?></td>
			<td class="actions">
				<?php echo $this->Html->Url($this->Html->__t('View'), array('controller' => 'units', 'action' => 'view', "params" => array($units['id']), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
				<?php echo $this->Html->Url($this->Html->__t('Edit'), array('controller' => 'units', 'action' => 'edit', "params" => array($units['id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('controller' => 'units', 'action' => 'delete', "params" => array($units['id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
			</td>
		</tr>
	<?php } ?>
	</table>
<?php } ?>

</div>

<div class="related">
	<h3><?php echo $this->Html->__t('Related Groups');?></h3>
	<?php if (!empty($typ__["data"]["Transports"]["Groups"])){ ?>
	<table class="table table-striped table-bordered table-listings">
	<tr>
		<th><?php echo $this->Html->__t('Name'); ?></th>
		<th><?php echo $this->Html->__t('Created'); ?></th>
		<th><?php echo $this->Html->__t('Modified'); ?></th>
		<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
	</tr>
	<?php
		foreach ($typ__["data"]["Transports"]["Groups"] as $units){ ?>
		<tr>
			<td><?php echo $units['name'];?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $units['created']);?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $units['modified']);?></td>
			<td class="actions">
				<?php echo $this->Html->Url($this->Html->__t('View'), array('controller' => 'groups', 'action' => 'view', "params" => array($units['id']), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
				<?php echo $this->Html->Url($this->Html->__t('Edit'), array('controller' => 'groups', 'action' => 'edit', "params" => array($units['id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('controller' => 'groups', 'action' => 'delete', "params" => array($units['id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
			</td>
		</tr>
	<?php } ?>
	</table>
<?php } ?>

</div>