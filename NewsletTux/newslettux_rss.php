<?php
	// cette section PHP est à placer tout en haut de votre page
	// avant même tout code HTML.
	// Modifiez si besoin le chemin relatif :
	// require_once('newslettux3/newslettux3cli_rss.php');

	// This PHP section must be located at the top of your page
	// before all HTML code
	// Edit, if needed, the relative path :
	// require_once('newslettux3/newslettux3cli_rss.php');
	require_once('newslettux3cli_rss.php');


	// le code ci dessous est l'affichage RSS ou la lecture d'une lettre
	// the code below is the RSS display or the web reading of a newsletter
	$type_flux = 'RSS'; // RSS ou ATOM
	$listes_diffusion = array(1); // seulement la liste d'ID 1, séparer par des virgules pour plusieurs listes
	$nb_items = 15; // le nombre de lettres que le flux doit lister

	$get_nid = $ntux3_text->GetValue('nid', 'int', 0);

	if ($get_nid == 0)
		$newslettux3_rss->RssFeed($type_flux, $listes_diffusion, $nb_items);
	else
		$newslettux3_rss->DisplayNewsletter($get_nid);
?>