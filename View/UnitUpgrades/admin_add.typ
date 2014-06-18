<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Unit Upgrades'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Html->Form(array(
					"action" => "/admin/UnitUpgrades/add/".$typ__["data"]["wargears_id"],
					"class" => "form-vertical",
					"id" => "UnitUpgradesAdminAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));


		echo $this->Html->Input("enhancements_id", "UnitUpgrades", array('label' => 'Enhances', 'class' => "form-control", 'type' => "select", 'id' => "Enhances"), $typ__['data']["Enhancements"]);

		echo $this->Html->Input("operations_id", "UnitUpgrades", array('label' => 'Operations', 'class' => "form-control", 'type' => "select", 'id' => "Operations"), $typ__['data']["Operations"]);

		echo $this->Html->Input("factor", "UnitUpgrades", array('label' => 'Factor', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "factor"));

		echo $this->Html->Input("wargears_id", "UnitUpgrades", array('placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "hidden", 'id' => "wargears_id", "value" => $typ__["data"]["wargears_id"]));

		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>