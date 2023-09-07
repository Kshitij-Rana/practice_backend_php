<?php
include 'helpers/dbconnection.php';
include 'helpers/authentication.php';
if(!isset($_POST['token'])){
    echo json_encode(
        array(
            "success" => false,
            "message" => "You should login first!"
        )
        );
        die;
}
if(!isset($_POST['cart']) || !isset($_POST['total'])){
    echo json_encode(
        array(
            "success" => false,
            "message" => "Cart and total are needed!"
        )
        );
        die;
}
global $conn;
$token = $_POST['token'];
$cart = $_POST['cart'];
$userId = getUserId($token);
$total = $_POST['total'];

$sql = "insert into orders(user_id,total)values('$userId','$total')";
$result = mysqli_query($conn,$sql);
if($result){
    $orderId = mysqli_insert_id($conn);
    $cartlist = json_decode($cart);
    foreach($cartlist as $cartItem){
        $product = $cartItem -> product;
        $productid = $product -> product_id;
        $quantity = $cartItem -> quantity;
        $price = $cartItem -> price;
        $line_total = $quantity * $price;
        $sql = "insert into order_details(order_id,product_id,quantity,line_total)values('$orderId','$productid','$quantity','$line_total')";
        $result = mysqli_query($conn,$sql);
    }
    echo json_encode(
        array(
            "success" => true,
            "message" => "Orders added successfully!"
        )
        );
}
?>