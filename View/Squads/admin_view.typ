<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t("Squads"), array("action" => "index", "admin" => true)); ?> - <?php echo $typ__["data"]["Squads"]["name"]; ?></h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
	  	<div class="panel-heading">
	  		<?php echo $this->Html->__t("Squads view"); ?>
	  		<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("action" => "edit", "admin" => true, "params" => array($typ__["data"]["Squads"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "action" => "delete", "params" => array($typ__["data"]["Squads"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
	  		</span>
	  	</div>
	  	<div class="panel-body">
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Name"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Squads"]["name"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Army type"); ?></span>
	  			<span class="col-md-9">
	  				<?php echo $this->Html->Url($typ__["data"]["Squads"]["army_name"], array("controller" => "armies", "action" => "view", "admin" => true, "params" => array($typ__["data"]["Squads"]["army_id"]))); ?>
	  			</span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["Squads"]["created"]); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["Squads"]["modified"]); ?></span>
	  		</div>
	  	</div>
	</div>
</div>


<div class="related">
	<h3><?php echo $this->Html->__t('Related Units');?></h3>
	<?php if (!empty($typ__["data"]["Squads"]["Units"])){ ?>
	<table class="table table-striped table-bordered table-listings">
	<tr>
		<th><?php echo $this->Html->__t('Name'); ?></th>

		<th><?php echo $this->Html->__t('WS'); ?></th>
		<th><?php echo $this->Html->__t('BS'); ?></th>
		<th><?php echo $this->Html->__t('S'); ?></th>
		<th><?php echo $this->Html->__t('T'); ?></th>
		<th><?php echo $this->Html->__t('I'); ?></th>
		<th><?php echo $this->Html->__t('W'); ?></th>
		<th><?php echo $this->Html->__t('A'); ?></th>
		<th><?php echo $this->Html->__t('Ld'); ?></th>
		<th><?php echo $this->Html->__t('S'); ?></th>
		<th><?php echo $this->Html->__t('Is'); ?></th>
		<th><?php echo $this->Html->__t('Pts'); ?></th>

		<th><?php echo $this->Html->__t('Created'); ?></th>
		<th><?php echo $this->Html->__t('Modified'); ?></th>
		<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
	</tr>
	<?php
		foreach ($typ__["data"]["Squads"]["Units"] as $Squads){ ?>
		<tr>
			<td><?php echo $Squads['name'];?></td>

			<td><?php echo $Squads['weapon_skill'];?></td>
			<td><?php echo $Squads['ballistic_skill'];?></td>
			<td><?php echo $Squads['strength'];?></td>
			<td><?php echo $Squads['toughness'];?></td>
			<td><?php echo $Squads['initiative'];?></td>
			<td><?php echo $Squads['wounds'];?></td>
			<td><?php echo $Squads['attacks'];?></td>
			<td><?php echo $Squads['leadership'];?></td>
			<td><?php echo $Squads['armour_save'];?></td>
			<td><?php echo $Squads['invulnerable_save'];?></td>
			<td><?php echo $Squads['pts'];?></td>

			<td><?php echo $Squads['created'];?></td>
			<td><?php echo $Squads['modified'];?></td>
			<td class="actions">
				<?php echo $this->Html->Url($this->Html->__t('View'), array('controller' => 'units', 'action' => 'view', "params" => array($Squads['id']), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
				<?php echo $this->Html->Url($this->Html->__t('Edit'), array('controller' => 'units', 'action' => 'edit', "params" => array($Squads['id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('controller' => 'units', 'action' => 'delete', "params" => array($Squads['id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
			</td>
		</tr>
	<?php } ?>
	</table>
<?php } ?>

</div>