<?php
include 'helpers/dbconnection.php';
include 'helpers/Authentication.php';

global $conn;

// if(isset($_POST['token'])){
//     $token = $_POST['token'];
//     $userId=getUserId($token);
//     if(!$userId){
//         echo json_encode(
//             array(
//                 "success" => false,
//                 "message" => "Invalid token"
//             )
//             );
//             die;
//     }
if(!isset($_POST['token'])){
    echo json_encode(
        array(
            "success" => false,
            "message" => "Invalid token"
        )
        );
        die;
}
    if(!isset($_POST['order_id'])||!isset($_POST['amount'])|| !isset($_POST['other_data'])){
       echo json_encode(
        array(
            'success' => false,
            'message' => 'Order Id, amount and other data is required'
        )
        );
        die;
    }
    global $conn;
    $token = $_POST['token'];
    $order_id = $_POST['order_id'];
    $amount = $_POST['amount'];
    $other_data = $_POST['other_data'];
    $userId = getUserId($token);

    $sql = "INSERT into payment(user_id,order_id,amount,other_data) values ('$userId','$order_id','$amount','$other_data')";
    $result = mysqli_query($conn, $sql);
    
   if($result){
    $sql = "UPDATE orders set status = 'paid' where order_id = '$order_id'";
    $result = mysqli_query($conn, $sql);
    if($result){
        echo json_encode(
            array(
                "success" => true,
                "message" => "Payment added successfully"
            )
            );
    }else{
        echo json_encode(
            array(
                "success" => false,
                "message" => "Updating order status failed"
            )
            );
    }
   }else{
    echo json_encode(
        array(
            "success" => false,
            "message" => "Creating payment failed!".mysqli_error($conn)
            )
        
        );
   }



?>