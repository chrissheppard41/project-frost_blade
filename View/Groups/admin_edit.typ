<?php ?>
<div class="users form">
	<div class="page-header">
    	<h1><?php echo $this->Html->Url($this->Html->__t('Groups'), array('controller' => 'Groups', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Edit"); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/Groups/edit/".$typ__["data"]["Groups"]["id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("id", "Groups", array('type' => "hidden", 'id' => "UserId"));
		echo $this->Html->Input("name", "Groups", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name", "required" => true));
		//echo $this->Html->Input("armies_id", "Groups", array('label' => 'Army', 'class' => "form-control", 'type' => "select", 'id' => "armies"), $typ__['data']["Armies"]);
		echo $this->Html->Input("armies_id", "Groups", array('class' => "form-control", 'type' => "hidden", 'id' => "armies", "value" => $typ__['data']["Groups"]["armies_id"]));

		echo $this->Html->MultiSearch("Wargears", "Groups", array('label' => 'Wargear', 'class' => "form-control", 'type' => "select", 'id' => "wargears", "multiple"), $typ__['data']["Wargears"]);
		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>