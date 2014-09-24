<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t("Unit Types"), array("action" => "index", "admin" => true)); ?> - <?php echo $typ__["data"]["unittypes"]["name"]; ?></h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
	  	<div class="panel-heading">
	  		<?php echo $this->Html->__t("UnitTypes view"); ?>
	  		<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("action" => "edit", "admin" => true, "params" => array($typ__["data"]["unittypes"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "action" => "delete", "params" => array($typ__["data"]["unittypes"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
	  		</span>
	  	</div>
	  	<div class="panel-body">
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Name"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["unittypes"]["name"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["unittypes"]["created"]); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["unittypes"]["modified"]); ?></span>
	  		</div>
	  	</div>
	</div>
</div>

<div class="related">
	<h3><?php echo $this->Html->__t('Related Units');?></h3>
	<?php if (!empty($typ__["data"]["unittypes"]["units"])){ ?>
	<table class="table table-striped table-bordered table-listings">
	<tr>
		<!--th><?php echo $this->Html->__t('Name'); ?></th-->
		<th><?php echo $this->Html->__t('Created'); ?></th>
		<th><?php echo $this->Html->__t('Modified'); ?></th>
		<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
	</tr>
	<?php
		foreach ($typ__["data"]["unittypes"]["units"] as $units){ ?>
		<tr>
			<!--td><?php echo $units['name'];?></td-->
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