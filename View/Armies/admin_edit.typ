<?php
//\Configure::pre($_POST);
?>
<div class="users form">
	<div class="page-header">
    	<h1><?php echo $this->Html->Url($this->Html->__t('Armies'), array('controller' => 'Armies', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Edit"); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/Armies/edit/".$typ__["data"]["Armies"]["id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("name", "Armies", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		echo $this->Html->Input("races_id", "Armies", array('label' => 'Races', 'class' => "form-control", 'type' => "select", 'id' => "races"), $typ__['data']["Races"]);
		echo $this->Html->Input("ArmyCharacteristics", "Armies", array('label' => 'Characteristics', 'class' => "form-control", 'type' => "select", 'id' => "races", "multiple"), $typ__['data']["ArmyCharacteristics"]);

		echo $this->Html->Input("colours_id", "Armies", array('label' => 'Colours', 'class' => "form-control", 'type' => "select", 'id' => "colours"), $typ__['data']["Colours"]);

		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>