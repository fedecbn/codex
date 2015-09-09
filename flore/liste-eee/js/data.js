//*******************************************************************************/
//   module_gestion/js/gestion.js                                               //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
/*******************************************************************************/
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
            if (aData[6] > 0 && aData[6]<=5)  {$('td:eq(6)', nRow).addClass('eval_FAIBLE');}
			else if (aData[6]> 5) {$('td:eq(6)', nRow).addClass('eval_FORT');}
            // Risque propagation
            if (aData[7] > 0 && aData[7]<=7)  {$('td:eq(7)', nRow).addClass('eval_FAIBLE');}
			else if (aData[7]> 7){$('td:eq(7)', nRow).addClass('eval_FORT');}
				
            if (aData[8] > 0 && aData[8]<=6){$('td:eq(8)', nRow).addClass('eval_FAIBLE');}
			else if (aData[8]> 7) {$('td:eq(8)', nRow).addClass('eval_FORT');}
			// Score de Weber	
            if (aData[9] > 0 && aData[9]<=20) {$('td:eq(9)', nRow).addClass('eval_FAIBLE');}
            else if (aData[9] > 20 && aData[9]<=27) { $('td:eq(9)', nRow).addClass('eval_INTER');}
			else if (aData[9]> 27){$('td:eq(9)', nRow).addClass('eval_FORT');}
				
            if (aData[10] == 'FAIBLE'){$('td:eq(10)', nRow).addClass('eval_FAIBLE');}
            else if (aData[10] == 'INTERMEDIAIRE') {$('td:eq(10)', nRow).addClass('eval_INTER');}
			else if (aData[10] == 'FORT') {$('td:eq(10)', nRow).addClass('eval_FORT');}
			else if (aData[10] == 'Insuffisamment documenté'){$('td:eq(10)', nRow).addClass('eval_NE');}
				
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
            "aoColumns": [                                                        
                { "sWidth": "6%" },
            	{ "sWidth": "20%" },
            	{ "sWidth": "5%" },
            	{ "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sClass": "eval","sWidth": "6%"},
				{ "sClass": "eval","sWidth": "8%" },
    			{ "sWidth": "6%" },
                { "sWidth": "5%" },
                { "sWidth": "5%" },
                { "sWidth": "3%" },
    			{ "sWidth": "3%" },
        		{ "sClass": "center","sWidth": "3%","bSortable": false },
    			{ "sClass": "center","sWidth": "3%","bSortable": false },
        		{ "sClass": "center","sWidth": "3%","bSortable": false }
        ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
                { type: "text" },
                { type: "text" },                                               // 
                { type: "select", values: ['ES','SSES','VAR','SVAR','FO','SSFO']}, // 
                { type: "select", values: ['oui','non']  },                                               //  
                { type: "select", values: ['oui','non']  },                                               //  
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "text" },                                                                                             
                { type: "select", values: [{ value: 'not_null', label: 'évalué'},{ value: 'Insuffisamment documenté', label: 'Insuffisamment documenté'},{ value: 'FAIBLE', label: 'FAIBLE'},{ value: 'INTERMEDIAIRE', label: 'INTERMEDIAIRE'},{ value: 'FORT', label: 'FORT'}]},                                    
                { type: "text" },                                              //                                            //  
                { type: "select", values: [{ value: 'pcpl', label: 'principale'},{ value: 'annexe', label: 'annexe'}]},                                    
                { type: "select", values: [{ value: 'emerg', label: 'emmergent'},{ value: 'non_emerg', label: 'nom_emergent'}]},
                { type: "select", values: [{ value: 'avere_local', label: 'localement'},{ value: 'avere_ailleurs', label: 'ailleurs'},{ value: 'non_avere', label: 'non avere'}]},                                               //  
                { type: "text" }                                               //  
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
		"aaSorting": [[2,'asc']],                                               // Nom scientifique 
        "sDom": '<"top"fl>rt<"bottom"ip>',
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
	oTable.fnSort( [ [0,'desc'] ] );		
	oTable2.fnSort( [ [2,'desc'] ] );		
	} else {
		oTable.fnClearTable (false);
		oTable.fnDraw ();
	}	
