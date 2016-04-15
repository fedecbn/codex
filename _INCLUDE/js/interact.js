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

var prevSelectedElement = null;

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

$( "#validate-button" ).button({text: true})
	.click(function() {
		var sData = oTable.$('input').serialize();
		if (sData != "") {
			validateFunc(sData,'valid');
			$("#dialog").dialog({
				open: function () {$(this).html("<br><center><b>Evaluations validées<b></center>")},         
				title: "Validation",
				modal: true,
				position:['middle',200],
				width: 300,
				height: 160,
				resizable: false,
				buttons: {
					"OK": function() {
						$(this).dialog( "close" );
						window.location.replace ('index.php');
					}
				}
			});
		}
		return (false);
	});

	$( "#invalidate-button" ).button({text: true})
	.click(function() {
		var sData = oTable.$('input').serialize();
		invalidateForm ("Invalider des evaluations",500,300,'#dialog',"form.php","submit.php",sData,'invalid');
		return (false);
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

