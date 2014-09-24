<?php ?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Races'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Html->Form(array(
					"action" => "/admin/races/add",
					"class" => "form-vertical",
					"id" => "RacesAdminAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));
		echo $this->Html->Input("name", "races", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		echo "<div><b>Icons</b></div>";
		echo $this->Html->Input("icon", "races", array('label' => '', 'class' => "", 'type' => "radio", 'id' => "icon"), array(
			array("id" => 1, "name" => "Space marines"),
			array("id" => 2, "name" => "Chaos Space marines"),
			array("id" => 3, "name" => "Daemons"),
			array("id" => 4, "name" => "Dark Eldar"),
			array("id" => 5, "name" => "Eldar"),
			array("id" => 6, "name" => "Imperial guard"),
			array("id" => 7, "name" => "Inquisistor"),
			array("id" => 8, "name" => "Necrons"),
			array("id" => 9, "name" => "Orks"),
			array("id" => 10, "name" => "Sisters of battle"),
			array("id" => 11, "name" => "Tau"),
			array("id" => 12, "name" => "Tyrnids")
			));
		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>