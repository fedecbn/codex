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

function include(destination) {
var e=window.document.createElement('script');
e.setAttribute('src',destination);
window.document.body.appendChild(e);
}

function affMasqBtn(){
    var n = $("input:checked[name='id']").length;                               // Nombre de checkbox cochée
            console.log (n);
    if(n == 0) {
        $("#export-TXT-button").button('disable');
        $("#export-PDF-button").button('disable');
        $("#del-button").button('disable'); 
    } else {
        $("#export-TXT-button").button('enable');
        $("#export-PDF-button").button('enable');
        $("#del-button").button('enable'); 
    }
}

function OR_declin(a,b,c,d,e) {
    return ( a || b || c || d || e);
}

function AND_declin(a,b,c,d,e) {
    return ( a && b && c && d && e);
}

function OR_fluct (a,b,c,d) {
    return ( a || b || c || d );
}

function AND_fluct (a,b,c,d) {
    return ( a && b && c && d );
}


var prevSelectedElement = null;

$(document).ready(function(){

//------------------------------------------------------------------------------ UI / Tabs

    // var $tabs = $("#tabs").tabs();

    // if ( $("#mode").val() == 'liste') {
        // $tabs.tabs('disable',2);                                                // Fiche
    // } 
	// else if ( $("#mode").val() == 'maj') {
        // $tabs.tabs ('disable',0);                                               // LR                                                
        // $tabs.tabs ('disable',1);                                               // EVEE                                                	
        // $tabs.tabs ('disable',2);                                               // EVEE                                                	
	// }
	// else {
        // $tabs.tabs ("option","active",2);                                       // Fiche
        // $tabs.tabs ('disable',0);                                               // LR                                                
        // $tabs.tabs ('disable',1);                                               // EVEE                                                
    // }

//------------------------------------------------------------------------------ UI / Boutons

    $( "#home-button" )
        .button({
            text: false
        })
        .click(function() {
            window.location.replace ('../home/index.php');
		});

        
	$( "#add-button" )
        .button({
            text: true
        })
        .click(function() {
            window.location.replace ('index.php?m=add');
		});

	$( "#to-refnat" )
        .button({
            text: true
        })
        .click(function() {
            window.location.replace ('../refnat/index.php');
		});

		
	$( "#export-TXT-button" )
        .button({
            text: true
        })
        .click(function() {
            var sData = oTable.$('input').serialize();
            if (sData != "") {
                exportFunc ("Exporter des fiches (TXT)","#dialog",'../commun/export_TXT.php',$("#export-TXT-fichier").val(),$("#export-TXT-query").val(),$("#export-TXT-query-id").val(),sData);
            }
            return (false);
		});

    $( "#del-button" )
        .button({
            tabIndex : -1,
            text: true
        })
        .click(function() {
            var sData = oTable.$('input').serialize();
            deleteFunc ("Supprimer des fiches",'#dialog',oTable,"del.php","",sData,"");
		});

    $( "#maj-from-taxa-button" )
        .button({
            text: true
        })
        .click(function() {
            window.location.replace ('index.php?m=maj');
		});

//------------------------------------------------------------------------------ BOUTONS / Exports PDF

    $( "#export-PDF-button" )
        .button({
            disabled: false,
            text: true
        })
        .click(function() {
            var sData = oTable.$('input').serialize();
            if (sData != "") {
                exportFunc ("Export PDF","#dialog",sData,'../commun/export_PDF.php',$("#export-PDF-fichier").val(),0);
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

//------------------------------------------------------------------------------ LISTES / Taxons (Ldata)
	include("js/data.js")        
	include("js/function.js")

    $('#data-liste').on("click",".view", function ($e) {		
        window.location.replace ('index.php?m=view&id='+$(this).attr('id'));				
        return (false);
	});

    $('#data-liste').on("click",".edit", function ($e) {
        window.location.replace ('index.php?m=edit&id='+$(this).attr('id'));				
        return (false);
	});
	
    $('#data-liste').on("click",".vocactrl", function ($e) {
        window.location.replace ('index.php?m=vocactrl&id='+$(this).attr('id'));				
        return (false);
	});

//------------------------------------------------------------------------------ CHECKBOX

    affMasqBtn ();

    $('.liste-all').click(function () {
        console.log ('liste-all');
        $('.liste-one').not(this).attr('checked', this.checked);
        affMasqBtn();
    });

    $('#data-liste').on("click",".liste-one", function ($e) {
        console.log ('liste-one');
        affMasqBtn();
	});

} else {

	include("js/function.js")


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
                    url: 'submit.php',
                    type: "post",
                    clearForm: true,                                 

                    // beforeSubmit:function(formData, jqForm, options){
                        // var queryString = $.param(formData); 
                        // alert ('submit: \n\n' + queryString); 
                    // },

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
								location.reload();
							},
                    		"Liste des taxons": function() {
                                $(this).dialog("close");
                                window.location.replace ('index.php');
								// window.close()
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
                    url: 'submit.php',
                    type: "post",
                    clearForm: false,                                 

                    // beforeSubmit:function(formData, jqForm, options){
                        // var queryString = $.param(formData); 
                        // alert ('submit: \n\n' + queryString); 
                    // },

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
								location.reload();
                                $(this).dialog("close");
                    	   },
                    		"Liste des taxons": function() {
                                $(this).dialog("close");
                                window.location.replace ('index.php');
								// window.close()
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

    $("#nom_complet_taxref").autocomplete({
        source: "../commun/JSDN_taxon.php",
        minLength:6,
        select: function(event, ui) {
        	$("#nom_complet_taxref").val(ui.item.value);
            $('#CD_REF').val(ui.item.CD_REF);
        	$("#taxon_atlas").val(ui.item.nom_rec);
            $('#famille').val(ui.item.FAMILLE);
            $('#NOM_VERN').val(ui.item.NOM_VERN);
        }
	});

    $("#nom_complet_taxref").change(function() {                                // Efface CD_REF & famille si le nom est effacé
        if ( $("#nom_complet_taxref").val() == "") {
            $("#CD_REF").val("");
            $("#taxon_atlas").val("");
            $("#famille").val("");
            $("#NOM_VERN").val("");
        }
    });

//------------------------------------------------------------------------------ buttonset

    // $( "#radio1,#radio2,#radio3,#radio4" ).buttonset( );

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

//------------------------------------------------------------------------------ FORM / Plages


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
