<section class="clearfix">
	<article>
		<h2>Register</h2>

		<div id="loginView">

			<?php echo $this->Html->Form(array("action" => "/users/register","class" => "form-vertical","id" => "UserAdminRegisterForm","method" => "post","accept-charset" => "utf-8")); ?>

				<?php
				echo $this->Html->Input("username", "users", array('label' => 'Username', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UsersName"));
				echo $this->Html->Input("email", "users", array('label' => 'Email', 'placeholder' => "Email", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UsersEmail"));
				echo $this->Html->Input("password", "users", array('label' => 'Password', 'placeholder' => "Password", 'class' => "form-control", 'type' => "password", 'id' => "UsersPassword"));
				echo $this->Html->Input("confirm_password", "users", array('label' => 'Confirm Password', 'placeholder' => "Confirm Password", 'class' => "form-control", 'type' => "password", 'id' => "UsersConfirmPassword"));
				echo $this->Html->Input("slug", "users", array('type' => "hidden", 'id' => "UsersSlug"));
				?>

				<?php echo $this->Html->Submit("Register",array('class' => "btn btn-primary")); ?>
			<?php echo $this->Html->Form(); ?>


		</div>
    </article>
</section>
