<?php
//\Configure::pre($typ__["data"]);
?>
<div class="users form">
	<div class="page-header">
    	<h1><?php echo $this->Html->Url($this->Html->__t('Squads'), array('controller' => 'Squads', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t('Squad Units'); ?> - <?php echo ((isset($typ__["data"]["SquadUnits"]["name"]))?$typ__["data"]["SquadUnits"]["name"]:$this->Html->__t("Admin Edit")); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/SquadUnits/edit/".$typ__["data"]["SquadUnits"]["id"]."/".$typ__["data"]["SquadUnits"]["squads_id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("min_count", "SquadUnits", array('label' => 'Squad min count', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "min"));
		echo $this->Html->Input("max_count", "SquadUnits", array('label' => 'Squad max count', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "max"));

		echo $this->Html->Input("name", "SquadUnits", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));

		echo $this->Html->Input("pts", "SquadUnits", array('label' => 'Points', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "a"));

		echo $this->Html->MultiSearch("Wargears", "SquadUnits", array('label' => 'Wargear', 'class' => "form-control", 'type' => "select", 'id' => "wargear", "multiple"), $typ__['data']["Wargears"]);

		echo $this->Html->MultiSearch("UnitCharacteristics", "SquadUnits", array('label' => 'Characteristics', 'class' => "form-control", 'type' => "select", 'id' => "characteristics", "multiple"), $typ__['data']["UnitCharacteristics"]);

		echo $this->Html->MultiSearch("Psykers", "SquadUnits", array('label' => 'Psykers abilities', 'class' => "form-control", 'type' => "select", 'id' => "psykers", "multiple"), $typ__['data']["Psykers"]);


		echo $this->Html->MultiSearch("Relics", "SquadUnits", array('label' => 'Race relics', 'class' => "form-control", 'type' => "select", 'id' => "relics", "multiple"), $typ__['data']["Relics"]);

		echo $this->Html->MultiSearch("Warlords", "SquadUnits", array('label' => 'Warlord Traits', 'class' => "form-control", 'type' => "select", 'id' => "warlords", "multiple"), $typ__['data']["Warlords"]);

		echo $this->Html->MultiSearch("Transports", "SquadUnits", array('label' => 'Transport Capacity', 'class' => "form-control", 'type' => "select", 'id' => "transports", "multiple"), $typ__['data']["Transports"]);


		echo $this->Html->MultiSearch("Groups", "SquadUnits", array('label' => 'Groups', 'class' => "form-control", 'type' => "select", 'id' => "Groups", "multiple"), $typ__['data']["Groups"]);

		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>