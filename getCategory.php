<?php
include './helpers/dbconnection.php';
global $conn;
$sql = "SELECT * FROM `category` ";
$result = mysqli_query($conn, $sql);
$category =[]; 
    while($response = mysqli_fetch_assoc($result)){
        $category[] = $response;
    }
if($result){
    
    echo json_encode(array(
        "success" => true,
        "message" => "Categories fetched successfully",
        "data" => $category,
    ));
}else{
    echo json_encode(
        array(
            "success" => false,
            "message" => "Something went wrong"
        )
        );
}

?>