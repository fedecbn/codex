//*******************************************************************************/
//   module_gestion/js/gestion.js                                               //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  10/08/14 - MaJ fonctions pgSQL                                //
//  Version 1.02  21/08/14 - MaJ droits                                         //
//  Version 1.03  22/08/14 - MaJ lr-liste                                       //
//  Version 1.10  31/08/14 - Aj buttonset                                       //
//  Version 1.11  01/09/14 - MaJ lr-liste                                       //
//  Version 1.10  02/08/14 - MaJ form v2                                        //
//  Version 1.13  04/09/14 - Aj plages                                          //
//  Version 1.14  08/09/14 - MaJ lr-liste                                       //
//  Version 1.15  14/09/14 - MaJ lr-liste                                       //
//  Version 1.16  14/09/14 - MaJ champs auto                                    //
//  Version 1.17  23/09/14 - MaJ lr-liste                                       //
//  Version 1.18  24/09/14 - MaJ lr-liste (coul UICN)                           //
/*******************************************************************************/

function include(destination) {
var e=window.document.createElement('script');
e.setAttribute('src',destination);
window.document.body.appendChild(e);
}

affMasqBtn();

function affMasqBtn(){
    var n = $("input:checked[name='id[]']").length;                               // Nombre de checkbox cochée
            console.log (n);
    if(n == 0) {
        $("#export-TXT-button").button('disable');
        $("#export-PDF-button").button('disable');
        $("#validate-button").button('disable');
        $("#invalidate-button").button('disable');
        $("#del-button").button('disable'); 
    } else {
        $("#export-TXT-button").button('enable');
        $("#export-PDF-button").button('enable');
        $("#validate-button").button('enable');
        $("#invalidate-button").button('enable');
        $("#del-button").button('enable'); 
    }
}

function lsi_affMasqBtn(){
    var n = $("input:checked[name='id']").length;                               // Nombre de checkbox cochée
            console.log (n);
    if(n == 0) {
        $("#export-TXT-button").button('disable');
        $("#export-PDF-button").button('disable');
        $("#del-button").button('disable'); 
    } else {
        $("#export-TXT-button").button('enable');
        $("#export-PDF-button").button('enable');
        $("#del-button").button('enable'); 
    }
}

function OR_declin(a,b,c,d,e) {
    return ( a || b || c || d || e);
}

function AND_declin(a,b,c,d,e) {
    return ( a && b && c && d && e);
}

function OR_fluct (a,b,c,d) {
    return ( a || b || c || d );
}

function AND_fluct (a,b,c,d) {
    return ( a && b && c && d );
}

function fnGetSelected( oTableLocal )                                      
	{
		var aReturn = new Array();
		var aTrs = oTableLocal.fnGetNodes();
		for ( var i=0 ; i<aTrs.length ; i++ )
		{
			if ( $(aTrs[i]).hasClass('row_selected') )
			{
				aReturn.push( aTrs[i] );
			}
		}
		return aReturn;
    }

//------------------------------------------------------------------------------ Suppression (v3)
    function deleteFunc (titre,dialog,dataTable,delUrl,id,sData,mode) {
    	$(dialog).dialog({
            open: function ()
            {
                if (id != '' )
                    $(this).html("<br><center>ID = "+id+"<br><b>Confirmer la suppression ?<b></center>");
                else
                    $(this).html("<br><center><b>Confirmer la suppression ?<b></center>");
            },         
            title: titre,
            modal: true,
            position:['middle',200],
        	width: 300,
    		height: 160,
        	resizable: false,
			buttons: {
        		"Annuler": function() {
        			$(this).dialog( "close" );
        		},
        		"Supprimer": function() {
                    $.ajax({
                        url: delUrl, 
                        type: "post",
                        data: {
                            select : sData,    
                            id: id,    
                            m: mode    
                        },       
                        error: function() {
                            alert("deleteFunc > Erreur AJAX");
                        },
                        success: function(msg) {
                            if (dataTable != '' ) dataTable.fnDraw();
                        }
                    });
        			$(this).dialog( "close" );
            	}
        	}
        });
    }

//------------------------------------------------------------------------------ Exports
    function exportFunc (titre,dialogId,exportUrl,fichier,query,queryid,sData) {
        $(this).ajaxSubmit({
            url: exportUrl,
            type: "post",
            data: {
                f : fichier,
                q : query,
                i : queryid,
                select : sData
            },
            error: function(e){
                alert ("Erreur AJAX");
            },
            success: function(e) {
                $(dialogId).dialog({
                    open: function ()
                    {
                        $(this).load ("../commun/export_statut.php"+"?f="+fichier);
                    },
                    close : function(event, ui) {
                        $(this).html("");
                    },
                    title: titre,
                    modal: true,
                    position:['middle',200],
                    width: 500,
                    height: 410,
                    resizable: false,
                    buttons: {
                        "Fermer": function() {
                            $(this).dialog( "close" );
                        }
                    }
                });
            }
        });
    }

  //------------------------------------------------------------------------------ Validation
    function validateFunc (uid,class_valid) {
		$(this).load ("submit.php?mode=validation&"+uid+"&class_valid="+class_valid);
	}

	function invalidateForm (titre,larg,haut,dialogId,formUrl,submitUrl,params,params2) {
        if (submitUrl != "") {
        	$(dialogId).dialog({
                open: function ()
                {
                    originalContent = $(dialogId).html();
                    $(dialogId).load (formUrl);
                },
                close : function(event, ui) {
                    $(dialogId).html(originalContent);
                },
                title: titre,
                modal: true,
                position:['middle',100],
        		width: larg,
        		height : haut,
            	resizable: false,
    			buttons: [
                    { text: "Annuler", 
						click: function(e) {
            		      $(dialogId).dialog( "close" ); 
						}
					},
                    { text: "Enregistrer", click: function() {
                        if ($("#form1").valid()) {
                            $("#form1",this).ajaxSubmit({
                                url: submitUrl+"?"+params,
                                type: "get",
                                data: { 
								class_valid : params2,
								mode : "validation" 
								},
                                clearForm: true,
                                error: function(){
                                    alert ("Erreur AJAX");
                                },
                                success: function(e) {
                                    $(dialogId).dialog( "close" ); 
									window.location.replace ('index.php');
                                }
                            });
						}
                    }}
                ]
            });
        } else {                                                                // View
        	$(dialogId).dialog({
                open: function ()
                {
                    $(dialogId).load (formUrl);
                },
                title: titre,
                modal: true,
                position:['middle',100],
        		width: larg,
        		height : haut,
            	resizable: false,
    			buttons: [
                    { text: "Fermer", click: function() {
            		      $(dialogId).dialog( "close" );
                    }}
                ]
            });
        }
    }


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

  
