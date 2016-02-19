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
    	"sAjaxSource": "liste.php?onglet=hub",
        "bStateSave": true,
        "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
		switch (aData[0])                                                  // Stylisation!
            {
                default : 
                    $('td:eq(1)', nRow).addClass('nom_taxon');
                break;
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
       // "aaSorting": [[3,'asc']],                                            
        "sDom": '<"top"fl>rt<"bottom"ip>',
            "aoColumns": [                                                    
                { "sWidth": "5%" },
            	{ "sWidth": "5%" },
            	{ "sWidth": "5%" },
                { "sWidth": "5%" },
                { "sWidth": "5%" },
                { "sWidth": "5%" },
                { "sWidth": "5%" },
                { "sWidth": "5%" },
                { "sWidth": "5%" },
                { "sWidth": "5%" },
                { "sWidth": "25%" },
                { "sWidth": "25%" },
    			{ "sClass": "center","sWidth": "50px","bSortable": false },     // 
        		{ "sClass": "center","sWidth": "20px","bSortable": false }      // .
        ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
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
                { type: "text" }
			]
		});
	include("../commun/js/user.js");        
	} else {
		oTable.fnClearTable (false);
		oTable.fnDraw ();
	}	
