

<?php

$servername = "localhost";
$username = "root";
$password = "";
$database = "scanner_project";
// // Create connection
$connection = new mysqli($servername, $username, $password,$database);
    
   
// Check connection
if ($connection->connect_error) {
  die("Connection failed: " . $connection->connect_error);
}

            $connection->set_charset("utf8");
            
            
            



	 	$id = $_POST['id'];
	$productid = $_POST['productid'];
	$product_qty = $_POST['product_qty'];



  


	$sql ="UPDATE  cust_cart_product SET product_qty='".$product_qty."' WHERE id=".$id;



  if ( mysqli_query($connection, $sql) ) {
        
        $sql1 ="select stock from merchant_add_product WHERE productid = '".$productid."' ";
    
          $s = mysqli_query($connection, $sql1) ;
              $ss = mysqli_fetch_assoc($s);
        
         $newqty =$ss["stock"] -$product_qty;
         
         $sql2 = "UPDATE merchant_add_product SET stock = '".$newqty."'  WHERE productid = '".$productid."'";
         

         
         mysqli_query($connection, $sql2);
         
         
         
          $result["error"] = false;
        $result["message"] = "Product uppdated Successfully-".$ss["stock"]."-".$product_qty;
		 echo json_encode($result);
        mysqli_close($connection);
    }
    else{
          $result["error"] = true;
        $result["message"] = "Product not Added";
      
} 
	



// 	$connection->query("UPDATE  cust_cart_product SET product_qty='".$product_qty."' WHERE id=".$id);




	



    	
// 	$result = array();
// 	$result['msg'] = "Successfully Edited..";
// 	echo json_encode($result);

?>


