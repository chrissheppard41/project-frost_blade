<?php
//\Configure::pre($_POST);
?>
<div class="users form">
	<div class="page-header">
    	<h1><?php echo $this->Html->Url($this->Html->__t('Armies'), array('controller' => 'Armies', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Edit"); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/Armies/edit/".$typ__["data"]["armies"]["id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("name", "armies", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		//echo $this->Html->Input("races_id", "armies", array('label' => 'Races', 'class' => "form-control", 'type' => "select", 'id' => "races"), $typ__['data']["races"]);
		echo $this->Html->Input("races_id", "armies", array('class' => "form-control", 'type' => "hidden", 'id' => "armies", "value" => $typ__['data']["armies"]["races_id"]));

		echo $this->Html->Input("armycharacteristics", "armies", array('label' => 'Characteristics', 'class' => "form-control", 'type' => "select", 'id' => "races", "multiple"), $typ__['data']["armycharacteristics"]);

		echo $this->Html->Input("colours_id", "armies", array('label' => 'Colours', 'class' => "form-control", 'type' => "select", 'id' => "colours"), $typ__['data']["colours"]);

		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>