//*******************************************************************************/
//*******************************************************************************/
//   module_gestion/js/gestion.js                                               //
//                                                                              //
//  Application WEB 'EVAL'                                                      //
//  Outil d’aide à l’évaluation de la flore                                     //
//                                                                              //
//  Version 1.00  10/08/14 - DariaNet                                           //
//  Version 1.01  12/08/14 - MaJ fonctions pgSQL                                //
//  Version 1.02  21/08/14 - MaJ droits                                         //
//  Version 1.03  22/08/14 - MaJ lsi-liste                                       //
//  Version 1.10  31/08/14 - Aj buttonset                                       //
//  Version 1.11  01/09/14 - MaJ lsi-liste                                       //
//  Version 1.12  02/08/14 - MaJ form v2                                        //
//  Version 1.13  04/09/14 - Aj plages                                          //
//  Version 1.14  08/09/14 - MaJ lsi-liste                                       //
//  Version 1.15  14/09/14 - MaJ lsi-liste                                       //
//  Version 1.16  14/09/14 - MaJ champs auto                                    //
//  Version 1.17  23/09/14 - MaJ lsi-liste                                       //
//  Version 1.18  24/09/14 - MaJ lsi-liste (coul UICN)                           //
/*******************************************************************************/

function lsi_affMasqBtn(){
    var n = $("input:checked[name='id']").length;                               // Nombre de checkbox cochée
            console.log (n);
    if(n == 0) {
        $("#lsi-export-TXT-button").button('disable');
        $("#lsi-export-PDF-button").button('disable');
        $("#lsi-del-button").button('disable'); 
    } else {
        $("#lsi-export-TXT-button").button('enable');
        $("#lsi-export-PDF-button").button('enable');
        $("#lsi-del-button").button('enable'); 
    }
}

function XOR (a,b,c) {
    return ( a || b || c) && !( a && b && c );
}


var prevSelectedElement = null;

$(document).ready(function(){

//------------------------------------------------------------------------------ UI / Tabs

    var $tabs = $("#tabs").tabs();

    if ( $("#mode").val() == 'liste') {
        $tabs.tabs('disable',2);                                                // Fiche
    } else {
        $tabs.tabs ("option","active",2);                                       // Fiche
        $tabs.tabs ('disable',0);                                               // lsi                                                
        $tabs.tabs ('disable',1);                                               // EVEE                                                
    }

//------------------------------------------------------------------------------ UI / Boutons

    $( "#home-button" )
        .button({
            text: false
        })
        .click(function() {
            window.location.replace ('../home/index.php');
		});
        
	$( "#lsi-add-button" )
        .button({
            text: true
        })
        .click(function() {
            window.location.replace ('index.php?m=add');
		});


	$( "#lsi-export-TXT-button" )
        .button({
            text: true
        })
        .click(function() {
            var sData = lsi_oTable.$('input').serialize();
            if (sData != "") {
                exportFunc ("Exporter des fiches (TXT)","#lsi-dialog",'../commun/export_TXT.php',$("#lsi-export-TXT-fichier").val(),$("#lsi-export-TXT-query").val(),$("#lsi-export-TXT-query-id").val(),sData);
            }
            return (false);
		});

    $( "#lsi-del-button" )
        .button({
            tabIndex : -1,
            text: true
        })
        .click(function() {
            var sData = lsi_oTable.$('input').serialize();
            deleteFunc ("Supprimer des fiches",'#lsi-dialog',lsi_oTable,"lsi-del.php","",sData,"");
		});

//------------------------------------------------------------------------------ BOUTONS / Exports PDF

    $( "#lsi-export-PDF-button" )
        .button({
            disabled: false,
            text: true
        })
        .click(function() {
            var sData = lsi_oTable.$('input').serialize();
            if (sData != "") {
                exportFunc ("Export PDF","#lsi-dialog",sData,'../commun/export_PDF.php',$("#lsi-export-PDF-fichier").val(),0);
            }
            return (false);
		});


//------------------------------------------------------------------------------ UI / tooltip

    $(function () {
        $(document).tooltip({
            content: function () {
                return $(this).prop('title');
            }
        });
    });

//------------------------------------------------------------------------------ prettyCheckable
/*
for (var i = inputList.length - 1; i >= 0; i--) {
    $(inputList[i]).prettyCheckable();
}

  $('input.check').prettyCheckable({
    color: 'red'
  });
*/
/*
$('.test input').iCheck({
  handle: 'checkbox'
});
  */
  
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

if ( $("#mode").val() == 'liste') {

//------------------------------------------------------------------------------ LISTES / Taxons

    if (typeof lsi_oTable == 'undefined') {
        var lsi_oTable = $('#lsi-liste').dataTable({
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
    	"sAjaxSource": "lsi-liste.php",
        "bStateSave": true,
		"fnStateSave": function (oSettings, oData) {
            localStorage.setItem( 'data_'+window.location.pathname, JSON.stringify(oData) );
			},
        "fnStateLoad": function (oSettings) {
            return JSON.parse( localStorage.getItem('data_'+window.location.pathname) );
			}, 
        "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            switch (aData[1])                                                  // Cat A
            {
                case "Les actus du réseau" : 
                    $('td:eq(1)', nRow).addClass('SUJET_1');
                break;
                case "Des technologies, logiciels et matériels" : 
                    $('td:eq(1)', nRow).addClass('SUJET_2');
                break;
                case "Des coups de pouce" : 
                    $('td:eq(1)', nRow).addClass('SUJET_3');
                break;
                case "Des données et des cartes" : 
                    $('td:eq(1)', nRow).addClass('SUJET_4');
                break;
                case "Des évènements et formations" : 
                    $('td:eq(1)', nRow).addClass('SUJET_5');
                break;
            }return nRow;
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
			"sDom": '<"top"fl>rt<"bottom"ip>',
            "aoColumns": [
                { "sWidth": "50px" },                                         // id
                { "sClass": "sujet", "sWidth": "120px" },                                        // sujet
                { "sWidth": "300px" },                                        // title
                { "sWidth": "500px" },                                        // Extrait
                { "sWidth": "120px" },                                        // tag
				{  
				"mRender": function ( data, display, full, meta ) {return '<a target="_blank" href="'+data+'">'+data.substr(0,30)+'...</a>';},
				"sWidth": "10px"
				},                                        				// link
				{  
				"mRender": function ( data, display, full, meta ) {return '<a target="_blank" href="'+data+'">'+data.substr(0,30)+'...</a>';},
				"sWidth": "10px"
				},                                        				// link_2
                { "sWidth": "100px" },                                        // date
    			{ "sClass": "center","sWidth": "50px","bSortable": false },     // Actions
        		{ "sClass": "center","sWidth": "20px","bSortable": false }      // Sélect.
        ]
        }).columnFilter({
            sPlaceHolder: "head:after",
            aoColumns: [ 
                { type: "text" },                                               // Famille
                { type: "text" },                                               // CD_REF
                { type: "text" },                                               // Nom scientifique 
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "text" },                                               //  
                { type: "text" }                                              //
			]
		});   
	} else {
		lsi_oTable.fnClearTable (false);
		lsi_oTable.fnDraw ();
	}	

    $('#lsi-liste').on("click",".lsi-view", function ($e) {
        window.location.replace ('index.php?m=view&id='+$(this).attr('id'));				
        return (false);
	});

    $('#lsi-liste').on("click",".lsi-edit", function ($e) {
        window.location.replace ('index.php?m=edit&id='+$(this).attr('id'));				
        return (false);
	});

//------------------------------------------------------------------------------ CHECKBOX

    lsi_affMasqBtn ();

    $('.lsi-liste-all').click(function () {
        console.log ('lsi-liste-all');
        $('.lsi-liste-one').not(this).attr('checked', this.checked);
        lsi_affMasqBtn();
    });

    $('#lsi-liste').on("click",".lsi-liste-one", function ($e) {
        console.log ('lsi-liste-one');
        lsi_affMasqBtn();
	});

} else {
//------------------------------------------------------------------------------ FORM
//------------------------------------------------------------------------------ FORM
//------------------------------------------------------------------------------ FORM
//------------------------------------------------------------------------------ FORM

//------------------------------------------------------------------------------ FORM / Submit

	$( "#enregistrer1-add-button,#enregistrer2-add-button" )
        .button({
            text: true
        })
        .click(function() {
            if ($("#form1").valid()) {
                $("#form1").ajaxSubmit({
                    url: 'lsi-submit.php',
                    type: "post",
                    clearForm: true,                                 
/*
                    beforeSubmit:function(formData, jqForm, options){
                        var queryString = $.param(formData); 
                        alert ('submit: \n\n' + queryString); 
                    },
*/
                    error: function(){
                        alert ("Erreur AJAX");
                    },
                    success: function(e) {
		            $("#enregistrer-dialog").dialog({
                        title: 'Enregistrement',
                        modal: true,
                        position:['middle',150],
                		width: 400,
                		height : 270,
                    	resizable: false,
			            buttons: {
                    		"Nouvelle fiche": function() {
                                $(this).dialog("close");
                    	   },
                    		"Retour aux news": function() {
                                $(this).dialog("close");
                                window.location.replace ('index.php');
                    	   }
                        }
                    });
                    }
                });
            }
            return (false);
		});

	$( "#enregistrer1-edit-button,#enregistrer2-edit-button" )
        .button({
            text: true
        })
        .click(function() {
            if ($("#form1").valid()) {
                $("#form1").ajaxSubmit({
                    url: 'lsi-submit.php',
                    type: "post",
                    clearForm: false,                                 
/*
                    beforeSubmit:function(formData, jqForm, options){
                        var queryString = $.param(formData); 
                        alert ('submit: \n\n' + queryString); 
                    },
*/
                    error: function(){
                        alert ("Erreur AJAX");
                    },
                    success: function(e) {
		            $("#enregistrer-dialog").dialog({
                        title: 'Enregistrement',
                        modal: true,
                        position:['middle',150],
                		width: 400,
                		height : 270,
                    	resizable: false,
			            buttons: {
                    		"Retour à la fiche": function() {
                                $(this).dialog("close");
                    	   },
                    		"Retour au news": function() {
                                $(this).dialog("close");
                                window.location.replace ('index.php');
                    	   }
                        }
                    });
                    }
                });
            }
            return (false);
		});

	$( "#retour1-button,#retour2-button" )
        .button({
            text: true
        })
        .click(function() {
            $( "#exit-confirm" ).dialog( "open" );
            return (false);
		});


	$( "#retour3-button,#retour4-button" )
        .button({
            text: true
        })
        .click(function() {
            window.location.replace ('index.php');
            return (false);
		});

//------------------------------------------------------------------------------ FORM / Taxon


//------------------------------------------------------------------------------ buttonset

    $( "#radio1,#radio2,#radio3,#radio4" ).buttonset(  );

//------------------------------------------------------------------------------ icheck

    $('.skin-square input').iCheck({
        checkboxClass: 'icheckbox_square-aero',
        radioClass: 'iradio_square-grey',
        increaseArea: '20%'
    });

//------------------------------------------------------------------------------ Editeur wysiwyg

    $(".editor").jqte({
        linktypes: ["URL site WEB", "Adresse email", "Image"]
    });


//------------------------------------------------------------------------------ DIALOG

	$( "#exit-confirm" ).dialog({
		modal: true,
        position:['middle',200],
        width: 500,
        height: 160,
    	autoOpen: false,
		resizable: false,
		buttons: {
			"Non": function() {
				$( this ).dialog( "close" );
			},
			"Oui": function() {
				$( this ).dialog( "close" );
                window.location.replace ('index.php');
            }
		}
    });

	$( "#enregistrer-dialog" ).hide();

}

//------------------------------------------------------------------------------ Suppression (v3)

    function deleteFunc (titre,dialog,dataTable,delUrl,id,sData,mode) {
    	$(dialog).dialog({
            open: function ()
            {
                if (id != '' )
                    $(this).html("<br><center>ID = "+id+"<br><b>Confirmer la suppression ?<b></center>");
                else
                    $(this).html("<br><center><b>Confirmer la suppression ?<b></center>");
            },         
            title: titre,
            modal: true,
            position:['middle',200],
        	width: 300,
    		height: 160,
        	resizable: false,
			buttons: {
        		"Annuler": function() {
        			$(this).dialog( "close" );
        		},
        		"Supprimer": function() {
                    $.ajax({
                        url: delUrl, 
                        type: "post",
                        data: {
                            select : sData,    
                            id: id,    
                            m: mode    
                        },       
                        error: function() {
                            alert("deleteFunc > Erreur AJAX");
                        },
                        success: function(msg) {
                            if (dataTable != '' ) dataTable.fnDraw();
                        }
                    });
        			$(this).dialog( "close" );
            	}
        	}
        });
    }

//------------------------------------------------------------------------------ Exports

    function exportFunc (titre,dialogId,exportUrl,fichier,query,queryid,sData) {
        $(this).ajaxSubmit({
            url: exportUrl,
            type: "post",
            data: {
                f : fichier,
                q : query,
                i : queryid,
                select : sData
            },
            error: function(e){
                alert ("Erreur AJAX");
            },
            success: function(e) {
                $(dialogId).dialog({
                    open: function ()
                    {
                        $(this).load ("../commun/export_statut.php"+"?f="+fichier);
                    },
                    close : function(event, ui) {
                        $(this).html("");
                    },
                    title: titre,
                    modal: true,
                    position:['middle',200],
                    width: 500,
                    height: 410,
                    resizable: false,
                    buttons: {
                        "Fermer": function() {
                            $(this).dialog( "close" );
                        }
                    }
                });
            }
        });
    }
});
