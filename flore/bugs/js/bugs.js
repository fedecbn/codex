/*******************************************************************************/
//  bugs/js/bugs.js                                                             //
//                                                                              //
//  Version 1.00  26/08/12 - DariaNet                                           //
//  Version 1.10  11/10/13 - MaJ liste                                          //
//  Version 1.11  02/06/14 - MaJ jquery & jquery-UI                             //
/*******************************************************************************/

$(document).ready(function(){

//------------------------------------------------------------------------------ UI / Tabs

    var $tabs = $("#tabs").tabs();
    
//------------------------------------------------------------------------------ UI / Boutons

	$( "#valid-button" )
        .button({
            icons: {
                primary: "ui-icon-check"
            },
            text: true
        })
        .click(function() {
            $("#form2").submit();
		});

    $( "#home-button" )
        .button({
            text: true
        })
        .click(function() {
              window.location.replace ('../home/index.php');				
		});

//------------------------------------------------------------------------------ LISTES

    function fnGetSelected( oTableLocal )                                      
	{
		var aReturn = new Array();
		var aTrs = oTableLocal.fnGetNodes();
		for ( var i=0 ; i<aTrs.length ; i++ )
		{
			if ( $(aTrs[i]).hasClass('row_selected') )
			{
				aReturn.push( aTrs[i] );
			}
		}
		return aReturn;
    }

    $.fn.dataTableExt.oApi.fnStandingRedraw = function(oSettings) {
        if(oSettings.oFeatures.bServerSide === false){
            var before = oSettings._iDisplayStart;
            oSettings.oApi._fnReDraw(oSettings);
        // iDisplayStart has been reset to zero - so lets change it back
            oSettings._iDisplayStart = before;
            oSettings.oApi._fnCalculateEnd(oSettings);
        }
        oSettings.oApi._fnDraw(oSettings);                                      // draw the 'current' page
    };

//------------------------------------------------------------------------------ LISTE / bug

    if (typeof bug_encours_oTable == 'undefined') {
        var bug_encours_oTable = $('#bug-encours-liste').dataTable({
    		"bJQueryUI": true,
    		"bPaginate": false,
    		"bLengthChange": false,
    		"bFilter": true,
    		"bSort": true,
    		"bInfo": false,
    		"bAutoWidth": false,
      		"bServerSide": true,
    		"sAjaxSource": "bug-encours-liste.php",
            "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                if (aData[8] == "0") {
                    $('td:eq(6)', nRow).addClass('bug_new');
                } else if (aData[8] == "1") {
                    $('td:eq(5)', nRow).addClass('bug_confirmed');
                    $('td:eq(6)', nRow).addClass('bug_confirmed');
                } else if (aData[8] == "2") {
                    $('td:eq(5)', nRow).addClass('bug_resolved');
                    $('td:eq(6)', nRow).addClass('bug_resolved');
                } else if (aData[8] == "3") {
                    $('td:eq(6)', nRow).addClass('bug_closed');
                } else if (aData[8] == "4") {
                    $('td:eq(5)', nRow).addClass('bug_concert');
                    $('td:eq(6)', nRow).addClass('bug_concert');
                } 
                return nRow;
            },
            "bProcessing": true,
            "oLanguage": { 
                "sProcessing":   "Traitement en cours...",
                "sLengthMenu":   "Afficher _MENU_ éléments",
                "sZeroRecords":  "Aucun élément à afficher",
                "sInfo": "Affichage de l'élément _START_ à _END_ sur _TOTAL_",
                "sInfoEmpty": "Affichage de l'élément 0 à 0 sur 0",
                "sInfoFiltered": "(filtré de _MAX_ éléments au total)",
                "sInfoPostFix":  "",
                "sSearch":       "Rechercher:",
                "sUrl":          "",
                "oPaginate": {
                    "sFirst":    "Premier",
                    "sPrevious": "Précédent",
                    "sNext":     "Suivant",
                    "sLast":     "Dernier"
                }
            }, 
            "aaSorting": [[0,'DESC']],                                          // id_bug
    		"aoColumns": [
    			{ "sWidth": "30px" },                                           // id_bug
    			{ "sClass": "center","sWidth": "70px","bSortable": true },      // Type
    			{ "sClass": "center","sWidth": "90px","bSortable": true },      // Date
    			null,                                                           // Auteur 
    			null,                                                           // Rubrique 
    			{ "sWidth": "400px" },                                          // Descr.
    			{ "sClass": "center","sWidth": "70px","bSortable": true },      // Statut TXT
        		null,                                                           // Comment
    			{ "bVisible": false },                                          // Statut
    			{ "sClass": "center","sWidth": "60px","bSortable": false }      // Actions
        ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
                { type: "text" },                                               // id_bug
                { type: "select", values: [{ value:'1',label:'Bug'},{ value:'2',label:'Remarque'},{ value:'3',label:'Demande'}]},// Type
                null,                                                           // Date
                null,                                                           // Auteur
                null,                                                           // Rubrique
                { type: "text" },                                               // Descr.
                { type: "select", values: [{ value:'0',label:'Nouveau'},{ value:'1',label:'En cours'},{ value:'2',label:'OK'},{ value:'3',label:'Terminé'},{ value:'4',label:'Concertation'}]},// Type
                { type: "text" },                                               // Comment
                null                                                            // Statut
			]
		});        
	} else {
		bug_encours_oTable.fnClearTable (false);
		bug_encours_oTable.fnDraw();
	}	

	$("#bug-encours-liste tbody").click(function(event) {
        $(bug_encours_oTable.fnSettings().aoData).each(function (){
			$(this.nTr).removeClass('row_selected');
		});
		$(event.target.parentNode).addClass('row_selected');
	});

    $('#bug-encours-liste').on("click",".bug-encours-edit", function ($e) {
        metaForm ("Modifier un bug",670,450,'#bug-encours-dialog',"bug-form.php","bug-submit.php",bug_encours_oTable,$(this).attr('id'));
        return (false);
	});

    $('#bug-encours-liste').on("click",".bug-encours-del", function ($e) {
        deleteFunc ("Supprimer un bug",'#bug-encours-dialog',bug_encours_oTable,"bug-del.php",$(this).attr('id'));  
	    return (false);
	});

//------------------------------------------------------------------------------ LISTE / bug

    if (typeof bug_ok_oTable == 'undefined') {
        var bug_ok_oTable = $('#bug-ok-liste').dataTable({
    		"bJQueryUI": true,
    		"bPaginate": false,
    		"bLengthChange": false,
    		"bFilter": true,
    		"bSort": true,
    		"bInfo": false,
    		"bAutoWidth": false,
      		"bServerSide": true,
    		"sAjaxSource": "bug-ok-liste.php",
            "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                if (aData[8] == "0") {
                    $('td:eq(6)', nRow).addClass('bug_new');
                } else if (aData[8] == "1") {
                    $('td:eq(5)', nRow).addClass('bug_confirmed');
                    $('td:eq(6)', nRow).addClass('bug_confirmed');
                } else if (aData[8] == "2") {
                    $('td:eq(5)', nRow).addClass('bug_resolved');
                    $('td:eq(6)', nRow).addClass('bug_resolved');
                } else if (aData[8] == "3") {
                    $('td:eq(6)', nRow).addClass('bug_closed');
                } else if (aData[8] == "4") {
                    $('td:eq(5)', nRow).addClass('bug_concert');
                    $('td:eq(6)', nRow).addClass('bug_concert');
                } 
                return nRow;
            },
            "bProcessing": true,
            "oLanguage": { 
                "sProcessing":   "Traitement en cours...",
                "sLengthMenu":   "Afficher _MENU_ éléments",
                "sZeroRecords":  "Aucun élément à afficher",
                "sInfo": "Affichage de l'élément _START_ à _END_ sur _TOTAL_",
                "sInfoEmpty": "Affichage de l'élément 0 à 0 sur 0",
                "sInfoFiltered": "(filtré de _MAX_ éléments au total)",
                "sInfoPostFix":  "",
                "sSearch":       "Rechercher:",
                "sUrl":          "",
                "oPaginate": {
                    "sFirst":    "Premier",
                    "sPrevious": "Précédent",
                    "sNext":     "Suivant",
                    "sLast":     "Dernier"
                }
            }, 
            "aaSorting": [[0,'DESC']],                                          // id_bug
    		"aoColumns": [
    			{ "sWidth": "30px" },                                           // id_bug
    			{ "sClass": "center","sWidth": "70px","bSortable": true },      // Type
    			{ "sClass": "center","sWidth": "90px","bSortable": true },      // Date
    			null,                                                           // Auteur 
    			null,                                                           // Rubrique 
    			{ "sWidth": "400px" },                                          // Descr.
    			{ "sClass": "center","sWidth": "70px","bSortable": true },      // Statut TXT
        		null,                                                           // Comment
    			{ "bVisible": false },                                          // Statut
    			{ "sClass": "center","sWidth": "60px","bSortable": false }      // Actions
        ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
                { type: "text" },                                               // id_bug
                { type: "select", values: [{ value:'1',label:'Bug'},{ value:'2',label:'Remarque'},{ value:'3',label:'Demande'}]},// Type
                null,                                                           // Date
                null,                                                           // Auteur
                null,                                                           // Rubrique
                { type: "text" },                                               // Descr.
                { type: "select", values: [{ value:'0',label:'Nouveau'},{ value:'1',label:'En cours'},{ value:'2',label:'OK'},{ value:'3',label:'Terminé'},{ value:'4',label:'Concertation'}]},// Type
                { type: "text" },                                               // Comment
                null                                                            // Statut
			]
		});        
	} else {
		bug_ok_oTable.fnClearTable (false);
		bug_ok_oTable.fnDraw();
	}	

	$("#bug-ok-liste tbody").click(function(event) {
        $(bug_ok_oTable.fnSettings().aoData).each(function (){
			$(this.nTr).removeClass('row_selected');
		});
		$(event.target.parentNode).addClass('row_selected');
	});

    $('#bug-ok-liste').on("click",".bug-ok-edit", function ($e) {
        metaForm ("Modifier un bug",670,450,'#bug-ok-dialog',"bug-form.php","bug-submit.php",bug_ok_oTable,$(this).attr('id'));
        return (false);
	});

    $('#bug-ok-liste').on("click",".bug-ok-del", function ($e) {
        deleteFunc ("Supprimer un bug",'#bug-ok-dialog',bug_ok_oTable,"bug-del.php",$(this).attr('id'));  
	    return (false);
	});

//------------------------------------------------------------------------------ FORM / Validation

	$("#form2").validate({
		rules: {
			descr: {
				required: true,
                minlength: 2
			},
			id_rubrique: {
				required: true,
			},
			cat: {
				required: true,
			},
		},
		messages: {
			descr: { required: "",	minlength: ""},
			id_rubrique: {required: ""},
			cat: {required: ""}
		}
	});

//------------------------------------------------------------------------------ FORM (v2)

    function metaForm (titre,larg,haut,dialogId,formUrl,submitUrl,tableId,params) {
        if (submitUrl != "") {
        	$(dialogId).dialog({
                open: function ()
                {
                    originalContent = $(dialogId).html();
                    $(dialogId).load (formUrl+"?id="+params);
                },
                close : function(event, ui) {
                    $(dialogId).html(originalContent);
                },
                title: titre,
                modal: true,
                position:['middle',100],
        		width: larg,
        		height : haut,
            	resizable: false,
    			buttons: [
                    { text: "Annuler", click: function() {
            		      $(dialogId).dialog( "close" );
                    }},
                    { text: "Enregistrer", click: function() {
                        if ($("#form1").valid()) {
                            $("#form1",this).ajaxSubmit({
                                url: submitUrl,
                                type: "post",
                                data: { id: params},
                                clearForm: true,
                                error: function(){
                                    alert ("Erreur AJAX");
                                },
                                success: function(e) {
                                    $(dialogId).dialog().dialog('close');
                                    tableId.fnStandingRedraw();
                                }
                            });
                        }
                    }}
                ]
            });
        } else {                                                                // View
        	$(dialogId).dialog({
                open: function ()
                {
                    $(dialogId).load (formUrl+"?id="+params);
                },
                title: titre,
                modal: true,
                position:['middle',100],
        		width: larg,
        		height : haut,
            	resizable: false,
    			buttons: [
                    { text: "Fermer", click: function() {
            		      $(dialogId).dialog( "close" );
                    }}
                ]
            });
        }
    }

//------------------------------------------------------------------------------ Suppression (v2)

    function deleteFunc (titre,dialog,dataTable,delUrl,id) {
    	$(dialog).dialog({
            open: function ()
            {
                $(this).html("<br><center><b>Confirmer la suppression ?<b></center>");
            },         
            title: titre,
            modal: true,
            position:['middle',100],
        	width: 300,
    		height: 150,
        	resizable: false,
			buttons: {
        		"Annuler": function() {
        			$(this).dialog( "close" );
        		},
        		"Supprimer": function() {
                    $.ajax({
                        url: delUrl, 
                        type: "post",
                        data: "id="+id,
                        error: function() {
                            alert("deleteFunc > Erreur AJAX");
                        },
                        success: function(msg) {
                            dataTable.fnDraw();
//                            dataTable.fnStandingRedraw();
                        }
                    });
        			$(this).dialog( "close" );
            	}
        	}
        });
    }

});
