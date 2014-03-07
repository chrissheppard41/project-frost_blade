<?php
//\Configure::pre($typ__);
$panel = "panel-primary";
if(!isset($typ__["data"]["SquadUnits"]["min_count"]) && !isset($typ__["data"]["SquadUnits"]["max_count"]))
	$panel = "panel-danger";


?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t("Squad Units"), array("action" => "index", "admin" => true)); ?> - <?php echo $typ__["data"]["SquadUnits"]["squads_name"]; ?></h1>
</div>

<div class="raceTypes view">
	<div class="panel <?php echo $panel; ?>">
	  	<div class="panel-heading">
	  		<?php echo $this->Html->__t("SquadUnits view"); ?>
	  		<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("action" => "edit", "admin" => true, "params" => array($typ__["data"]["SquadUnits"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "action" => "delete", "params" => array($typ__["data"]["SquadUnits"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
	  		</span>
	  	</div>
	  	<div class="panel-body">
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Min Squad count"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["SquadUnits"]["min_count"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Max Squad count"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["SquadUnits"]["max_count"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Squad"); ?></span>
	  			<span class="col-md-9">
	  				<?php echo $this->Html->Url($typ__["data"]["SquadUnits"]["squads_name"], array("controller" => "armies", "action" => "view", "admin" => true, "params" => array($typ__["data"]["SquadUnits"]["squads_id"]))); ?>
	  			</span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Units"); ?></span>
	  			<span class="col-md-9">
	  				<?php echo $this->Html->Url($typ__["data"]["SquadUnits"]["units_name"], array("controller" => "armies", "action" => "view", "admin" => true, "params" => array($typ__["data"]["SquadUnits"]["units_id"]))); ?>
	  			</span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["SquadUnits"]["created"]); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["SquadUnits"]["modified"]); ?></span>
	  		</div>
	  	</div>
	</div>
</div>
