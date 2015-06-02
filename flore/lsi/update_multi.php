<?php

function update_multi($db,$query,$statut,$id_att,$att_sel,$table,$id)
	{

    if (!empty($query))
		{
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
		$i=0;
		while ($row=pg_fetch_array ($result,NULL,PGSQL_ASSOC))
			{
			$att[$i]=$row["$id_att"];
			$i++;
			}
		}
		
	/*déclaration quand la variable est vide*/
	$att = empty($att) ? array() : $att;
	$att_sel = empty($att_sel) ? array() : $att_sel;
    // echo "<br>".$query;
	// echo "$statut 1 :";var_dump($att);
	// echo "$statut 2 :";var_dump($att_sel);
	
	if ($table == "eee.reponse") {$att3 = 'zone';} 
	else {$att3 = 'statut';}
	
	$query = "";
	$supp = array_diff($att, $att_sel);
	$add = array_diff($att_sel,$att);
	
	if (!empty($supp))		/*Suppression*/
		{
		foreach ($supp as $field => $val)
		$query= $query."DELETE FROM $table WHERE (uid,$id_att,$att3) = ($id,$val,'$statut'); ";
		// echo "<br>".$query;
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
		}
	if (!empty($add))		/*Ajout*/
		{
		foreach ($add as $field => $val)
		$query= $query."INSERT INTO $table VALUES ($id,$val,'$statut'); ";
		// echo "<br>".$query;
		$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
		}
		/*Log*/
		add_log ("log",5,$id_user,getenv("REMOTE_ADDR"),"Saisie edit fiche",$id,"eee");
    pg_free_result ($result);	
	}
	
	
function add_multi_3($db,$add,$uid,$table,$statut)
	{
	$query = "";
	if (!empty($add))
		{
		foreach ($add as $val)
			{
			$query= $query."INSERT INTO $table VALUES ($uid,$val,'$statut'); ";
			}
		if (!empty($query))
			{
			$result=pg_query ($db,$query) or die ("Erreur pgSQL : ".$query);
			}
		}
	echo "<br>".$query;
	pg_free_result ($result);
	}