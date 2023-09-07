<?php
include 'helpers/dbconnection.php';
include 'helpers/authentication.php';
if (!isset($_POST['token'])){
    echo json_encode(
        array(
            "success" => false,
            "message" => "You are not authorized!"
        )
        );
        die();
}
global $conn;

$token = $_POST['token'];
$isAdmin = isAdmin($token);
$userId = getUserId($token);
$sql= '';
if($isAdmin){
    $sql = "SELECT orders . *, email , full_name from orders join user on user.user_id = orders.user_id"; 
}else{
    $sql = "select * from orders where user_id = '$userId'";
}

$result = mysqli_query($conn, $sql);
if($result){
    $order =[];
    while ($row = mysqli_fetch_assoc($result)){
        $order[] = $row; 
    }echo json_encode(
        array(
            "success" => true,
            "message" => "Order fetched successfully",
            "data" => $order
        )
        );
}else{
    echo json_encode(
        array(
            "message" => "Fetching orders failed",
            "success" => false
        )
        );
}
?>