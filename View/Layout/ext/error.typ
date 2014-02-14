<?php
echo "<h1>".$typ__['code']."</h1> <p>".$typ__['message']."</p>";
foreach($typ__['errors'] as $key => $value) {
	echo "<p>".$value."</p>";
}
if(isset($typ__['trace'])) {
	echo "<p>".nl2br($typ__['trace'])."</p>";
}
?>