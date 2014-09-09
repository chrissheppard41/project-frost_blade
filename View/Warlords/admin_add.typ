<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Warlords traits'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Html->Form(array(
					"action" => "/admin/Warlords/add".(isset($typ__['data']["Groups"]["id"])?"/".$typ__['data']["Groups"]["id"]:""),
					"class" => "form-vertical",
					"id" => "WarlordsAdminAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));
		echo $this->Html->Input("name", "Warlords", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		//echo $this->Html->Input("pts", "Warlords", array('label' => 'Points', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "pts"));
		//echo $this->Html->Input("armies_id", "Warlords", array('label' => 'Army', 'class' => "form-control", 'type' => "select", 'id' => "armies"), $typ__['data']["Armies"]);
		echo $this->Html->Input("armies_id", "Warlords", array('class' => "form-control", 'type' => "hidden", 'id' => "armies", "value" => $typ__['data']["Warlords"]["armies_id"]));

		if(isset($typ__['data']["Groups"]["id"])) {
			echo $this->Html->Input("Groups", "Warlords", array('type' => "hidden", 'id' => "groups", "value" => $typ__['data']["Groups"]["id"]));
		}

		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>