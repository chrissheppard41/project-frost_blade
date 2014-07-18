<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t("Units"), array("action" => "index", "admin" => true)); ?> - <?php echo $typ__["data"]["Units"]["name"]; ?></h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
	  	<div class="panel-heading">
	  		<?php echo $this->Html->__t("Units view"); ?>
	  		<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("action" => "edit", "admin" => true, "params" => array($typ__["data"]["Units"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "action" => "delete", "params" => array($typ__["data"]["Units"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
	  		</span>
	  	</div>
	  	<div class="panel-body">
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Name"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["name"]; ?></span>
	  		</div>

	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Weapon skill"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["weapon_skill"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Ballistic Skill"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["ballistic_skill"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Strength"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["strength"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Toughness"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["toughness"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Initiative"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["initiative"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Wounds"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["wounds"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Attacks"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["attacks"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Leadership"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["leadership"]; ?></span>
	  		</div>

	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Front armour"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["front_armour"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Side armour"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["side_armour"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Rear armour"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["rear_armour"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Hull hitpoints"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["hull_hitpoints"]; ?></span>
	  		</div>

	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Armour save"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["armour_save"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Invulnerable save"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["invulnerable_save"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Points"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["Units"]["pts"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Unit type"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Url($typ__["data"]["Units"]["unittype_name"], array("controller" => "unittypes", "action" => "view", "admin" => true, "params" => array($typ__["data"]["Units"]["unittype_id"]))); ?></span>
	  		</div>

	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Army"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Url($typ__["data"]["Units"]["army_name"], array("controller" => "armies", "action" => "view", "admin" => true, "params" => array($typ__["data"]["Units"]["army_id"]))); ?></span>
	  		</div>

	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["Units"]["created"]); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["Units"]["modified"]); ?></span>
	  		</div>
	  	</div>
	</div>
</div>


<div class="related">
	<h3><?php echo $this->Html->__t('Related Squads');?></h3>
	<?php if (!empty($typ__["data"]["Units"]["Squads"])){ ?>
	<table class="table table-striped table-bordered table-listings">
	<tr>
		<th><?php echo $this->Html->__t('Name'); ?></th>
		<th><?php echo $this->Html->__t('Created'); ?></th>
		<th><?php echo $this->Html->__t('Modified'); ?></th>
		<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
	</tr>
	<?php
		foreach ($typ__["data"]["Units"]["Squads"] as $Units){ ?>
		<tr>
			<td><?php echo $Units['name'];?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $Units['created']);?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $Units['modified']);?></td>
			<td class="actions">
				<?php echo $this->Html->Url($this->Html->__t('View'), array('controller' => 'squads', 'action' => 'view', "params" => array($Units['id']), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
				<?php echo $this->Html->Url($this->Html->__t('Edit'), array('controller' => 'squads', 'action' => 'edit', "params" => array($Units['id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('controller' => 'squads', 'action' => 'delete', "params" => array($Units['id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
			</td>
		</tr>
	<?php } ?>
	</table>
<?php } ?>

</div>


<div class="related">
	<h3><?php echo $this->Html->__t('Related Wargears');?></h3>
	<?php if (!empty($typ__["data"]["Units"]["Wargears"])){ ?>
	<table class="table table-striped table-bordered table-listings">
	<tr>
		<th><?php echo $this->Html->__t('Name'); ?></th>
		<th><?php echo $this->Html->__t('Created'); ?></th>
		<th><?php echo $this->Html->__t('Modified'); ?></th>
		<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
	</tr>
	<?php
		foreach ($typ__["data"]["Units"]["Wargears"] as $wargears){ ?>
		<tr>
			<td><?php echo $wargears['name'];?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $wargears['created']);?></td>
			<td><?php echo $this->Html->Time("TimeAgo", $wargears['modified']);?></td>
			<td class="actions">
				<?php echo $this->Html->Url($this->Html->__t('View'), array('controller' => 'wargears', 'action' => 'view', "params" => array($wargears['id']), "admin" => true), array('class' => 'btn-sm btn-primary')); ?>
				<?php echo $this->Html->Url($this->Html->__t('Edit'), array('controller' => 'wargears', 'action' => 'edit', "params" => array($wargears['id']), "admin" => true), array('class' => 'btn-sm btn-warning')); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t('Delete'), array('controller' => 'wargears', 'action' => 'delete', "params" => array($wargears['id']), "admin" => true), array('class' => 'btn-sm btn-danger'), $this->Html->__t('Are you sure you want to delete this record?')); ?>
			</td>
		</tr>
	<?php } ?>
	</table>
<?php } ?>

</div>
