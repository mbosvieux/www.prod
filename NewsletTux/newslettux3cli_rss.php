<?php

/**********************************************************************************
* NewsletTux 3 R2                                                                 *
* Project by Matthieu LACROIX (http://www.newslettux.fr)                          *
* =============================================================================== *
* Software Version:           NewsletTux 3.1.0. R2                                *
* Software by:                Matthieu LACROIX (http://www.newslettux.fr)         *
* Copyright 2009-2010 by:     NewsletTux.fr (http://www.newslettux.fr)            *
*                                                                                 *
* Support, News, Updates at:  http://www.newslettux.fr                            *
***********************************************************************************
* This program is free software but NOT open source. You may not distribute it    *
* under the terms of the provided license as published by Matthieu LACROIX        *
* You are not allowed to edit parts of this file.                                 *
*                                                                                 *
* This program is distributed in the hope that it is and will be useful, but      *
* WITHOUT ANY WARRANTIES; without even any implied warranty of MERCHANTABILITY    *
* or FITNESS FOR A PARTICULAR PURPOSE.                                            *
*                                                                                 *
* See the "{en|fr}_license_newslettux3.txt" file for details of the               *
* NewsletTux license.                                                             *
* The latest version can always be found at http://www.newslettux.fr              *
**********************************************************************************/

/*
	************************************************************************************************
	INIT VARS
	************************************************************************************************
*/
	define('NTUX3_ROOT', './');
	$this_filename = 'newslettux3cli_rss.php';
	require_once(NTUX3_ROOT.'_lib/config_vars.php');
	require_once(NTUX3_ROOT.'_lib/class_feeds.php');
	//$ntux3_page->SetTitle($ntux3_lang['title'][$this_filename]);
	//$ntux3_page->AddContent('<h1>'.$ntux3_lang['title'][$this_filename].'</h1>');

	// testing mysql.php file
	if (!file_exists(NTUX3_ROOT.'_sql/conn.php'))
	{
		die("<p class=\"ntux3_err\">Connection file missing - correct relative path or check file correctly named.<br /><br />Fichier de connexion manquant, vérifiez le chemin relatif et vérifiez que le fichier soit correctement nommé.</p>");
	};

	// is NewsletTux 3 installed ?
	if (file_exists(NTUX3_ROOT.'_admin/install.php'))
	{
		// not installed
		die("<p class=\"ntux3_err\">NewsletTux not already installed, please install it before.<br /><br />NewsletTux n'est pas installé, installez-le d'abord.</p>");
	};

	$newslettux3_rss = new NTUX3_Feeds();
?>