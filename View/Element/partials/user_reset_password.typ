<section class="clearfix">
	<article>
		<h2>Lost password <span><a href="javascript:history.go(-1)" class="back">Back</a></span></h2>

		<div id="loginView">

			<?php echo $this->Html->Form(array("ng-submit" => "lostpassword()","class" => "form-vertical","id" => "UserLostPasswordForm","name" => "UserLostPasswordForm","method" => "post","accept-charset" => "utf-8")); ?>

				<?php echo $this->Html->Input("email", "users", array("ng-model" => "email", 'label' => 'Enter your Email', 'placeholder' => "Email", 'class' => "form-control", 'maxlength' => "255", 'type' => "email", 'id' => "UserEmail", "required" => "required"), array(), true); ?>
				<span class="error" ng-show="UserLostPasswordForm.email.$error.required">You must include your email address</span>
				<span class="error" ng-show="UserLostPasswordForm.email.$error.email">Please enter a valid email</span><br />

				<?php echo $this->Html->Submit("Register",array('class' => "btn btn-primary")); ?>
			<?php echo $this->Html->Form(); ?>


		</div>
    </article>
</section>
