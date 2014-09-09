<?php
//\Configure::pre($typ__["data"]);
?>
<div class="users form">
	<div class="page-header">
    	<h1><?php echo $this->Html->Url($this->Html->__t('Groups'), array('controller' => 'Groups', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t('Group wargear'); ?> - <?php echo ((isset($typ__["data"]["WargearGroups"]["name"]))?$typ__["data"]["WargearGroups"]["name"]:$this->Html->__t("Admin Edit")); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/WargearGroups/edit/".$typ__["data"]["WargearGroups"]["id"]."/".$typ__["data"]["WargearGroups"]["groups_id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		/*echo $this->Html->Input("min_count", "WargearGroups", array('label' => 'Squad min count', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "min"));
		echo $this->Html->Input("max_count", "WargearGroups", array('label' => 'Squad max count', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "max"));*/

		echo $this->Html->Input("pts", "WargearGroups", array('label' => 'Points', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "a"));

		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>