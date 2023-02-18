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
$connection->set_charset("utf8");



 if( !empty($_POST["name"])and !empty($_POST["bank"])and !empty($_POST["ac_no"])and !empty($_POST["total_amt"])
			  and !empty($_POST["phone"])and !empty($_POST["uid"]) 
			  //and !empty($_POST["order_id"])
			 // and !empty($_POST["order_date"])
			  )
{

      
    $name= $_POST["name"];
	 $bank= $_POST["bank"];
    $ac_no= $_POST["ac_no"];
	$total_amt= $_POST["total_amt"];
	$phone= $_POST["phone"];
	$uid =$_POST["uid"];
// 	$order_date=$_POST["order_date"];
// 	$order_id=$_POST["order_id"];
   
   
    
               
      
     
//      $name=mysqli_real_escape_string($connection,$name);
// 	  $bank=mysqli_real_escape_string($connection,$bank);
// 	   $ac_no=mysqli_real_escape_string($connection,$ac_no);
// 	    $total_amt=mysqli_real_escape_string($connection,$total_amt);
// 		 $craft_id=mysqli_real_escape_string($connection,phone);
     
     
	 
	

 
   
 $sql1 = "INSERT INTO     order_tb(uid,order_date,total_amt) VALUES ('".$uid."',	'".date("d/m/Y")."','".$total_amt."')";
  if ( mysqli_query($connection, $sql1))
 
    {
        
        $qry = "select max(order_id) as oid from order_tb";
        
        $result1 = mysqli_query($connection, $qry) or die("Error in Selecting " . mysqli_error($connection));
        
        $row = mysqli_fetch_assoc($result1);
        
         $sql_cart = "select * from cust_cart_product where uid = ".$uid;
         
          $result2 = mysqli_query($connection, $sql_cart) or die("Error in Selecting " . mysqli_error($connection));
          
            while($row1 = $result2->fetch_assoc()){
                
                $sql_order_items = "INSERT INTO  order_items_tb(productid,product_qty,order_id,uid)  VALUES ('".$row1["productid"]."','".$row1["product_qty"]."','".$row["oid"]."',
                '".$row1["uid"]."')";
                 mysqli_query($connection, $sql_order_items);
   
                
                
            
        }
        
        $delete_cart = "delete from cust_cart_product where uid =".$uid;
        
          if ( mysqli_query($connection, $delete_cart))
   {}
        
        
        
        
     
        
           $sql = "INSERT INTO    customer_payment(name,bank,ac_no,total_amt,phone,order_id,uid) VALUES (
	'".$name."','".$bank."','".$ac_no."','".$total_amt."','".$phone."','".$row["oid"]."','".$uid."')";
	
        if ( mysqli_query($connection, $sql))
   {
       
       
        $result["error"] = false;
        $result["message"] = "your payment successfull";
        
      
   
        
        
	}
	else{
		$result["error"] = true;
        $result["message"] = "payment not success";
	}
    }


//     $sql = "INSERT INTO    customer_payment(name,bank,ac_no,total_amt,phone,order_id,uid) VALUES (
// 	'".$name."','".$bank."','".$ac_no."','".$total_amt."','".$phone."','".$order_id."','".$uid."')";
	
	
	


//     if ( mysqli_query($connection, $sql1)   && mysqli_query($connection, $sql))
//     {
//         $result["error"] = false;
//         $result["message"] = "your payment successfull";
        
//          //	$connection->query("DELETE  * FROM  cust_cart_product") ;
     
        
        
// 	}
// 	else{
// 		$result["error"] = true;
//         $result["message"] = "payment not success";
// 	}

        echo json_encode($result);
        mysqli_close($connection);

    

}

	   
	   
	 


?>
