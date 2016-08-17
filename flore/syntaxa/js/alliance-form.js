//------------------------------------------------------------------------------//
//  module_gestion/js/alliance-form.js                                          //                                             
//                                                                              //
//  SILENE-Flore                                                                //
//  Module extrene : Typologie des habitats naturels du PNM                     //
//                                                                              //
//  Version 1.00  22/12/14 - OlGa                                               //
//  Version 1.01  03/02/15 - Corr bug sur ALTI                                  //
//  Version 1.02  19/13/15 - MaJ de taxon_add                                   //
//------------------------------------------------------------------------------//

$(document).ready(function() {


    $("#taxon2").autocomplete({
        source: function( request, response )
        {                     
            $.ajax(
            {
                url: "../commun/JSDN_taxon_rec.php",
                data: {
                    sql: $("#taxref_flore_sql").val(),    
                    term: request.term
                },       
                type: "POST",
                dataType: "json",
                success: function (data)
                {
                    response( $.map( data, function( item )
                    {
                        return{
                            label: item.NOM_COMPLET,
                            value: item.value,
                            CD_REF: item.CD_REF
                        }
                    }));
                }
            });               
        },
        minLength:6,
        select: function(event, ui){
            $('#taxon2_CD_REF').val(ui.item.CD_REF);
        }
	});
    $("#taxon2").change(function() {
        if ($("#taxon2").val() == ""){
            $("#taxon2_CD_REF").val("");
        }
    });

    $("#taxon3").autocomplete({
        source: function( request, response )
        {                     
            $.ajax(
            {
                url: "../commun/JSDN_taxon_rec.php",
                data: {
                    sql: $("#taxref_bryo_sql").val(),    
                    term: request.term
                },       
                type: "POST",
                dataType: "json",
                success: function (data)
                {
                    response( $.map( data, function( item )
                    {
                        return{
                            label: item.NOM_COMPLET,
                            value: item.value,
                            CD_REF: item.CD_REF
                        }
                    }));
                }
            });               
        },
        minLength:6,
        select: function(event, ui){
            $('#taxon3_CD_REF').val(ui.item.CD_REF);
        }
	});
    $("#taxon3").change(function() {
        if ($("#taxon3").val() == ""){
            $("#taxon3_CD_REF").val("");
        }
    });

    $("#taxon4").autocomplete({
        source: function( request, response )
        {                     
            $.ajax(
            {
                url: "../commun/JSDN_taxon_rec.php",
                data: {
                    sql: $("#taxref_flore_sql").val(),    
                    term: request.term
                },       
                type: "POST",
                dataType: "json",
                success: function (data)
                {
                    response( $.map( data, function( item )
                    {
                        return{
                            label: item.NOM_COMPLET,
                            value: item.value,
                            CD_REF: item.CD_REF
                        }
                    }));
                }
            });               
        },
        minLength:6,
        select: function(event, ui){
            $('#taxon4_CD_REF').val(ui.item.CD_REF);
        }
	});
    $("#taxon4").change(function() {
        if ($("#taxon4").val() == ""){
            $("#taxon4_CD_REF").val("");
        }
    });
    $("#taxon5").autocomplete({
        source: function( request, response )
        {                     
            $.ajax(
            {
                url: "../commun/JSDN_taxon_rec.php",
                data: {
                    sql: $("#taxref_flore_sql").val(),    
                    term: request.term
                },       
                type: "POST",
                dataType: "json",
                success: function (data)
                {
                    response( $.map( data, function( item )
                    {
                        return{
                            label: item.NOM_COMPLET,
                            value: item.value,
                            CD_REF: item.CD_REF
                        }
                    }));
                }
            });               
        },
        minLength:6,
        select: function(event, ui){
            $('#taxon5_CD_REF').val(ui.item.CD_REF);
        }
	});
    $("#taxon5").change(function() {
        if ($("#taxon5").val() == ""){
            $("#taxon5_CD_REF").val("");
        }
    });
	
});

//------------------------------------------------------------------------------ FORM / Validate

function taxon_list(FICHE_TYPE){
    var idsyntaxon = $("#idsyntaxon").val();                           
    console.log('taxon_list FICHE_TYPE='+FICHE_TYPE);
    if (idsyntaxon != "") 
    {
    	var url = 'FICHE_TYPE='+FICHE_TYPE+'&idsyntaxon='+escape(idsyntaxon);             
    	$.ajax({
			type: "POST",
	       	url: "../commun/taxon_process.php",
		    cache: false,
			data: url,
            error: function() {
                alert("taxon_list > Erreur AJAX");
                return (false);
            },
		    success: function(html){
    			$("#taxon_list_"+FICHE_TYPE).html(html);
		    }
	    });
    }
    return (false);
}




function taxon_add(FICHE_TYPE){
    var idsyntaxon = $("#idsyntaxon").val();                           
    var taxon = $("#taxon"+FICHE_TYPE).val();                           
    var CD_REF = $("#taxon"+FICHE_TYPE+"_CD_REF").val();                           
    var COMM = $("#COMM").val();                           

    console.log('taxon_add FICHE_TYPE='+FICHE_TYPE);
    if (idsyntaxon != "" & taxon != "" & CD_REF != "") 
    {
    	var url = 'submit=1&taxon='+escape(taxon)+'&CD_REF='+escape(CD_REF)+'&FICHE_TYPE='+FICHE_TYPE+'&idsyntaxon='+escape(idsyntaxon)+'&COMM='+escape(COMM);              
		$.ajax({
			type: "POST",
            url: "../commun/taxon_process.php",
			data: url,
            error: function() {
                alert ("taxon_add > Erreur AJAX");
                return false;
            },
			success: function(e){
				$("#taxon"+FICHE_TYPE).val('');
				$("#taxon"+FICHE_TYPE+"_CD_REF").val('');
				$("#COMM").val('');
				taxon_list(FICHE_TYPE);
			}
		});
    }
	return (false);                                                
}
