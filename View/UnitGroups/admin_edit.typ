<?php
//\Configure::pre($typ__);
?>
<div class="users form">
	<div class="page-header">
		<h1><?php echo $this->Html->Url($this->Html->__t('Unit Groups'), array('controller' => 'unitgroups', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Edit"); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/UnitGroups/edit/".$typ__["data"]["unitgroups"]["id"]."/".$typ__["data"]["squad_id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("min_count", "unitgroups", array('label' => 'Squad min count', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "min"));
		echo $this->Html->Input("max_count", "unitgroups", array('label' => 'Squad max count', 'placeholder' => "0", 'class' => "form-control", 'maxlength' => "255", 'type' => "number", 'id' => "max"));

		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>