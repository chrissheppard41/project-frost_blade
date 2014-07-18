<?php
//\Configure::pre($_POST);
?>
<div class="users form">
	<div class="page-header">
    	<h1><?php echo $this->Html->Url($this->Html->__t('Units'), array('controller' => 'Units', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Edit"); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/Units/edit/".$typ__["data"]["Units"]["id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("name", "Units", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		echo $this->Html->Input("weapon_skill", "Units", array('label' => 'Weapon skill', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "ws"));
		echo $this->Html->Input("ballistic_skill", "Units", array('label' => 'Ballistic skill', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "bs"));
		echo $this->Html->Input("strength", "Units", array('label' => 'Strength', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "s"));
		echo $this->Html->Input("toughness", "Units", array('label' => 'Toughness', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "t"));
		echo $this->Html->Input("initiative", "Units", array('label' => 'Initiative', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "i"));
		echo $this->Html->Input("wounds", "Units", array('label' => 'Wounds', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "w"));
		echo $this->Html->Input("attacks", "Units", array('label' => 'Attacks', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "a"));
		echo $this->Html->Input("leadership", "Units", array('label' => 'Leadership', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "ld"));
		echo $this->Html->Input("armour_save", "Units", array('label' => 'Armour save', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "as"));
		echo $this->Html->Input("invulnerable_save", "Units", array('label' => 'Invulnerable save', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "is"));

		echo $this->Html->Input("front_armour", "Units", array('label' => 'Front armour', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "fa"));
		echo $this->Html->Input("side_armour", "Units", array('label' => 'Side armour', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "sa"));
		echo $this->Html->Input("rear_armour", "Units", array('label' => 'Rear armour', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "ra"));
		echo $this->Html->Input("hull_hitpoints", "Units", array('label' => 'Hull hitpoints', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "hp"));

		echo $this->Html->Input("pts", "Units", array('label' => 'Points', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "a"));

		echo $this->Html->Input("unittypes_id", "Units", array('label' => 'Unit Type', 'class' => "form-control", 'type' => "select", 'id' => "unittypes"), $typ__['data']["UnitTypes"]);
		echo $this->Html->Input("armies_id", "Units", array('label' => 'Army', 'class' => "form-control", 'type' => "select", 'id' => "armies"), $typ__['data']["Armies"]);

		echo $this->Html->Input("UnitCharacteristics", "Units", array('label' => 'Characteristics', 'class' => "form-control", 'type' => "select", 'id' => "characteristics", "multiple"), $typ__['data']["UnitCharacteristics"]);
		echo $this->Html->Input("Wargears", "Units", array('label' => 'Wargear', 'class' => "form-control", 'type' => "select", 'id' => "wargear", "multiple"), $typ__['data']["Wargears"]);

		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>