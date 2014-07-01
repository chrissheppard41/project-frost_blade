<!doctype html>
<html>
<head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title><?php //echo $title_for_layout; ?></title>
        <?php
        echo $this->Html->Meta('robots', 'noindex, nofollow');

        /* Including CSS and favicon. Also outputting blocks of inline meta and CSS. */
        echo $this->Html->Css(array('libs/bootstrap.min.css', 'libs/bootstrap.css', 'build.min.css'));
        ?>
</head>
<body>
        <!-- Opening topNavigation. -->
        <?php echo $this->element("admin/nav"); ?>
        <!-- Closing topNavigation. -->

        <!-- Opening mainContainer. -->
        <div id="mainContainer" class="container">
                <?php
                echo $this->Html->Flash();
                ?>

                <?php echo $this->element("admin/sub_nav"); ?>

                <div id="main" role="main">
                        <?php echo $typ__view; ?>
                </div>
                <footer>
                        <p class="pull-right">--- &copy; <?php echo date('Y'); ?></p>
                        <p>Licensed for use by <?php echo Configure::read('Company.name'); ?>, developed by <strong>---</strong>.</p>
                </footer>
        </div>
        <!-- Closing mainContainer. -->

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="/js/libs/jquery-1.7.2.min.js"><\/script>')</script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <?php
        /* Including scripts. Also outputting any inline script files and any inline buffered code. */
        echo $this->Html->Js(array('libs/bootstrap.min.js'));
        echo $this->Html->Script();
        ?>
        <!--[if lt IE 7 ]>
                <script defer src="//ajax.googleapis.com/ajax/libs/chrome-frame/1.0.3/CFInstall.min.js"></script>
                <script defer>window.attachEvent('onload',function(){CFInstall.check({mode:'overlay'})});</script>
        <![endif]-->
</body>
</html>