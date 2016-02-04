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
