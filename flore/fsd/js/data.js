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
			// "bStateSave": true,
			// "fnStateSave": function (oSettings, oData) {
				// localStorage.setItem( 'data_'+window.location.pathname, JSON.stringify(oData) );
				// },
			// "fnStateLoad": function (oSettings) {
				// return JSON.parse( localStorage.getItem('data_'+window.location.pathname) );
				// }, 
			"fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
			switch (aData[4]) {default : $('td:eq(4)', nRow).addClass('nom_taxon'); break;}
			switch (aData[8]){
				case "Oui" :$('td:eq(8)', nRow).addClass('oui');break;
				case "Oui si" :$('td:eq(8)', nRow).addClass('ouisi');break;
				case "Non" :$('td:eq(8)', nRow).addClass('non');break;
				}
			switch (aData[9]){
				case "Oui" :$('td:eq(9)', nRow).addClass('oui');break;
				case "Oui si" :$('td:eq(9)', nRow).addClass('ouisi');break;
				case "Non" :$('td:eq(9)', nRow).addClass('non');break;
				}
			switch (aData[10]){
				case "Oui" :$('td:eq(10)', nRow).addClass('oui');break;
				case "Oui si" :$('td:eq(10)', nRow).addClass('ouisi');break;
				case "Non" :$('td:eq(10)', nRow).addClass('non');break;
				}
			switch (aData[11]){
				case "Oui" :$('td:eq(11)', nRow).addClass('oui');break;
				case "Oui si" :$('td:eq(11)', nRow).addClass('ouisi');break;
				case "Non" :$('td:eq(11)', nRow).addClass('non');break;
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
					{ "sWidth": "3%" },
					{ "sWidth": "2%" },
					{ "sWidth": "6%" },
					{ "sWidth": "6%" },
					{ "sWidth": "14%" },
					{ "sWidth": "12%" },
					{ "sWidth": "30%" },
					{ "sWidth": "4%" },
					{ "sWidth": "3%" },
					{ "sWidth": "3%" },
					{ "sWidth": "3%" },
					{ "sWidth": "3%" },
					{ "sWidth": "3%" },
					{ "sWidth": "3%" },
					{ "sWidth": "3%" },
					{ "sWidth": "8%" },
					{ "sClass": "center","sWidth": "3%","bSortable": false },     // 
					{ "sClass": "center","sWidth": "3%","bSortable": false }      // .
			]
			}).columnFilter({
				sPlaceHolder: "head:after",
				aoColumns: [ 
					{ type: "text" },
					{ type: "select", values: [1,2,3]}, // 
					{ type: "text" },                                               // 
					{ type: "text" },                                               //  
					{ type: "text" },  
					{ type: "text" },                                               //  
					{ type: "text" },   
					{ type: "select", values: ['String','Float','Integer']},
					{ type: "select", values: [{ value: 'not_null', label: 'Dans FSD'},{ value: 'Oui', label: 'Oui'},{ value: 'Oui si', label: 'Oui si'},{ value: 'Non', label: 'Non'},{ value: 'NSP', label: 'NeSaitPas'}]},
					{ type: "select", values: [{ value: 'not_null', label: 'Dans FSD'},{ value: 'Oui', label: 'Oui'},{ value: 'Oui si', label: 'Oui si'},{ value: 'Non', label: 'Non'},{ value: 'NSP', label: 'NeSaitPas'}]},
					{ type: "select", values: [{ value: 'not_null', label: 'Dans FSD'},{ value: 'Oui', label: 'Oui'},{ value: 'Oui si', label: 'Oui si'},{ value: 'Non', label: 'Non'},{ value: 'NSP', label: 'NeSaitPas'}]},
					{ type: "select", values: [{ value: 'not_null', label: 'Dans FSD'},{ value: 'Oui', label: 'Oui'},{ value: 'Oui si', label: 'Oui si'},{ value: 'Non', label: 'Non'},{ value: 'NSP', label: 'NeSaitPas'}]},
					{ type: "select", values: [{ value: 'not_null', label: 'present'},{ value: 'null', label: 'absent'}]},                                              //  
					{ type: "text" },                                               //  
					{ type: "text" },                                               //  
					{ type: "text" },  
				]
			});
	oTable.fnSort( [ [0,'asc'] ] );		

		include("../commun/js/user.js");
	} else {
	oTable.fnClearTable (false);
	oTable.fnDraw ();
}	
