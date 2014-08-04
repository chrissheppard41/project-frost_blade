<section class="clearfix">
	<article>
		<h2>User login <span><a href="#/" class="back">Back</a></span></h2>

		<div class="alert alert-danger alert-dismissable form" ng-show="formMessage"><span ng-bind-html="formMessage"></span></div>

		<?php echo $this->Html->Form(
			array(
				"class" => "form-vertical",
				"name" => "UserLoginForm",
				"id" => "UserLoginForm",
				"method" => "post",
				"accept-charset" => "utf-8",
				"ng-submit" => "login()"
			)
		); ?>
			<?php echo $this->Html->Input("email", "Users", array("ng-model" => "email", "name" => "email", 'label' => 'Email', 'placeholder' => "Email", 'class' => "form-control", 'maxlength' => "255", 'type' => "email", 'id' => "UserEmail", "required" => "required"), array(), true); ?>

			<span class="error" ng-show="UserLoginForm.email.$error.required">You must include your email address</span>
			<span class="error" ng-show="UserLoginForm.email.$error.email">Please enter a valid email</span>

			<?php echo $this->Html->Input("password", "Users", array("ng-model" => "password", 'label' => 'Password', 'placeholder' => "Password", 'class' => "form-control", 'type' => "password", 'id' => "UserPassword", "required" => "required"), array(), true); ?>

			<span class="error" ng-show="UserLoginForm.password.$error.required">You must enter a password</span>

			<input type="hidden" name="data[return_to]" id="UserReturnTo" value="/users/login" />
			<p class="controls">
				<a href="#/user/reset_password">I forgot my password</a>
			</p>
			<?php echo $this->Html->Submit("Login",
				array(
					'class' => "btn btn-primary"
				)
			); ?>
		<?php echo $this->Html->Form(); ?>

	</article>
</section>