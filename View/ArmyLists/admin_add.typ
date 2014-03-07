<?php
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Army Lists'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
		echo $this->Html->Form(array(
			"action" => "/admin/ArmyLists/add",
			"class" => "form-vertical",
			"id" => "ArmyListsAdminAddForm",
			"method" => "post",
			"accept-charset" => "utf-8"
		));
		echo $this->Html->Input("name", "ArmyLists", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		echo $this->Html->Input("descr", "ArmyLists", array('label' => 'Description', 'placeholder' => "Description", 'class' => "form-control", 'maxlength' => "255", 'type' => "textarea", 'id' => "descr"));
		echo $this->Html->Input("point_limit", "ArmyLists", array('label' => 'Points limit', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "point_limit"));
		echo $this->Html->Input("hide", "ArmyLists", array('label' => 'Army Hidden', 'class' => "form-control", 'type' => "checkbox", 'id' => "hide"));

		echo $this->Html->Input("armies_id", "ArmyLists", array('label' => 'Army', 'class' => "form-control", 'type' => "select", 'id' => "races"), $typ__['data']["Armies"]);
		echo $this->Html->Input("users_id", "ArmyLists", array('label' => 'Username', 'class' => "form-control", 'type' => "select", 'id' => "username"), $typ__['data']["Users"]);
		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>