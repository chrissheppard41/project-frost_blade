<?php ?>
<div class="users form">
	<div class="page-header">
    	<h1><?php echo $this->Html->Url($this->Html->__t('Unit Types'), array('controller' => 'UnitTypes', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Edit"); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/UnitTypes/edit/".$typ__["data"]["unittypes"]["id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("id", "unittypes", array('type' => "hidden", 'id' => "UserId"));
		echo $this->Html->Input("name", "unittypes", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name", "required" => true));
		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>