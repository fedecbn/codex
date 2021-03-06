
/*<![CDATA[*/

/*
Codes originels © DR.
Killeak : corrections pour compatibilite avec IE 6 et 7, Firefox 2 et Safari 2.
*/
/*
  deplacer( liste_depart, liste_arrivee )
  Déplace depuis la liste de départ (argument 1) et à destination de la liste d'arrivée (argument 2) le ou les éléments sélectionnés par l'utilisateur, l'ajout se faisant à la suite des éléments déjà présents dans la liste d'arrivée.
*/
  function deplacer( liste_depart, liste_arrivee )
  {
    for( i = 0; i < liste_depart.options.length; i++ )
    {
      if( liste_depart.options[i].selected && liste_depart.options[i] != "" )
      {
        o = new Option( liste_depart.options[i].text, liste_depart.options[i].value );
        liste_arrivee.options[liste_arrivee.options.length] = o;
        liste_depart.options[i] = null;
        i = i - 1 ;
		soumettre_2listes( liste_depart,liste_arrivee )
      }
      else
      {
        // alert( "aucun element selectionne" );
      }
    }
  }
/*
  deplacer_tout( liste_depart, liste_arrivee )
  Déplace depuis la liste de départ (argument 1) et à destination de la liste d'arrivée (argument 2) tous les éléments présents dans la liste de départ, en les ajoutant à la suite de ceux déjà présents dans la liste d'arrivée.
*/
  function deplacer_tout( liste_depart, liste_arrivee )
  {
    for( i = 0; i < liste_depart.options.length; i++ )
    {
      o = new Option( liste_depart.options[i].text, liste_depart.options[i].value );
      liste_arrivee.options[liste_arrivee.options.length] = o;
      liste_depart.options[i] = null;
      i = i - 1 ;
    }
  }
/*
  deplacer_hautbas( liste, sens )
  Déplace au sein de la liste (argument 1) un élément dans le sens (argument 2) voulu : -1 pour remonter, +1 pour descendre.
*/
  function deplacer_hautbas( liste, sens )
  {
    // init
    var listemax = liste.length - 2;
    var listesel = liste.selectedIndex;
    // debordement
    if( ( listesel < 0 ) || ( listesel < 1 && sens == -1 ) || ( listesel > listemax && sens == 1 ) )
    {
      return false;
    }
    // permutation
    tmpopt = new Option( liste.options[listesel+sens].text, liste.options[listesel+sens].value );
    liste.options[listesel+sens].text = liste.options[listesel].text;
    liste.options[listesel+sens].value = liste.options[listesel].value;
    liste.options[listesel+sens].selected = true;
    liste.options[listesel].text = tmpopt.text;
    liste.options[listesel].value = tmpopt.value;
    liste.options[listesel].selected = false;
    return true;
  }
/*
  soumettre_2listes( liste1, liste2 )
  Au moment de la soumission du formulaire, sélectionne automatiquement toutes les valeurs des listes données dans les deux arguments, afin que les valeurs choisies soit récupérées dans le script de traitement.
*/
  function soumettre_2listes( liste1, liste2 )
  {
    var listelen1 = liste1.length;
    for( i = 0; i < listelen1; i++ )
    {
      liste1.options[i].selected = true;
    }
    var listelen2 = liste2.length;
    for( j = 0; j < listelen2; j++ )
    {
      liste2.options[j].selected = true;
    }
  }
/*
  soumettre_1liste( liste )
  Au moment de la soumission du formulaire, sélectionne automatiquement toutes les valeurs de la liste donnée indiquée dans l'argument, afin que les valeurs choisies soit récupérées dans le script de traitement.
*/
  function soumettre_1liste( liste )
  {
    var listelen = liste.length;
	for( i = 0; i < listelen; i++ )
    {
      liste.options[i].selected = true;
    }
  }
//-->
/*]]>*/