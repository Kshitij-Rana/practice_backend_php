<?php
include './helpers/dbconnection';
global $conn;
$sql = "Select * from products";
$result = mysqli_query($conn,$sql);

if ($result){
    $products = [];
    while ($response = mysqli_fetch_assoc($result)){
        $products = $response;
    }
    echo json_encode(
        array(
            "status" => true,
            "message" => "Products fetched successfully",
            "data" => $products
        )
        );
}else{
    echo json_encode(
        array(
            "status" => false,
            "message" => "Something went wrong"
        )
        );
}
?>