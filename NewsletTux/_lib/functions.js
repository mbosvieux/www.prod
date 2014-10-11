
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
* This program is free software but NOT open source. You may distribute it        *
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


function NTUX3_SwitchDisplay(id_element)
{
	if (document.getElementById(id_element).style.display=='none')
		document.getElementById(id_element).style.display='';
	else
		document.getElementById(id_element).style.display='none';
}

function NTUX3_HideAll(id)
{
	for (var i=0; i < 1000; ++i)
	{
		if (document.getElementById(id+i))
		{
			//alert('cache bloc '+ id);
			document.getElementById(id+i).style.display='none';
		}
	}
}

function NTUX3_HideArea(id_area, timeout)
{
	window.setTimeout("NTUX3_SwitchDisplay('" + id_area + "')", 1000*timeout);
};

function NTUX3_popUp(URL)
{
	day = new Date();
	id = day.getTime();
	eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=800,height=600');");
}



function NTUX3_SwitchDisplayIcon(id_element)
{
	// if id_element displayed, hide it. Switch to icon "Display"
	if(document.getElementById(id_element).style.display=='none')
	{
		document.getElementById(id_element).style.display='';
		document.getElementById('img_'+id_element).src='./img/ico/20/hide.png';
	}
	else
	{
		document.getElementById(id_element).style.display='none';
		document.getElementById('img_'+id_element).src='./img/ico/20/show.png';
	}
	//alert(document.getElementById('img_'+id_element).src);
}

function NTUX3_ExpandCat(cat_name, id_cat)
{
	var url_hide = '../_img/ico/16/collapse.png';
	var url_show = '../_img/ico/16/expand.png';
	//var url_hide = '_img/hide.png';
	//var url_show = '_img/show.png';
	if(document.getElementById(cat_name+id_cat).style.display=='none')
	{
		document.getElementById(cat_name+id_cat).style.display='';
		if(document.getElementById('img_'+cat_name+id_cat))
			document.getElementById('img_'+cat_name+id_cat).src=url_hide;
	}
	else
	{
		document.getElementById(cat_name+id_cat).style.display='none';
		if(document.getElementById('img_'+cat_name+id_cat))
		document.getElementById('img_'+cat_name+id_cat).src=url_show;
	}
}


function NTUX3_OnClickShowItem(id_checkbox, id_item)
{
	if(document.getElementById(id_checkbox).checked==false)
		document.getElementById(id_item).style.display='none';
	else
		document.getElementById(id_item).style.display='';

}



function NTUX3_SwitchCheckbox(id)
{
	var status = document.getElementById(id).checked;
	document.getElementById(id).checked = !status;
}

function NTUX3_SelectCheckboxes(action, id)
{
	var checkboxes = document.getElementById(id).getElementsByTagName('input');
	for (var i=0;i<checkboxes.length;i++)
	{
		if (checkboxes[i].type == 'checkbox')
		{
			if (action == 'all')
			{
				checkboxes[i].checked = true;
			}

			if (action == 'none')
			{
				checkboxes[i].checked = false;
			}

			if (action == 'invert')
			{
				if (checkboxes[i].checked)
					checkboxes[i].checked = false;
				else
					checkboxes[i].checked = true;
			}
		}
	}
	return true;
}



function NTUX3_ConfirmLink(link, text)
{
	if(confirm(text + '\n[OK]  Oui\n[Annuler]  Non'))
		window.open(lien.href);

	return false;
}




function NTUX3ajax_ChkValue(theValue, NTUX3_ROOT, theValueToCheck)
{
	//alert('VALUE=' + theValueToCheck);
	switch(theValue)
	{
		case 'email':
			var url = NTUX3_ROOT+'_admin/n3_ajax.php?act=check_email';
			var url_end = '&email=' + theValueToCheck;
			break;

		case 'profile_title':
			var url = NTUX3_ROOT+'_admin/n3_ajax.php?act=check_profile_title';
			var url_end = '&title=' + theValueToCheck;
			break;
	};

	var httpRequest = false;

	if (window.XMLHttpRequest)
	{ // Mozilla, Safari,...
		httpRequest = new XMLHttpRequest();
		if (httpRequest.overrideMimeType)
		{
			httpRequest.overrideMimeType('text/xml');
			// Voir la note ci-dessous à propos de cette ligne
		}
	}
	else if (window.ActiveXObject)
	{ // IE
		try
		{
			httpRequest = new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch (e)
		{
			try
			{
				httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch (e) {}
		}
	}

	if (!httpRequest)
	{
		alert('Abandon :( Impossible de créer une instance XMLHTTP');
		return false;
	}

	httpRequest.onreadystatechange = function() { NTUX3alertAjax_ChkValue(theValue, httpRequest, theValueToCheck); };
	httpRequest.open('GET', url + url_end, true);
	httpRequest.send(null);
	return true;
}

function NTUX3alertAjax_ChkValue(theValue, httpRequest, theValueToCheck)
{
	//alert('RDY : ' + httpRequest.readyState + ' STATUS : ' +httpRequest.status);
	if (httpRequest.readyState == 4)
	{
		if (httpRequest.status == 200)
		{
			//alert(httpRequest.responseText);
			// Edit page content
			var num_rows = httpRequest.responseText;
			//alert ('RECU=' + num_rows);
			//var num_rows = str.split('|');

			switch(theValue)
			{
				case 'email':
					switch(num_rows)
					{
						case '0':
							document.getElementById('email').className='input_ok';
							document.getElementById('ajax_warning_email_exists').style.display='none';
							document.getElementById('ajax_warning_email_bad_syntax').style.display='none';
							break;

						case '1':
							document.getElementById('email').className='input_nok';
							NTUX3_SwitchDisplay('ajax_warning_email_exists');
							break;

						case '2':
							document.getElementById('email').className='input_warning';
							NTUX3_SwitchDisplay('ajax_warning_email_bad_syntax');
							break;
					};
					break;


				case 'profile_title':
					switch(num_rows)
					{
						case '0':
							document.getElementById('title').className='input_ok';
							document.getElementById('ajax_warning_title_exists').style.display='none';
							break;

						case '1':
							document.getElementById('title').className='input_nok';
							NTUX3_SwitchDisplay('ajax_warning_title_exists');
							break;
					};
					break;
			};
		}
		else
		{
			alert('Un problème est survenu avec la requête.');
		}
	}
}

function NTUX3_AdminAddProfile(str)
{
	//alert ("str INI : " + str);
	var my_rand = parseInt(Math.random() * 1000000+1);
	//alert('RAND=' + my_rand);


	// add new LI into target_id_profiles
	var container = document.getElementById('target_id_profiles');
	//alert('TIdProf contient '+container.length +' objets');

	// Create a new <li> element for to insert inside <ul id="target_id_profiles">
	var new_element = document.createElement('li');

	// before insertint 'str', unescape special chars
	var str2 = str.replace(/@@@/gi, '"');
	var str_final = str2.replace(/{LISTITEM}/gi, my_rand);
	//alert ("str END : " + str_final);

	new_element.innerHTML = str_final;
	container.insertBefore(new_element, container.lastChild);
}

function NTUX3_AdminActivateUnitTestField()
{
	if (document.getElementById('is_draft').checked == true)
	{
		document.getElementById('is_ut').checked=false;
		document.getElementById('li_unit_test_email').style.display='none';
		document.getElementById('li_unit_test_email_formats').style.display='none';
	}
	else
	{
		document.getElementById('is_ut').checked=true;
		document.getElementById('li_unit_test_email').style.display='';
		document.getElementById('li_unit_test_email_formats').style.display='';
	};
}

function NTUX3_AdminSelectDateSend(checked_element)
{
	switch(checked_element)
	{
		case '0':
			document.getElementById('select_date').style.display='none';
			document.getElementById('send_now').style.display='none';
			/*document.getElementById('just_send_now').checked=false;*/
			break;

		case '1':
			document.getElementById('select_date').style.display='';
			document.getElementById('send_now').style.display='none';
			/*document.getElementById('just_send_now').checked=false;*/
			break;

		case '2':
			document.getElementById('select_date').style.display='none';
			document.getElementById('send_now').style.display='';
			/*document.getElementById('just_send_now').checked=true;*/
			break;
	};

}



function NTUX3_SelectLine(valueselect, line_id, old_classname)
{
	if (valueselect != 'field_type_none')
	{
		document.getElementById(line_id).style.fontWeight='bold';
		document.getElementById(line_id).className='input_ok';
	}
	else
	{
		document.getElementById(line_id).style.fontWeight='normal';
		document.getElementById(line_id).className=old_classname;
	}
}



