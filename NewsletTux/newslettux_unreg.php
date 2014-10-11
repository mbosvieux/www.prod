<?php
	// cette section PHP est à placer tout en haut de votre page
	// avant même tout code HTML.
	// Modifiez si besoin le chemin relatif :
	// require_once('newslettux3/newslettux3cli_form_subscribe.php');

	// This PHP section must be located at the top of your page
	// before all HTML code
	// Edit, if needed, the relative path :
	// require_once('newslettux3/newslettux3cli_form_subscribe.php');
	require_once('newslettux3cli_form_subscribe.php');
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="fr">
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<title>D&eacute;sinscription d'une liste de diffusion</title>
</head>
<body>
	<p>Vous allez &ecirc;tre d&eacute;sinscrit(e) de la liste de diffusion.</p>
<?php
	// ici est le code d'affichage du formulaire de désinscription.
	// vous pouvez placer ce bloc PHP n'importe où dans votre code HTML.

	// here is the code to display the unsubscription form.
	// you can write this PHP section wherever you want in your HTML code.
	echo $newslettux3->UnregForm('');
?>
</body>
</html>