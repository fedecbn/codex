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

//------------------------------------------------------------------------------ FORM/ ajout d'input a la volée biblio
//http://stackoverflow.com/questions/34533772/problems-with-remove-since-replacing-live-with-on
//solution https://jsfiddle.net/anacaona83/o8o9w20d/

/*
$(function() {
        var scntDiv = $('#p_scents');
        var i = $('#p_scents p').size()+1;

        
        $('#addScnt').on('click', function() {
                var url = '../../_INCLUDE/fonctions.inc.php';
                $('<p><TABLE BORDER="0"><tr><td>metaform_text ("Nom du syntaxon","no_lab",100,"","p_scnt",pg_result($result,0,"\"$colname2\""), pg_fetch_result(pg_query ($db,$query_description."\'$colname2\'".";"),0,"description" ));</td><td><label for="p_scnts"><input type="text" id="p_scnt" size="20" name="p_scnt_code_' + i +'" value="' + i + '" placeholder="Valeur de l\'input" /></label><button type=\"button\" href="#" id="remScnt">Supprimer</button></td></tr></TABLE></p>').appendTo(scntDiv);
	      i++;
                return false;
        });
        
        $('#remScnt').on('click', function() {
                if( i > 2 ) {
                        $(this).parents('tr').remove();
                        i--;
                }
                return false;
        });
});
*/


/*
function concatenatenomcomplet () {
		var nom = $("#nomSyntaxon");
		var pr = nom.val();
		nom.removeClass("error");
        document.getElementById('nomCompletSyntaxon').value=pr;
		return (true);
	};
	
$("#nomCompletSyntaxon").keyup (concatenatenomcomplet);

*/

$(function() {
  var scntDiv = $('#p_scents');
  var i = $('#p_scents p').size() + 1;

  $('#addScnt').on('click', function() {
    $('<p><TABLE BORDER="0"><TR><TH><label for="p_scnts"><input type="text" id="p_scnt_typo_' + i + '" size="20" name="typo_' + i + '" value="p_scnt_typo_' + i + '" placeholder="Valeur de l\'input" /></label></TH><TH><label for="p_scnts"><input type="text" id="p_scnt_code_' + i + '" size="20" name="code_' + i + '" value="p_scnt_code_' + i + '" placeholder="Valeur de l\'input" /></label><a href="#" id="remScnt">Supprimer</a></TH></p>').appendTo(scntDiv);
    i++;
    return false;
  });

  scntDiv.on('click', '#remScnt', function() {
    if (i > 2) {
      $(this).parents('tr').remove();
      i--;
    }
    return false;
  });
});



/*
// cette chose étrange permet de ne n'avoir aucune variable visible dans la page
// comme si elles n'existaient pas. Pas de polution de l'espace global, bien.
(function () {
 
        var champs = [
                "id_frais",
                "societe",
                "pourcentage"
            ],
 
            // fin de la config
            modifier = document.getElementById("modifier"),
            valider = document.getElementById("valider"),
            ajouter_ligne = document.getElementById("ajouter_ligne"),
            table = document.getElementById("frais"),
            form = document.getElementById("form_frais");
 
 
 
        function action_valider () {
            champs_disabled(true);
            valider.disabled = true;
            modifier.disabled = false;
 
            /*
                La partie en AJAX c'est ici que ça se passe
 
           */
 
 /*
        }
        // désactive les bouttons qui vont bien
        function action_modifier () {
            champs_disabled(false);
            valider.disabled = false;
            modifier.disabled = true;
        }
        // désactiver les champs pour pas tout niquer
        function champs_disabled (disabled) {
            var i,c = table.tBodies[0].getElementsByTagName("input"),
                l = c.length;
 
            for (i = 0; i < l; i++) {
                c[i].disabled = disabled;
            }
        }
 
        form.onsubmit = function () {return false;} // on empeche d'envoyer le formulaire
        modifier.onclick = action_modifier; // on rend les inputs actifs
        valider.onclick = action_valider; // on envoie la requete AJAX et on rens les champs disabled
 
        ajouter_ligne.onclick = function () {// le petit bouton magique pour rajouter des lignes
 
            var i, supprimer,
            tbody = table.tBodies[0],
            ligne = tbody.insertRow(-1);
 
            function champ (name, value) { // juste parce que c'est chiant de retapper
                var t = document.createElement("input");
 
                t.type = "text";
                t.name = t.id = name +"[]";
                t.value = value || "";
 
                return t;
            }
            // ici on rajoute les cellules (<td>) des différentes rubriques…
            for (i =0; i < champs.length; i++) {
                (ligne.insertCell(i)).appendChild(champ(champs[i]));
            }
             
            supprimer = document.createElement("button");
            supprimer.type = "button";
            supprimer.className = "del";
            supprimer.innerHTML = "×";
            supprimer.onclick = function () {
                var tr = this.parentNode.parentNode;
                    index = tr.sectionRowIndex;
 
                tbody.deleteRow(index);
 
                valider.disabled = false;
                modifier.disabled = true;
            };
 
 
            i = ligne.insertCell(champs.length);
            i.className = "actions";
            i.appendChild(supprimer);
 
            //maintenant on va renuméroter les lignes pour éviter les merdouilles
            var n, nt, inputs, index;
            //c'est pas génial comme déclaration mais bon…
 
            for (var n = 0, nt = tbody.rows.length; n < nt; n++) {
                inputs = tbody.rows[n].getElementsByTagName("input");
                index = tbody.rows[n].sectionRowIndex;
                for (var nn = 0, ntn = inputs.length; nn < ntn; nn++) {
                    inputs[nn].id = inputs[nn].name = inputs[nn].name.replace(/\[\d*\]$/, "["+index+"]");
                }
            }
 
            // on a rajouté une ligne donc on réactive la soumission de formulaire
            valider.disabled = false;
            modifier.disabled = true;
        };
             
 
    })();
    
    */ 
	
	
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