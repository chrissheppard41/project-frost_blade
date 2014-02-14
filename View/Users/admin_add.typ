<?php ?>
<div class="Userss form">
    <h2><?php echo $this->Html->Url($this->Html->__t('Users'), array('controller' => 'Users', 'action' => 'index', 'admin' => true)); ?> - <?php echo $this->Html->__t("Admin Add"); ?></h2>
	<?php
	echo $this->Html->Form(array(
					"action" => "/admin/Users/add",
					"class" => "form-vertical",
					"id" => "UsersAdminAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));
		echo $this->Html->Input("Username", "Users", array('label' => 'Username', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UsersName"));
		echo $this->Html->Input("Email", "Users", array('label' => 'Email', 'placeholder' => "Email", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UsersEmail"));
		echo $this->Html->Input("Password", "Users", array('label' => 'Password', 'placeholder' => "Password", 'class' => "form-control", 'type' => "password", 'id' => "UsersPassword"));
		echo $this->Html->Input("confirm_password", "Users", array('label' => 'Confirm Password', 'placeholder' => "Confirm Password", 'class' => "form-control", 'type' => "password", 'id' => "UsersConfirmPassword"));
		echo $this->Html->Input("is_admin", "Users", array('label' => 'Is Admin', 'class' => "form-control", 'type' => "checkbox", 'id' => "UsersIsAdmin"));
		echo $this->Html->Input("email_verified", "Users", array('label' => 'Verify Email', 'class' => "form-control", 'type' => "checkbox", 'id' => "UsersEmailVerified"));
		echo $this->Html->Input("slug", "Users", array('type' => "hidden", 'id' => "UsersSlug"));
		echo $this->Html->Submit($this->Html->__t('Save'),
			array(
				'class' => "btn btn-primary"
			)
		);
		echo $this->Html->Form();
	?>
</div>