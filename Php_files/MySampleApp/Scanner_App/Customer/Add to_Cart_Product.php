
<?php
$servername = "localhost";
$username = "root";
$password = "";
$database = "scanner_project";

// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);


   if( !empty($_POST["productid"])and !empty($_POST["product_qty"])and !empty($_POST["uid"]))
{

      $productid = $_POST["productid"];
    $product_qty= $_POST["product_qty"];
     $uid= $_POST["uid"];
    
   
               
      
    //   $productid=mysqli_real_escape_string($connection,$productid);
    //   $product_qty=mysqli_real_escape_string($connection,$product_qty);
    //     $uid=mysqli_real_escape_string($connection,$uid);
   
   

      

 
 

// $findexist="select * from cust_cart_product where productid='".$productid."'";
$findexist="select * from cust_cart_product where productid='".$productid."' && uid='".$uid."'";


        $resultsearch=mysqli_query($connection,$findexist);
        
  
    if(mysqli_num_rows($resultsearch)>0)
    {
          while($row=mysqli_fetch_array($resultsearch))
          {
            //   $result["success"] = "3";
            //   $result["message"] = "Product Already Added";
			    $result["error"] = true;
              $result["message"] = "Product Already Added, Go to cart and change qty!";

              echo json_encode($result);
              mysqli_close($connection);
          }}
  
else{

   
      $sql = "INSERT INTO cust_cart_product (productid,product_qty,uid) VALUES ('".$productid."','".$product_qty."','".$uid."')";


    if ( mysqli_query($connection, $sql) ) {
        
        $sql1 ="select stock from merchant_add_product WHERE productid = '".$productid."' ";
        
          $s = mysqli_query($connection, $sql1) ;
              $ss = mysqli_fetch_assoc($s);
        
         $newqty =$ss["stock"] -$product_qty;
         
         $sql2 = "UPDATE merchant_add_product SET stock = '".$newqty."'  WHERE productid = '".$productid."'";
         
         mysqli_query($connection, $sql2);
         
         
          $result["error"] = false;
        $result["message"] = "Product Added Successfully-".$ss["stock"]."-".$product_qty;
		 echo json_encode($result);
        mysqli_close($connection);
    }
    else{
          $result["error"] = true;
        $result["message"] = "Product not Added";
      
} }	}
	
	
	
	

	
//     if ( mysqli_query($connection, $sql) ) {
//         $result["error"] = false;
//         $result["message"] = "Registration success";
		
// 		 echo json_encode($result);
//         mysqli_close($connection);
//     }
    
      
// }   }

?>

