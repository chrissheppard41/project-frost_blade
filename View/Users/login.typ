<section class="clearfix">
	<article>
		<h2>Login</h2>

		<?php echo $this->Html->Form(
			array(
				"action" => "/users/login",
				"class" => "form-vertical",
				"id" => "UserAdminLoginForm",
				"method" => "post",
				"accept-charset" => "utf-8"
			)
		); ?>
			<?php echo $this->Html->Input("email", "Users", array('label' => 'Email', 'placeholder' => "Email", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UserEmail")); ?>
			<?php echo $this->Html->Input("password", "Users", array('label' => 'Password', 'placeholder' => "Password", 'class' => "form-control", 'type' => "password", 'id' => "UserPassword")); ?>
			<input type="hidden" name="data[return_to]" id="UserReturnTo" value="/users/login" />
			<p class="controls">
				<a href="/users/reset_password">I forgot my password</a>
			</p>
			<?php echo $this->Html->Submit("Login",
				array(
					'class' => "btn btn-primary"
				)
			); ?>
		<?php echo $this->Html->Form(); ?>
	</article>
</section>

