<?php
//\Configure::pre($typ__["data"]);
?>
<div class="users form">
	<div class="page-header">
    	<h1><?php echo $this->Html->Url($this->Html->__t('Squads'), array('controller' => 'Squads', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t('Squad Units'); ?> - <?php echo ((isset($typ__["data"]["squadunits"]["name"]))?$typ__["data"]["squadunits"]["name"]:$this->Html->__t("Admin Edit")); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/SquadUnits/edit/".$typ__["data"]["squadunits"]["id"]."/".$typ__["data"]["squadunits"]["squads_id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("min_count", "squadunits", array('label' => 'Squad min count', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "min"));
		echo $this->Html->Input("max_count", "squadunits", array('label' => 'Squad max count', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "max"));

		echo $this->Html->Input("name", "squadunits", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));

		echo $this->Html->Input("pts", "squadunits", array('label' => 'Points', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "a"));

		echo $this->Html->MultiSearch("Wargears", "squadunits", array('label' => 'Wargear', 'class' => "form-control", 'type' => "select", 'id' => "wargear", "multiple"), $typ__['data']["wargears"]);

		echo $this->Html->MultiSearch("UnitCharacteristics", "squadunits", array('label' => 'Characteristics', 'class' => "form-control", 'type' => "select", 'id' => "characteristics", "multiple"), $typ__['data']["unitcharacteristics"]);

		echo $this->Html->MultiSearch("Psykers", "squadunits", array('label' => 'Psykers abilities', 'class' => "form-control", 'type' => "select", 'id' => "psykers", "multiple"), $typ__['data']["psykers"]);


		echo $this->Html->MultiSearch("Relics", "squadunits", array('label' => 'Race relics', 'class' => "form-control", 'type' => "select", 'id' => "relics", "multiple"), $typ__['data']["relics"]);

		echo $this->Html->MultiSearch("Warlords", "squadunits", array('label' => 'Warlord Traits', 'class' => "form-control", 'type' => "select", 'id' => "warlords", "multiple"), $typ__['data']["warlords"]);

		echo $this->Html->MultiSearch("Transports", "squadunits", array('label' => 'Transport Capacity', 'class' => "form-control", 'type' => "select", 'id' => "transports", "multiple"), $typ__['data']["transports"]);


		echo $this->Html->MultiSearch("Groups", "squadunits", array('label' => 'Groups', 'class' => "form-control", 'type' => "select", 'id' => "Groups", "multiple"), $typ__['data']["groups"]);

		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>