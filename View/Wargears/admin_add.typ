<?php
//\Configure::pre($typ__);
?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Wargears'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Html->Form(array(
					"action" => "/admin/Wargears/add".(isset($typ__['data']["Groups"]["id"])?"/".$typ__['data']["Groups"]["id"]:""),
					"class" => "form-vertical",
					"id" => "WargearsAdminAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));
		echo $this->Html->Input("name", "Wargears", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		//echo $this->Html->Input("pts", "Wargears", array('label' => 'Points', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "pts"));
		echo $this->Html->Input("armies_id", "Wargears", array('label' => 'Army', 'class' => "form-control", 'type' => "select", 'id' => "armies"), $typ__['data']["Armies"]);

		if(isset($typ__['data']["Groups"]["id"])) {
			echo $this->Html->Input("Groups", "Wargears", array('type' => "hidden", 'id' => "groups", "value" => $typ__['data']["Groups"]["id"]));
		}

		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>