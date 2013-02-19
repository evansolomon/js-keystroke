<html>
<head>
	<title>KeyStroke cookies</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="jquery.cookie.js"></script>
	<script src="../min/jquery.keystroke.min.js"></script>
	<script src="toggle-cookie.js"></script>
</head>
<body>
<?php
	if ( isset( $_COOKIE['toggleableCookie'] ) )
		echo "<p>You have the secret cookie!!!!</p>";
?>
Press CTRL + C to create/delete a cookie called "toggleableCookie".
</body>
</html>
