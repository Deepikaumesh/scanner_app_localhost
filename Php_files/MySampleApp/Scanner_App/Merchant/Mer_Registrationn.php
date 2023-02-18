<?php 
$servername = "localhost";
$username = "root";
$password = "";
$database = "scanner_project";

// Create connection
$connection = mysqli_connect($servername, $username, $password, $database);
   

          if( !empty($_POST["username"])and !empty($_POST["email"])and !empty($_POST["phone"])and !empty($_POST["password"]))
{

      $username = $_POST["username"];
    $email= $_POST["email"];
    $phone= $_POST["phone"];
    $password = $_POST["password"];
    
               
      
      $username=mysqli_real_escape_string($connection,$username);
     $email=mysqli_real_escape_string($connection,$email);
      $phone=mysqli_real_escape_string($connection,$phone);
       $password=mysqli_real_escape_string($connection,$password);

      

 
 

$findexist="select * from  merchant_registration where username='".$username."'";


        $resultsearch=mysqli_query($connection,$findexist);
        
  
    if(mysqli_num_rows($resultsearch)>0)
    {
          while($row=mysqli_fetch_array($resultsearch))
          {
              // $result["success"] = "3";
              // $result["message"] = "user Already exist";
			    $result["error"] = true;
              $result["message"] = "user Already exist";

              echo json_encode($result);
              //mysqli_close($connection);
          }}
  
else{

    $sql = "INSERT INTO  merchant_registration (username,email,phone,password) VALUES ('".$username."','".$email."','".$phone."','".$password."')";


    if ( mysqli_query($connection, $sql) ) {
        $result["error"] = false;
        $result["message"] = "Registration success";

        echo json_encode($result);
   //     mysqli_close($connection);

    }
	// else {
        // $result["error"] = "true";
        // $result["message"] = "error in Registration";
        // echo json_encode($result);
    
     //  mysqli_close($connection);
    // }
	}
}

?>