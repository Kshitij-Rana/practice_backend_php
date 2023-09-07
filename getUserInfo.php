<?php
include 'helpers/dbconnection.php';
include 'helpers/Authentication.php';

if(!isset($_POST['token'])){
    echo json_encode(
        array(
            "success" => false,
            "message" => "You are not authorized"
        )
        );
        die;
}
global $conn;
$token = $_POST['token'];
$userID = getUserId($token);

$sql = "select user_id,email,full_name,role from user where user_id = $userID";
$result = mysqli_query($conn,$sql);
if($result){
    $row=mysqli_fetch_assoc($result);
    echo json_encode(
        array(
            "success" => true,
            "message" => "Information fetched successfully",
            "data" => $row
        )
        );
}else{
    echo json_encode(
        array(
            "success" => false,
            "message" => "Information fetched failed"
        )
        );
}