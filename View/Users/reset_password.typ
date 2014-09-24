<section class="clearfix">
	<article>
		<h2>Lost password</h2>

		<div id="loginView">

			<?php echo $this->Html->Form(array("action" => "/users/lostpassword","class" => "form-vertical","id" => "UserRegisterForm","method" => "post","accept-charset" => "utf-8")); ?>

				<?php echo $this->Html->Input("email", "users", array('label' => 'Enter your Email', 'placeholder' => "Email", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UserEmail", "required" => true)); ?>

				<?php echo $this->Html->Submit("Register",array('class' => "btn btn-primary")); ?>
			<?php echo $this->Html->Form(); ?>


		</div>
    </article>
</section>
