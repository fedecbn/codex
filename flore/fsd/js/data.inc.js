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
			"sAjaxSource": "liste.php?onglet=fsd",
			"bStateSave": true,
			"fnStateSave": function (oSettings, oData) {
				localStorage.setItem( 'data_'+window.location.pathname, JSON.stringify(oData) );
				},
			"fnStateLoad": function (oSettings) {
				return JSON.parse( localStorage.getItem('data_'+window.location.pathname) );
				}, 
			"fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
			switch (aData[0]) {default : $('td:eq(0)', nRow).addClass('nom_taxon'); break;}
			switch (aData[4]){
				case "Oui" :$('td:eq(4)', nRow).addClass('oui');break;
				case "Oui si" :$('td:eq(4)', nRow).addClass('ouisi');break;
				case "Non" :$('td:eq(4)', nRow).addClass('non');break;
				}
			switch (aData[5]){
				case "Oui" :$('td:eq(5)', nRow).addClass('oui');break;
				case "Oui si" :$('td:eq(5)', nRow).addClass('ouisi');break;
				case "Non" :$('td:eq(5)', nRow).addClass('non');break;
				}
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
			"sDom": '<"top"l>rt<"bottom"ip>',
				"aoColumns": [                                                        // 
					{ "sWidth": "12%" },
					{ "sWidth": "15%" },
					{ "sWidth": "35%" },
					{ "sWidth": "8%" },
					{ "sWidth": "3%" },
					{ "sWidth": "3%" },
					{ "sWidth": "3%" },
					{ "sWidth": "3%" },
					{ "sWidth": "15%" },
					{ "sClass": "center","sWidth": "3%","bSortable": false },     // 
					{ "sClass": "center","sWidth": "3%","bSortable": false }      // .
			]
			}).columnFilter({
				sPlaceHolder: "head:after",
				aoColumns: [ 
					{ type: "text" },                                               // 
					{ type: "text" },                                               //  
					{ type: "text" },  
					{ type: "select", values: ['character varying','float','integer','boolean','date']},
					{ type: "select", values: [{ value: 'Oui', label: 'Oui'},{ value: 'Non', label: 'Non'},{ value: 'NSP', label: 'NeSaitPas'}]},
					{ type: "select", values: [{ value: 'Oui', label: 'Oui'},{ value: 'Non', label: 'Non'},{ value: 'NSP', label: 'NeSaitPas'}]},
					{ type: "select", values: [{ value: 'not_null', label: 'present'},{ value: 'null', label: 'absent'}]},                                              //                                         //  
					{ type: "text" },                                               //  
					{ type: "text" },  
				]
			});
	oTable.fnSort( [ [0,'asc'] ] );		

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
			// "aaSorting": [[ 0, "asc" ],[ 1, "asc" ]],
			"sAjaxSource": "liste.php?onglet=meta",
			"bStateSave": true,
			"fnStateSave": function (oSettings, oData) {
				localStorage.setItem( 'data_'+window.location.pathname, JSON.stringify(oData) );
				},
			"fnStateLoad": function (oSettings) {
				return JSON.parse( localStorage.getItem('data_'+window.location.pathname) );
				}, 
			"fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
			switch (aData[1]) {default : $('td:eq(1)', nRow).addClass('nom_taxon'); break;}
			switch (aData[3]) {default : $('td:eq(3)', nRow).addClass('nom_taxon'); break;}
			switch (aData[6]){
				case "Oui" :$('td:eq(6)', nRow).addClass('oui');break;
				case "Oui si" :$('td:eq(6)', nRow).addClass('ouisi');break;
				case "Non" :$('td:eq(6)', nRow).addClass('non');break;
				}
			switch (aData[5]){
				case "Oui" :$('td:eq(5)', nRow).addClass('oui');break;
				case "Oui si" :$('td:eq(5)', nRow).addClass('ouisi');break;
				case "Non" :$('td:eq(5)', nRow).addClass('non');break;
				}
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
			"sDom": '<"top"l>rt<"bottom"ip>',
				"aoColumns": [                                                        // 
					{ "sWidth": "2%" },
					{ "sWidth": "12%" },
					{ "sWidth": "3%" },
					{ "sWidth": "12%" },
					{ "sWidth": "20%" },
					{ "sWidth": "5%" },
					{ "sWidth": "5%" },
					{ "sWidth": "40%" },
					{ "sClass": "center","sWidth": "3%","bSortable": false },     // 
					{ "sClass": "center","sWidth": "3%","bSortable": false }      // .
			]
			}).columnFilter({
				sPlaceHolder: "head:after",
				aoColumns: [ 
					{ type: "text" },                                               // 
					{ type: "text" },                                               // 
					{ type: "text" },                                               //  
					{ type: "text" },  
					{ type: "text" },  
					{ type: "select", values: [{ value: 'Oui', label: 'Oui'},{ value: 'Oui si', label: 'Oui si'},{ value: 'Non', label: 'Non'}]},
					{ type: "select", values: [{ value: 'Oui', label: 'Oui'},{ value: 'Non', label: 'Non'}]},
					{ type: "text" }
					]
			});
	oTable1.fnSort( [ [0,'asc'],[1,'asc'] ] );


/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/	
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/	
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/	
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/	

	var oTable2 = $('#onglet2-liste').dataTable({
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
			// "aaSorting": [[ 0, "asc" ],[ 1, "asc" ]],
			"sAjaxSource": "liste.php?onglet=data",
			"bStateSave": true,
			"fnStateSave": function (oSettings, oData) {
				localStorage.setItem( 'data_'+window.location.pathname, JSON.stringify(oData) );
				},
			"fnStateLoad": function (oSettings) {
				return JSON.parse( localStorage.getItem('data_'+window.location.pathname) );
				}, 
			"fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
			switch (aData[1]) {default : $('td:eq(1)', nRow).addClass('nom_taxon'); break;}
			switch (aData[3]) {default : $('td:eq(3)', nRow).addClass('nom_taxon'); break;}
			switch (aData[6]){
				case "Oui" :$('td:eq(6)', nRow).addClass('oui');break;
				case "Oui si" :$('td:eq(6)', nRow).addClass('ouisi');break;
				case "Non" :$('td:eq(6)', nRow).addClass('non');break;
				}
			switch (aData[5]){
				case "Oui" :$('td:eq(5)', nRow).addClass('oui');break;
				case "Oui si" :$('td:eq(5)', nRow).addClass('ouisi');break;
				case "Non" :$('td:eq(5)', nRow).addClass('non');break;
				}
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
			"sDom": '<"top"l>rt<"bottom"ip>',
				"aoColumns": [                                                        // 
					{ "sWidth": "2%" },
					{ "sWidth": "12%" },
					{ "sWidth": "3%" },
					{ "sWidth": "12%" },
					{ "sWidth": "20%" },
					{ "sWidth": "5%" },
					{ "sWidth": "5%" },
					{ "sWidth": "40%" },
					{ "sClass": "center","sWidth": "3%","bSortable": false },     // 
					{ "sClass": "center","sWidth": "3%","bSortable": false }      // .
			]
			}).columnFilter({
				sPlaceHolder: "head:after",
				aoColumns: [ 
					{ type: "text" },                                               // 
					{ type: "text" },                                               // 
					{ type: "text" },                                               //  
					{ type: "text" },  
					{ type: "text" },  
					{ type: "select", values: [{ value: 'Oui', label: 'Oui'},{ value: 'Oui si', label: 'Oui si'},{ value: 'Non', label: 'Non'}]},
					{ type: "select", values: [{ value: 'Oui', label: 'Oui'},{ value: 'Non', label: 'Non'}]},
					{ type: "text" }
					]
			});
	oTable2.fnSort( [ [0,'asc'],[1,'asc'] ] );

/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/	
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/	
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/	
/*---------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/	

	var oTable3 = $('#onglet3-liste').dataTable({
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
			// "aaSorting": [[ 0, "asc" ],[ 1, "asc" ]],
			"sAjaxSource": "liste.php?onglet=taxa",
			"bStateSave": true,
			"fnStateSave": function (oSettings, oData) {
				localStorage.setItem( 'data_'+window.location.pathname, JSON.stringify(oData) );
				},
			"fnStateLoad": function (oSettings) {
				return JSON.parse( localStorage.getItem('data_'+window.location.pathname) );
				}, 
			"fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
			switch (aData[1]) {default : $('td:eq(1)', nRow).addClass('nom_taxon'); break;}
			switch (aData[3]) {default : $('td:eq(3)', nRow).addClass('nom_taxon'); break;}
			switch (aData[6]){
				case "Oui" :$('td:eq(6)', nRow).addClass('oui');break;
				case "Oui si" :$('td:eq(6)', nRow).addClass('ouisi');break;
				case "Non" :$('td:eq(6)', nRow).addClass('non');break;
				}
			switch (aData[5]){
				case "Oui" :$('td:eq(5)', nRow).addClass('oui');break;
				case "Oui si" :$('td:eq(5)', nRow).addClass('ouisi');break;
				case "Non" :$('td:eq(5)', nRow).addClass('non');break;
				}
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
			"sDom": '<"top"l>rt<"bottom"ip>',
				"aoColumns": [                                                        // 
					{ "sWidth": "2%" },
					{ "sWidth": "12%" },
					{ "sWidth": "3%" },
					{ "sWidth": "12%" },
					{ "sWidth": "20%" },
					{ "sWidth": "5%" },
					{ "sWidth": "5%" },
					{ "sWidth": "40%" },
					{ "sClass": "center","sWidth": "3%","bSortable": false },     // 
					{ "sClass": "center","sWidth": "3%","bSortable": false }      // .
			]
			}).columnFilter({
				sPlaceHolder: "head:after",
				aoColumns: [ 
					{ type: "text" },                                               // 
					{ type: "text" },                                               // 
					{ type: "text" },                                               //  
					{ type: "text" },  
					{ type: "text" },  
					{ type: "select", values: [{ value: 'Oui', label: 'Oui'},{ value: 'Oui si', label: 'Oui si'},{ value: 'Non', label: 'Non'}]},
					{ type: "select", values: [{ value: 'Oui', label: 'Oui'},{ value: 'Non', label: 'Non'}]},
					{ type: "text" }
					]
			});
	oTable3.fnSort( [ [0,'asc'],[1,'asc'] ] );	
	include("../commun/js/user.js");
		
	} else {
	oTable.fnClearTable (false);
	oTable.fnDraw ();
	oTable1.fnClearTable (false);
	oTable1.fnDraw ();
	oTable2.fnClearTable (false);
	oTable2.fnDraw ();
	oTable3.fnClearTable (false);
	oTable3.fnDraw ();
}