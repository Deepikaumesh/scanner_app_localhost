<?php
$servername = "localhost";
$username = "root";
$password = "";
$database = "scanner_project";
 
 include 'ip_address.php';
$ip_address= '192.168.29.64';
// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);
   
// Check connection
if ($connection->connect_error) {
  die("Connection failed: " . $connection->connect_error);
}
 

   $productid	 = $_POST['productid'];
     $productname = $_POST['productname'];
	   $productprice = $_POST['productprice'];
	   //  $productqty = $_POST['productqty'];
	     $stock = $_POST['stock'];

 $file_name1 = $_FILES['image']['name'];
 $file_tmp =$_FILES['image']['tmp_name'];
  move_uploaded_file($file_tmp,'image_uploaded/'.$file_name1);
 
 

  $file_name2="http://$ip_address/MySampleApp/Scanner_App/Merchant/image_uploaded/".$file_name1;
 



 $sql = "INSERT INTO `merchant_add_product`( `productid`,`productname`,`productprice`,`stock`,`image`) VALUES ( '$productid',' $productname ','$productprice',
 '$stock','$file_name2')";

 if ($connection->query($sql) === TRUE)
{
  echo json_encode(array("statusCode=200","msg"=>"New record created successfully"));
} 
else 
{
  echo json_encode(array("statusCode=0","msg"=>$connection->error));
}
 
 
?>


