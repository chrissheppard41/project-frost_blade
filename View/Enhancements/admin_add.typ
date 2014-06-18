<?php ?>
<div class="page-header">
	<h1><?php echo $this->Html->Url($this->Html->__t('Enhancements'), array('action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h1>
</div>
<div class="armyLists form">
	<?php
	echo $this->Html->Form(array(
					"action" => "/admin/Enhancements/add",
					"class" => "form-vertical",
					"id" => "EnhancementsAdminAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));
		echo $this->Html->Input("name", "Enhancements", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "name"));
		echo $this->Html->Input("effected_column", "Enhancements", array('label' => 'Effected Column', 'placeholder' => "Effected Column", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "effected_column"));
		echo $this->Html->Submit($this->Html->__t('Save'),array('class' => "btn btn-primary"));
		echo $this->Html->Form();
	?>
</div>