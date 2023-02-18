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

  
    
    
    $uid = $_GET['uid'];
 
   
   
 $sql = "SELECT order_items_tb.id as cartid,order_items_tb.product_qty,order_items_tb.uid, merchant_add_product.* FROM order_items_tb inner join merchant_add_product ON order_items_tb.productid =merchant_add_product.productid WHERE order_items_tb.uid=".$uid;

  
    $result = mysqli_query($connection, $sql) or die("Error in Selecting " . mysqli_error($connection));
     
    
    $response = array();
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            array_push($response,$row);
        }
    }

    
//$connection->close();
//header('Content-Type: application/json');
echo json_encode($response);


?>

