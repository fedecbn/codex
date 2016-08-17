<?php
//------------------------------------------------------------------------------//
//  commun/TAXON_PROCESS.PHP                                                    //
//                                                                              //
//  SILENE-Flore                                                                //
//  Module extrene : Typologie des habitats naturels du PNM                     //
//                                                                              //
//  Version 1.00  28/11/12 - OlGa                                               //
//  Version 1.01  22/01/13 - MaJ ID                                             //
//  Version 1.01  22/01/13 - Aj 'FICHE_TYPE'                                    //
//  Version 1.02  23/12/14 - Aj utf8_encode                                     //
//  Version 1.03  19/03/13 - Aj 'COMM'                                          //
//------------------------------------------------------------------------------//

//------------------------------------------------------------------------------ INIT.
include ("../../_INCLUDE/config_sql.inc.php");
include ("commun.inc.php");
//------------------------------------------------------------------------------ VAR.
$table="syntaxa.st_cortege_floristique";

//----------------------------------------------------------------------------- PARMS.
$idsyntaxon = isset($_POST['idsyntaxon']) ? $_POST['idsyntaxon'] : "";
$idrattachement= isset($_POST['idrattachement']) ? $_POST['idrattachement'] : "";;
$FICHE_TYPE = isset($_POST['FICHE_TYPE']) ? $_POST['FICHE_TYPE'] : 1;
$taxon = isset($_POST['taxon']) ? $_POST['taxon'] : "";
$CD_REF = isset($_POST['CD_REF']) ? $_POST['CD_REF'] : "";
$COMM = isset($_POST['COMM']) ? $_POST['COMM'] : "";

//------------------------------------------------------------------------------ CONNEXION SERVEUR mySQL
$db=sql_connect (SQL_base);
if (!$db) fatal_error ("Impossible de se connecter au serveur PostgreSQL.",false);
 //   $db_selected=mysql_select_db(SQL_base,$db) or die ("Impossible d'utiliser la base : ".mysql_error());
//------------------------------------------------------------------------------ INIT JAVASCRIPT
?>
<script type="text/javascript" >
	$(".tax_delete").click(function(){
		var tax_id = $(this).parent().find(".tax_id").val();
		var type_id = $(this).parent().find(".type_id").val();
//		var tax_content = $(this).parent().find(".tax_content").val();
		var url = 'id=' + tax_id;
		$.ajax({
		    type: "POST",
		    url: "../commun/taxon_delete.php",
		    data: url,
		    success: function(){
				taxon_list(type_id);
            }
		});
        return (false);
	});
</script>
<?php
//------------------------------------------------------------------------------ MAIN
    if (isset($_POST['submit'])) {                                              // MaJ table 
/* //A faire dans la base de données?
alter table syntaxa.st_cortege_floristique add column code_referentiel text;
alter table syntaxa.st_cortege_floristique add column version_referentiel text;
alter table syntaxa.st_cortege_floristique add column cd_ref text;
alter table syntaxa.st_cortege_floristique add column nom_complet text;
alter table syntaxa.st_cortege_floristique add column "rqTaxon" text;
*/
     $query="INSERT INTO ".$table." (\"codeEnregistrementSyntaxon\",code_referentiel,version_referentiel,\"idRattachementReferentiel\",cd_ref,nom_complet,\"rqTaxon\") VALUES ('".$idsyntaxon."','TAXREF','7','".$idrattachement."',".$CD_REF.",'".$taxon."',".sql_format($COMM).");";
//   $query="INSERT INTO ".$table." (\"codeEnregistrementSyntaxon\",code_referentiel,version_referentiel,cd_ref,nom_complet,\"rqTaxon\") VALUES ('".$idsyntaxon."','TAXREF','7',".$CD_REF.",'".$taxon."',".sql_format($COMM).");";
echo "idrattachement:". $idrattachement."<br>";
		echo $query."<br>"; 
		$result=pg_query($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
    }
    $query="SELECT * FROM ".$table." WHERE \"codeEnregistrementSyntaxon\"='".$idsyntaxon."';";    // Affiche la liste
//echo $query; 
	$result=pg_query($db,$query) or fatal_error ("Erreur pgSQL : ".pg_result_error ($result),false);
	echo ("<table border=1 class=\"list\" >");
    if (pg_num_rows($result)>0)
    	while($row = pg_fetch_array($result))
        {
			//<td valign="middle" width="100%">'.utf8_encode($row['nom_complet']).' '.utf8_encode($row['rqTaxon']).'</td>
        	echo '<tr class=\"list\" ><form id="form" action="taxon_delete.php?id='.$row['idCortegeFloristique'].'" method="post">
			<td valign="middle" width="50%">'.utf8_encode($row['nom_complet']).'</td>
			<td valign="middle" width="50%">'.utf8_encode($row['rqTaxon']).'</td>
    		<td valign="middle" width="10%">
    		<input type="hidden" class="tax_id" id="tax_id" value="'.$row['idCortegeFloristique'].'" />
			<input type="hidden" class="type_id" id="tax_id" value="'.$FICHE_TYPE.'" />
    		<img src="../../_GRAPH/details_close.png" class="tax_delete" name="tax_delete" border="0" title="Supprimer" />
    		</form>
    		</td></tr>';

    	}
	echo '</table>';
?>
