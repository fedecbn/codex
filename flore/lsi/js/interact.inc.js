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


function lsi_affMasqBtn(){
    var n = $("input:checked[name='id']").length;                               // Nombre de checkbox cochée
            console.log (n);
    if(n == 0) {
        $("#lsi-export-TXT-button").button('disable');
        $("#lsi-export-PDF-button").button('disable');
        $("#lsi-del-button").button('disable'); 
    } else {
        $("#lsi-export-TXT-button").button('enable');
        $("#lsi-export-PDF-button").button('enable');
        $("#lsi-del-button").button('enable'); 
    }
}

function XOR (a,b,c) {
    return ( a || b || c) && !( a && b && c );
}
	
	
		$( "#lsi-add-button" )
        .button({
            text: true
        })
        .click(function() {
            window.location.replace ('index.php?m=add');
		});


	$( "#lsi-export-TXT-button" )
        .button({
            text: true
        })
        .click(function() {
            var sData = lsi_oTable.$('input').serialize();
            if (sData != "") {
                exportFunc ("Exporter des fiches (TXT)","#lsi-dialog",'../commun/export_TXT.php',$("#lsi-export-TXT-fichier").val(),$("#lsi-export-TXT-query").val(),$("#lsi-export-TXT-query-id").val(),sData);
            }
            return (false);
		});

    $( "#lsi-del-button" )
        .button({
            tabIndex : -1,
            text: true
        })
        .click(function() {
            var sData = lsi_oTable.$('input').serialize();
            deleteFunc ("Supprimer des fiches",'#lsi-dialog',lsi_oTable,"lsi-del.php","",sData,"");
		});

//------------------------------------------------------------------------------ BOUTONS / Exports PDF

    $( "#lsi-export-PDF-button" )
        .button({
            disabled: false,
            text: true
        })
        .click(function() {
            var sData = lsi_oTable.$('input').serialize();
            if (sData != "") {
                exportFunc ("Export PDF","#lsi-dialog",sData,'../commun/export_PDF.php',$("#lsi-export-PDF-fichier").val(),0);
            }
            return (false);
		});

		
		
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