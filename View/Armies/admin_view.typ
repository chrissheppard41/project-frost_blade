<?php
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t("Armies"), array("action" => "index", "admin" => true)); ?> - <?php echo $typ__["data"]["Armies"]["name"]; ?></h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
	  	<div class="panel-heading">
	  		<?php echo $this->Html->__t("Army view"); ?>
	  		<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("action" => "edit", "admin" => true, "params" => array($typ__["data"]["Armies"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "action" => "delete", "params" => array($typ__["data"]["Armies"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
	  		</span>
	  	</div>
	  	<div class="panel-body">
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Name"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Armies"]["name"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Race"); ?></span>
	  			<span class="col-md-9">
	  				<?php echo $this->Html->Url($typ__["data"]["Armies"]["race_name"], array("controller" => "races", "action" => "view", "admin" => true, "params" => array($typ__["data"]["Armies"]["race_id"]))); ?>
	  			</span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["Armies"]["created"]); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["Armies"]["modified"]); ?></span>
	  		</div>
	  	</div>
	</div>
</div>


<div class="related">
	<h3><?php echo $this->Html->__t('Related Army Characteristics');?></h3>
	<?php if (!empty($typ__["data"]["Armies"]["ArmyCharacteristics"])){ ?>
	<table class="table table-striped table-bordered table-listings">
	<tr>
		<th><?php echo $this->Html->__t('Name'); ?></th>
		<th><?php echo $this->Html->__t('Created'); ?></th>
		<th><?php echo $this->Html->__t('Modified'); ?></th>
		<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
	</tr>
	<?php
		foreach ($typ__["data"]["Armies"]["ArmyCharacteristics"] as $armies){ ?>
		<tr>
			<td><?php echo $armies['name'];?></td>
			<td><?php echo $armies['created'];?></td>
			<td><?php echo $armies['modified'];?></td>
			<td class="actions">
				<?php echo $this->Html->Url($this->Html->__t('View'), array('controller' => 'armycharacteristics', 'action' => 'view', "params" => array($armies['id']), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
				<?php echo $this->Html->Url($this->Html->__t('Edit'), array('controller' => 'armycharacteristics', 'action' => 'edit', "params" => array($armies['id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('controller' => 'armycharacteristics', 'action' => 'delete', "params" => array($armies['id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
			</td>
		</tr>
	<?php } ?>
	</table>
<?php } ?>

</div>


<div class="related">
	<h3><?php echo $this->Html->__t('Related Squads');?></h3>
	<?php if (!empty($typ__["data"]["Armies"]["Squads"])){ ?>
	<table class="table table-striped table-bordered table-listings">
	<tr>
		<th><?php echo $this->Html->__t('Name'); ?></th>
		<th><?php echo $this->Html->__t('Created'); ?></th>
		<th><?php echo $this->Html->__t('Modified'); ?></th>
		<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
	</tr>
	<?php
		foreach ($typ__["data"]["Armies"]["Squads"] as $squads){ ?>
		<tr>
			<td><?php echo $squads['name'];?></td>
			<td><?php echo $squads['created'];?></td>
			<td><?php echo $squads['modified'];?></td>
			<td class="actions">
				<?php echo $this->Html->Url($this->Html->__t('View'), array('controller' => 'squads', 'action' => 'view', "params" => array($squads['id']), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
				<?php echo $this->Html->Url($this->Html->__t('Edit'), array('controller' => 'squads', 'action' => 'edit', "params" => array($squads['id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('controller' => 'squads', 'action' => 'delete', "params" => array($squads['id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
			</td>
		</tr>
	<?php } ?>
	</table>
<?php } ?>

</div>