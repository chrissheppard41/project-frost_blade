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
                }
                echo $this->Html->css(array('libs/bootstrap.min.css', 'libs/bootstrap.css', 'main.css'));
*/
                /* Including CSS and favicon. Also outputting blocks of inline meta and CSS. */
                //echo $this->Html->css(array('example/styles.css'));
                /*echo $this->fetch('meta');
                echo $this->fetch('css');
                echo $this->Html->meta('icon');*/
        ?>
</head>
<body>
        <div class="container">
                <?php //echo $this->Session->flash(); ?>
                <div id="main" role="main" class="fluid-content">
                        <?php echo $typ__view; ?>
                </div>
        </div>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script src="/js/libs/jquery-ui-1.10.2.min.js"></script>
        <script src="/js/libs/angular/angular.min.js"></script>
        <script>window.jQuery || document.write('<script src="/js/libs/jquery-1.7.2.min.js"><\/script>')</script>
        <?php
                /* Including scripts. Also outputting any inline script files and any inline buffered code. */
                //echo $this->Html->script(array('example/script.js'));
                /*echo $this->Html->script(array(
                        'libs/moment.js'
                        ));
                echo $this->fetch('script');
                echo $this->Js->writeBuffer(array('onDomReady' => true));*/
        ?>
</body>
</html>