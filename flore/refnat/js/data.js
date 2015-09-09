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
//------------------------------------------------------------------------------ LISTES / Construction du tableau

    if (typeof oTable == 'undefined') {
        var oTable = $('#data-liste').dataTable({
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
    	"sAjaxSource": "liste.php",
        "bStateSave": true,
		"fnStateSave": function (oSettings, oData) {
            localStorage.setItem( 'data_'+window.location.pathname, JSON.stringify(oData) );
			},
        "fnStateLoad": function (oSettings) {
            return JSON.parse( localStorage.getItem('data_'+window.location.pathname) );
			}, 
        "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
		switch (aData[0])                                                  // Stylisation!
            {
                default : 
                    $('td:eq(2)', nRow).addClass('nom_taxon');
                break;
            }
		if (aData[7] == 't'){$('td:eq(7)', nRow).addClass('taxref_true');}else if (aData[7] == 'f'){$('td:eq(7)', nRow).addClass('taxref_false');}
		if (aData[8] == 't'){$('td:eq(8)', nRow).addClass('taxref_true');}else if (aData[8] == 'f'){$('td:eq(8)', nRow).addClass('taxref_false');}
		if (aData[9] == 't'){$('td:eq(9)', nRow).addClass('taxref_true');}else if (aData[9] == 'f'){$('td:eq(9)', nRow).addClass('taxref_false');}
		if (aData[10] == 't'){$('td:eq(10)', nRow).addClass('taxref_true');}else if (aData[10] == 'f'){$('td:eq(10)', nRow).addClass('taxref_false');}
		if (aData[11] == 't'){$('td:eq(11)', nRow).addClass('taxref_true');}else if (aData[11] == 'f'){$('td:eq(11)', nRow).addClass('taxref_false');}
		if (aData[12] == 't'){$('td:eq(12)', nRow).addClass('taxref_true');}else if (aData[12] == 'f'){$('td:eq(12)', nRow).addClass('taxref_false');}
		if (aData[13] == 't'){$('td:eq(13)', nRow).addClass('taxref_true');}else if (aData[13] == 'f'){$('td:eq(13)', nRow).addClass('taxref_false');}
		if (aData[14] == 't'){$('td:eq(14)', nRow).addClass('taxref_true');}else if (aData[14] == 'f'){$('td:eq(14)', nRow).addClass('taxref_false');}
		return nRow;
		},
		"oLanguage": { "sProcessing":   "Traitement en cours...",
            "sLengthMenu":   "Afficher _MENU_ taxons",
            "sZeroRecords":  "Aucun taxon à afficher",
            "sInfo": "Affichage du taxon _START_ à _END_",
            "sInfoEmpty": "Affichage du taxon 0 à 0 sur 0 ",
            "sInfoFiltered": "",
            "sInfoPostFix":  "",
            "sSearch":       "Rechercher ",
            "sUrl":          "",
            "oPaginate": {
                "sFirst":    "Premier",
                "sPrevious": "Précédent",
                "sNext":     "Suivant",
                "sLast":     "Dernier"
            }
        }, 
       // "aaSorting": [[3,'asc']],                                               // Nom scientifique 
        "sDom": '<"top"fl>rt<"bottom"ip>',
            "aoColumns": [                                                        // 
            	{ "sWidth": "7%" },
            	{ "sWidth": "7%" },
            	{ "sWidth": "25%" },
            	{ "sWidth": "3%" },
            	{ "sWidth": "13%" },
            	{ "sWidth": "12%" },
            	{ "sWidth": "3%" },
            	{ "sWidth": "3%" },
            	{ "sWidth": "3%" },
            	{ "sWidth": "3%" },
            	{ "sWidth": "3%" },
            	{ "sWidth": "3%" },
            	{ "sWidth": "3%" },
            	{ "sWidth": "3%" },
            	{ "sWidth": "3%" },
    			{ "sClass": "center","sWidth": "3%","bSortable": false },     // 
        		{ "sClass": "center","sWidth": "3%","bSortable": false }      // .
        ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
                { type: "text" },
                { type: "text" },                                               // 
                { type: "text" },                                               //  
                { type: "select", values: ['ES','SSES','VAR','SVAR','FO','SSFO']}, // Rang
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "select", values: [{ value: 't', label: 'Oui'},{ value: 'f', label: 'Non'}] },                                               //  
                { type: "select", values: [{ value: 't', label: 'Oui'},{ value: 'f', label: 'Non'}] },                                               //  
                { type: "select", values: [{ value: 't', label: 'Oui'},{ value: 'f', label: 'Non'}] },                                               //  
                { type: "select", values: [{ value: 't', label: 'Oui'},{ value: 'f', label: 'Non'}] },                                               //  
                { type: "select", values: [{ value: 't', label: 'Oui'},{ value: 'f', label: 'Non'}] },                                               //  
                { type: "select", values: [{ value: 't', label: 'Oui'},{ value: 'f', label: 'Non'}] },                                               //  
                { type: "select", values: [{ value: 't', label: 'Oui'},{ value: 'f', label: 'Non'}] },                                               //  
                { type: "select", values: [{ value: 't', label: 'Oui'},{ value: 'f', label: 'Non'}] }                                               //  
			]
		});        

		var oTable2 = $('#user-liste').dataTable({
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
    	"sAjaxSource": "liste_user.php",
        "bStateSave": true,
		"fnStateSave": function (oSettings, oData) {
            localStorage.setItem( 'user_'+window.location.pathname, JSON.stringify(oData) );
			},
        "fnStateLoad": function (oSettings) {
            return JSON.parse( localStorage.getItem('user_'+window.location.pathname) );
			}, 
            "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
			switch (aData[4]){case 'Pas d\'accès' :$('td:eq(4)', nRow).addClass('avancement_1');break;case 'Lecteur' : $('td:eq(4)', nRow).addClass('avancement_2'); break;case 'Participant' : $('td:eq(4)', nRow).addClass('avancement_3');break;case 'Evaluateur' : $('td:eq(4)', nRow).addClass('avancement_4');break;case 'Référent' : $('td:eq(4)', nRow).addClass('avancement_5');break;}
			return nRow;
			},        
			"oLanguage": { "sProcessing":   "Traitement en cours...",
            "sLengthMenu":   "Afficher _MENU_ taxons",
            "sZeroRecords":  "Aucun uilisateur à afficher",
            "sInfo": "Affichage de l'utilisateur _START_ à _END_",
            "sInfoEmpty": "Affichage de l'utilisateur 0 à 0 sur 0 ",
            "sInfoFiltered": "",
            "sInfoPostFix":  "",
            "sSearch":       "Rechercher ",
            "sUrl":          "",
            "oPaginate": {
                "sFirst":    "Premier",
                "sPrevious": "Précédent",
                "sNext":     "Suivant",
                "sLast":     "Dernier"
            }
        }, 
		// "aaSorting": [[2,'asc']],                                               // Nom scientifique 
        "sDom": '<"top"fl>rt<"bottom"ip>',
            "aoColumns": [
                { "sWidth": "10%" },                                                           
                { "sWidth": "20%" },                                                           
        		{ "sWidth": "20%" },                         									
        		{ "sWidth": "20%" },                         									
        		{ "sClass": "center","sWidth": "25%"},                         									
        		{ "sClass": "center","sWidth": "5%","bSortable": false }      // Sélect.
        ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
                { type: "text" },                                               // Famille
                { type: "text" },                                               // CD_REF
                { type: "text" },                                               // Nom scientifique 
                { type: "text" },                                               //  
				{ type: "select", values: [{ value: 0, label: 'Pas d\'accès'},{ value: 1, label: 'Lecteur' },{ value: 64, label: 'Participant' },{ value: 128, label: 'Evaluateur' },{ value: 129, label: 'Référent' },{ value: 255, label: 'Administrateur'}] },
			]
		});		
		oTable.fnSort( [ [2,'desc'] ] );		
		oTable2.fnSort( [ [2,'desc'] ] );		
		} else {
		oTable.fnClearTable (false);
		oTable.fnDraw ();
	}	
