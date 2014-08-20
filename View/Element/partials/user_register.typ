<section class="clearfix">
	<article>
		<h2>Register <span><a href="javascript:history.go(-1)" class="back">Back</a></span></h2>

		<div class="alert alert-danger alert-dismissable form" ng-show="formMessage"><span ng-bind-html="formMessage"></span></div>

		<?php echo $this->Html->Form(array("class" => "form-vertical","id" => "UserRegisterForm","name" => "UserRegisterForm","method" => "post","accept-charset" => "utf-8", "ng-submit" => "register()")); ?>c

			<?php echo $this->Html->Input("username", "Users", array("ng-model" => "username", 'label' => 'Username', 'placeholder' => "Name", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UsersName", "required" => "required"), array(), true); ?>
			<span class="error" ng-show="UserRegisterForm.username.$error.required">You must include a valid username</span>


			<?php echo $this->Html->Input("email", "Users", array("ng-model" => "email", 'label' => 'Email', 'placeholder' => "Email", 'class' => "form-control", 'maxlength' => "255", 'type' => "email", 'id' => "UsersEmail", "required" => "required"), array(), true); ?>
			<span class="error" ng-show="UserRegisterForm.email.$error.required">You must include your email address</span>
			<span class="error" ng-show="UserRegisterForm.email.$error.email">Please enter a valid email</span>


			<?php echo $this->Html->Input("password", "Users", array("ng-model" => "password", 'label' => 'Password', 'placeholder' => "Password", 'class' => "form-control", 'type' => "password", 'id' => "UsersPassword", "required" => "required"), array(), true); ?>
			<span class="error" ng-show="UserRegisterForm.password.$error.required">You must enter a password</span>


			<?php echo $this->Html->Input("confirm_password", "Users", array("ng-model" => "confirm_password", 'label' => 'Confirm Password', 'placeholder' => "Confirm Password", 'class' => "form-control", 'type' => "password", 'id' => "UsersConfirmPassword", "required" => "required"), array(), true); ?>
			<span class="error" ng-show="UserRegisterForm.confirm_password.$error.required">You must enter your matching password</span>


			<?php echo $this->Html->Input("slug", "Users", array("ng-model" => "slug", 'type' => "hidden", 'id' => "UsersSlug"), array(), true); ?>

			<?php echo $this->Html->Submit("Register",array('class' => "btn btn-primary")); ?>
		<?php echo $this->Html->Form(); ?>


    </article>
</section>
