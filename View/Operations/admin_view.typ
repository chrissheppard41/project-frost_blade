<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t("Operations"), array("action" => "index", "admin" => true)); ?> - <?php echo $typ__["data"]["operations"]["name"]; ?></h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
	  	<div class="panel-heading">
	  		<?php echo $this->Html->__t("Operations view"); ?>
	  		<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("action" => "edit", "admin" => true, "params" => array($typ__["data"]["operations"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "action" => "delete", "params" => array($typ__["data"]["operations"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
	  		</span>
	  	</div>
	  	<div class="panel-body">
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Name"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["operations"]["name"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Operation"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["operations"]["operation"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["operations"]["created"]); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["operations"]["modified"]); ?></span>
	  		</div>
	  	</div>
	</div>
</div>

<div class="related">
	<h3><?php echo $this->Html->__t('Related Armies');?></h3>
	<?php if (!empty($typ__["data"]["operations"]["armies"])){ ?>
	<table class="table table-striped table-bordered table-listings">
	<tr>
		<th><?php echo $this->Html->__t('Name'); ?></th>
		<th><?php echo $this->Html->__t('Created'); ?></th>
		<th><?php echo $this->Html->__t('Modified'); ?></th>
		<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
	</tr>
	<?php
		foreach ($typ__["data"]["operations"]["armies"] as $armies){ ?>
		<tr>
			<td><?php echo $armies['name'];?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $armies['created']);?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $armies['modified']);?></td>
			<td class="actions">
				<?php echo $this->Html->Url($this->Html->__t('View'), array('controller' => 'armies', 'action' => 'view', "params" => array($armies['id']), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
				<?php echo $this->Html->Url($this->Html->__t('Edit'), array('controller' => 'armies', 'action' => 'edit', "params" => array($armies['id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('controller' => 'armies', 'action' => 'delete', "params" => array($armies['id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
			</td>
		</tr>
	<?php } ?>
	</table>
<?php } ?>

</div>