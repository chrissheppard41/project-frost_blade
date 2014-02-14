<?php
//echo "<pre>".print_r($_POST, true)."</pre>";
?>
<div class="row">
	<div class="span6 offset3">
		<div id="loginView">
    		<div class="page-header">
			    <h1>Register</h1>
			</div>

			<?php echo $this->Html->Form(array("action" => "/users/register","class" => "form-vertical","id" => "UserAdminRegisterForm","method" => "post","accept-charset" => "utf-8")); ?>

				<?php
				echo $this->Html->Input("Username", "Users", array('label' => 'Username', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UsersName"));
				echo $this->Html->Input("Email", "Users", array('label' => 'Email', 'placeholder' => "Email", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UsersEmail"));
				echo $this->Html->Input("Password", "Users", array('label' => 'Password', 'placeholder' => "Password", 'class' => "form-control", 'type' => "password", 'id' => "UsersPassword"));
				echo $this->Html->Input("confirm_password", "Users", array('label' => 'Confirm Password', 'placeholder' => "Confirm Password", 'class' => "form-control", 'type' => "password", 'id' => "UsersConfirmPassword"));
				echo $this->Html->Input("email_verified", "Users", array('label' => 'Verify Email', 'class' => "form-control", 'type' => "checkbox", 'id' => "UsersEmailVerified"));
				echo $this->Html->Input("slug", "Users", array('type' => "hidden", 'id' => "UsersSlug"));
				?>

				<input type="hidden" name="data[return_to]" id="UserReturnTo" value="/users/login" />

				<?php echo $this->Html->Submit("Register",array('class' => "btn btn-primary")); ?>
			<?php echo $this->Html->Form(); ?>


		</div>
    </div>
</div>
