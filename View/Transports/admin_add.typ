<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Transports capacity'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Html->Form(array(
					"action" => "/admin/Transports/add".(isset($typ__['data']["Groups"]["id"])?"/".$typ__['data']["Groups"]["id"]:""),
					"class" => "form-vertical",
					"id" => "TransportsAdminAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));
		echo $this->Html->Input("name", "Transports", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		//echo $this->Html->Input("pts", "Transports", array('label' => 'Points', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "pts"));
		//echo $this->Html->Input("armies_id", "Transports", array('label' => 'Army', 'class' => "form-control", 'type' => "select", 'id' => "armies"), $typ__['data']["Armies"]);
		echo $this->Html->Input("armies_id", "Transports", array('class' => "form-control", 'type' => "hidden", 'id' => "armies", "value" => $typ__['data']["Transports"]["armies_id"]));

		if(isset($typ__['data']["Groups"]["id"])) {
			echo $this->Html->Input("Groups", "Transports", array('type' => "hidden", 'id' => "groups", "value" => $typ__['data']["Groups"]["id"]));
		}

		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>