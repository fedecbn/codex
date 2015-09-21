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
			switch (aData[9]){
				case "oui" :$('td:eq(9)', nRow).addClass('oui');break;
				case "non" :$('td:eq(9)', nRow).addClass('non');break;
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
					{ type: "select", values: [{ value: true, label: 'Oui'},{ value: false, label: 'Non'}] },  
					{ type: "select", values: [{ value: 'Indigène', label: 'Indigène'},{ value: 'Cryptogène', label: 'Cryptogène'},{ value: 'Exotique', label: 'Exotique'}] },  
					{ type: "select", values: [{ value: 'not_null', label: 'évalué'},{ value: '', label: 'non évalué'},{ value: 'RE', label: 'RE'},{ value: 'CR*', label: 'CR*'},{ value: 'CR', label: 'CR'},{ value: 'EN', label: 'EN'},{ value: 'VU', label: 'VU'},{ value: 'NT', label: 'NT'},{ value: 'LC', label: 'LC'},{ value: 'DD', label: 'DD'},{ value: 'NE', label: 'NE'},{value: 'NA', label: 'NA'}]},
					{ type: "text" },                                               //  
					{ type: "select", values: [{ value: true, label: 'Oui'},{ value: false, label: 'Non'}] },  
				]
			});
	oTable.fnSort( [ [0,'desc'] ] );		

		include("../commun/js/user.js");
	} else {
	oTable.fnClearTable (false);
	oTable.fnDraw ();
}	
