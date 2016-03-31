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
		
$( "#enregistrer1-syntaxon-add-button,#enregistrer2-syntaxon-add-button" )
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
                    		"Liste des syntaxons": function() {
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
