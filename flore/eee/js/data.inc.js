//*******************************************************************************/
//   module_gestion/js/gestion.js                                               //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
/*******************************************************************************/
    if (typeof oTable == 'undefined') {
        var oTable = $('#onglet0-liste').dataTable({
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
    	"sAjaxSource": "liste.php?onglet=eee",
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
            "sLengthMenu":   "Afficher _MENU_ lignes",
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
        "sDom": '<"top"l>rt<"bottom"ip>',
            "aoColumns": descColumns
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: filterColumns
		});        
	oTable.fnSort( [ [1,'asc'] ] );		

	
	
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/	
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/	
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/	
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/	

        var oTable1 = $('#onglet1-liste').dataTable({
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
    	"sAjaxSource": "liste.php?onglet=eee_reg",
        "bStateSave": true,
		"fnStateSave": function (oSettings, oData) {
            localStorage.setItem( 'data_'+window.location.pathname, JSON.stringify(oData) );
			},
        "fnStateLoad": function (oSettings) {
            return JSON.parse( localStorage.getItem('data_'+window.location.pathname) );
			}, 
        "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            if (aData[8] > 0 && aData[8]<=5)  {$('td:eq(8)', nRow).addClass('eval_FAIBLE');}
			else if (aData[8]> 5) {$('td:eq(8)', nRow).addClass('eval_FORT');}
            // Risque propagation
            if (aData[13] > 0 && aData[13]<=7)  {$('td:eq(13)', nRow).addClass('eval_FAIBLE');}
			else if (aData[13]> 7){$('td:eq(13)', nRow).addClass('eval_FORT');}
				
            if (aData[18] > 0 && aData[18]<=6){$('td:eq(18)', nRow).addClass('eval_FAIBLE');}
			else if (aData[18]> 7) {$('td:eq(18)', nRow).addClass('eval_FORT');}
			// Score de Weber	
            if (aData[19] > 0 && aData[19]<=20) {$('td:eq(19)', nRow).addClass('eval_FAIBLE');}
            else if (aData[19] > 20 && aData[19]<=27) { $('td:eq(19)', nRow).addClass('eval_INTER');}
			else if (aData[19]> 27){$('td:eq(19)', nRow).addClass('eval_FORT');}
								
            return nRow;
        },
		"oLanguage": { "sProcessing":   "Traitement en cours...",
            "sLengthMenu":   "Afficher _MENU_ lignes",
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
        "sDom": '<"top"l>rt<"bottom"ip>',
            "aoColumns": [                                                        
                { "sWidth": "5%" },
            	{ "sWidth": "15%" },
            	{ "sWidth": "8%" },
            	{ "sWidth": "7%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
                { "sWidth": "4%" },
        		{ "sClass": "center","sWidth": "3%","bSortable": false },
        		{ "sClass": "center","sWidth": "3%","bSortable": false }
        ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
                { type: "text" },
                { type: "text" },                                               // 
                { type: "text" },                                               // 
                { type: "text" },                                               // 
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "text" },                                                                                             
                { type: "text" },                                                                                             
                { type: "text" },                                                                                             
                { type: "text" },                                                                                             
                { type: "text" },                                                                                             
                { type: "text" },                                                                                             
                { type: "text" },                                                                                             
                { type: "text" },                                                                                             
                { type: "text" },                                                                                             
                { type: "text" },                                                                                             
                { type: "text" },                                                                                             
                { type: "text" }                                               //  
			]
		});        
	oTable1.fnSort( [ [1,'asc'] ] );		

		include("../commun/js/user.js");
		
	} else {
		oTable.fnClearTable (false);
		oTable.fnDraw ();
		// oTable1.fnClearTable (false);
		// oTable1.fnDraw ();
	}	
