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
		echo $this->Html->css(array('libs/bootstrap.min.css', 'libs/bootstrap.css', 'build.min.css'));
		/* Including CSS and favicon. Also outputting blocks of inline meta and CSS. */
		//echo $this->Html->css(array('example/styles.css'));
		/*echo $this->fetch('meta');
		echo $this->fetch('css');
		echo $this->Html->meta('icon');*/
	?>
</head>
<body>
	<div class="container">
		<?php echo $this->Html->Flash(); ?>
		<div id="main" role="main" class="fluid-content">
			<?php echo $typ__view; ?>
		</div>
	</div>

	<?php
		echo $this->Html->Js(array('all.min.js'));
		echo $this->Html->Script();
	?>
</body>
</html>