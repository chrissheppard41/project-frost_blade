<?php
//\Configure::pre($typ__)
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Squads'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/Squads/add",
		"class" => "form-vertical",
		"id" => "SquadsAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("name", "Squads", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		echo $this->Html->Input("armies_id", "Squads", array('label' => 'Army', 'class' => "form-control", 'type' => "select", 'id' => "armies"), $typ__['data']["Armies"]);
		echo $this->Html->Input("types_id", "Squads", array('label' => 'Type', 'class' => "form-control", 'type' => "select", 'id' => "types"), $typ__['data']["Types"]);
		echo $this->Html->Input("Units", "Squads", array('label' => 'Units', 'class' => "form-control", 'type' => "select", 'id' => "units", "multiple"), $typ__['data']["Units"]);

		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>