//*******************************************************************************/
//   module_gestion/js/gestion.js                                               //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  12/08/14 - MaJ fonctions pgSQL                                //
//  Version 1.02  21/08/14 - MaJ droits                                         //
//  Version 1.03  22/08/14 - MaJ lr-liste                                       //
//  Version 1.10  31/08/14 - Aj buttonset                                       //
//  Version 1.11  01/09/14 - MaJ lr-liste                                       //
//  Version 1.12  02/08/14 - MaJ form v2                                        //
//  Version 1.13  04/09/14 - Aj plages                                          //
//  Version 1.14  08/09/14 - MaJ lr-liste                                       //
//  Version 1.15  14/09/14 - MaJ lr-liste                                       //
//  Version 1.16  14/09/14 - MaJ champs auto                                    //
//  Version 1.17  23/09/14 - MaJ lr-liste                                       //
//  Version 1.18  24/09/14 - MaJ lr-liste (coul UICN)                           //
/*******************************************************************************/

 //------------------------------------------------------------------------------ UI / Activation des onglets

    var $tabs = $("#tabs").tabs();

    if ( $("#mode").val() == 'liste') {
        $tabs.tabs('disable',2);                                                // Fiche
    } 
	else if ( $("#mode").val() == 'maj') {
        $tabs.tabs ('disable',0);                                               //   Fiche                                              
        $tabs.tabs ('disable',1);                                               //                                                 	
        $tabs.tabs ('disable',2);                                               //                                                 	
	}
	else {
        $tabs.tabs ("option","active",2);                                       // Fiche
        $tabs.tabs ('disable',0);                                               //                                                 
        $tabs.tabs ('disable',1);                                               //                                                 
    }

 //------------------------------------------------------------------------------ bouttons
	
	$( "#clear_button" )
        .button({text: true})
        .click(function() {
			metaForm ("Importer des données",670,500,'#clear-dialog',"form.php","submit.php",$(this).attr('name'),$(this).attr('value'),"Nettoyer");
			return (false);
		});
		
	$( "#import_button" )
        .button({text: true})
        .click(function() {
			metaForm ("Importer des données",670,500,'#import-dialog',"form.php","submit.php",$(this).attr('name'),$(this).attr('value'),"Importer");
			return (false);
		});
		
	$( "#import_taxon_button" )
        .button({text: true})
        .click(function() {
			metaForm ("Importer des données",670,500,'#import-dialog',"form.php","submit.php",$(this).attr('name'),$(this).attr('value'),"Importer");
			return (false);
		});

	$( "#verif_button" )
        .button({text: true})
        .click(function() {
			metaForm ("Vérification de la conformité des données",670,500,'#verif-dialog',"form.php","submit.php",$(this).attr('name'),$(this).attr('value'),"Lancer la verification");
			return (false);
		});

	$( "#diff_button" )
        .button({text: true})
        .click(function() {
			metaForm ("Analyse des différences entre la partie temporaire et la partie propre",670,500,'#diff-dialog',"form.php","submit.php",$(this).attr('name'),$(this).attr('value'),"Lancer l'analyse");
			return (false);
		});

	$( "#push_button" )
        .button({text: true})
        .click(function() {
			metaForm ("Passer les données dans la partie propre",670,500,'#push-dialog',"form.php","submit.php",$(this).attr('name'),$(this).attr('value'),"Pousser les données");
			return (false);
		});
		
	$( "#pull_button" )
        .button({text: true})
        .click(function() {
			metaForm ("Passer les données dans la partie temporaire",670,500,'#push-dialog',"form.php","submit.php",$(this).attr('name'),$(this).attr('value'),"Tirer les données");
			return (false);
		});
		
	$( "#export_button" )
        .button({text: true})
        .click(function() {
			metaForm ("Exporter des données",670,500,'#export-dialog',"form.php","submit.php",$(this).attr('name'),$(this).attr('value'),"Exporter");
			return (false);
		});
		
	$( "#bilan_button" )
        .button({text: true})
        .click(function() {
			metaForm ("Bilan sur les données",670,500,'#bilan-dialog',"form.php","submit.php",$(this).attr('name'),$(this).attr('value'),"Lancer le bilan");
			return (false);
		});


 //------------------------------------------------------------------------------ fonctin metForm
		
    function metaForm (titre,larg,haut,dialogId,formUrl,submitUrl,params,params2,name) {
        if (submitUrl != "") {
        	$(dialogId).dialog({
                open: function ()
                {
                    originalContent = $(dialogId).html();
                    $(dialogId).load (formUrl+"?id="+params+"&m="+params2);
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
                    { text: "Annuler", click: function() {
            		      $(dialogId).dialog( "close" );
                    }},
                    { text: name, click: function() {
                        if ($("#form1").valid()) {
							document.getElementById('chargement').style.display = "";
                            $("#form1",this).ajaxSubmit({
                                url: submitUrl,
                                type: "post",
                                data: { id: params, m:params2},
                                clearForm: true,
                                error: function(){
                                    alert ("Erreur AJAX");
                                },
                                success: function(e) {
                                    $(dialogId).dialog().dialog('close');
									window.location.reload();
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
                    $(dialogId).load (formUrl+"?id="+params+"&id_user="+params2);
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
    };



	
/*Autocompletion*/
 $(function() {
var availableTags = [
"Communication personnelle ()",
"EPPO",
"FLORA GALICA",
"GRIN",
"TAXA - réseau des CBN"
];

function split( val ) {
return val.split( /,\s*/ );
}

function extractLast( term ) {
return split( term ).pop();
}

var source = ["#ids1","#ids2","#ids3","#ids4","#ids5","#ids6","#ids7","#ids8","#ids9","#ids10","#ids11","#ids12","#ids13"];

for (i = 0; i < source.length; i++)
{
	$( source[i] )
	// don't navigate away from the field on tab when selecting an item
	.bind( "keydown", function( event ) {if ( event.keyCode === $.ui.keyCode.TAB &&$( this ).autocomplete( "instance" ).menu.active ) {event.preventDefault();}}).autocomplete({
	minLength: 0,source: function( request, response ) {// delegate back to autocomplete, but extract the last term
	response( $.ui.autocomplete.filter(availableTags, extractLast( request.term ) ) );},
	focus: function() {// prevent value inserted on focus
	return false;},select: function( event, ui ) {var terms = split( this.value );// remove the current input
	terms.pop();// add the selected item
	terms.push( ui.item.value );// add placeholder to get the comma-and-space at the end
	terms.push( "" );this.value = terms.join( " | " );return false;}});
} 


});