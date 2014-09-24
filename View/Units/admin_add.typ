<?php
//\Configure::pre($typ__)
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Units'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/Units/add",
		"class" => "form-vertical",
		"id" => "UnitsAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		//echo $this->Html->Input("name", "units", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));

		echo $this->Html->Input("weapon_skill", "units", array('label' => 'Weapon skill', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "ws"));
		echo $this->Html->Input("ballistic_skill", "units", array('label' => 'Ballistic skill', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "bs"));
		echo $this->Html->Input("strength", "units", array('label' => 'Strength', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "s"));
		echo $this->Html->Input("toughness", "units", array('label' => 'Toughness', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "t"));
		echo $this->Html->Input("wounds", "units", array('label' => 'Wounds', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "w"));
		echo $this->Html->Input("initiative", "units", array('label' => 'Initiative', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "i"));
		echo $this->Html->Input("attacks", "units", array('label' => 'Attacks', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "a"));
		echo $this->Html->Input("leadership", "units", array('label' => 'Leadership', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "ld"));
		echo $this->Html->Input("armour_save", "units", array('label' => 'Armour save', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "as"));
		echo $this->Html->Input("invulnerable_save", "units", array('label' => 'Invulnerable save', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "is"));

		echo $this->Html->Input("front_armour", "units", array('label' => 'Front armour', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "fa"));
		echo $this->Html->Input("side_armour", "units", array('label' => 'Side armour', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "sa"));
		echo $this->Html->Input("rear_armour", "units", array('label' => 'Rear armour', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "ra"));
		echo $this->Html->Input("hull_hitpoints", "units", array('label' => 'Hull hitpoints', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "hp"));

		//echo $this->Html->Input("pts", "units", array('label' => 'Points', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "a"));

		echo $this->Html->Input("unittypes_id", "units", array('label' => 'Unit Type', 'class' => "form-control", 'type' => "select", 'id' => "unittypes"), $typ__['data']["unittypes"]);


		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>