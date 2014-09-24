<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t("Units"), array("action" => "index", "admin" => true)); ?> - View unit</h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
	  	<div class="panel-heading">
	  		<?php echo $this->Html->__t("Units view"); ?>
	  		<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("action" => "edit", "admin" => true, "params" => array($typ__["data"]["units"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "action" => "delete", "params" => array($typ__["data"]["units"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
	  		</span>
	  	</div>
	  	<div class="panel-body">
	  		<!--div class="row">
	  			<span class="col-md-3"><?php //echo $this->Html->__t("Name"); ?></span>
	  			<span class="col-md-9"><?php //echo $typ__["data"]["Units"]["name"]; ?></span>
	  		</div-->

	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Weapon skill"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["weapon_skill"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Ballistic Skill"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["ballistic_skill"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Strength"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["strength"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Toughness"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["toughness"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Wounds"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["wounds"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Initiative"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["initiative"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Attacks"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["attacks"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Leadership"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["leadership"]; ?></span>
	  		</div>

	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Front armour"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["front_armour"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Side armour"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["side_armour"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Rear armour"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["rear_armour"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Hull hitpoints"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["hull_hitpoints"]; ?></span>
	  		</div>

	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Armour save"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["armour_save"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Invulnerable save"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["units"]["invulnerable_save"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Unit type"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Url($typ__["data"]["units"]["unittype_name"], array("controller" => "unittypes", "action" => "view", "admin" => true, "params" => array($typ__["data"]["units"]["unittype_id"]))); ?></span>
	  		</div>

	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["units"]["created"]); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["units"]["modified"]); ?></span>
	  		</div>
	  	</div>
	</div>
</div>


<div class="related">
	<h3><?php echo $this->Html->__t('Related Squads');?></h3>
	<?php if (!empty($typ__["data"]["units"]["squads"])){ ?>
	<table class="table table-striped table-bordered table-listings">
	<tr>
		<th><?php echo $this->Html->__t('Name'); ?></th>
		<th><?php echo $this->Html->__t('Created'); ?></th>
		<th><?php echo $this->Html->__t('Modified'); ?></th>
		<th class="actions"><?php echo $this->Html->__t('Actions');?></th>
	</tr>
	<?php
		foreach ($typ__["data"]["units"]["squads"] as $Units){ ?>
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
