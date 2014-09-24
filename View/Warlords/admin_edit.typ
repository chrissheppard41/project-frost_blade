<?php ?>
<div class="users form">
	<div class="page-header">
    	<h1><?php echo $this->Html->Url($this->Html->__t('Warlords traits'), array('controller' => 'Warlords', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Edit"); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/Warlords/edit/".$typ__["data"]["warlords"]["id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("id", "warlords", array('type' => "hidden", 'id' => "UserId"));
		echo $this->Html->Input("name", "warlords", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name", "required" => true));
		//echo $this->Html->Input("pts", "warlords", array('label' => 'Points', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "pts"));
		//echo $this->Html->Input("armies_id", "warlords", array('label' => 'Army', 'class' => "form-control", 'type' => "select", 'id' => "armies"), $typ__['data']["Armies"]);
		echo $this->Html->Input("armies_id", "warlords", array('class' => "form-control", 'type' => "hidden", 'id' => "armies", "value" => $typ__['data']["warlords"]["armies_id"]));
		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>