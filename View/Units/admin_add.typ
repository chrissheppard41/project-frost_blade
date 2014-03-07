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
		echo $this->Html->Input("pts", "Units", array('label' => 'Points', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "a"));

		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>