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
    	"sServerMethod": "POST",
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
            switch (aData[6])                                                  // Cat A
            {
                case "oui" : $('td:eq(6)', nRow).addClass('oui'); break;
                case "non" : $('td:eq(6)', nRow).addClass('non'); break;
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
       "aaSorting": [[2,'asc']],                                               // Nom scientifique 
       "sDom": '<"top"l>rt<"bottom"ip>',
      "aoColumns":  descColumns
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: filterColumns
		});        
	oTable.fnSort( [ [0,'desc'] ] );		

		include("../commun/js/user.js");
		
	} else {
		oTable.fnClearTable (false);
		oTable.fnDraw ();
	}	

