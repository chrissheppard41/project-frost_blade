<?php ?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Groups'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Html->Form(array(
					"action" => "/admin/Groups/add",
					"class" => "form-vertical",
					"id" => "GroupsAdminAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));
		echo $this->Html->Input("name", "groups", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		//echo $this->Html->Input("armies_id", "Groups", array('label' => 'Army', 'class' => "form-control", 'type' => "select", 'id' => "armies"), $typ__['data']["Armies"]);
		echo $this->Html->Input("armies_id", "groups", array('class' => "form-control", 'type' => "hidden", 'id' => "armies", "value" => $typ__['data']["groups"]["armies_id"]));

		echo $this->Html->MultiSearch("wargears", "groups", array('label' => 'Wargear', 'class' => "form-control", 'type' => "select", 'id' => "wargears", "multiple"), $typ__['data']["wargears"]);

		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>