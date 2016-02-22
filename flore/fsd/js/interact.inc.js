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
        $tabs.tabs('disable',5);                                                // Fiche
    } 
	else {
        $tabs.tabs ("option","active",5);                                       // Fiche
        $tabs.tabs ('disable',0);                                               //                                                 
        $tabs.tabs ('disable',1);                                               //                                                 
        $tabs.tabs ('disable',2);                                               //                                                 
        $tabs.tabs ('disable',3);                                               //                                                 
        $tabs.tabs ('disable',4);                                               //                                                 
    }


	
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