<?php
include '../helpers/dbconnection.php';

if(isset($_POST['email']) 
&& isset($_POST['full_name']) 
&& isset($_POST['password'])){

global $conn;//uta ko function tancha
$email=$_POST['email'];

$sql = "Select * from user where email = '$email'";//query lagako
$result = mysqli_query($conn,$sql);
$num = mysqli_num_rows($result);

if($num > 0 ){
    echo json_encode(
        array(
            "success" =>false,
            "message" =>"Email address already exists. Try new email."
        )
    );
    return;
}else{
   $username =$_POST['full_name'];
   $password = $_POST['password'];
   $hash_password = password_hash($password,PASSWORD_DEFAULT);
    $insertQuery = "INSERT INTO `user`( `full_name`, `email`, `password`) VALUES ('$username','$email','$hash_password')";
    $result = mysqli_query($conn,$insertQuery);
    if($insertQuery){
        echo json_encode(
            array(
                "message" =>"New account created",
                "success" => true,
            )
        );
    }else{
        echo json_encode(
            array(
                "success" => false,
                "message" => "Error"

            )
        );
    }


}
}
?>