<?php
	if($this->ElementExists("partials/".$typ__["data"][0])) {
		echo $this->Element("partials/".$typ__["data"][0]);
	} else {
		echo "Internal error 500. No element found.";
	}