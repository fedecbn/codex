﻿$('#data-liste').on("click",".view", function ($e) {		
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

	$('#onglet0-liste').on("click",".view", function ($e) {		
        window.location.replace ('index.php?m=view&id='+$(this).attr('id'));				
        return (false);
	});

    $('#onglet0-liste').on("click",".edit", function ($e) {
        window.location.replace ('index.php?m=edit&id='+$(this).attr('id'));				
        return (false);
	});
	
    $('#onglet0-liste').on("click",".vocactrl", function ($e) {
        window.location.replace ('index.php?m=vocactrl&id='+$(this).attr('id'));				
        return (false);
	});

	$('#onglet1-liste').on("click",".view", function ($e) {		
        window.location.replace ('index.php?m=view&id='+$(this).attr('id'));				
        return (false);
	});

    $('#onglet1-liste').on("click",".edit", function ($e) {
        window.location.replace ('index.php?m=edit&id='+$(this).attr('id'));				
        return (false);
	});
	
    $('#onglet1-liste').on("click",".vocactrl", function ($e) {
        window.location.replace ('index.php?m=vocactrl&id='+$(this).attr('id'));				
        return (false);
	});


	$('#onglet2-liste').on("click",".view", function ($e) {		
        window.location.replace ('index.php?m=view&id='+$(this).attr('id'));				
        return (false);
	});

    $('#onglet2-liste').on("click",".edit", function ($e) {
        window.location.replace ('index.php?m=edit&id='+$(this).attr('id'));				
        return (false);
	});
	
    $('#onglet2-liste').on("click",".vocactrl", function ($e) {
        window.location.replace ('index.php?m=vocactrl&id='+$(this).attr('id'));				
        return (false);
	});

	$('#onglet3-liste').on("click",".view", function ($e) {		
        window.location.replace ('index.php?m=view&id='+$(this).attr('id'));				
        return (false);
	});

    $('#onglet3-liste').on("click",".edit", function ($e) {
        window.location.replace ('index.php?m=edit&id='+$(this).attr('id'));				
        return (false);
	});
	
    $('#onglet3-liste').on("click",".vocactrl", function ($e) {
        window.location.replace ('index.php?m=vocactrl&id='+$(this).attr('id'));				
        return (false);
	});

    $('#onglet0-liste').on("click",".fsd", function ($e) {
        window.location.replace ('index.php?m=fsd&id='+$(this).attr('id'));				
        return (false);
	});
    $('#onglet1-liste').on("click",".fsd", function ($e) {
        window.location.replace ('index.php?m=fsd&id='+$(this).attr('id'));				
        return (false);
	});
    $('#onglet2-liste').on("click",".fsd", function ($e) {
        window.location.replace ('index.php?m=fsd&id='+$(this).attr('id'));				
        return (false);
	});
    $('#onglet3-liste').on("click",".fsd", function ($e) {
        window.location.replace ('index.php?m=fsd&id='+$(this).attr('id'));				
        return (false);
	});

    $('#onglet0-liste').on("click",".eee_reg", function ($e) {
        window.location.replace ('index.php?m=eee_reg&id='+$(this).attr('id'));				
        return (false);
	});
    $('#onglet1-liste').on("click",".eee_reg", function ($e) {
        window.location.replace ('index.php?m=eee_reg&id='+$(this).attr('id'));				
        return (false);
	});
    $('#onglet2-liste').on("click",".eee_reg", function ($e) {
        window.location.replace ('index.php?m=eee_reg&id='+$(this).attr('id'));				
        return (false);
	});
    $('#onglet3-liste').on("click",".eee_reg", function ($e) {
        window.location.replace ('index.php?m=eee_reg&id='+$(this).attr('id'));				
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