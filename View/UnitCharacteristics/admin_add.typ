<?php ?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Unit Characteristics'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Html->Form(array(
					"action" => "/admin/UnitCharacteristics/add",
					"class" => "form-vertical",
					"id" => "UnitsAdminAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));
		echo $this->Html->Input("name", "UnitCharacteristics", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UserName"));

		//echo $this->Html->Input("armies_id", "UnitCharacteristics", array('label' => 'Army', 'class' => "form-control", 'type' => "select", 'id' => "armies"), $typ__['data']["Armies"]);
		echo $this->Html->Input("armies_id", "UnitCharacteristics", array('class' => "form-control", 'type' => "hidden", 'id' => "armies", "value" => $typ__['data']["UnitCharacteristics"]["armies_id"]));

		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>