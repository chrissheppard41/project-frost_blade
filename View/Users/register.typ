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

				<?php echo $this->Html->Input("Username", "User", array('label' => 'Username', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UserName")); ?>
				<?php echo $this->Html->Input("Email", "User", array('label' => 'Email', 'placeholder' => "Email", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UserEmail")); ?>
				<?php echo $this->Html->Input("Password", "User", array('label' => 'Password', 'placeholder' => "Password", 'class' => "form-control", 'type' => "password", 'id' => "UserPassword")); ?>
				<?php echo $this->Html->Input("confirm_password", "User", array('label' => 'Confirm Password', 'placeholder' => "Confirm Password", 'class' => "form-control", 'type' => "password", 'id' => "UserConfirmPassword")); ?>

				<input type="hidden" name="data[return_to]" id="UserReturnTo" value="/users/login" />

				<?php echo $this->Html->Submit("Register",array('class' => "btn btn-primary")); ?>
			<?php echo $this->Html->Form(); ?>


		</div>
    </div>
</div>
