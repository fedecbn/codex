/********************************************************************************/
//   module_admin/js/admin.js                                                   //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  12/08/14 - MaJ fonctions pgSQL                                //
//  Version 1.02  18/08/14 - MaJ user-liste                                     //
//  Version 1.03  21/08/14 - MaJ suivi-liste                                    //
/********************************************************************************/

function suivi_affMasqBtn(){
    var n = $("input:checked[name='id']").length;                               // Nombre de checkbox cochée
            console.log (n);
    if(n == 0) {
        $("#admin-suivi-export-TXT-button").button('disable');
    } else {
        $("#admin-suivi-export-TXT-button").button('enable');
    }
}

$(document).ready(function(){

    var user_oTable;

//------------------------------------------------------------------------------ UI / Tabs

    var $tabs = $("#tabs").tabs();
    if ( $("#niveau").val() < 1) {
        $tabs.tabs ('disable',3);                                               // Stats
        $tabs.tabs ('disable',4);                                               // Users
        $tabs.tabs ('disable',5);                                               // Logs
    }

//------------------------------------------------------------------------------ UI / tooltip

    $( document ).tooltip();

//------------------------------------------------------------------------------ UI / Boutons

    $( "#home-button" )
        .button({
            text: false
        })
        .click(function() {
            window.location.replace ('../home/index.php');				
		});

//------------------------------------------------------------------------------ UI / Boutons / Contenu

	$( "#content-add-button" )
        .button({
            icons: {
                primary: "ui-icon-plusthick"
            },
            text: true
        })
        .click(function() {
            metaForm ("Ajouter un contenu",950,650,'#content-dialog',"content-form.php","content-submit.php",content_oTable,"","");
		});

//------------------------------------------------------------------------------ UI / Boutons / Suivi

	$( "#admin-suivi-export-TXT-button" )
        .button({
            text: true
        })
        .click(function() {
            var sData = suivi_oTable.$('input').serialize();
            if (sData != "") {
                exportFunc ("Exporter (TXT)","#admin-suivi-dialog",'../commun/export_TXT.php',$("#admin-suivi-export-TXT-fichier").val(),$("#admin-suivi-export-TXT-query").val(),$("#admin-suivi-export-TXT-query-id").val(),sData);
            }
            return (false);
		});

//------------------------------------------------------------------------------ UI / Boutons / Métadonnées photos

	$( "#photo-add-button" )
        .button({
            text: true
        })
        .click(function() {
            metaForm ("Ajouter une métadonnée",630,550,'#photo-dialog',"photo-form.php","photo-submit.php",photo_oTable,"","");
		});

//------------------------------------------------------------------------------ Export TXT

	$( "#photo-export-TXT-button" )
        .button({
            text: true
        })
        .click(function() {
        	$('#photo-dialog').dialog({
                open: function ()
                {
                    $(this).load ("../commun/export_TXT.php" , {t:$("#photo-export-TXT-titre").val(),f:$("#photo-export-TXT-fichier").val(),q:$("#photo-export-TXT-query").val() });
                },         
                title: "Export TXT",
                modal: true,
                position:['middle',200],
        		width: 450,
        		height: 300,
            	resizable: false,
    			buttons: {
            			"Fermer": function() {
            				$(this).dialog( "close" );
            			}
            	   }
            });
	   });
//------------------------------------------------------------------------------ UI / Boutons / User

	$( "#admin-user-add-button" )
        .button({
            text: true
        })
        .click(function() {
            metaForm ("Ajouter un utilisateur",670,390,'#admin-user-dialog',"user-form.php","user-submit.php",user_oTable,"",$(this).attr('name'));
		});

	$( "#mdp-button" )
		.button({	
			text: true 
		})
	.click(function() {
		var sData = user_oTable.$('input').serialize();
		mdpFunc ("Envoyer les mots de passe",'#admin-user-dialog',user_oTable,"index.php","",sData,"mdp");
	});


//------------------------------------------------------------------------------ UI / Boutons / LOG

	$( "#admin-log-del-button" )
        .button({
            text: true
        })
        .click(function() {
            deleteFunc ("Effacer toutes les données",'#admin-log-dialog',log_oTable,"log-del.php","");  
        	return (false);
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

    $.fn.dataTableExt.oApi.fnStandingRedraw = function(oSettings) {
        if(oSettings.oFeatures.bServerSide === false){
            var before = oSettings._iDisplayStart;
            oSettings.oApi._fnReDraw(oSettings);
        // iDisplayStart has been reset to zero - so lets change it back
            oSettings._iDisplayStart = before;
            oSettings.oApi._fnCalculateEnd(oSettings);
        }
        oSettings.oApi._fnDraw(oSettings);                                      // draw the 'current' page
    };

//------------------------------------------------------------------------------ LISTE / Contenu

    if (typeof text_oTable == 'undefined') {
        var text_oTable = $('#admin-text-liste').dataTable({
    		"bJQueryUI": true,
    		"bPaginate": false,
    		"bLengthChange": true,
    		"bFilter": false,
    		"bSort": true,
    		"bInfo": true,
        	"bAutoWidth": false,
		    "bProcessing": true,
        	"bServerSide": true,
        	"sAjaxSource": "text-liste.php",
            "bStateSave": true,
			"fnStateSave": function (oSettings, oData) {
				localStorage.setItem( 'text_'+window.location.pathname, JSON.stringify(oData) );
				},
			"fnStateLoad": function (oSettings) {
				return JSON.parse( localStorage.getItem('text_'+window.location.pathname) );
				}, 
            "oLanguage": { "sProcessing":   "Traitement en cours...",
                "sLengthMenu":   "Afficher _MENU_ éléments",
                "sZeroRecords":  "Aucun élément à afficher",
                "sInfo": "Affichage de l'élement _START_ à _END_ sur _TOTAL_ éléments",
                "sInfoEmpty": "Affichage de l'élement 0 à 0 sur 0 éléments",
                "sInfoFiltered": "(filtré de _MAX_ éléments au total)",
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
            "aaSorting": [[0,'asc']],
            "sDom": '<"top"fl>rt<"bottom"ip>',
            "aoColumns": [
        		{ "sWidth": "5%"},                                           // Code
    			{ "sWidth": "10%"},
    			{ "sWidth": "75%"},
        		{ "sClass": "center","sWidth": "5%" },                        // Langue
        		{ "sClass": "center","sWidth": "5%","bSortable": false }      // Actions
    		]
    	});
	} else {
		text_oTable.fnClearTable (false);
		text_oTable.fnDraw();
	}	

    $('#admin-text-liste').on("click",".admin-text-edit", function ($e) {
        metaForm ("Modifier un texte",920,650,'#admin-text-dialog',"text-form.php","text-submit.php",text_oTable,$(this).attr('id'),$(this).attr('name'));
        return (false);
	});

//------------------------------------------------------------------------------ LISTE / User

    if (typeof user_oTable == 'undefined') {
        var user_oTable = $('#admin-user-liste').dataTable({
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
        	"sAjaxSource": "user-liste.php",
            "bStateSave": true,
			"fnStateSave": function (oSettings, oData) {
				localStorage.setItem( 'user_'+window.location.pathname, JSON.stringify(oData) );
				},
			"fnStateLoad": function (oSettings) {
				return JSON.parse( localStorage.getItem('user_'+window.location.pathname) );
				}, 
            "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
			switch (aData[6]){case 'Pas d\'accès' :$('td:eq(6)', nRow).addClass('avancement_1');break;case 'Lecteur' : $('td:eq(6)', nRow).addClass('avancement_2'); break;case 'Participant' : $('td:eq(6)', nRow).addClass('avancement_3');break;case 'Evaluateur' : $('td:eq(6)', nRow).addClass('avancement_4');break;case 'Référent' : $('td:eq(6)', nRow).addClass('avancement_5');break;}
			switch (aData[7]){case 'Pas d\'accès' :$('td:eq(7)', nRow).addClass('avancement_1');break;case 'Lecteur' : $('td:eq(7)', nRow).addClass('avancement_2'); break;case 'Participant' : $('td:eq(7)', nRow).addClass('avancement_3');break;case 'Evaluateur' : $('td:eq(7)', nRow).addClass('avancement_4');break;case 'Référent' : $('td:eq(7)', nRow).addClass('avancement_5');break;}
			switch (aData[8]){case 'Pas d\'accès' :$('td:eq(8)', nRow).addClass('avancement_1');break;case 'Lecteur' : $('td:eq(8)', nRow).addClass('avancement_2'); break;case 'Participant' : $('td:eq(8)', nRow).addClass('avancement_3');break;case 'Evaluateur' : $('td:eq(8)', nRow).addClass('avancement_4');break;case 'Référent' : $('td:eq(8)', nRow).addClass('avancement_5');break;}
			switch (aData[9]){case 'Pas d\'accès' :$('td:eq(9)', nRow).addClass('avancement_1');break;case 'Lecteur' : $('td:eq(9)', nRow).addClass('avancement_2'); break;case 'Participant' : $('td:eq(9)', nRow).addClass('avancement_3');break;case 'Evaluateur' : $('td:eq(9)', nRow).addClass('avancement_4');break;case 'Référent' : $('td:eq(9)', nRow).addClass('avancement_5');break;}
			switch (aData[10]){case 'Pas d\'accès' :$('td:eq(10)', nRow).addClass('avancement_1');break;case 'Lecteur' : $('td:eq(10)', nRow).addClass('avancement_2'); break;case 'Participant' : $('td:eq(10)', nRow).addClass('avancement_3');break;case 'Evaluateur' : $('td:eq(10)', nRow).addClass('avancement_4');break;case 'Référent' : $('td:eq(10)', nRow).addClass('avancement_5');break;}
			switch (aData[11]){case 'oui' :$('td:eq(11)', nRow).addClass('oui');break;case 'non' : $('td:eq(11)', nRow).addClass('non'); break;}
			switch (aData[12]){case 'oui' :$('td:eq(12)', nRow).addClass('oui');break;case 'non' : $('td:eq(12)', nRow).addClass('non'); break;}
			switch (aData[13]){case 'oui' :$('td:eq(13)', nRow).addClass('oui');break;case 'non' : $('td:eq(13)', nRow).addClass('non'); break;}
			switch (aData[14]){case 'oui' :$('td:eq(14)', nRow).addClass('oui');break;case 'non' : $('td:eq(14)', nRow).addClass('non'); break;}
			switch (aData[15]){case 'oui' :$('td:eq(15)', nRow).addClass('oui');break;case 'non' : $('td:eq(15)', nRow).addClass('non'); break;}
			return nRow;
			},
			"oLanguage": { "sProcessing":   "Traitement en cours...",
                "sLengthMenu":   "Afficher _MENU_ éléments",
                "sZeroRecords":  "Aucun élément à afficher",
                "sInfo": "Affichage de l'élement _START_ à _END_ sur _TOTAL_ éléments",
                "sInfoEmpty": "Affichage de l'élement 0 à 0 sur 0 éléments",
                "sInfoFiltered": "(filtré de _MAX_ éléments au total)",
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
	
            "aaSorting": [[1,'asc']],
            "sDom": '<"top"fl>rt<"bottom"ip>',
        	"aoColumns": [
        		{ "sWidth": "4%"},                                            // Code
        		{ "sWidth": "7%"},
        		{ "sWidth": "7%"},
        		{ "sWidth": "10%"},
        		{ "sWidth": "13%"},
        		{ "sWidth": "6%"},
        		{ "sWidth": "6%"},                                            // Niveau
        		{ "sWidth": "6%"},                                            // Niveau
        		{ "sWidth": "6%"},                                            // Niveau
        		{ "sWidth": "6%"},                                            // Niveau
        		{ "sWidth": "6%"},                                            // Niveau
        		{ "sWidth": "2%"},                                            // ref
        		{ "sWidth": "2%"},                                            // ref
        		{ "sWidth": "2%"},                                            // ref
        		{ "sWidth": "2%"},                                            // ref
        		{ "sWidth": "2%"},                                            // ref
        		{ "sClass": "center","sWidth": "5%","bSortable": false },      // Actions
        		{ "sClass": "center","sWidth": "3%","bSortable": false }      // Actions
            ]
            }).columnFilter({
                sPlaceHolder: "head:after",
                aoColumns: [ 
                    { type: "text" },                                           // Code
                    { type: "text" },                                           // Nom
                    { type: "text" },                                           // Prénom
                    { type: "text" },                                           // CBN
                    { type: "text" },                                           // Login
                    { type: "text" },                                           // Login
					{ type: "select", values: [{ value: 0, label: 'Pas d\'accès'},{ value: 1, label: 'Lecteur' },{ value: 64, label: 'Participant' },{ value: 128, label: 'Evaluateur' },{ value: 129, label: 'Référent' },{ value: 255, label: 'Administrateur'}] },
					{ type: "select", values: [{ value: 0, label: 'Pas d\'accès'},{ value: 1, label: 'Lecteur' },{ value: 64, label: 'Participant' },{ value: 128, label: 'Evaluateur' },{ value: 129, label: 'Référent' },{ value: 255, label: 'Administrateur'}] },
					{ type: "select", values: [{ value: 0, label: 'Pas d\'accès'},{ value: 1, label: 'Lecteur' },{ value: 64, label: 'Participant' },{ value: 128, label: 'Evaluateur' },{ value: 129, label: 'Référent' },{ value: 255, label: 'Administrateur'}] },
					{ type: "select", values: [{ value: 0, label: 'Pas d\'accès'},{ value: 1, label: 'Lecteur' },{ value: 64, label: 'Participant' },{ value: 128, label: 'Evaluateur' },{ value: 129, label: 'Référent' },{ value: 255, label: 'Administrateur'}] },
					{ type: "select", values: [{ value: 0, label: 'Pas d\'accès'},{ value: 1, label: 'Lecteur' },{ value: 64, label: 'Participant' },{ value: 128, label: 'Evaluateur' },{ value: 129, label: 'Référent' },{ value: 255, label: 'Administrateur'}] },
					{ type: "select", values: [{ value: 'oui', label: 'oui'},{ value: 'non', label: 'non' }] },
					{ type: "select", values: [{ value: 'oui', label: 'oui'},{ value: 'non', label: 'non' }] },
					{ type: "select", values: [{ value: 'oui', label: 'oui'},{ value: 'non', label: 'non' }] },
					{ type: "select", values: [{ value: 'oui', label: 'oui'},{ value: 'non', label: 'non' }] },
					{ type: "select", values: [{ value: 'oui', label: 'oui'},{ value: 'non', label: 'non' }] }
    			]
    		});      
	} else {
		user_oTable.fnClearTable( false );
		user_oTable.fnDraw();
	}	

    $('#admin-user-liste').on("click",".admin-user-edit", function ($e) {
        metaForm ("Modifier un utilisateur",670,410,'#admin-user-dialog',"user-form.php","user-submit.php",user_oTable,$(this).attr('id'),$(this).attr('name'));
        return (false);
	});
		
    $('#admin-user-liste').on("click",".admin-user-del", function ($e) {
        deleteFunc ("Supprimer un utilisateur",'#admin-user-dialog',user_oTable,"user-del.php",$(this).attr('id'));  
		return (false);
	});

    $('#admin-user-liste').on("click",".admin-user-mdp", function ($e) {
        mdpFunc ("Envoyer le mdp",'#admin-user-dialog',user_oTable,"index.php","",$(this).attr('id'),"mdp");  
		return (false);
	});


//------------------------------------------------------------------------------ LISTE / suivis

    if (typeof suivi_oTable == 'undefined') {
        var suivi_oTable = $('#admin-suivi-liste').dataTable({
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
        	"sAjaxSource": "suivi-liste.php",
            "bStateSave": true,
			"fnStateSave": function (oSettings, oData) {
				localStorage.setItem( 'suivi_'+window.location.pathname, JSON.stringify(oData) );
				},
			"fnStateLoad": function (oSettings) {
				return JSON.parse( localStorage.getItem('suivi_'+window.location.pathname) );
				}, 
            "oLanguage": { "sProcessing":   "Traitement en cours...",
                "sLengthMenu":   "Afficher _MENU_ éléments",
                "sZeroRecords":  "Aucun élément à afficher",
                "sInfo": "Affichage de l'élement _START_ à _END_ sur _TOTAL_ éléments",
                "sInfoEmpty": "Affichage de l'élement 0 à 0 sur 0 éléments",
                "sInfoFiltered": "",
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
			"fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                switch (aData[6])                                                  // Cat A
				{
                case "modif" : 
                    $('td:eq(6)', nRow).addClass('change_modif');
                break;
                case "suppr" : 
                    $('td:eq(6)', nRow).addClass('change_suppr');
                break;
                case "ajout" : 
                    $('td:eq(6)', nRow).addClass('change_ajout');
                break;
                }
                return nRow;
            },			
            "aaSorting": [[5,'desc']],
            "sDom": '<"top"fl>rt<"bottom"ip>',
            "aoColumns": [
    			{ "sWidth": "50px" },                                           // etape
            	null,                                                           // user
            	null,                                                           // CBN
    			{ "sWidth": "40px" },                                           // UID
            	null,                                                           // taxon
            	null,                                                           // table
            	null,                                                           // table
            	null,                                                           // champ
            	null,                                                           // champ
            	null,                                                           // valeur
            	null,                                                           // valeur
            	null,                                                           // date
        		null,                                         // heure
    			{ "bVisible": false },                                          // ID
        		{ "sClass": "center","sWidth": "20px","bSortable": false }      // Sélect.
            ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
                { type: "text" },                                               // etape
                { type: "text" },                                               // user
                { type: "text" },                                               // CBN
                { type: "text" },                                               // UID
                { type: "text" },                                               // UID
                { type: "select", values: [{ value: 'lr', label: 'Liste rouge'},{ value: 'eee', label: 'EEE'},{ value: 'catnat', label: 'catalogue national'},{ value: 'ref_nat', label: 'evol° TAXREF'}] },                                    //  
                { type: "select", values: [{ value: 'ajout', label: 'ajout'},{ value: 'modif', label: 'modification'},{ value: 'suppr', label: 'suppression'}] },                                    //  
                { type: "select", values: [{ value: 'manuel', label: 'manuel'},{ value: 'auto', label: 'automatique'}] },
                { type: "text" },                                               // table
                { type: "text" },                                               // valeur
                { type: "text" },                                               // valeur
                { type: "text" },                                               // date
                { type: "text" }                                                            // ID
			]
		});        
	} else {
		suivi_oTable.fnClearTable (false);
		suivi_oTable.fnDraw();
	}	
		
//------------------------------------------------------------------------------ CHECKBOX

    suivi_affMasqBtn ();

    $('.admin-suivi-liste-all').click(function () {
        console.log ('admin-suivi-liste-all');
        $('.admin-suivi-liste-one').not(this).attr('checked', this.checked);
        suivi_affMasqBtn();
    });

    $('#admin-suivi-liste').on("click",".admin-suivi-liste-one", function ($e) {
        console.log ('admin-suivi-liste-one');
        suivi_affMasqBtn();
	});

//------------------------------------------------------------------------------ LISTE / LOG

    if (typeof log_oTable == 'undefined') {
        var log_oTable = $('#admin-log-liste').dataTable({
    		"bJQueryUI": true,
            "iDisplayLength": 50,
    		"aLengthMenu": [[50,100,200,-1],[50,100,200,'Tous']],
    		"bPaginate": true,
    		"sPaginationType": "full_numbers",
    		"bLengthChange": false,
    		"bFilter": true,
    		"bSort": true,
    		"bInfo": true,
    		"bAutoWidth": false,
    		"bServerSide": true,
    		"sAjaxSource": "log-liste.php",
            "oLanguage": { "sProcessing":   "Traitement en cours...",
                "sLengthMenu":   "Afficher _MENU_ éléments",
                "sZeroRecords":  "Aucun élément à afficher",
                "sInfo": "Affichage de l'élement _START_ à _END_ sur _TOTAL_ éléments",
                "sInfoEmpty": "Affichage de l'élement 0 à 0 sur 0 éléments",
                "sInfoFiltered": "(filtré de _MAX_ éléments au total)",
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
            "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                if (aData[9] == "1") {
                    $('td:eq(0)', nRow).addClass('phase_1');
                } 
                else if (aData[9] == "2") {
                    $('td:eq(0)', nRow).addClass('phase_2');
                } 
                else if (aData[9] == "3") {
                    $('td:eq(0)', nRow).addClass('phase_3');
                } 
                else if (aData[9] == "4") {
                    $('td:eq(0)', nRow).addClass('phase_4');
                } 
                else if (aData[9] == "5") {
                    $('td:eq(0)', nRow).addClass('phase_5');
                } 
                else if (aData[9] == "6") {
                    $('td:eq(0)', nRow).addClass('phase_6');
                } 
                else if (aData[9] == "7") {
                    $('td:eq(0)', nRow).addClass('phase_7');
                } 
                return nRow;
            },
    		"aaSorting": [[ 8, "desc" ]],                                       // Tri ID
            "sDom": '<"top"fl>rt<"bottom"ip>',
    		"aoColumns": [
    		    { "sClass": "center" },                                         // Event
    			null,                                                           // User
    			null,                                                           // IP
    			null,                                                           // Descr 1
    			null,                                                           // Descr 2
    			null,                                                           // Tables
    			{ "sWidth": "90px" },                                           // Date
    			{ "sWidth": "60px","bSortable": false },                        // Heure
    			{ "sWidth": "60px" },                                           // ID
    			{ "bVisible": false }                                           // ID
        ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
                { type: "select", values: [{ value: '1', label: 'Information'},{ value: '2', label: 'Erreur'},{ value: '3', label: 'Sécurité'},{ value: '4', label: 'Système'},{ value: '5', label: 'Données'},{ value: '6', label: 'Réf.'}]},
                { type: "text" },                                               // User
                { type: "text" },                                               // IP 
                { type: "text" },                                               // Descr 1
                { type: "text" },                                               // Descr 2
                { type: "text" },                                               // Tables
                { type: "text" }                                                // Date
			]
		});        
	} else {
		log_oTable.fnClearTable( false );
		log_oTable.fnDraw();
	}	

	$("#admin-log-liste tbody").click(function(event) {
        $(log_oTable.fnSettings().aoData).each(function (){
			$(this.nTr).removeClass('row_selected');
		});
		$(event.target.parentNode).addClass('row_selected');
	});

//------------------------------------------------------------------------------ FORM (v2)

    function metaForm (titre,larg,haut,dialogId,formUrl,submitUrl,tableId,params,params2) {
        if (submitUrl != "") {
        	$(dialogId).dialog({
                open: function ()
                {
                    originalContent = $(dialogId).html();
                    $(dialogId).load (formUrl+"?id="+params+"&id_user="+params2);
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
                    { text: "Enregistrer", click: function() {
                        if ($("#form1").valid()) {
                            $("#form1",this).ajaxSubmit({
                                url: submitUrl,
                                type: "post",
                                data: { id: params},
                                clearForm: true,
                                error: function(){
                                    alert ("Erreur AJAX");
                                },
                                success: function(e) {
                                    $(dialogId).dialog().dialog('close');
                                    tableId.fnStandingRedraw();
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
    }

	//------------------------------------------------------------------------------ mot de passe (v3)

    function mdpFunc (titre,dialog,dataTable,mdpUrl,id,sData,mode) {
    	$(dialog).dialog({
            open: function ()
            {
                if (id != '' )
                    $(this).html("<br><center>ID = "+id+"<br><b>Confirmer l'envoie ?<b></center>");
                else
                    $(this).html("<br><center><b>Confirmer l'envoie ?<b></center>");
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
        		"Envoyer": function() {
                    $.ajax({
                        url: mdpUrl, 
                        type: "GET",
                        data: {
                            select : sData,    
                            id: id,    
                            m: mode    
                        },       
                        error: function() {
                            alert("mdpFunc > Erreur AJAX");
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
//------------------------------------------------------------------------------ Suppression (v2)

    function deleteFunc (titre,dialog,dataTable,delUrl,id) {
    	$(dialog).dialog({
            open: function ()
            {
                $(this).html("<center><b>Confirmer la suppression ?<b></center>");
            },         
            title: titre,
            modal: true,
            position:['middle',200],
        	width: 350,
    		height: 190,
        	resizable: false,
			buttons: {
        		"Annuler": function() {
        			$(this).dialog( "close" );
        		},
        		"Supprimer": function() {
                    $.ajax({
                        url: delUrl, 
                        type: "post",
                        data: "id="+id,
                        error: function() {
                            alert("deleteFunc > Erreur AJAX");
                        },
                        success: function(msg) {
                            dataTable.fnDraw();
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

//------------------------------------------------------------------------------ EXPORTS / LOGS

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

//------------------------------------------------------------------------------ File Manager

//------------------------------------------------------------------------------ INT Page

});
