<section class="clearfix">
	<article>
		<h2>My profile</h2>

		echo $this->Html->Form(array(
					"action" => "/users/edit/".$typ__["data"]["Users"]["id"],
					"class" => "form-vertical",
					"id" => "UserAddForm",
					"method" => "post",
					"accept-charset" => "utf-8"
				));
			<?php
			echo $this->Html->Input("email", "Users", array('label' => 'Email', 'placeholder' => "Email", 'class' => "form-control", 'maxlength' => "255", 'type' => "text", 'id' => "UserEmail", "required" => true));
			echo $this->Html->Input("Password", "Users", array('label' => 'Password', 'placeholder' => "Password", 'class' => "form-control", 'type' => "password", 'id' => "UserPassword"));
			echo $this->Html->Input("confirm_password", "Users", array('label' => 'Confirm Password', 'placeholder' => "Confirm Password", 'class' => "form-control", 'type' => "password", 'id' => "UserConfirmPassword"));
			echo $this->Html->Submit($this->Html->__t('Save'),
				array(
					'class' => "btn btn-primary"
				)
			);
			?>
		<?php echo $this->Html->Form(); ?>
    </article>
</section>

