//*******************************************************************************/
//   commun/js/fiche_taxon.js                                                   //
//                                                                              //
//  Banque de semences VANDA                                                    //
//                                                                              //
//  Version 1.00  15/09/13 - DariaNet                                           //
//  Version 1.10  09/12/13 - MaJ fiche                                          //
//  Version 1.11  13/02/14 - Aj bouton [Fermer]                                 //
//  Version 1.12  11/05/14 - MaJ Qtips => tooltip                               //
/*******************************************************************************/

$(document).ready(function(){

//------------------------------------------------------------------------------ UI / tooltip

    $( document ).tooltip();

//------------------------------------------------------------------------------ UI / Tabs

//------------------------------------------------------------------------------ UI / Boutons

    $( "#close-button" )                                                       //  [Fermer]
        .button({
            icons: {
                primary: "ui-icon-closethick"
            },
            text: true
        })
        .click(function() {
            void window.close();
		});

    $( "#home-button" )
        .button({
            text: false
        })
        .click(function() {
            window.location.replace ('../home/index.php');
		});

//------------------------------------------------------------------------------ Lightbox

   $('#lightbox a').lightBox({
     	overlayBgColor: '#979797',
       	overlayOpacity: 1,
       	containerResizeSpeed: 350,
    	imageLoading: '../../_GRAPH/loading.gif',
    	imageBtnClose: '../../_GRAPH/close.png',
    	imageBtnPrev: '../../_GRAPH/prev.png',
    	imageBtnNext: '../../_GRAPH/next.png',       	
        txtImage: 'Photo',
       	txtOf: 'sur',
        width: 100,
        height: 100
    });

//------------------------------------------------------------------------------ LISTES

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

//------------------------------------------------------------------------------ LISTE / Catalogue
/*
    if (typeof catalog_oTable == 'undefined') {
        var catalog_oTable = $('#liste_catalog').dataTable({
   	    "bJQueryUI": true,
        "iDisplayLength": 100,
    	"aLengthMenu": [[50,100,300],[50,100,300]],
    	"bPaginate": true,
        "sPaginationType": "full_numbers",
    	"bLengthChange": true,
    	"bFilter": true,
    	"bSort": true,
    	"bInfo": true,
    	"bAutoWidth": false,
		"bProcessing": true,
    	"bServerSide": true,
    	"sAjaxSource": "catalog-liste.php",
        "bStateSave": true,
        "oLanguage": { "sProcessing":   "Traitement en cours...",
            "sLengthMenu":   "Afficher _MENU_ taxons",
            "sZeroRecords":  "Aucun taxon à afficher",
            "sInfo": "Affichage du taxon _START_ à _END_ sur _TOTAL_ ",
            "sInfoEmpty": "Affichage du taxon 0 à 0 sur 0 ",
            "sInfoFiltered": "(filtré de _MAX_ taxons au total)",
            "sInfoPostFix":  "",
            "sSearch":       "Filtrer sur tous les champs ",
            "sUrl":          "",
            "oPaginate": {
                "sFirst":    "Premier",
                "sPrevious": "Précédent",
                "sNext":     "Suivant",
                "sLast":     "Dernier"
            }
        }, 
        "aaSorting": [[2,'asc']],
//        "sDom": '<"top"f>rt<"bottom"ilp><"clear">',
        "sDom": '<"top"fl>rt<"bottom"ip>',
            "aoColumns": [
        	{ "sWidth": "60px" },                                               // CD_NOM
        	{ "sWidth": "60px" },                                               // CD_NOM
        	{ "sWidth": "500px" },                                              // Nom complet 
//        	{ "sClass": "taxon_rec","sWidth": "500px" },                        // Nom complet 
        	{ "sWidth": "500px" },                                              // Nom FR.
        	{ "sWidth": "100px" },                                              // Type biolo.
  			{ "sClass": "center","sWidth": "50px" },                            // UICN
//        	{ "sWidth": "100px" },                                              // Source
    		{ "sClass": "center","sWidth": "30px" },                            // Commentaire
    		{ "sClass": "center","sWidth": "30px" },                            // Relecture CBNMED
    		{ "sClass": "center","sWidth": "30px" },                            // Relecture CBNA
    		{ "sClass": "center","sWidth": "30px" },                            // Publication
    		{ "sClass": "center","sWidth": "90px","bSortable": false }          // Actions
        ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
                { type: "text" },                                               // ID
                { type: "text" },                                               // CD_NOM
                { type: "text" },                                               // Nom complet 
                { type: "text" },                                               // Nom FR.
                null,                                                // Type biolo.
                { type: "select", values: ['EX','EW','RE','CR','EN','VU','NT','LC','DD','NA','NE']}, // UICN
//                null,                                                           // Source
                null,                                                           // Commentaire
                { type: "select", values: ['0','1']},                           // RELECTURE
                { type: "select", values: ['0','1']},                           // RELECTURE
                { type: "select", values: ['0','1']}                            // Publication
			]
		});        
	} else {
		catalog_oTable.fnClearTable( false );
		catalog_oTable.fnDraw();
	}	

	$( ".catalog-view" ).live("click",function (event) {
        window.location.replace ('index.php?m=fiche&id='+$(this).attr('id'));				
//        $tabs.tabs('enable',2);
//        $tabs.tabs('select',2);                                                 
//        taxonView ("Fiche taxon","catalog-view.php",$(this).attr('id'));   
        return (false);
	});

	$( ".catalog-edit" ).live("click",function (event) {
        window.location.replace ('index.php?m=edit&id='+$(this).attr('id'));				
//        catalogForm ("Modifier un taxon","catalog-form.php",$(this).attr('id'));   
        return (false);
	});
		
	$( ".catalog-del" ).live("click",function (event) {
        deleteFunc ("Supprimer un taxon",'#catalog-dialog',catalog_oTable,"catalog-del.php",$(this).attr('id'));  
		return (false);
	});
*/
//------------------------------------------------------------------------------ LISTES / Banque de semences

    if (typeof banque_sem_oTable == 'undefined') {
       var banque_sem_oTable = $('#banque-sem-liste').dataTable({
    		"bJQueryUI": true,
    		"bPaginate": false,
    		"bLengthChange": false,
    		"bFilter": false,
    		"bSort": true,
    		"bInfo": false,
    		"bServerSide": false,
            "oLanguage": { "sProcessing":   "Traitement en cours...",
                "sLengthMenu":   "Afficher _MENU_ éléments",
                "sZeroRecords":  "Aucun élément à afficher",
                "sInfo": "Affichage de l'élement _START_ à _END_ sur _TOTAL_ éléments",
                "sInfoEmpty": "Affichage de l'élement 0 à 0 sur 0 éléments",
                "sInfoFiltered": "(filtré de _MAX_ eléments au total)",
                "sInfoPostFix":  "",
                "sSearch":       "Rechercher:",
                "sUrl":          "",
                "oPaginate": {
                    "sFirst":    "Premier",
                    "sPrevious": "Précédent",
                    "sNext":     "Suivant",
                    "sLast":     "Dernier"
                }
            }, 
//            "aaSorting": [[2,'asc']],
            "aoColumns": [
        		null,                                                           // Commune
        		{ "sWidth": "60px" },                                           // INSEE
        		null,                                                           // Date(s) de récolte
        		null,                                                           // Nb acces.
        		{ "sClass": "center","sWidth": "30px" },                        // CBNMED
        		{ "sClass": "center","sWidth": "30px" }                         // CBNA
    		]
    	});
	} else {
		banque_sem_oTable.fnClearTable (false);
		banque_sem_oTable.fnDraw ();
	}	

//------------------------------------------------------------------------------ LISTES / Germination - Protocoles testés

    if (typeof germin_prot_test_oTable == 'undefined') {
       var germin_prot_test_oTable = $('#germin-prot-test-liste').dataTable({
    		"bJQueryUI": true,
    		"bPaginate": false,
    		"bLengthChange": false,
    		"bFilter": false,
    		"bSort": true,
    		"bInfo": false,
    		"bServerSide": false,
            "oLanguage": { "sProcessing":   "Traitement en cours...",
                "sLengthMenu":   "Afficher _MENU_ éléments",
                "sZeroRecords":  "Aucun élément à afficher",
                "sInfo": "Affichage de l'élement _START_ à _END_ sur _TOTAL_ éléments",
                "sInfoEmpty": "Affichage de l'élement 0 à 0 sur 0 éléments",
                "sInfoFiltered": "(filtré de _MAX_ eléments au total)",
                "sInfoPostFix":  "",
                "sSearch":       "Rechercher:",
                "sUrl":          "",
                "oPaginate": {
                    "sFirst":    "Premier",
                    "sPrevious": "Précédent",
                    "sNext":     "Suivant",
                    "sLast":     "Dernier"
                }
            }, 
//            "aaSorting": [[2,'asc']],
            "aoColumns": [
//        		{ "sWidth": "60px" },                                           // Date début
        		null,                                                           // Prétraitement
        		null,                                                           // Traitement
        		null                                                            // Régime photo et thermo.
//        		{ "sClass": "center","sWidth": "30px" },                        // CBNMED
//        		{ "sClass": "center","sWidth": "30px" }                         // CBNA
    		]
    	});
	} else {
		germin_prot_test_oTable.fnClearTable (false);
		germin_prot_test_oTable.fnDraw ();
	}	

//------------------------------------------------------------------------------ LISTES / Germination - Protocoles favorables

    if (typeof germin_prot_favo_oTable == 'undefined') {
       var germin_prot_favo_oTable = $('#germin-prot-favo-liste').dataTable({
    		"bJQueryUI": true,
    		"bPaginate": false,
    		"bLengthChange": false,
    		"bFilter": false,
    		"bSort": true,
    		"bInfo": false,
    		"bServerSide": false,
            "oLanguage": { "sProcessing":   "Traitement en cours...",
                "sLengthMenu":   "Afficher _MENU_ éléments",
                "sZeroRecords":  "Aucun élément à afficher",
                "sInfo": "Affichage de l'élement _START_ à _END_ sur _TOTAL_ éléments",
                "sInfoEmpty": "Affichage de l'élement 0 à 0 sur 0 éléments",
                "sInfoFiltered": "(filtré de _MAX_ eléments au total)",
                "sInfoPostFix":  "",
                "sSearch":       "Rechercher:",
                "sUrl":          "",
                "oPaginate": {
                    "sFirst":    "Premier",
                    "sPrevious": "Précédent",
                    "sNext":     "Suivant",
                    "sLast":     "Dernier"
                }
            }, 
//            "aaSorting": [[2,'asc']],
            "aoColumns": [
        		null,                                                           // Prétraitement
        		null,                                                           // Traitement
        		null,                                                           // Régime photo et thermo.
        		{ "sWidth": "80px" },                                           // % germinatif
//        		{ "sWidth": "80px" },                                           // % corrigé
        		null                                                            // Graines utilisées
//        		null,                                                           // Mode de conservation
//        		{ "sClass": "center","sWidth": "30px" },                        // CBNMED
//        		{ "sClass": "center","sWidth": "30px" }                         // CBNA
    		]
    	});
	} else {
		germin_prot_favo_oTable.fnClearTable (false);
		germin_prot_favo_oTable.fnDraw ();
	}	

//------------------------------------------------------------------------------ EXPORTS / LOGS
/*
	$( "a",".log-export" ).button({icons: {primary: "ui-icon-document"},text: true});
    $( "#link-log-export" ).click(function() {
		$( "#log-export" ).dialog( "open" );
			return false;
	});
	$( "#log-export" ).dialog({
    	autoOpen: false,
		resizable: false,
		draggable: true,
        width: 500,
		height: 370,
		modal: true,
		buttons: {
			"Fermer": function() {
				$( this ).dialog( "close" );
			}
		}
	});	
*/
//------------------------------------------------------------------------------ INT Page

    $("#init_page").hide();
    $("#main_page").show();

//------------------------------------------------------------------------------ FORM / Exit

	$( "#exit-confirm" ).dialog({
		modal: true,
        position:['middle',200],
		height:180,
    	autoOpen: false,
		resizable: false,
		buttons: {
				"Non": function() {
					$( this ).dialog( "close" );
				},
				"Oui": function() {
					$( this ).dialog( "close" );
                    window.location.replace ('../home/index.php');				
                }
			}
		});
});

//------------------------------------------------------------------------------ Banque de semence

function banque_sem_list(){
    var CD_NOM = $("#CD_NOM").val();                           
    if (CD_NOM != "") 
    {
    	var url = 'CD_NOM='+escape(CD_NOM);             
    	$.ajax({
			type: "POST",
		    url: "../commun/banque_sem_process.php",
		    cache: false,
			data: url,
            error: function() {
                alert("banque_sem_list > Erreur AJAX");
                return false;
            },
		    success: function(html){
			    $("#banque_sem_list").html(html);
		    }
	    });
    }
	return false;                                                
}

function banque_sem_add(){
    var CD_NOM = $("#CD_NOM").val();                           
    var nom_commune_maj = $("#nom_commune_maj").val();                           
    var insee_commune = $("#insee_commune").val();                           
    var date_recolte = $("#date_recolte").val();                           
    var nbre_access = $("#nbre_access").val();                           

    if (CD_NOM != "" & nom_commune_maj != "" & insee_commune != "" & date_recolte != "" & nbre_access != "") 
    {
    	var url = 'submit=1&nom_commune_maj='+escape(nom_commune_maj)+'&insee_commune='+escape(insee_commune)+'&date_recolte='+escape(date_recolte)+'&nbre_access='+escape(nbre_access)+'&CD_NOM='+escape(CD_NOM);             
		$.ajax({
			type: "POST",
			url: "../commun/banque_sem_process.php",
			data: url,
            error: function() {
                alert("banque_sem_add > Erreur AJAX");
                return false;
            },
			success: function(){
				$("#nom_commune_maj").val('');
				$("#insee_commune").val('');
				$("#date_recolte").val('');
				$("#nbre_access").val('');
				banque_sem_list();
			}
		});
    }
	return false;                                                
}

//------------------------------------------------------------------------------ Germination / Protocoles testés

function prot_test_list(){
    var CD_NOM = $("#CD_NOM").val();                           
    if (CD_NOM != "") 
    {
    	var url = 'CD_NOM='+escape(CD_NOM);             
    	$.ajax({
			type: "POST",
		    url: "../commun/prot_test_process.php",
		    cache: false,
			data: url,
            error: function() {
                alert("prot_test_list > Erreur AJAX");
                return false;
            },
		    success: function(html){
			    $("#prot_test_list").html(html);
		    }
	    });
    }
	return false;                                                
}

function prot_test_add(){
    var CD_NOM = $("#CD_NOM").val();                           
    var id_pretraitement = $("#id_pretraitement").val();                           
    var id_traitement = $("#id_traitement").val();                           
    var id_regime_photo_periodique = $("#id_regime_photo_periodique").val();                           

            console.log('id_pretraitement='+id_pretraitement);
            console.log('id_traitement='+id_traitement);

//    if (CD_NOM != "" && id_pretraitement != 0 && id_traitement != 0 && id_regime_photo_periodique != 0 ) 
    if (CD_NOM != "" && id_regime_photo_periodique != 0 ) 
    {
//                alert("VALID");
    	var url = 'submit=1&id_pretraitement='+escape(id_pretraitement)+'&id_traitement='+escape(id_traitement)+'&id_regime_photo_periodique='+escape(id_regime_photo_periodique)+'&CD_NOM='+escape(CD_NOM);             
		$.ajax({
			type: "POST",
			url: "../commun/prot_test_process.php",
			data: url,
            error: function() {
                alert("prot_test_add > Erreur AJAX");
                return false;
            },
			success: function(){
				$("#id_pretraitement").val('');
				$("#id_traitement").val('');
				$("#id_regime_photo_periodique").val('');
				prot_test_list();
			}
		});
    }
	return false;                                                
}

//------------------------------------------------------------------------------ Germination / Protocoles favorables

function prot_favo_list(){
    var CD_NOM = $("#CD_NOM").val();                           
    if (CD_NOM != "") 
    {
    	var url = 'CD_NOM='+escape(CD_NOM);             
    	$.ajax({
			type: "POST",
		    url: "../commun/prot_favo_process.php",
		    cache: false,
			data: url,
            error: function() {
                alert("prot_test_list > Erreur AJAX");
                return false;
            },
		    success: function(html){
			    $("#prot_favo_list").html(html);
		    }
	    });
    }
	return false;                                                
}

function prot_favo_add(){
    var CD_NOM = $("#CD_NOM").val();                           
    var id_pretraitement = $("#id_pretraitement2").val();                           
    var id_traitement = $("#id_traitement2").val();                           
    var id_regime_photo_periodique = $("#id_regime_photo_periodique2").val();                           
    var pourcent_germ = $("#pourcent_germ").val();                           
    var id_graines_utilisee = $("#id_graines_utilisee").val();                           
    var id_mode_conservation = $("#id_mode_conservation").val();                           

//    if (CD_NOM != "" && id_pretraitement != 0 && id_traitement != 0 && id_regime_photo_periodique != 0 && pourcent_germ != "" && id_graines_utilisee != 0 & id_mode_conservation != 0 ) 
    if (CD_NOM != "" && id_regime_photo_periodique != 0 && pourcent_germ != "" && id_graines_utilisee != 0 & id_mode_conservation != 0 ) 
    {
//                alert("VALID");
    	var url = 'submit=1&id_pretraitement='+escape(id_pretraitement)+'&id_traitement='+escape(id_traitement)+'&id_regime_photo_periodique='+escape(id_regime_photo_periodique)+'&pourcent_germ='+escape(pourcent_germ)+'&id_graines_utilisee='+escape(id_graines_utilisee)+'&id_mode_conservation='+escape(id_mode_conservation)+'&CD_NOM='+escape(CD_NOM);             
		$.ajax({
			type: "POST",
			url: "../commun/prot_favo_process.php",
			data: url,
            error: function() {
                alert("prot_favo_add > Erreur AJAX");
                return false;
            },
			success: function(){
				$("#id_pretraitement2").val('');
				$("#id_traitement2").val('');
				$("#id_regime_photo_periodique2").val('');
				$("#pourcent_germ").val('');
				$("#id_graines_utilisee").val('');
				$("#id_mode_conservation").val('');
				prot_favo_list();
			}
		});
    }
	return false;                                                
}

