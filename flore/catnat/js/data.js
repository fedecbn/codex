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
			switch (aData[2]){default :$('td:eq(2)', nRow).addClass('nom_taxon');break;}
			switch (aData[5]){
				case "oui" : $('td:eq(5)', nRow).addClass('hyb_oui');break;
				case "non" : $('td:eq(5)', nRow).addClass('hyb_non');break;
				}
			switch (aData[10]){
				case "oui" :$('td:eq(10)', nRow).addClass('end_oui');break;
				case "non" :$('td:eq(10)', nRow).addClass('end_non');break;
				}
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
					{ "sWidth": "10%" },
					{ "sWidth": "25%" },
					{ "sWidth": "3%" },
					{ "sWidth": "10%" },
					{ "sWidth": "4%" },
					{ "sWidth": "10%" },
					{ "sWidth": "10%" },
					{ "sWidth": "10%" },
					{ "sWidth": "4%" },
					{ "sClass": "center","sWidth": "3%","bSortable": false },     // 
					{ "sClass": "center","sWidth": "3%","bSortable": false }      // .
			]
			}).columnFilter({
				sPlaceHolder: "head:after",
				aoColumns: [ 
					{ type: "text" },
					{ type: "text" },                                               // 
					{ type: "text" },                                               //  
					{ type: "select", values: ['ES','SSES','VAR','SVAR','FO','SSFO']}, // 
					{ type: "text" },                                               //  
					{ type: "select", values: [{ value: 't', label: 'Oui'},{ value: 'f', label: 'Non'}] },  
					{ type: "select", values: [{ value: 'Indigène', label: 'Indigène'},{ value: 'Cryptogène', label: 'Cryptogène'},{ value: 'Exotique', label: 'Exotique'}] },  
					{ type: "select", values: [{ value: 'not_null', label: 'évalué'},{ value: '', label: 'non évalué'},{ value: 'RE', label: 'RE'},{ value: 'CR*', label: 'CR*'},{ value: 'CR', label: 'CR'},{ value: 'EN', label: 'EN'},{ value: 'VU', label: 'VU'},{ value: 'NT', label: 'NT'},{ value: 'LC', label: 'LC'},{ value: 'DD', label: 'DD'},{ value: 'NE', label: 'NE'},{value: 'NA', label: 'NA'}]},
					{ type: "text" },                                               //  
					{ type: "select", values: [{ value: 't', label: 'Oui'},{ value: 'f', label: 'Non'}] },  
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
			// switch (aData[4])                                                  // Cat EU
            // {	
                // case '0' : 
                    // $('td:eq(21)', nRow).addClass('avancement_1');
                // break;
                // case '1' : 
                    // $('td:eq(21)', nRow).addClass('avancement_2');
                // break;
                // case '64' : 
                    // $('td:eq(21)', nRow).addClass('avancement_3');
                // break;
                // case '128' : 
                    // $('td:eq(21)', nRow).addClass('avancement_4');
                // break;
                // case '255' : 
                    // $('td:eq(21)', nRow).addClass('avancement_5');
                // break;
            // }
            // return nRow;
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
            "aoColumns": [
                null,                                                           
                null,                                                           
        		null,                         									
        		null,                         									
        		null,                         									
    			// { "sClass": "center","sWidth": "50px","bSortable": false },     // Actions
        		{ "sClass": "center","sWidth": "20px","bSortable": false }      // Sélect.
        ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
                { type: "text" },                                               // Famille
                { type: "text" },                                               // CD_REF
                { type: "text" },                                               // Nom scientifique 
                { type: "text" },                                               //  
                { type: "text" }                                               //  
			]
		});		
			
	} else {
	oTable.fnClearTable (false);
	oTable.fnDraw ();
}	
