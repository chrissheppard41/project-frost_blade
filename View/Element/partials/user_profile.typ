<section class="clearfix">
	<article>
		<h2>My profile <span><a href="javascript:history.go(-1)" class="back">Back</a></span></h2>

		<div class="alert alert-danger alert-dismissable form" ng-show="formMessage"><span ng-bind-html="formMessage"></span></div>
		<div class="alert alert-success alert-dismissable form" ng-show="formSuccessMessage"><span ng-bind-html="formSuccessMessage"></span></div>

		<?php echo $this->Html->Form(array(
					"class" => "form-vertical",
					"id" => "UserProfileForm",
					"name" => "UserProfileForm",
					"method" => "post",
					"accept-charset" => "utf-8",
					"ng-submit" => "profile()"
				)); ?>

			<?php echo $this->Html->Input("email", "users", array("ng-model" => "email", 'label' => 'Email', 'placeholder' => "Email", 'class' => "form-control", 'maxlength' => "255", 'type' => "email", 'id' => "UsersEmail", "required" => "required"), array(), true); ?>
			<span class="error" ng-show="UserProfileForm.email.$error.required">You must include your email address</span>
			<span class="error" ng-show="UserProfileForm.email.$error.email">Please enter a valid email</span>


			<?php echo $this->Html->Input("password", "users", array("ng-model" => "password", 'label' => 'Password', 'placeholder' => "Password", 'class' => "form-control", 'type' => "password", 'id' => "UsersPassword"), array(), true); ?>


			<?php echo $this->Html->Input("confirm_password", "users", array("ng-model" => "confirm_password", 'label' => 'Confirm Password', 'placeholder' => "Confirm Password", 'class' => "form-control", 'type' => "password", 'id' => "UsersConfirmPassword"), array(), true); ?>

			<?php echo $this->Html->Submit($this->Html->__t('Save'),
				array(
					'class' => "btn btn-primary"
				)
			);
			?>
		<?php echo $this->Html->Form(); ?>
    </article>
</section>