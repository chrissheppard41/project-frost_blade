<!doctype html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<title><?php //echo $title_for_layout; ?></title>
	<?php
		/* Checks if the domain is a sub-domain of rehabstudio, and if so, adds a meta robots tag. */
		/*if (strripos(str_replace('www.', '', env('HTTP_HOST')), '.rehabstudio.com')) {
			echo $this->Html->meta(array('name' => 'robots', 'content' => 'noindex, nofollow'));
		}*/
		echo $this->Html->css(array(/*'libs/bootstrap.min.css', 'libs/bootstrap.css', */'build.min.css'));
		/* Including CSS and favicon. Also outputting blocks of inline meta and CSS. */
		//echo $this->Html->css(array('example/styles.css'));
		/*echo $this->fetch('meta');
		echo $this->fetch('css');
		echo $this->Html->meta('icon');*/
	?>
</head>
<body id="army_default">
	<div class="container">
		<header>
			<h1>Army Display tool</h1>

			<?php
			if(\Configure::Logged()) {
			?>
			<div>
				<span class="button">
					<?php
						echo $this->Html->Url($this->Html->__t('Logout'), array('controller' => 'users', 'action' => 'logout'), array('class' => 'red'));
						echo $this->Html->Url($this->Html->__t('Profile'), array('controller' => 'users', 'action' => 'profile'), array('class' => 'orange'));
					?>
				</span>
				<span class="user">Welcome: <?php echo $this->Session->read("Auth.user.username"); ?></span>
			</div>
			<?php
			} else {
			?>
			<div>
				<span class="button">
					<?php
						echo $this->Html->Url($this->Html->__t('Login'), array('controller' => 'users', 'action' => 'login'), array('class' => 'blue'));
						echo $this->Html->Url($this->Html->__t('Register'), array('controller' => 'users', 'action' => 'register'), array('class' => 'green'));
					?>
				</span>
				<span class="user">Welcome: Guest</span>
			</div>
			<?php
			}
			?>

		</header>

		<?php echo $this->Html->Flash(); ?>
		<div id="main" role="main" class="fluid-content">
			<?php echo $typ__view; ?>
		</div>

		<footer>
			<span>&copy; Chris Sheppard, <?php echo date('Y'); ?></span>
		</footer>
	</div>

	<?php
		echo $this->Html->Js(array('all.min.js'));
		echo $this->Html->Script();
	?>
</body>
</html>