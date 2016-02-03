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

	$( "#import_button" )
        .button({text: true})
        .click(function() {
			metaForm ("Importer des données",670,500,'#import-dialog',"form.php","submit.php",$(this).attr('name'),$(this).attr('value'),"Importer");
			return (false);
		});
		
	$( "#export_button" )
        .button({text: true})
        .click(function() {
			metaForm ("Exporter des données",670,500,'#export-dialog',"form.php","submit.php",$(this).attr('name'),$(this).attr('value'),"Exporter");
			return (false);
		});
		
	$( "#bilan_button" )
        .button({text: true})
        .click(function() {
			metaForm ("Bilan sur les données",670,500,'#bilan-dialog',"form.php","submit.php",$(this).attr('name'),$(this).attr('value'),"Lancer le bilan");
			return (false);
		});
					
    function metaForm (titre,larg,haut,dialogId,formUrl,submitUrl,params,params2,name) {
        if (submitUrl != "") {
        	$(dialogId).dialog({
                open: function ()
                {
                    originalContent = $(dialogId).html();
                    $(dialogId).load (formUrl+"?id="+params+"&m="+params2);
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
                    { text: name, click: function() {
                        if ($("#form1").valid()) {
							document.getElementById('chargement').style.display = "";
                            $("#form1",this).ajaxSubmit({
                                url: submitUrl,
                                type: "post",
                                data: { id: params, m:params2},
                                clearForm: true,
                                error: function(){
                                    alert ("Erreur AJAX");
                                },
                                success: function(e) {
                                    $(dialogId).dialog().dialog('close');
									window.location.reload();
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
                    $(dialogId).load (formUrl+"?id="+params+"&id_user="+params2);
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
    };

