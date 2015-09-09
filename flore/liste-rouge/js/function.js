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

//------------------------------------------------------------------------------ FORM / Plages
// function enable_champ() {
// var hybride_oui=$("input[id=hybride1]:checked").val();	
// var indi=$("#id_indi").val();					
// var tbl_eval = ["cat_a","just_a","cat_a1","crit_a1","cat_a234","crit_a2","crit_a3","crit_a4","cat_b","just_b","cat_c","just_c","cat_c1","crit_c1","cat_c2","crit_c2","cat_d","just_d","cat_d1","crit_d1","cat_d2","crit_d2","cat_e","just_e","cat_ini","just_ini","cat_fin","just_fin","cd_ajustmt","id_raison_ajust"];
// if (hybride_oui == 'TRUE' || indi == 'E')	{		
	// for (i = 0; i < tbl_eval.length; i++){
   // document.getElementById(tbl_eval[i]).disabled = false;
		// }
	// }
// }

// function disabled_champ() {
// var hybride_oui=$("input[id=hybride1]:checked").val();	
// var indi=$("#id_indi").val();					
// var tbl_eval = ["cat_a","just_a","cat_a1","crit_a1","cat_a234","crit_a2","crit_a3","crit_a4","cat_b","just_b","cat_c","just_c","cat_c1","crit_c1","cat_c2","crit_c2","cat_d","just_d","cat_d1","crit_d1","cat_d2","crit_d2","cat_e","just_e","cat_ini","just_ini","cat_fin","just_fin","cd_ajustmt","id_raison_ajust"];
// if (hybride_oui == 'TRUE' || indi == 'E')	{		
	// for (i = 0; i < tbl_eval.length; i++){
	// document.getElementById(tbl_eval[i]).disabled = true;
		// }
	// }
// }

function eval () {
	// var hybride_oui=$("input[id=hybride1]:checked").val();						
	var indi=$("#id_indi").val();
	var tbl_eval = ["cat_a","just_a","cat_a1","crit_a1","cat_a234","crit_a2","crit_a3","crit_a4","cat_b","just_b","cat_c","just_c","cat_c1","crit_c1","cat_c2","crit_c2","cat_d","just_d","cat_d1","crit_d1",
	"cat_d2","crit_d2","cat_e","just_e","cat_ini","just_ini","cat_fin","just_fin","cd_ajustmt","id_raison_ajust","menace1","menace2","menace3"];
	// alert ('hybride_what='+hybride_what);
	// if (hybride_oui == 'TRUE' || indi == '3')	{	
	if (indi == '3')	{
		/*Rendre l'évaluation disabled*/
		for (i = 0; i < tbl_eval.length; i++){
		   document.getElementById(tbl_eval[i]).disabled = true;
		   // document.getElementById(tbl_eval[i]).readOnly = true;
		   document.getElementById(tbl_eval[i]).className= "";
		   
			if (document.getElementById(tbl_eval[i]).type == "text")					document.getElementById(tbl_eval[i]).value='';
			else if (document.getElementById(tbl_eval[i]).type == "select-one")		document.getElementById(tbl_eval[i]).value=0;
			// alert(document.getElementById(tbl_eval[i]).value);
		} 	
		/*pour afficher NA de cat ini et fin*/
		document.getElementById('cat_fin').value = 10;
		document.getElementById('cat_ini').value = 10;
		/*pour faire passer NA de cat ini et fin malgré le disabled*/
		// var cat_fin = document.createElement("input");cat_fin.setAttribute("type", "hidden");cat_fin.setAttribute("name", "cat_fin");cat_fin.setAttribute("value", 10); document.getElementById("cat_fin").appendChild(cat_fin);
		// var cat_ini = document.createElement("input");cat_ini.setAttribute("type", "hidden");cat_ini.setAttribute("name", "cat_ini");cat_ini.setAttribute("value", 10); document.getElementById("cat_ini").appendChild(cat_ini);
		} else {
		/*Rendre l'évaluation enabled*/
		// alert(tbl_eval);
		for (i = 0; i < tbl_eval.length; i++){
			document.getElementById(tbl_eval[i]).disabled = false;
			// document.getElementById(tbl_eval[i]).readOnly = false;
			} 
			/*tous les calculs d'évaluation*/
			crita2 () ;					
			fcrit_a1() ;
			cata234 ();
			fcrit_a() ;
			catb ();
			catc1 ();
			catc2 ();
			catc ();
			catd2 ();
			catd ();
			catini ();
			catfin ();
		}
	}
	// $("#hybride1").change (eval);$("#hybride2").change (eval);$("#hybride3").change (eval);
	$("#id_indi").change (eval);
	// $("#id_indi").keyup (eval);

//------------------------------------------------------------------------------ FORM / Plages	
// function precision () {
		// /*tous les calculs de seuil OK*/
		// validatemailleexpert ();	
		// validateaooprecis ();
		// validatenblocprecis ();
		// validatenbindivprecis ();
		// redeff_precis ();
		// validatereduceffprecis (); 
	// }	
	// $("#nbm5_post1990_est").keyup (precision);
	// $("#nbm5_post1990").keyup (precision);
	// $("#nbm5_post2000").keyup (precision);
	// $("#aoo_precis").keyup (precision);
	// $("#nbloc_precis").keyup (precision);
	// $("#nbindiv_precis").keyup (precision);

	function validatemailleexpert () {
        var mailleexpert = $("#nbm5_post1990_est");
		var pr = mailleexpert.val();
		if (isNaN (pr)){
			mailleexpert.addClass("error");
            document.getElementById('aoo_precis').value='';
			return (false);
		} else {
			mailleexpert.removeClass("error");
            document.getElementById('aoo_precis').value=pr;
			validateaooprecis ();
			return (true);
		}
	}
	
	function validatemaille () {
        var maille1990 = $("#nbm5_post1990");
		var aoo1 = maille1990.val();
		var aoo4 = maille1990.val()*4;
		if (isNaN (aoo1)){
			maille1990.addClass("error");
            document.getElementById('aoo1').value='';
            document.getElementById('aoo4').value='';
			return (false);
		} else {
			maille1990.removeClass("error");
            document.getElementById('aoo1').value=aoo1;
            document.getElementById('aoo4').value=aoo4;
			return (true);
		}
	}
	// $("#nbm5_post1990_est").keyup (validatemailleexpert);
	
	function validateaooprecis () {
        var aooprecis = $("#aoo_precis");
        var pr = aooprecis.val();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#cd_indi").val();
// alert ('pr='+pr);
		if (isNaN (pr)){
			aooprecis.addClass("error");
            document.getElementById('id_aoo').value=0;
			return (false);
		} else {
			aooprecis.removeClass("error");
            if (pr == '') 						document.getElementById('id_aoo').value=0;
    		else if (pr == 0)					document.getElementById('id_aoo').value=1;
    		else if (pr >= 1 && pr < 10)		document.getElementById('id_aoo').value=2;
    		else if (pr >= 10 && pr < 20)		document.getElementById('id_aoo').value=3;
    		else if (pr >= 20 && pr < 30)		document.getElementById('id_aoo').value=4;
    		else if (pr >= 30 && pr < 500)		document.getElementById('id_aoo').value=5;
    		else if (pr >= 500 && pr < 2000)	document.getElementById('id_aoo').value=6;
    		else if (pr >= 2000 && pr <3000)	document.getElementById('id_aoo').value=7;
    		else if (pr >= 3000 )				document.getElementById('id_aoo').value=8;
    		else								document.getElementById('id_aoo').value=0;
    		
			if (hybride_oui != 'TRUE' && indi != 'E') {catb () ;catd2 ();redeff_precis ();}
			return (true);
		}
	}
	// $("#aoo_precis").keyup (validateaooprecis);
	
	function validatenblocprecis () {
		var nblocprecis = $("#nbloc_precis");
		var pr=nblocprecis.val ();
        var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#cd_indi").val();
		// alert ('pr='+pr);
		if (isNaN (pr)){
			nblocprecis.addClass("error");
            document.getElementById('id_nbloc').value='';
			return (false);
		} else {
			nblocprecis.removeClass("error");
            if (pr == 1) 					document.getElementById('id_nbloc').value=1;
            else if (pr > 1 && pr <= 5) 	document.getElementById('id_nbloc').value=2;
    		else if (pr > 5 && pr <= 10) 	document.getElementById('id_nbloc').value=3;
    		else if (pr > 10 && pr <= 15)	document.getElementById('id_nbloc').value=4;
    		else if (pr > 15 )				document.getElementById('id_nbloc').value=5;
    		else							document.getElementById('id_nbloc').value=0;
    		
			if (hybride_oui != 'TRUE' && indi != 'E') {catb () ;catd2 ();}
			return (true);
		}
	}
	// $("#nbloc_precis").keyup (validatenblocprecis);

	function validatenbindivprecis () {
        var nbindivprecis = $("#nbindiv_precis");
		var pr=nbindivprecis.val ();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#cd_indi").val();
		// alert('pr='+pr);
		if (isNaN (pr)){
			nbindivprecis.addClass("error");
            document.getElementById('id_nbindiv').value='';
			if (hybride_oui != 'TRUE' && indi != 'E') {catc1 ();catc2 ();catd1 ();}
			return (false);
		} else {
			nbindivprecis.removeClass("error");
            if 		(pr == '') 					document.getElementById('id_nbindiv').value=0;
			else if (pr == 0) 					document.getElementById('id_nbindiv').value=1;
    		else if (pr > 0 && pr < 50) 		document.getElementById('id_nbindiv').value=2;
    		else if (pr >= 50 && pr < 250) 		document.getElementById('id_nbindiv').value=3;
    		else if (pr >= 250 && pr < 1000) 	document.getElementById('id_nbindiv').value=4;
    		else if (pr >= 1000 && pr < 2000) 	document.getElementById('id_nbindiv').value=5;
    		else if (pr >= 2000 && pr < 2500) 	document.getElementById('id_nbindiv').value=6;
    		else if (pr >= 2500 && pr < 10000) 	document.getElementById('id_nbindiv').value=7;
    		else if (pr >= 10000 && pr <= 15000)document.getElementById('id_nbindiv').value=8;
    		else if (pr > 15000 ) 				document.getElementById('id_nbindiv').value=9;
    		else 								document.getElementById('id_nbindiv').value=10;
    		if (hybride_oui != 'TRUE' && indi != 'E') {catc1 ();catc2 ();catd1 ();}
			return (true);
		}
	}
	// $("#nbindiv_precis").keyup (validatenbindivprecis);

	function redeff_precis () {                                                
        var obs1990_est=$("#nbm5_post1990_est").val ();
        var obs1990=$("#nbm5_post1990").val ();
        var obs2000=$("#nbm5_post2000").val ();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#cd_indi").val();
		if (obs1990_est == 0 && obs1990 != null)	m = (obs1990 - obs2000)/obs1990;
		else if (obs1990_est < obs2000)				m = 0;
		else										m = (obs1990_est - obs2000)/obs1990_est;
		// alert('m='+m);
		if ((obs1990_est == null || obs1990_est == 0) && (obs1990 == null || obs1990 == 0) || m <0)
            document.getElementById('reduc_eff_precis').value= null;
        else {
            document.getElementById('reduc_eff_precis').value= m;		
			validatereduceffprecis ();
			}
		return (true);
    }
	
	
	function validatereduceffprecis () {
        var reduceffprecis = $("#reduc_eff_precis");
		var pr=100*reduceffprecis.val ();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#cd_indi").val();
		// alert('pr='+pr);
		if (isNaN (pr) || (pr > 100 )){
			reduceffprecis.addClass("error");
            document.getElementById('id_reduc_eff').value='';
			if (hybride_oui != 'TRUE' && indi != 'E')
				crita2 ();
			return (false);
		} else {
			reduceffprecis.removeClass("error");
            if (pr == 100)					document.getElementById('id_reduc_eff').value=1;
    		else if (pr >= 90 && pr < 100)	document.getElementById('id_reduc_eff').value=2;
    		else if (pr >= 80 && pr < 90)	document.getElementById('id_reduc_eff').value=3;
    		else if (pr >= 70 && pr < 80)	document.getElementById('id_reduc_eff').value=4;
    		else if (pr >= 50 && pr < 70)	document.getElementById('id_reduc_eff').value=5;
    		else if (pr >= 40 && pr < 50)	document.getElementById('id_reduc_eff').value=6;
    		else if (pr >= 30 && pr < 40)	document.getElementById('id_reduc_eff').value=8;
    		else if (pr >= 20 && pr < 30)	document.getElementById('id_reduc_eff').value=8;
    		else if (pr < 20 && pr > 0)		document.getElementById('id_reduc_eff').value=9;
    		else							document.getElementById('id_reduc_eff').value=0;
    		
			if (hybride_oui != 'TRUE' && indi != 'E')	crita2 ();
			return (true);
		}
	}
	$("#reduc_eff_precis").keyup (validatereduceffprecis);

	$("#nbm5_post1990_est").keyup (validatemailleexpert);
	$("#nbm5_post1990_est").keyup (redeff_precis);
	$("#nbm5_post1990").keyup (redeff_precis);
	$("#nbm5_post1990").keyup (validatemaille);
	$("#nbm5_post2000").keyup (redeff_precis);
	$("#aoo_precis").keyup (validateaooprecis);
	$("#nbloc_precis").keyup (validatenblocprecis);
	$("#nbindiv_precis").keyup (validatenbindivprecis);

//------------------------------------------------------------------------------ FORM / Valeurs auto sur l'évaluation

	function crita2 () {                                                         
        var reduc_eff = $("#id_reduc_eff").val();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#id_indi").val();
		// alert ('id_reduc_eff='+reduc_eff.val());		
		if (reduc_eff == 0)							document.getElementById('crit_a2').value=0;
        else if (reduc_eff == 9)					document.getElementById('crit_a2').value=6;
		else if (reduc_eff == 8)					document.getElementById('crit_a2').value=5;
		else if (reduc_eff == 7 || reduc_eff == 6)	document.getElementById('crit_a2').value=4;
		else if (reduc_eff == 5 || reduc_eff == 4)	document.getElementById('crit_a2').value=3;
		else if (reduc_eff == 3 || reduc_eff == 2)	document.getElementById('crit_a2').value=2;
		else if (reduc_eff == 1)					document.getElementById('crit_a2').value=1;
        else 										document.getElementById('crit_a2').value=7;
		if (hybride_oui != 'TRUE' && indi != '3')	cata234 ();
		return (true);
    }	
	$("#id_reduc_eff").change (crita2);
	
	function fcrit_a1() {   // Catégorie A1 & A
        var crit_a1=$("#crit_a1").val ();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#id_indi").val();
		// alert ('crit_a1='+crit_a1);
        switch (crit_a1) {
            case '1' : document.getElementById('cat_a1').value=2;document.getElementById('cat_a1').className="CR*"; break;
            case '2' : document.getElementById('cat_a1').value=3;document.getElementById('cat_a1').className="CR";break;
            case '3' : document.getElementById('cat_a1').value=4;document.getElementById('cat_a1').className="EN"; break;
            case '4' : document.getElementById('cat_a1').value=5;document.getElementById('cat_a1').className="VU";break;
            case '5' : document.getElementById('cat_a1').value=6;document.getElementById('cat_a1').className="NT";break;
            case '6' : document.getElementById('cat_a1').value=7;document.getElementById('cat_a1').className="LC";break;
            case '7' : document.getElementById('cat_a1').value=8;document.getElementById('cat_a1').className="DD";break;
            case '0' : document.getElementById('cat_a1').value=0;document.getElementById('cat_a1').className="";break;
		}
		if (hybride_oui != 'TRUE' && indi != '3')	fcrit_a();
		return (true);
    }
	$("#crit_a1").change (fcrit_a1);
	
	function cata234 () {                // Catégorie A234 & A
        var crita2=$("#crit_a2").val ();
        var crita3=$("#crit_a3").val ();
        var crita4=$("#crit_a4").val ();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#id_indi").val();
		if (crita2==0) {crita2 = 8;}
		if (crita3==0) {crita3 = 8;}
		if (crita4==0) {crita4 = 8;}
        var m=Math.min (crita2,crita3,crita4);
// alert ('min='+m);
        switch (m) {
            case 1 : document.getElementById('cat_a234').value=2;document.getElementById('cat_a234').className="CR*"; break;
            case 2 : document.getElementById('cat_a234').value=3;document.getElementById('cat_a234').className="CR";break;
            case 3 : document.getElementById('cat_a234').value=4;document.getElementById('cat_a234').className="EN"; break;
            case 4 : document.getElementById('cat_a234').value=5;document.getElementById('cat_a234').className="VU";break;
            case 5 : document.getElementById('cat_a234').value=6;document.getElementById('cat_a234').className="NT";break;
            case 6 : document.getElementById('cat_a234').value=7;document.getElementById('cat_a234').className="LC";break;
            case 7 : document.getElementById('cat_a234').value=8;document.getElementById('cat_a234').className="DD";break;
            case 8 : document.getElementById('cat_a234').value=0;document.getElementById('cat_a234').className="";break;
		}
		if (hybride_oui != 'TRUE' && indi != '3')	fcrit_a();
		return (true);
    }
	$("#crit_a2").change (cata234);
	$("#crit_a3").change (cata234);
	$("#crit_a4").change (cata234);
	
	function fcrit_a() {   // Catégorie A1 & A	
		var cata1=$("#cat_a1").val ();
		var cata234=$("#cat_a234").val ();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#id_indi").val();
		if (cata1==0 && cata234==0) {var m = 0;}
		else {
			if (cata1==0) {cata1 = 8;}
			if (cata234==0) {cata234 = 8;}
			var m=Math.min (cata1,cata234);
			}
        document.getElementById('cat_a').value=m;
		 switch (m) {
            case 2 : document.getElementById('cat_a').className="CR*"; break;
            case 3 : document.getElementById('cat_a').className="CR";break;
            case 4 : document.getElementById('cat_a').className="EN"; break;
            case 5 : document.getElementById('cat_a').className="VU";break;
            case 6 : document.getElementById('cat_a').className="NT";break;
            case 7 : document.getElementById('cat_a').className="LC";break;
            case 8 : document.getElementById('cat_a').className="DD";break;
            case 0 : document.getElementById('cat_a').className="";break;
		}

		if (hybride_oui != 'TRUE' && indi != '3')	catini();
		return (true);
		}
	$("#cat_a1").change (cata234);
	$("#cat_a234").change (cata234);
		
	function catb () {                                                          // Catégorie B
 		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#3d_indi").val();
		var aoo=$("#id_aoo").val ();
        var nbloc=$("#id_nbloc").val ();
        var fragmt_sev=$("input[name=fragmt_sev]:checked").val();
        var a= $("input[name=declin_cont_ii]:checked").val(); 						//declin_cont_aoo
        var b=$("input[name=declin_cont_iv]:checked").val();						//declin_cont_nbloc
        var c=$("input[name=declin_cont_i]:checked").val();							//declin_cont_sspop
        var d=$("input[name=declin_cont_v]:checked").val();							//declin_cont_nbind
        var e=$("input[name=declin_cont_iii]:checked").val();						//declin_cont_hab
        var fa=$("input[name=fluct_extrem_ii]:checked").val();						//fluct_extrem_aoo
        var fb=$("input[name=fluct_extrem_iv]:checked").val();						//fluct_extrem_nbloc
        var fc=$("input[name=fluct_extrem_iii]:checked").val();						//fluct_extrem_sspop
        var fd=$("input[name=fluct_extrem_v]:checked").val();						//fluct_extrem_nbind
		// $("#cat_b").className=$("#cat_b").options[$("#cat_b").selectedIndex].className;
		// alert ('reponse = '+aoo+' et '+nbloc+' et '+fragmt_sev+' et '+a+' et '+b+' et '+c+' et '+d+' et '+e+' et '+fa+' et '+fb+' et '+fc+' et '+fd);

        if (aoo == 0 && nbloc == 0 && fragmt_sev== '' && a=='' && b=='' && c=='' && d=='' && e=='' && fa=='' && fb=='' && fc=='' && fd=='') 
            {document.getElementById('cat_b').value=0;document.getElementById('cat_b').className="";}
        else if (aoo == 9) 
            {document.getElementById('cat_b').value=8;document.getElementById('cat_b').className="DD";}
        else if (aoo == 1) 
            {document.getElementById('cat_b').value=2;document.getElementById('cat_b').className="CR*";}
        else if (aoo == 2 && (nbloc==1 || fragmt_sev =='TRUE') && (OR_fluct(fa=='TRUE',fb=='TRUE',fc=='TRUE',fd=='TRUE') || OR_declin (a=='TRUE',b=='TRUE',c=='TRUE',d=='TRUE',e=='TRUE'))) 
            {document.getElementById('cat_b').value=3;document.getElementById('cat_b').className="CR*";}
        else if (aoo == 2 && nbloc!=1  && ((fragmt_sev=='TRUE' && OR_fluct(fa=='TRUE',fb=='TRUE',fc=='TRUE',fd=='TRUE')) || (OR_declin(a=='TRUE',b=='TRUE',c=='TRUE',d=='TRUE',e=='TRUE') && OR_fluct(fa=='TRUE',fb=='TRUE',fc=='TRUE',fd=='TRUE')) || (OR_declin(a=='TRUE',b=='TRUE',c=='TRUE',d=='TRUE',e=='TRUE') && fragmt_sev=='TRUE')))
            {document.getElementById('cat_b').value=3;document.getElementById('cat_b').className="CR";}
        else if (aoo <= 5 && ((nbloc<=2 && nbloc!=0) || fragmt_sev =='TRUE')  && (OR_fluct(fa=='TRUE',fb=='TRUE',fc=='TRUE',fd=='TRUE') || OR_declin(a=='TRUE',b=='TRUE',c=='TRUE',d=='TRUE',e=='TRUE')))
            {document.getElementById('cat_b').value=4;document.getElementById('cat_b').className="EN";}
        else if (aoo <= 5 && (nbloc>2 || nbloc == 0)  && ((fragmt_sev=='TRUE' && OR_fluct(fa=='TRUE',fb=='TRUE',fc=='TRUE',fd=='TRUE')) || (OR_declin(a=='TRUE',b=='TRUE',c=='TRUE',d=='TRUE',e=='TRUE') && OR_fluct(fa=='TRUE',fb=='TRUE',fc=='TRUE',fd=='TRUE')) || (OR_declin(a=='TRUE',b=='TRUE',c=='TRUE',d=='TRUE',e=='TRUE') && fragmt_sev=='TRUE')))
            {document.getElementById('cat_b').value=4;document.getElementById('cat_b').className="EN";}
        else if (aoo <= 6 && ((nbloc<=3 && nbloc!=0) || fragmt_sev =='TRUE')  && (OR_declin(a=='TRUE',b=='TRUE',c=='TRUE',d=='TRUE',e=='TRUE') || OR_fluct(fa=='TRUE',fb=='TRUE',fc=='TRUE',fd=='TRUE')))
            {document.getElementById('cat_b').value=5;document.getElementById('cat_b').className="VU";}
        else if (aoo <= 6 && (nbloc>3 || nbloc == 0)  && ((fragmt_sev=='TRUE' && OR_fluct(fa=='TRUE',fb=='TRUE',fc=='TRUE',fd=='TRUE')) || (OR_declin(a=='TRUE',b=='TRUE',c=='TRUE',d=='TRUE',e=='TRUE') && OR_fluct(fa=='TRUE',fb=='TRUE',fc=='TRUE',fd=='TRUE')) || (OR_declin(a=='TRUE',b=='TRUE',c=='TRUE',d=='TRUE',e=='TRUE') && fragmt_sev=='TRUE')))
            {document.getElementById('cat_b').value=5;document.getElementById('cat_b').className="VU";}
        else if (aoo == 2 && (nbloc==1 || fragmt_sev =='TRUE')  && AND_declin(a!='TRUE',b!='TRUE',c!='TRUE',d!='TRUE',e!='TRUE') && AND_fluct(fa!='TRUE',fb!='TRUE',fc!='TRUE',fd!='TRUE'))
            {document.getElementById('cat_b').value=6;document.getElementById('cat_b').className="NT";}
        else if (aoo == 2 && nbloc!=1 && fragmt_sev =='TRUE' && AND_declin(a!='TRUE',b!='TRUE',c!='TRUE',d!='TRUE',e!='TRUE') && AND_fluct(fa!='TRUE',fb!='TRUE',fc!='TRUE',fd!='TRUE'))
            {document.getElementById('cat_b').value=6;document.getElementById('cat_b').className="NT";}
        else if (aoo == 2 && nbloc!=1 && OR_declin(a=='TRUE',b=='TRUE',c=='TRUE',d=='TRUE',e=='TRUE') && fragmt_sev !='TRUE' && AND_fluct(fa!='TRUE',fb!='TRUE',fc!='TRUE',fd!='TRUE'))
            {document.getElementById('cat_b').value=6;document.getElementById('cat_b').className="NT";}
        else if (aoo == 2 && nbloc!=1 && OR_fluct(fa=='TRUE',fb=='TRUE',fc=='TRUE',fd=='TRUE') && fragmt_sev !='TRUE' && AND_declin(a!='TRUE',b!='TRUE',c!='TRUE',d!='TRUE',e!='TRUE'))
            {document.getElementById('cat_b').value=6;document.getElementById('cat_b').className="NT";}
		else if (aoo <= 5 && ((nbloc<=2 && nbloc!=0) || fragmt_sev =='TRUE')  && AND_declin(a!='TRUE',b!='TRUE',c!='TRUE',d!='TRUE',e!='TRUE') && AND_fluct(fa!='TRUE',fb!='TRUE',fc!='TRUE',fd!='TRUE'))
            {document.getElementById('cat_b').value=6;document.getElementById('cat_b').className="NT";}
        else if (aoo <= 5 && (nbloc>2 || nbloc == 0) && fragmt_sev =='TRUE' && AND_declin(a!='TRUE',b!='TRUE',c!='TRUE',d!='TRUE',e!='TRUE') && AND_fluct(fa!='TRUE',fb!='TRUE',fc!='TRUE',fd!='TRUE'))
            {document.getElementById('cat_b').value=6;document.getElementById('cat_b').className="NT";}
        else if (aoo <= 5 && (nbloc>2 || nbloc == 0) && OR_declin(a=='TRUE',b=='TRUE',c=='TRUE',d=='TRUE',e=='TRUE') && fragmt_sev !='TRUE' && AND_fluct(fa!='TRUE',fb!='TRUE',fc!='TRUE',fd!='TRUE'))
            {document.getElementById('cat_b').value=6;document.getElementById('cat_b').className="NT";}
        else if (aoo <= 5 && (nbloc>2 || nbloc == 0) && OR_fluct(fa=='TRUE',fb=='TRUE',fc=='TRUE',fd=='TRUE') && fragmt_sev !='TRUE' && AND_declin(a!='TRUE',b!='TRUE',c!='TRUE',d!='TRUE',e!='TRUE'))
            {document.getElementById('cat_b').value=6;document.getElementById('cat_b').className="NT";}
        else if (aoo <= 6 && ((nbloc<=3 && nbloc!=0) || fragmt_sev =='TRUE')  && AND_declin(a!='TRUE',b!='TRUE',c!='TRUE',d!='TRUE',e!='TRUE') && AND_fluct(fa!='TRUE',fb!='TRUE',fc!='TRUE',fd!='TRUE'))
            {document.getElementById('cat_b').value=6;document.getElementById('cat_b').className="NT";}
        else if (aoo <= 6 && (nbloc>3 || nbloc == 0) && fragmt_sev =='TRUE' && AND_declin(a!='TRUE',b!='TRUE',c!='TRUE',d!='TRUE',e!='TRUE') && AND_fluct(fa!='TRUE',fb!='TRUE',fc!='TRUE',fd!='TRUE'))
            {document.getElementById('cat_b').value=6;document.getElementById('cat_b').className="NT";}
        else if (aoo <= 6 && (nbloc>3 || nbloc == 0) && OR_declin(a=='TRUE',b=='TRUE',c=='TRUE',d=='TRUE',e=='TRUE') && fragmt_sev !='TRUE' && AND_fluct(fa!='TRUE',fb!='TRUE',fc!='TRUE',fd!='TRUE'))
            {document.getElementById('cat_b').value=6;document.getElementById('cat_b').className="NT";}
        else if (aoo <= 6 && (nbloc>3 || nbloc == 0) && OR_fluct(fa=='TRUE',fb=='TRUE',fc=='TRUE',fd=='TRUE') && fragmt_sev !='TRUE' && AND_declin(a!='TRUE',b!='TRUE',c!='TRUE',d!='TRUE',e!='TRUE'))
            {document.getElementById('cat_b').value=6;document.getElementById('cat_b').className="NT";}
        else if (AND_declin(a=='',b=='',c=='',d=='',e=='') && AND_fluct(fa=='',fb=='',fc=='',fd==''))
            {document.getElementById('cat_b').value=8;document.getElementById('cat_b').className="DD";}
        else 
            {document.getElementById('cat_b').value=7;document.getElementById('cat_b').className="LC";}
		if (hybride_oui != 'TRUE' && indi != '3')	catini();
		return (true);
    }
	$("#cd_indi").change (eval);$("#id_aoo").change (eval);$("#fragmt_sev1").change (eval);$("#fragmt_sev2").change (eval);$("#fragmt_sev3").change (eval);$("#declin_cont_i1").change (eval);$("#declin_cont_i2").change (eval);$("#declin_cont_i3").change (eval);$("#declin_cont_ii1").change (eval);$("#declin_cont_ii2").change (eval);$("#declin_cont_ii3").change (eval);$("#declin_cont_iii1").change (eval);$("#declin_cont_iii2").change (eval);$("#declin_cont_iii3").change (eval);$("#declin_cont_iv1").change (eval);$("#declin_cont_iv2").change (eval);$("#declin_cont_iv3").change (eval);$("#declin_cont_v1").change (eval);$("#declin_cont_v2").change (eval);$("#declin_cont_v3").change (eval);$("#fluct_extrem_ii1").change (eval);$("#fluct_extrem_ii2").change (eval);$("#fluct_extrem_ii3").change (eval);$("#fluct_extrem_iii1").change (eval);$("#fluct_extrem_iii2").change (eval);$("#fluct_extrem_iii3").change (eval);$("#fluct_extrem_iv1").change (eval);$("#fluct_extrem_iv2").change (eval);$("#fluct_extrem_iv3").change (eval);$("#fluct_extrem_v1").change (eval);$("#fluct_extrem_v2").change (eval);$("#fluct_extrem_v3").change (eval);
	
	function catc1 () {                                                         // Catégorie C1 & C
        var critc1=$("#crit_c1").val ();
        var nbindiv=$("#id_nbindiv").val ();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#id_indi").val();
// alert ('nbindiv='+nbindiv);
// alert ('critc1='+critc1);
        if (critc1 == 0 && nbindiv == 0) 										{document.getElementById('cat_c1').value=0;document.getElementById('cat_c1').className="";}
		else if (nbindiv == 1)													{document.getElementById('cat_c1').value=2;document.getElementById('cat_c1').className="CR*";}
        else if (nbindiv <= 3 && critc1 == 5)									{document.getElementById('cat_c1').value=3;document.getElementById('cat_c1').className="CR";}
        else if (nbindiv <= 3 && critc1 >= 4)									{document.getElementById('cat_c1').value=4;document.getElementById('cat_c1').className="EN";}
        else if (nbindiv <= 3 && critc1 >= 3)									{document.getElementById('cat_c1').value=5;document.getElementById('cat_c1').className="VU";}
        else if (nbindiv <= 6 && critc1 >= 4)									{document.getElementById('cat_c1').value=4;document.getElementById('cat_c1').className="EN";}
		else if (nbindiv <= 6 && critc1 >= 3)									{document.getElementById('cat_c1').value=5;document.getElementById('cat_c1').className="VU";}
        else if (nbindiv <= 7 && critc1 >= 3)									{document.getElementById('cat_c1').value=5;document.getElementById('cat_c1').className="VU";}
        else if (nbindiv == 9)													{document.getElementById('cat_c1').value=7;document.getElementById('cat_c1').className="LC";}
        else if (nbindiv != 10 && nbindiv != 0)									{document.getElementById('cat_c1').value=7;document.getElementById('cat_c1').className="LC";}
        else if (nbindiv == 10 || nbindiv == 0 || critc1 == 1 || critc1 == 0)	{document.getElementById('cat_c1').value=8;document.getElementById('cat_c1').className="DD";}	//egale à null ou Inconnu
        else 																	{document.getElementById('cat_c1').value=7;document.getElementById('cat_c1').className="LC";}
		if (hybride_oui != 'TRUE' && indi != '3')	catc();
		return (true);
    }
	$("#crit_c1").change (catc1);
	$("#id_nbindiv").change (catc1);

	function catc2 () {                                                         // Catégorie C2 & C
        var critc2=$("#crit_c2").val ();
        var nbindiv=$("#id_nbindiv").val ();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#id_indi").val();
// alert ('critc2='+critc2);
        if (critc2 == 0 && nbindiv == 0)										{document.getElementById('cat_c2').value=0;document.getElementById('cat_c2').className="";}
		else if (nbindiv == 1)													{document.getElementById('cat_c2').value=2;document.getElementById('cat_c2').className="CR*";}
        else if (nbindiv <= 3 && critc2 == 1)									{document.getElementById('cat_c2').value=3;document.getElementById('cat_c2').className="CR";}
        else if (nbindiv <= 3 && critc2 == 2)									{document.getElementById('cat_c2').value=4;document.getElementById('cat_c2').className="EN";}
        else if (nbindiv <= 3 && critc2 == 3)									{document.getElementById('cat_c2').value=5;document.getElementById('cat_c2').className="VU";}
        else if (nbindiv <= 6 && (critc2 == 1 || critc2 == 2))					{document.getElementById('cat_c2').value=4;document.getElementById('cat_c2').className="EN";}
		else if (nbindiv <= 6 && critc2 == 3)									{document.getElementById('cat_c2').value=5;document.getElementById('cat_c2').className="VU";}
        else if (nbindiv <= 7 && (critc2 == 1 || critc2 == 2 || critc2 == 3))	{document.getElementById('cat_c2').value=5;document.getElementById('cat_c2').className="VU";}
        else if (nbindiv != 10 && nbindiv != 0)									{document.getElementById('cat_c2').value=7;document.getElementById('cat_c2').className="LC";}
        else if (nbindiv == 10 || nbindiv == 0 || critc2 == 4 || critc2 == 0)	{document.getElementById('cat_c2').value=8;document.getElementById('cat_c2').className="DD";}	//egale à null ou Inconnu
        else																	{document.getElementById('cat_c2').value=7;document.getElementById('cat_c2').className="LC";}
		if (hybride_oui != 'TRUE' && indi != '3')	catc();
		return (true);
    }
	$("#crit_c2").change (catc2);
	$("#id_nbindiv").change (catc2);

	function catc () {  
		var catc1=$("#cat_c1").val ();
		var catc2=$("#cat_c2").val ();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#id_indi").val();
		if (catc1==0 && catc2==0) {var m = 0;}
		else {
			if (catc1==0) {catc1 = 8;}
			if (catc2==0) {catc2 = 8;}
			var m=Math.min (catc1,catc2);
			}
		document.getElementById('cat_c').value=m;
		 switch (m) {
            case 2 : document.getElementById('cat_c').className="CR*"; break;
            case 3 : document.getElementById('cat_c').className="CR";break;
            case 4 : document.getElementById('cat_c').className="EN";break;
            case 5 : document.getElementById('cat_c').className="VU";break;
            case 6 : document.getElementById('cat_c').className="NT";break;
            case 7 : document.getElementById('cat_c').className="LC";break;
            case 8 : document.getElementById('cat_c').className="DD";break;
            case 0 : document.getElementById('cat_c').className="";break;
		}

		if (hybride_oui != 'TRUE' && indi != '3')	catini ();
	}
	$("#cat_c1").change (catc);
	$("#cat_c2").change (catc);
	
	function catd1 () {                                                          // Catégorie D
        var nbindiv=$("#id_nbindiv").val ();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#id_indi").val();
        if (nbindiv == 0)			{document.getElementById('cat_d1').value=0;document.getElementById('cat_d1').className="";}
        else if (nbindiv == 1)		{document.getElementById('cat_d1').value=8;document.getElementById('cat_d1').className="DD";}
        else if (nbindiv == 2)		{document.getElementById('cat_d1').value=3;document.getElementById('cat_d1').className="CR";}
        else if (nbindiv == 3)		{document.getElementById('cat_d1').value=4;document.getElementById('cat_d1').className="EN";}
        else if (nbindiv == 4)		{document.getElementById('cat_d1').value=5;document.getElementById('cat_d1').className="VU";}
		else if (nbindiv == 5)		{document.getElementById('cat_d1').value=6;document.getElementById('cat_d1').className="NT";}
		else if (nbindiv == 10)		{document.getElementById('cat_d1').value=8;document.getElementById('cat_d1').className="DD";}
        else						{document.getElementById('cat_d1').value=7;document.getElementById('cat_d1').className="LC";}
 		if (hybride_oui != 'TRUE' && indi != '3')	catd ();
		return (true);
    }
	$("#id_nbindiv").change (catd1);
	
	
	function catd2 () {                                                          // Catégorie D
        var nbloc=$("#id_nbloc").val ();
        var menace=$("input[name=menace]:checked").val();
        var aoo=$("#id_aoo").val ();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#id_indi").val();
        if (menace == ''  && aoo==0 && nbloc==0)				{document.getElementById('cat_d2').value=0;document.getElementById('cat_d2').className="";document.getElementById('crit_d2').value='';}
        else if (menace == '' || (aoo==0 && nbloc==0))			{document.getElementById('cat_d2').value=8;document.getElementById('cat_d2').className="DD";document.getElementById('crit_d2').value='';}
        else if (menace == 'TRUE' && (aoo!=0 && aoo <=3))		{document.getElementById('cat_d2').value=5;document.getElementById('cat_d2').className="VU";document.getElementById('crit_d2').value='menace et aoo < 20km²';}
        else if (menace == 'TRUE' && (nbloc==2 || nbloc == 1))	{document.getElementById('cat_d2').value=5;document.getElementById('cat_d2').className="VU";document.getElementById('crit_d2').value='menace et nb de localité <=5';}			
        else if (menace == 'TRUE' && aoo!=0 && aoo <=4)			{document.getElementById('cat_d2').value=6;document.getElementById('cat_d2').className="NT";document.getElementById('crit_d2').value='menace et aoo < 30km²';}		
        else if (menace == 'FALSE' && aoo!=0 && aoo <=3)		{document.getElementById('cat_d2').value=6;document.getElementById('cat_d2').className="NT";document.getElementById('crit_d2').value='pas de menace et aoo < 20km²';}			
        else													{document.getElementById('cat_d2').value=7;document.getElementById('cat_d2').className="LC";document.getElementById('crit_d2').value='';}
		if (hybride_oui != 'TRUE' && indi != '3')	catd ();
		return (true);
    }

	$("#id_nbloc").change (catd2);
	$("#id_aoo").change (catd2);
	$("#menace1").change (catd2);
	$("#menace2").change (catd2);
	$("#menace3").change (catd2);
	
	function catd () {                                                          // Catégorie D
		var catd1=$("#cat_d1").val ();
		var catd2=$("#cat_d2").val ();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#id_indi").val();
		if (catd1==0 && catd2==0) {var m = 0;}
		else {
			if (catd1==0) {catd1 = 8;}
			if (catd2==0) {catd2 = 8;}
			var m=Math.min (catd1,catd2);
			}
		document.getElementById('cat_d').value=m;
		switch (m) {
            case 2 : document.getElementById('cat_d').className="CR*"; break;
            case 3 : document.getElementById('cat_d').className="CR";break;
            case 4 : document.getElementById('cat_d').className="EN";break;
            case 5 : document.getElementById('cat_d').className="VU";break;
            case 6 : document.getElementById('cat_d').className="NT";break;
            case 7 : document.getElementById('cat_d').className="LC";break;
            case 8 : document.getElementById('cat_d').className="DD";break;
            case 0 : document.getElementById('cat_d').className="";break;
		}
		if (hybride_oui != 'TRUE' && indi != '3')	catini ();
    }
	$("#cat_d1").change (catd);
	$("#cat_d2").change (catd);
	
	function catini () {                                                        // Catégorie init
        var cata=$("#cat_a").val ();
        var catb=$("#cat_b").val ();
        var catc=$("#cat_c").val ();
        var catd=$("#cat_d").val ();
        var cate=$("#cat_e").val ();
		var hybride_oui=$("input[id=hybride1]:checked").val();						
		var indi=$("#id_indi").val();
		if (cata==0 && catb==0 && catc==0 && catd==0 && cate==0)
			var	m = 0
		else
			{
			if (cata==0) {cata = 8;}
			if (catb==0) {catb = 8;}
			if (catc==0) {catc = 8;}
			if (catd==0) {catd = 8;}
			if (cate==0) {cate = 8;}
			var	m=Math.min (cata,catb,catc,catd,cate);
			}
		document.getElementById('cat_ini').value=m;
		switch (m) {
            case 2 : document.getElementById('cat_ini').className="CR*"; break;
            case 3 : document.getElementById('cat_ini').className="CR";break;
            case 4 : document.getElementById('cat_ini').className="EN";break;
            case 5 : document.getElementById('cat_ini').className="VU";break;
            case 6 : document.getElementById('cat_ini').className="NT";break;
            case 7 : document.getElementById('cat_ini').className="LC";break;
            case 8 : document.getElementById('cat_ini').className="DD";break;
            case 0 : document.getElementById('cat_ini').className="";break;
		}

// alert ('m='+m);
		if (hybride_oui != 'TRUE' && indi != '3')	
			catfin ();
		return (true);
    }
	$("#cat_a").change (catini);
	$("#cat_b").change (catini);
	$("#cat_c").change (catini);
	$("#cat_d").change (catini);
	$("#cat_e").change (catini);

	function catfin () {                                                        // Catégorie init
        var categ_ini=$("#cat_ini").val ();
        var ajust=$("#cd_ajustmt").val ();
		if (categ_ini == 0)	var	m = 0;
		else	            var	m = parseInt(categ_ini) + parseInt(ajust);
		document.getElementById('cat_fin').value = m;
		switch (m) {
            case 2 : document.getElementById('cat_fin').className="CR*"; break;
            case 3 : document.getElementById('cat_fin').className="CR";break;
            case 4 : document.getElementById('cat_fin').className="EN";break;
            case 5 : document.getElementById('cat_fin').className="VU";break;
            case 6 : document.getElementById('cat_fin').className="NT";break;
            case 7 : document.getElementById('cat_fin').className="LC";break;
            case 8 : document.getElementById('cat_fin').className="DD";break;
            case 0 : document.getElementById('cat_fin').className="";break;
		}

		return (true);
    }
	$("#cat_ini").change (catfin);
	$("#cd_ajustmt").change (catfin);
	
//------------------------------------------------------------------------------ FORM / Valid.

	$("#form1").validate({
		rules: {
			cd_ref: {
                digits: true
			},
			nom_sci: {
				required: true,
                minlength: 3
			},
			aoo1: {
                digits: true
			},
			aoo4: {
                digits: true
			},
			aoo_precis: {
                digits: true
			},
			nbloc_precis: {
                digits: true
			},
			nbm5_total: {
                digits: true
			},
			nbm5_post1990: {
                digits: true
			},
			nbm5_post1990_ajt: {
                digits: true
			},
			nbm5_post2000: {
                digits: true
			},
			nbcommune: {
                digits: true
			},
			nbindiv_precis: {
                digits: true
			},

		},
		messages: {
			cd_ref: { digits: ""},
			nom_sci: { required: "",minlength: ""},
			aoo1: { digits: ""},
			aoo4: { digits: ""},
			aoo_precis: { digits: ""},
            nbloc_precis: { digits: ""},
			nbm5_total: { digits: ""},
			nbm5_post1990: { digits: ""},
			nbm5_post1990_ajt: { digits: ""},
			nbm5_post2000: { digits: ""},
			nbcommune: { digits: ""},
			nbindiv_precis: { digits: ""}
		}
	});
