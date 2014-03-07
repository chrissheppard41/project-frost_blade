<?php
//\Configure::pre($typ__)
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('SquadUnits'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/SquadUnits/add",
		"class" => "form-vertical",
		"id" => "SquadUnitsAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("name", "SquadUnits", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		echo $this->Html->Input("armies_id", "SquadUnits", array('label' => 'Army type', 'class' => "form-control", 'type' => "select", 'id' => "armies"), $typ__['data']["Armies"]);
		echo $this->Html->Input("Units", "SquadUnits", array('label' => 'Units', 'class' => "form-control", 'type' => "select", 'id' => "units", "multiple"), $typ__['data']["Units"]);

		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>