/*******************************************************************************/
//  home/home.js                                                                //
//                                                                              //
//  Banque de semences VANDA                                                    //
//                                                                              //
//  Version 1.00  13/07/12 - DariaNet                                           //
//  Version 1.10  04/08/12 - Aj logout-button                                   //
//  Version 1.11  05/08/12 - MaJ boutons                                        //
//  Version 1.20  24/11/12 - MaJ paths                                          //
//  Version 1.21  29/04/14 - MaJ pour multi-langues                             //
/*******************************************************************************/

$(document).ready(function(){

//------------------------------------------------------------------------------ Lang Switcher
/*
    install_switch(
            $("#lang-button"),
            $("body"),
            $("#templates a")
    );
*/

$('*[lang|="it"]').hide();

$("#lang_fr").click(function (event) {
//alert ('fr');
    event.preventDefault();
    $('h1[lang|="it"]').hide();
    $('h1[lang|="fr"]').show();

    $('div[lang|="it"]').hide();
    $('div[lang|="fr"]').show();
    $.cookie("lang_select","fr", {
       expires : 10,
       path    : '/',
       secure  : false
    });
});

$("#lang_it").click(function (event) {
//alert ('it');
    event.preventDefault();
    $('h1[lang|="fr"]').hide();
    $('h1[lang|="it"]').show();

    $('div[lang|="fr"]').hide();
    $('div[lang|="it"]').show();
    $.cookie("lang_select","it", {
       expires : 10,
       path    : '/',
       secure  : false
    });
});

//------------------------------------------------------------------------------ UI / Boutons / Bar de titre
    
	$( "a.download").button({text: true});

    $("#home-button")
        .button({
            text: true
        })                
        .click(function() {
              window.location.replace ('index.php');
		});
		
    $("#notice-button")
        .button({
            text: true
        })                
        .click(function() {
              window.location.replace ('index.php?action=3_notice');				
		});
/*
    $( "#rem-button" )
        .button({
            text: true
        })                
        .click(function() {
              window.location.replace ('../commun/main.php?action=4_rem');				
		});
*/
    $("#contact-button")
        .button({
            text: true
        })                
        .click(function() {
              window.location.replace ('index.php?action=4_contacts');
		});

    $("#admin-button")
        .button({
            text: true
        })                
        .click(function() {
              window.location.replace ('../module_admin/index.php');
		});
    
    $("#logout-button")
        .button({
            text: true
        })                
        .click(function() {
              window.location.replace ('logout.php');
		});
		
//------------------------------------------------------------------------------ UI / Boutons / Login

	$("#valider_fr,#valider_it")
        .button({
            text: true
        });	
		
	
	$("#envoi-mdp")
        .button({
            text: true
        });

	$("#accueil")
        .button({
            text: true
        });

	$("#retour")
        .button({
            icons: {
                primary: "ui-icon-arrowthick-1-w"
            },
            text: true
        })
        .click(function() {
            history.go(-1);
		});

//------------------------------------------------------------------------------ UI / Boutons / Recherche

	$("#ok-button")
        .button({
            icons: {
                primary: "ui-icon-check"
            },
            text: true
        })
        .click(function() {
            $("#ok-button").hide();
            showWaiting();
		});
    $("#ok-button").hide();
    $("#waiting").hide();

//------------------------------------------------------------------------------ VALID

	$("#form1").validate({
		rules: {
			user_login: {
				required: true,
				minlength: 2
			},
			user_pw: {
				required: true,
				minlength: 3
			},
		},
		messages: {
			user_login: {
				required: "",
				minlength: ""
			},
			user_pw: {
				required: "",
				minlength: ""
			}
		}
	});

//------------------------------------------------------------------------------ Waiting bar

    hideWaiting();

    function showWaiting() {
      $("#waiting").show();
    }

    function hideWaiting() {
      $("#waiting").hide();
    }

//------------------------------------------------------------------------------ FORM / Contenu

    function contentForm (titre,contentUrl,params) {
    	$('#content-dialog').dialog({
            open: function ()
            {
                $(this).load (contentUrl+"?id="+params);
            },         
            title: titre,
            modal: true,
    		width: 950,
    		height : 550,
        	resizable: false,
			buttons: {
        		"Annuler": function() {
        			$(this).dialog( "close" );
        		},
        		"Enregistrer": function() {
                    if ($("#saf-add").valid()) {
                        $("form",this).ajaxSubmit({
                            url: "content-submit.php",
                            type: "post",
                            data: { id: params},
                            clearForm: true,                                 
                            error: function(){
                                alert("Erreur AJAX");
                            },
                            success: function(e) {
                                content_oTable.fnDraw();
                            }   
                        });
                        $(this).dialog("close");
                    }
            	}
        	}
        });
    }
	

//------------------------------------------------------------------------------ INT Page

    $("#init_page").hide();
    $("#main_page").show();

//------------------------------------------------------------------------------ Troggle panels

//------------------------------------------------------------------------------ Autocomplete

//------------------------------------------------------------------------------ Validation

});
