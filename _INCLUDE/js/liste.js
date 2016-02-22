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

	/*A supprimer à terme*/
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