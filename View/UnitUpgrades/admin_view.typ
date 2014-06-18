<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t("Unit Upgrades"), array("action" => "index", "admin" => true)); ?> - Admin view</h1>
</div>

<div class="raceTypes view">
	<div class="panel panel-default">
	  	<div class="panel-heading">
	  		<?php echo $this->Html->__t("UnitUpgrades view"); ?>
	  		<span class="pull-right">
				<?php echo $this->Html->Url($this->Html->__t("Edit"), array("action" => "edit", "admin" => true, "params" => array($typ__["data"]["UnitUpgrades"]["id"])), array("class" => "btn-sm btn-warning")); ?>
				<?php echo $this->Html->UrlPost($this->Html->__t("Delete"), array("admin" => true, "action" => "delete", "params" => array($typ__["data"]["UnitUpgrades"]["id"])), array("class" => "btn-sm btn-danger"), $this->Html->__t("Are you sure you want to delete this record?")); ?>
	  		</span>
	  	</div>
	  	<div class="panel-body">
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Enhancement"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Url($typ__["data"]["UnitUpgrades"]["enhancement_name"], array("controller" => "enhancements", "action" => "view", "admin" => true, "params" => array($typ__["data"]["UnitUpgrades"]["enhancement_id"]))); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Add"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Url($typ__["data"]["UnitUpgrades"]["operation_name"], array("controller" => "operations", "action" => "view", "admin" => true, "params" => array($typ__["data"]["UnitUpgrades"]["operation_id"]))); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Factor"); ?></span>
	  			<span class="col-md-9"><?php echo $typ__["data"]["UnitUpgrades"]["factor"]; ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Wargear"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Url($typ__["data"]["UnitUpgrades"]["wargear_name"], array("controller" => "wargear", "action" => "view", "admin" => true, "params" => array($typ__["data"]["UnitUpgrades"]["wargear_id"]))); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Created"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["UnitUpgrades"]["created"]); ?></span>
	  		</div>
	  		<div class="row">
	  			<span class="col-md-3"><?php echo $this->Html->__t("Modified"); ?></span>
	  			<span class="col-md-9"><?php echo $this->Html->Time("TimeAgo", $typ__["data"]["UnitUpgrades"]["modified"]); ?></span>
	  		</div>
	  	</div>
	</div>
</div>
