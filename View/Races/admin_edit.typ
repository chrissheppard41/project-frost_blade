<?php ?>
<div class="users form">
    <h2><?php echo $this->Html->Url($this->Html->__t('Army Lists'), array('controller' => 'armylists', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Edit"); ?></h2>
	<?php
	echo $this->Html->Form(array(
					"action" => "/admin/armylists/edit/".$typ__["data"]["Races"]["id"],
					"class" => "form-vertical",
					"id" => "UserAdminAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));
		echo $this->Html->Input("id", "Races", array('type' => "hidden", 'id' => "UserId"));
		echo $this->Html->Input("name", "Races", array('label' => 'Name', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UserName", "required" => true));
		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>