<?php
include 'helpers/dbconnection.php';
include 'helpers/authentication.php';
if(!isset($_POST['token'])){
    echo json_encode(
        array(
            "success" => false,
            "message" => "Token Required"
        )
        );
        die;
}
global $conn;
$token=$_POST['token'];
$checkAdmin = isAdmin($token);
if (!$checkAdmin){
    echo json_encode(
        array(
            "success" => false,
            "message" => "You are not authorized."
        )
        );
        die();
}
if(!isset($_POST['product_id'])){
    echo json_encode(
        array(
            "success" => false,
            "message" => "Product id is required"
        )
        );
        exit;
}
$productid=$_POST['product_id'];
$sql = "update product set in_stock = 0 where product_id = $productid";
$result = mysqli_query($conn,$sql);
if($result){
    echo json_encode(
        array(
            "success" =>true,
            "message" =>"Product deleted"
        )
        );
}else{
    echo json_encode(
        array(
            "success" =>false,
            "message" =>"Product deletion failed"
        )
        );
}