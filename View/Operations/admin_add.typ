<?php ?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Operations'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Html->Form(array(
					"action" => "/admin/Operations/add",
					"class" => "form-vertical",
					"id" => "OperationsAdminAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));
		echo $this->Html->Input("name", "Operations", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		echo $this->Html->Input("operation", "Operations", array('label' => 'Name', 'placeholder' => "Operation", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "operation"));

		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>