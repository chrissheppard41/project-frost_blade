<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t("Groups"), array("action" => "index", "admin" => true)); ?> - <?php echo $typ__["data"]["groups"]["name"]; ?></h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
		<div class="panel-heading">
			<?php echo $this->Html->__t("Groups view"); ?>
			<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("action" => "edit", "admin" => true, "params" => array($typ__["data"]["groups"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "action" => "delete", "params" => array($typ__["data"]["groups"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
			</span>
		</div>
		<div class="panel-body">
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Name"); ?></span>
				<span class="col-md-9"><?php echo $typ__["data"]["groups"]["name"]; ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Army"); ?></span>
				<span class="col-md-9"><?php echo $this->Html->Url($typ__["data"]["groups"]["army_name"], array("controller" => "armies", "action" => "view", "admin" => true, "params" => array($typ__["data"]["groups"]["army_id"]))); ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
				<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["groups"]["created"]); ?></span>
			</div>
			<div class="row">
				<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
				<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["groups"]["modified"]); ?></span>
			</div>
		</div>
	</div>
</div>

<div class="related">
	<h3>
		<?php echo $this->Html->__t('Related Wargears');?>
		<p class="pull-right">
			<?php echo $this->Html->Url($this->Html->__t('Add'), array('controller' => 'wargears', 'action' => 'add', "params" => array($typ__["data"]["groups"]["id"]), "admin" => true), array('class' => 'btn btn-success')); ?>
		</p>
	</h3>
	<?php if (!empty($typ__["data"]["groups"]["wargears"])){ ?>
	<table class="table table-striped table-bordered table-listings">
	<tr>
		<th><?php echo $this->Html->__t('Name'); ?></th>
		<th><?php echo $this->Html->__t('Pts'); ?></th>
		<th><?php echo $this->Html->__t('Created'); ?></th>
		<th><?php echo $this->Html->__t('Modified'); ?></th>
		<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
	</tr>
	<?php
		foreach ($typ__["data"]["groups"]["wargears"] as $wargears){ ?>
		<tr>
			<td><?php echo $wargears['name'];?></td>
			<td><?php echo $wargears['pts'];?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $wargears['created']);?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $wargears['modified']);?></td>
			<td class="actions">
				<?php echo $this->Html->Url($this->Html->__t('Set points'), array('controller' => 'wargearGroups', 'action' => 'edit', "params" => array($wargears['wargeargroups_id'], $typ__["data"]["groups"]["id"]), "admin" => true), array('class' => 'btn-sm btn-info')); ?>
				<?php echo $this->Html->Url($this->Html->__t('View'), array('controller' => 'wargears', 'action' => 'view', "params" => array($wargears['id']), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
				<?php echo $this->Html->Url($this->Html->__t('Edit'), array('controller' => 'wargears', 'action' => 'edit', "params" => array($wargears['id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('controller' => 'wargears', 'action' => 'delete', "params" => array($wargears['id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
			</td>
		</tr>
	<?php } ?>
	</table>
<?php } ?>

</div>


<div class="related">
	<h3><?php echo $this->Html->__t('Related Squads');?></h3>
	<?php if (!empty($typ__["data"]["Groups"]["SquadUnits"])){ ?>
	<table class="table table-striped table-bordered table-listings">
	<tr>
		<th><?php echo $this->Html->__t('Name'); ?></th>
		<th><?php echo $this->Html->__t('Created'); ?></th>
		<th><?php echo $this->Html->__t('Modified'); ?></th>
		<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
	</tr>
	<?php
		foreach ($typ__["data"]["Groups"]["SquadUnits"] as $squadunit){ ?>
		<tr>
			<td><?php echo $squadunit['name'];?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $squadunit['created']);?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $squadunit['modified']);?></td>
			<td class="actions">
				<?php echo $this->Html->Url($this->Html->__t('View'), array('controller' => 'squads', 'action' => 'view', "params" => array($squadunit['squads_id']), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
				<?php echo $this->Html->Url($this->Html->__t('Edit'), array('controller' => 'squads', 'action' => 'edit', "params" => array($squadunit['squads_id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('controller' => 'squads', 'action' => 'delete', "params" => array($squadunit['squads_id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
			</td>
		</tr>
	<?php } ?>
	</table>
<?php } ?>

</div>