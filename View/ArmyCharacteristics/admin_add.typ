<?php ?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Army Characteristics'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Html->Form(array(
					"action" => "/admin/ArmyCharacteristics/add",
					"class" => "form-vertical",
					"id" => "RacesAdminAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));
		echo $this->Html->Input("name", "armycharacteristics", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UserName"));
		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>