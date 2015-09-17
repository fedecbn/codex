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
			switch (aData[5]){case 't' :$('td:eq(5)', nRow).addClass('oui');break;case 'f' : $('td:eq(5)', nRow).addClass('non'); break;}
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
		// "aaSorting": [[2,'asc']],                                               // Nom scientifique 
        "sDom": '<"top"fl>rt<"bottom"ip>',
            "aoColumns": [
                { "sWidth": "12%" },                                                           
                { "sWidth": "16%" },                                                           
        		{ "sWidth": "16%" },                         									
        		{ "sWidth": "16%" },                         									
        		{ "sClass": "center","sWidth": "20%"},                         									
        		{ "sClass": "center","sWidth": "20%"}                        									
        		// { "sClass": "center","sWidth": "5%","bSortable": false }      // Sélect.
        ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
                { type: "text" },                                               // 
                { type: "text" },                                               // 
                { type: "text" },                                               //   
                { type: "select", values:[{ value: 1, label: 'CBN Alpin'},{ value: 2, label: 'CBN de Bailleul'},{ value: 3, label: 'CBN de Brest'},{ value: 4, label: 'CBN de Corse'},{ value: 5, label: 'CBN de Franche-Comté'},{ value: 6, label: 'CBN des Pyrénées et de Midi-Pyrénées'},{ value: 7, label: 'CBN du Bassin Parisien'},{ value: 8, label: 'CBN du Massif central'},{ value: 12, label: '[Guyane]'},{ value: 13, label: '[Grand Est]'},{ value: 14, label: '[Guadeloupe]'},{ value: 15, label: '[Martinique]'},{ value: 16, label: 'FCBN'},{ value: 0, label: 'inconnu'},{ value: 9, label: 'CBN Méditerranéen de Porquerolles'},{ value: 10, label: 'CBN Sud-Atlantique'},{ value: 11, label: 'CBN Mascarin'}]},                                               //  
				{ type: "select", values: [{ value: 1, label: 'Lecteur' },{ value: 64, label: 'Participant' },{ value: 128, label: 'Evaluateur' },{ value: 129, label: 'Référent' },{ value: 255, label: 'Administrateur'}] },
                { type: "select", values: [{ value: true, label: 'Oui'},{ value: false, label: 'Non' } ] }
			]
		});	
	oTable2.fnSort( [ [2,'desc'] ] );