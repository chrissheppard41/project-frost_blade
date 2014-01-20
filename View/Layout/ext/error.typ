<?php
echo "<h1>".$typ__passed_params['code']."</h1> <p>".$typ__passed_params['message']."</p>";
foreach($typ__passed_params['errors'] as $key => $value) {
	echo "<p>".$value."</p>";
}
if(isset($typ__passed_params['trace'])) {
	echo "<p>".nl2br($typ__passed_params['trace'])."</p>";
}
?>