<?php
$servername = 'localhost';
$username = 'root';
$password = '';
$database = "scanner_project";

// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);

  if( !empty($_POST["username"])and !empty($_POST["password"]))
{

      $username = $_POST["username"];
    $password = $_POST["password"];
    
               
      
      $username=mysqli_real_escape_string($connection,$username);
       $password=mysqli_real_escape_string($connection,$password);
	   



$username = $_POST['username'];
 $password = $_POST['password'];
 $sql = "SELECT * FROM admin_registration WHERE username = '".$username."' AND password = '".$password."'";
 $result = mysqli_query($connection,$sql);
 $count = mysqli_num_rows($result);
 if($count == 1){
    echo json_encode("Success");
 } 
 else{
    echo json_encode("Error");
}}
?>

