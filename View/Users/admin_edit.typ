<?php



?>

<div class="users form">
    <h2><?php echo $this->Html->Url($this->Html->__t('Users'), array('controller' => 'users', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Edit"); ?></h2>
	<?php
	echo $this->Html->Form(array(
					"action" => "/admin/users/edit/".$typ__["data"]["Users"]["id"],
					"class" => "form-vertical",
					"id" => "UserAdminAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));
		echo $this->Html->Input("id", "Users", array('type' => "hidden", 'id' => "UserId"));
		echo $this->Html->Input("Username", "Users", array('label' => 'Username', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UserName", "required" => true));
		echo $this->Html->Input("Email", "Users", array('label' => 'Email', 'placeholder' => "Email", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UserEmail", "required" => true));
		echo $this->Html->Input("Password", "Users", array('label' => 'Password', 'placeholder' => "Password", 'class' => "form-control", 'type' => "password", 'id' => "UserPassword"));
		echo $this->Html->Input("confirm_password", "Users", array('label' => 'Confirm Password', 'placeholder' => "Confirm Password", 'class' => "form-control", 'type' => "password", 'id' => "UserConfirmPassword"));
		echo $this->Html->Input("Is_admin", "Users", array('label' => 'Is Admin', 'class' => "form-control", 'type' => "checkbox", 'id' => "UserIsAdmin"));
		echo $this->Html->Input("Email_verified", "Users", array('label' => 'Verify Email', 'class' => "form-control", 'type' => "checkbox", 'id' => "UserEmailVerified"));
		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>