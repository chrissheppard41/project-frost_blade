<?php ?>
<div class="users form">
	<div class="page-header">
    	<h1><?php echo $this->Html->Url($this->Html->__t('Unit Upgrades'), array('controller' => 'UnitUpgrades', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Edit"); ?></h1>
	</div>
	<?php
	echo $this->Html->Form(array(
		"action" => "/admin/UnitUpgrades/edit/".$typ__["data"]["unitupgrades"]["id"]."/".$typ__["data"]["wargears_id"],
		"class" => "form-vertical",
		"id" => "UserAdminAddForm",
		"method" => "post",
		"accept-charset" => "utf-8"
	));
		echo $this->Html->Input("enhancements_id", "unitupgrades", array('label' => 'Enhances', 'class' => "form-control", 'type' => "select", 'id' => "Enhances"), $typ__['data']["enhancements"]);

		echo $this->Html->Input("operations_id", "unitupgrades", array('label' => 'Operations', 'class' => "form-control", 'type' => "select", 'id' => "Operations"), $typ__['data']["operations"]);

		echo $this->Html->Input("factor", "unitupgrades", array('label' => 'Factor', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "factor"));

		echo $this->Html->Input("wargears_id", "unitupgrades", array('placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "hidden", 'id' => "wargears_id", "value" => $typ__["data"]["wargears_id"]));
		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>