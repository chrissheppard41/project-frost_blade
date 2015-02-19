<?php
//\Configure::pre($_POST);
?>
<div class="users form">
	<div class="page-header">
    	<h1><?php echo $this->Html->Url($this->Html->__t('Squads'), array('controller' => 'Squads', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Edit"); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/Squads/edit/".$typ__["data"]["squads"]["id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("name", "squads", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		//echo $this->Html->Input("armies_id", "squads", array('label' => 'Army', 'class' => "form-control", 'type' => "select", 'id' => "armies"), $typ__['data']["Armies"]);
		echo $this->Html->Input("armies_id", "squads", array('class' => "form-control", 'type' => "hidden", 'id' => "armies", "value" => $typ__["data"]["squads"]["armies_id"]));
		echo $this->Html->Input("types_id", "squads", array('label' => 'Type', 'class' => "form-control", 'type' => "select", 'id' => "types"), $typ__['data']["types"]);
		echo $this->Html->MultiSearch("units", "squads", array('label' => 'Units', 'class' => "form-control", 'type' => "select", 'id' => "units", "multiple"), $typ__['data']["units"]);

		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>