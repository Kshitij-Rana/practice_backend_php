<?php
include('../helpers/dbconnection.php');
if (isset($_POST['email'])
&& isset($_POST['password'])){
global $conn;
$email = $_POST['email'];
$pasword = $_POST['password'];
$emailquery = "Select * from user where email ='$email'";
$result = mysqli_query($conn,$emailquery);
$num = mysqli_num_rows($result);
if($num > 0){
    $row = mysqli_fetch_assoc($result) ;
    $verify = password_verify($pasword,$row['password']);
    if($verify == 1){
        $accessToken = bin2hex(openssl_random_pseudo_bytes(16));
        $userID = $row['user_id'];
        $role = $row['role'];
        $insertokensql = "INSERT INTO `personal_acess_token`( `token`, `user_id`) VALUES ('$accessToken','$userID')";
        $result = mysqli_query($conn,$insertokensql);
        if($result){
            echo json_encode(
                array(
                    "success" => true,
                    "token"=> $accessToken,
                    "role" => $role,
                    "message" => "Logged in"
            )
                );
                
        }
    }else{
        echo json_encode(
            array(
                "success" => false,
                "message"=>"Password is incorrect"
            )
            
        );
    }
}else{
     echo json_encode(
       array(
        "success" => false,
        "message" =>"Entered email is not found."
       )
    );
}

}else{
    echo json_encode(
        array(
         "success" => false,
         "message" =>"Entered email is not found."
        )
     );
}

?>