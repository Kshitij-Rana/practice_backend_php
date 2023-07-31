<?php
include './helpers/dbconnection.php';
global $conn;
$sql = "SELECT * FROM `category` ";
$result = mysqli_query($conn, $sql);

if($result){
    $category =[];
    while($response = mysqli_fetch_assoc($result)){
        $category = $response;
    }
    echo json_encode(array(
        "status" => true,
        "message" => "Categories getched successfully",
        "data" => $category,
    ));
}else{
    echo json_encode(
        array(
            "status" => false,
            "message" => "Something went wrong"
        )
        );
}

?>