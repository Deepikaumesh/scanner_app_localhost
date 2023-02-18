<?php
$servername = "localhost";
$username = "root";
$password = "";
$database = "scanner_project";

// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);
   
// Check connection
if ($connection->connect_error) {
  die("Connection failed: " . $connection->connect_error);
}
 $id=$_POST['id'];
	$connection->query("DELETE FROM merchant_add_product WHERE id=".$id);

$result=array("success"=>'Successfully Deleted');
echo json_encode($result);
?>