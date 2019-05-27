<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="st.css">
	<title>Interfata</title>
</head>
<body>
<?php

$conn = oci_connect('ANDR', 'ANDR', 'localhost/XE');
if (!$conn) {
    $e = oci_error();
    trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}
?>
	<h2 align="center" class="header">
	
	<?php
	echo "Meniul de azi ".date("d-m-Y");
	?>
	
	</h2>
	<button value="Refresh Page" style="cursor:pointer" onClick="window.location.reload()";>Genereaza Meniu</button>
	<button style="float:right; cursor:pointer;" onclick="window.location.assign('user.php')">Vizualizeaza utilizatorii</button>
	<button style="float:right; cursor:pointer;" onclick="window.location.assign('produse.php')">Adauga rating</button>

	<table align="center" border="1px" style="width: 600px; line-height: 40px;">
			<tr>
			<th style="background-color:brown;">Denumire preparat/Dish name</th>
			<th style="background-color:brown;">Cantitate/Cantity</th>
			<th style="background-color:brown;">Pret/Price</th>
			</tr>
			
			<?php
				/* include 'generateMenu.php';
				generateMenu(); */

			$stid = oci_parse($conn, 'SELECT NUME, PRET FROM PRODUSE ORDER BY DBMS_RANDOM.VALUE');
			if (!$stid) {
				$e = oci_error($conn);
				trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
			}
			$r = oci_execute($stid);
			if (!$r) {
				$e = oci_error($stid);
				trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
			}

			print "<table border='1' align='center'; style='width:600px; line-height:40px;'>\n";
			while ($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
				print "<tr>\n";
				foreach ($row as $item) {
					print "<td>" . htmlentities($item, ENT_QUOTES) . "</td>\n";
				}
				print "</tr>\n";
			}
			print "</table>\n";

			oci_free_statement($stid);
			oci_close($conn);

			?>

			
	</table>

</body>
</html>