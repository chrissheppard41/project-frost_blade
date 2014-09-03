<?php ?>
<div class="users form">
	<div class="page-header">
    	<h1><?php echo $this->Html->Url($this->Html->__t('Unit Characteristics'), array('controller' => 'UnitCharacteristics', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Edit"); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/UnitCharacteristics/edit/".$typ__["data"]["UnitCharacteristics"]["id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("id", "UnitCharacteristics", array('type' => "hidden", 'id' => "UserId"));
		echo $this->Html->Input("name", "UnitCharacteristics", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UserName", "required" => true));

		//echo $this->Html->Input("armies_id", "UnitCharacteristics", array('label' => 'Army', 'class' => "form-control", 'type' => "select", 'id' => "armies"), $typ__['data']["Armies"]);
		echo $this->Html->Input("armies_id", "UnitCharacteristics", array('class' => "form-control", 'type' => "hidden", 'id' => "armies", "value" => $typ__['data']["UnitCharacteristics"]["armies_id"]));
		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>