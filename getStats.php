<?php
include 'helpers/dbconnection.php';
include 'helpers/authentication.php';

if (!isset($_POST['token'])){
echo json_encode(
    array(
        "success" => false,
        "message" => "You need to Login first!"
    )
    );
}else{
    $token = $_POST['token'];
    $isAdmin = isAdmin($token);
    if(!$isAdmin){
        echo json_encode(
            array(
                "success" => false,
                "message" => "You are not Admin"
            )
            );
            die;
    }
    global $conn;
    $sql = 'SELECT sum(total) as total_income from orders where status="paid"';
    $result = mysqli_query($conn,$sql);
    $row = mysqli_fetch_assoc($result);
    $total_income = $row['total_income'];

    $sql = 'SELECT count(*) as total_users from user';
    $result = mysqli_query($conn,$sql);
    $row = mysqli_fetch_assoc($result);
    $total_users = $row['total_users'];

    $sql = 'SELECT count(*) as total_orders from orders';
    $result = mysqli_query($conn,$sql);
    $row = mysqli_fetch_assoc($result);
    $total_orders = $row['total_orders'];

    $sql = 'SELECT count(*) as total_products from product';
    $result = mysqli_query($conn,$sql);
    $row = mysqli_fetch_assoc($result);
    $total_products = $row['total_products'];
    if($result){
       
        echo json_encode(
           array(
            "success" => true,
            "message" => "Stats fetched",
            "data" => array(
                "total_income" =>$total_income,
                "total_users" => $total_users,
                "total_orders" => $total_orders,
                "total_products" => $total_products
            )
           )
           );
    }else{
        echo json_encode(
            array(
             "success" => false,
             "message" => "Fetching total income failed!"
            )
            ); 
    }
}