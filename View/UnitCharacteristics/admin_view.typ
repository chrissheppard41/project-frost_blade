<?php
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t("Unit Characteristics"), array("action" => "index", "admin" => true)); ?> - <?php echo $typ__["data"]["unitcharacteristics"]["name"]; ?></h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
	  	<div class="panel-heading">
	  		<?php echo $this->Html->__t("Unit Characteristics view"); ?>
	  		<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("action" => "edit", "admin" => true, "params" => array($typ__["data"]["unitcharacteristics"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "action" => "delete", "params" => array($typ__["data"]["unitcharacteristics"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
	  		</span>
	  	</div>
	  	<div class="panel-body">
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Name"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["unitcharacteristics"]["name"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Army"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Url($typ__["data"]["unitcharacteristics"]["army_name"], array("controller" => "armies", "action" => "view", "admin" => true, "params" => array($typ__["data"]["unitcharacteristics"]["army_id"]))); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["unitcharacteristics"]["created"]); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["unitcharacteristics"]["modified"]); ?></span>
	  		</div>
	  	</div>
	</div>
</div>

<div class="related">
	<h3><?php echo $this->Html->__t('Related Unit');?></h3>
	<?php if (!empty($typ__["data"]["unitcharacteristics"]["units"])){ ?>
	<table class="table table-striped table-bordered table-listings">
	<tr>
		<th><?php echo $this->Html->__t('Name'); ?></th>
		<th><?php echo $this->Html->__t('Created'); ?></th>
		<th><?php echo $this->Html->__t('Modified'); ?></th>
		<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
	</tr>
	<?php
		foreach ($typ__["data"]["unitcharacteristics"]["units"] as $units){ ?>
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