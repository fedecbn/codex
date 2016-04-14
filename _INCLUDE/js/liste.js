
	$('#data-liste,#onglet0-liste,#onglet1-liste,#onglet2-liste,#onglet3-liste,#lsi-liste').on("click",".view", function ($e) {		
        window.location.replace ('index.php?m=view&id='+$(this).attr('id'));				
        return (false);
	});

    $("#data-liste,#onglet0-liste,#onglet1-liste,#onglet2-liste,#onglet3-liste,#lsi-liste").on("click",".edit", function ($e) {
        window.location.replace ('index.php?m=edit&id='+$(this).attr('id'));				
        return (false);
	});

	
    $('#data-liste,#onglet0-liste,#onglet1-liste,#onglet2-liste,#onglet3-liste').on("click",".vocactrl", function ($e) {
        window.location.replace ('index.php?m=vocactrl&id='+$(this).attr('id'));				
        return (false);
	});

    $('#data-liste,#onglet0-liste,#onglet1-liste,#onglet2-liste,#onglet3-liste').on("click",".fsd", function ($e) {
        window.location.replace ('index.php?m=fsd&id='+$(this).attr('id'));				
        return (false);
	});

    $('#data-liste,#onglet0-liste,#onglet1-liste,#onglet2-liste,#onglet3-liste').on("click",".eee_reg", function ($e) {
        window.location.replace ('index.php?m=eee_reg&id='+$(this).attr('id'));				
        return (false);
	});

    $('#data-liste,#onglet0-liste,#onglet1-liste,#onglet2-liste,#onglet3-liste').on("click",".valid", function ($e) {
		validateFunc("id[]="+$(this).attr('value'),$(this).attr('class'));
		document.getElementById("validation_"+$(this).attr('value')).style.display = "";
		document.getElementById("invalidation_"+$(this).attr('value')).style.display = "none";
		document.getElementById("valid_"+$(this).attr('value')).src = "../../_GRAPH/mini/no_validate.png";
		document.getElementById("invalid_"+$(this).attr('value')).src = "../../_GRAPH/mini/invalidate.png";
		document.getElementById("invalida_"+$(this).attr('value')).className = "invalid";
		$(this).removeClass("valid");
        return (false);
	});

    $('#data-liste,#onglet0-liste,#onglet1-liste,#onglet2-liste,#onglet3-liste').on("click",".invalid", function ($e) {
		invalidateForm ("Invalider des evaluations",500,300,'#dialog',"form.php","submit.php","id[]="+$(this).attr('value'),'invalid');
		// document.getElementById("validation_"+$(this).attr('value')).style.display = "none";
		// document.getElementById("invalidation_"+$(this).attr('value')).style.display = "";
		// document.getElementById("valid_"+$(this).attr('value')).src = "../../_GRAPH/mini/validate.png";
		// document.getElementById("invalid_"+$(this).attr('value')).src = "../../_GRAPH/mini/no_invalidate.png";
		// document.getElementById("valida_"+$(this).attr('value')).className = "valid";
		// $(this).removeClass("invalid");		
        return (false);
	});


	/*A supprimer à terme*/
    $('#lsi-liste').on("click",".lsi-view", function ($e) {
        window.location.replace ('index.php?m=view&id='+$(this).attr('id'));				
        return (false);
	});

//------------------------------------------------------------------------------ CHECKBOX


    $('.lsi-liste-all').click(function () {
        console.log ('lsi-liste-all');
        $('.lsi-liste-one').not(this).attr('checked', this.checked);
        lsi_affMasqBtn();
    });

    $('#lsi-liste').on("click",".lsi-liste-one", function ($e) {
        console.log ('lsi-liste-one');
        lsi_affMasqBtn();
	});
	
//------------------------------------------------------------------------------ CHECKBOX

    // affMasqBtn ();

    $('.liste-all').click(function () {
        console.log ('liste-all');
        $('.liste-one').not(this).attr('checked', this.checked);
        affMasqBtn();
    });

    $('#data-liste').on("click",".liste-one", function ($e) {
        console.log ('liste-one');
        affMasqBtn();
	});

    $('#onglet0-liste').on("click",".liste-one", function ($e) {
        console.log ('liste-one');
        affMasqBtn();
	});

    $('#onglet1-liste').on("click",".liste-one", function ($e) {
        console.log ('liste-one');
        affMasqBtn();
	});

    $('#onglet2-liste').on("click",".liste-one", function ($e) {
        console.log ('liste-one');
        affMasqBtn();
	});

    $('#onglet3-liste').on("click",".liste-one", function ($e) {
        console.log ('liste-one');
        affMasqBtn();
	});