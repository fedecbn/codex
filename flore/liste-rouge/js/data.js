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

    if (typeof oTable == 'undefined' && typeof oTable2 == 'undefined' ) {
        var oTable = $('#data-liste').dataTable({
   	    "bJQueryUI": true,
   	    "iCookieDuration": 60*60*24,
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
            switch (aData[3])                                                  // Cat A
            {
                default : $('td:eq(3)', nRow).addClass('nom_taxon'); break;
            }
            switch (aData[5])                                                  // Cat A
            {
                case "Indigène" : $('td:eq(5)', nRow).addClass('Indigène'); break;
                case "Cryptogène" : $('td:eq(5)', nRow).addClass('Cryptogène'); break;
                case "Exotique" : $('td:eq(5)', nRow).addClass('Exotique'); break;
            }
            switch (aData[11])                                                  // Cat A
            {
                case "DD" : $('td:eq(11)', nRow).addClass('UICN_DD'); break;
                case "LC" : $('td:eq(11)', nRow).addClass('UICN_LC'); break;
                case "NT" : $('td:eq(11)', nRow).addClass('UICN_NT'); break;
                case "VU" : $('td:eq(11)', nRow).addClass('UICN_VU'); break;
                case "EN" : $('td:eq(11)', nRow).addClass('UICN_EN'); break;
                case "CR" : $('td:eq(11)', nRow).addClass('UICN_CR'); break;
				case "CR*" : $('td:eq(11)', nRow).addClass('UICN_CR');break;
                case "RE" : $('td:eq(11)', nRow).addClass('UICN_RE'); break;
                case "EW" : $('td:eq(11)', nRow).addClass('UICN_EW'); break;
                case "EX" : $('td:eq(11)', nRow).addClass('UICN_EX'); break;
                case "NA" : $('td:eq(11)', nRow).addClass('UICN_NA'); break;
                case "NE" : $('td:eq(11)', nRow).addClass('UICN_NE'); break;
            }
            switch (aData[12])                                                  // Cat B
            {
                case "DD" : $('td:eq(12)', nRow).addClass('UICN_DD'); break;
                case "LC" : $('td:eq(12)', nRow).addClass('UICN_LC'); break;
                case "NT" : $('td:eq(12)', nRow).addClass('UICN_NT'); break;
                case "VU" : $('td:eq(12)', nRow).addClass('UICN_VU'); break;
                case "EN" : $('td:eq(12)', nRow).addClass('UICN_EN'); break;
                case "CR" : $('td:eq(12)', nRow).addClass('UICN_CR'); break;
				case "CR*" : $('td:eq(12)', nRow).addClass('UICN_CR');break;
                case "RE" : $('td:eq(12)', nRow).addClass('UICN_RE'); break;
                case "EW" : $('td:eq(12)', nRow).addClass('UICN_EW'); break;
                case "EX" : $('td:eq(12)', nRow).addClass('UICN_EX'); break;
                case "NA" : $('td:eq(12)', nRow).addClass('UICN_NA'); break;
                case "NE" : $('td:eq(12)', nRow).addClass('UICN_NE'); break;
            }
            switch (aData[13])                                                  // Cat C
            {
                case "DD" : $('td:eq(13)', nRow).addClass('UICN_DD'); break;
                case "LC" : $('td:eq(13)', nRow).addClass('UICN_LC'); break;
                case "NT" : $('td:eq(13)', nRow).addClass('UICN_NT'); break;
                case "VU" : $('td:eq(13)', nRow).addClass('UICN_VU'); break;
                case "EN" : $('td:eq(13)', nRow).addClass('UICN_EN'); break;
                case "CR" : $('td:eq(13)', nRow).addClass('UICN_CR'); break;
				case "CR*" : $('td:eq(13)', nRow).addClass('UICN_CR');break;
                case "RE" : $('td:eq(13)', nRow).addClass('UICN_RE'); break;
                case "EW" : $('td:eq(13)', nRow).addClass('UICN_EW'); break;
                case "EX" : $('td:eq(13)', nRow).addClass('UICN_EX'); break;
                case "NA" : $('td:eq(13)', nRow).addClass('UICN_NA'); break;
                case "NE" : $('td:eq(13)', nRow).addClass('UICN_NE'); break;
            }
            switch (aData[14])                                                  // Cat D
            {
                case "DD" : $('td:eq(14)', nRow).addClass('UICN_DD'); break;
                case "LC" : $('td:eq(14)', nRow).addClass('UICN_LC'); break;
                case "NT" : $('td:eq(14)', nRow).addClass('UICN_NT'); break;
                case "VU" : $('td:eq(14)', nRow).addClass('UICN_VU'); break;
                case "EN" : $('td:eq(14)', nRow).addClass('UICN_EN'); break;
                case "CR" : $('td:eq(14)', nRow).addClass('UICN_CR'); break;
				case "CR*" : $('td:eq(14)', nRow).addClass('UICN_CR');break;
                case "RE" : $('td:eq(14)', nRow).addClass('UICN_RE'); break;
                case "EW" : $('td:eq(14)', nRow).addClass('UICN_EW'); break;
                case "EX" : $('td:eq(14)', nRow).addClass('UICN_EX'); break;
                case "NA" : $('td:eq(14)', nRow).addClass('UICN_NA'); break;
                case "NE" : $('td:eq(14)', nRow).addClass('UICN_NE'); break;
            }
            switch (aData[15])                                                  // Cat 
            {
                case "DD" : $('td:eq(15)', nRow).addClass('UICN_DD'); break;
                case "LC" : $('td:eq(15)', nRow).addClass('UICN_LC'); break;
                case "NT" : $('td:eq(15)', nRow).addClass('UICN_NT'); break;
                case "VU" : $('td:eq(15)', nRow).addClass('UICN_VU'); break;
                case "EN" : $('td:eq(15)', nRow).addClass('UICN_EN'); break;
                case "CR" : $('td:eq(15)', nRow).addClass('UICN_CR'); break;
				case "CR*" : $('td:eq(15)', nRow).addClass('UICN_CR');break;
                case "RE" : $('td:eq(15)', nRow).addClass('UICN_RE'); break;
                case "EW" : $('td:eq(15)', nRow).addClass('UICN_EW'); break;
                case "EX" : $('td:eq(15)', nRow).addClass('UICN_EX'); break;
                case "NA" : $('td:eq(15)', nRow).addClass('UICN_NA'); break;
                case "NE" : $('td:eq(15)', nRow).addClass('UICN_NE'); break;
            }
            switch (aData[17])                                                  // Cat EU
            {
                case "DD" : $('td:eq(17)', nRow).addClass('UICN_DD'); break;
                case "LC" : $('td:eq(17)', nRow).addClass('UICN_LC'); break;
                case "NT" : $('td:eq(17)', nRow).addClass('UICN_NT'); break;
                case "VU" : $('td:eq(17)', nRow).addClass('UICN_VU'); break;
                case "EN" : $('td:eq(17)', nRow).addClass('UICN_EN'); break;
                case "CR" : $('td:eq(17)', nRow).addClass('UICN_CR'); break;
				case "CR*" : $('td:eq(17)', nRow).addClass('UICN_CR');break;
                case "RE" : $('td:eq(17)', nRow).addClass('UICN_RE'); break;
                case "EW" : $('td:eq(17)', nRow).addClass('UICN_EW'); break;
                case "EX" : $('td:eq(17)', nRow).addClass('UICN_EX'); break;
                case "NA" : $('td:eq(17)', nRow).addClass('UICN_NA'); break;
                case "NE" : $('td:eq(17)', nRow).addClass('UICN_NE'); break;
                break;
            }
            switch (aData[18])                                                  // Cat EU
            {
                case "DD" : $('td:eq(18)', nRow).addClass('UICN_DD'); break;
                case "LC" : $('td:eq(18)', nRow).addClass('UICN_LC'); break;
                case "NT" : $('td:eq(18)', nRow).addClass('UICN_NT'); break;
                case "VU" : $('td:eq(18)', nRow).addClass('UICN_VU'); break;
                case "EN" : $('td:eq(18)', nRow).addClass('UICN_EN'); break;
                case "CR" : $('td:eq(18)', nRow).addClass('UICN_CR'); break;
				case "CR*" : $('td:eq(18)', nRow).addClass('UICN_CR');break;
                case "RE" : $('td:eq(18)', nRow).addClass('UICN_RE'); break;
                case "EW" : $('td:eq(18)', nRow).addClass('UICN_EW'); break;
                case "EX" : $('td:eq(18)', nRow).addClass('UICN_EX'); break;
                case "NA" : $('td:eq(18)', nRow).addClass('UICN_NA'); break;
                case "NE" : $('td:eq(18)', nRow).addClass('UICN_NE'); break;
                break;
            }
			switch (aData[21])                                                  // Cat EU
            {	
                case 'à réaliser' : $('td:eq(21)', nRow).addClass('avancement_1'); break;
                case 'en cours' : $('td:eq(21)', nRow).addClass('avancement_2'); break;
                case 'réalisée' : $('td:eq(21)', nRow).addClass('avancement_3'); break;
            }
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
       "aaSorting": [[2,'asc']],                                               // Nom scientifique 
        "sDom": '<"top"fl>rt<"bottom"ip>',
            "aoColumns": [
                { "sWidth": "5%" },                                                           // Etape
                { "sWidth": "9%" },                                                           // famille
            	{ "sWidth": "4%" },                                           // CD_REF
            	{ "sWidth": "15%", "sClass": "nom_taxon" },                     // Nom scientifique 
                { "sWidth": "5%" },                                                           // Rang
                { "sWidth": "4%" },                                                       
                { "sWidth": "2%" },                                                            
                { "sWidth": "3%" },                                                           // AOO4
                { "sWidth": "3%" },                                                           // AOO precis+plage
                { "sWidth": "3%" },                                                           // Nb loc.
                { "sWidth": "3%" },                                                           // Nb mailles
        		{ "sClass": "uicn","sWidth": "2%" },                          // cat_A
        		{ "sClass": "uicn","sWidth": "2%" },                          // cat_B
        		{ "sClass": "uicn","sWidth": "2%" },                          // cat_C
        		{ "sClass": "uicn","sWidth": "2%" },                          // cat_D
        		{ "sClass": "uicn","sWidth": "2%" },                          // cat_fin
                { "sWidth": "4%" },
        		{ "sClass": "uicn","sWidth": "2%" },                          // cat_EU
        		{ "sClass": "uicn","sWidth": "2%" },                          // cat_synt_reg
        		{ "sWidth": "2%" },                         									// nb_reg_eval
        		{ "sWidth": "2%" },                         									// notes
    			{ "sClass": "valid", "sWidth": "5%"  },                                           // UID
    			{ "sClass": "center","sWidth": "3%","bSortable": false },     // Actions
        		{ "sClass": "center","sWidth": "3%","bSortable": false }      // Sélect.
        ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
                { type: "select", values: [{ value: '1', label: 'pré-eval'},{ value: '2', label: 'éval'},{ value: '3', label: 'post-éval'}]},
                { type: "text" },                                               // Famille
                { type: "text" },                                               // CD_REF
                { type: "text" },                                               // Nom scientifique 
                { type: "select", values: ['ES','SSES','VAR','SVAR','FO','SSFO']}, // Rang
                // { type: "text" },                                               //  
                { type: "select", values: [{ value: 1, label: 'Indigène'},{ value: 2, label: 'Cryptogène'},{ value: 3, label: 'Exotique'}] },                                               //  
//                { type: "text" },                                               //  
//                { type: "text" },                                               //  
//                { type: "text" },                                               //  
                { type: "select", values: [{ value: 't', label: 'Oui'},{ value: 'f', label: 'Non'}] },                                               //  
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "select", values: [{ value: 'not_zero', label: 'évalué'},{ value: '0', label: 'non évalué'},{ value: '1', label: 'RE'},{ value: '2', label: 'CR*'},{ value: '3', label: 'CR'},{ value: '4', label: 'EN'},{ value: '5', label: 'VU'},{ value: '6', label: 'NT'},{ value: '7', label: 'LC'},{ value: '8', label: 'DD'},{ value: '9', label: 'NE'},{value: '10', label: 'NA'}]},
                // { type: "text" },                                               //  
                { type: "select", values: [{ value: 'not_zero', label: 'évalué'},{ value: '0', label: 'non évalué'},{ value: '1', label: 'RE'},{ value: '2', label: 'CR*'},{ value: '3', label: 'CR'},{ value: '4', label: 'EN'},{ value: '5', label: 'VU'},{ value: '6', label: 'NT'},{ value: '7', label: 'LC'},{ value: '8', label: 'DD'},{ value: '9', label: 'NE'},{value: '10', label: 'NA'}]},
                // { type: "text" },                                               //  
                { type: "select", values: [{ value: 'not_zero', label: 'évalué'},{ value: '0', label: 'non évalué'},{ value: '1', label: 'RE'},{ value: '2', label: 'CR*'},{ value: '3', label: 'CR'},{ value: '4', label: 'EN'},{ value: '5', label: 'VU'},{ value: '6', label: 'NT'},{ value: '7', label: 'LC'},{ value: '8', label: 'DD'},{ value: '9', label: 'NE'},{value: '10', label: 'NA'}]},
                // { type: "text" },                                               //  
                { type: "select", values: [{ value: 'not_zero', label: 'évalué'},{ value: '0', label: 'non évalué'},{ value: '1', label: 'RE'},{ value: '2', label: 'CR*'},{ value: '3', label: 'CR'},{ value: '4', label: 'EN'},{ value: '5', label: 'VU'},{ value: '6', label: 'NT'},{ value: '7', label: 'LC'},{ value: '8', label: 'DD'},{ value: '9', label: 'NE'},{value: '10', label: 'NA'}]},
                // { type: "text" },                                               //  
                // { type: "select", values: [{ value: 't', label: 'Oui'},{ value: 'f', label: 'Non'}] },                                    //  
                { type: "select", values: [{ value: 'not_zero', label: 'évalué'},{ value: '0', label: 'non évalué'},{ value: '1', label: 'RE'},{ value: '2', label: 'CR*'},{ value: '3', label: 'CR'},{ value: '4', label: 'EN'},{ value: '5', label: 'VU'},{ value: '6', label: 'NT'},{ value: '7', label: 'LC'},{ value: '8', label: 'DD'},{ value: '9', label: 'NE'},{value: '10', label: 'NA'}]},
                { type: "text" },                                               //  
                { type: "select", values: [{ value: 'not_zero', label: 'évalué'},{ value: '0', label: 'non évalué'},{ value: '1', label: 'RE'},{ value: '2', label: 'CR*'},{ value: '3', label: 'CR'},{ value: '4', label: 'EN'},{ value: '5', label: 'VU'},{ value: '6', label: 'NT'},{ value: '7', label: 'LC'},{ value: '8', label: 'DD'},{ value: '9', label: 'NE'},{value: '10', label: 'NA'}]},
                { type: "select", values: [{ value: 'not_zero', label: 'évalué'},{ value: '0', label: 'non évalué'},{ value: '1', label: 'RE'},{ value: '2', label: 'CR*'},{ value: '3', label: 'CR'},{ value: '4', label: 'EN'},{ value: '5', label: 'VU'},{ value: '6', label: 'NT'},{ value: '7', label: 'LC'},{ value: '8', label: 'DD'},{ value: '9', label: 'NE'},{value: '10', label: 'NA'}]},
                { type: "text" },
                { type: "text" },
//              { type: "select", values: ['EX','EW','RE','CR','CR*','EN','VU','NT','LC','DD','NA','NE']}, // cat_fin
                { type: "select", values: [{ value: 1, label: 'à réaliser'},{ value: 2, label: 'en cours'},{ value: 3, label: 'réalisée'}]}                                               //  
			]
		});        
	oTable.fnSort( [ [0,'desc'] ] );		

	include("js/user.js");

	} else {
		oTable.fnClearTable (false);
		oTable.fnDraw ();
	}	

