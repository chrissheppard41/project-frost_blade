<?php ?>
<div class="users form">
	<div class="page-header">
    	<h1><?php echo $this->Html->Url($this->Html->__t('Enhancements'), array('controller' => 'Enhancements', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Edit"); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/Enhancements/edit/".$typ__["data"]["Enhancements"]["id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("id", "Enhancements", array('type' => "hidden", 'id' => "UserId"));
		echo $this->Html->Input("name", "Enhancements", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name", "required" => true));
		echo $this->Html->Input("effected_column", "Enhancements", array('label' => 'Effected Column', 'placeholder' => "Effected Column", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "effected_column"));
		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>