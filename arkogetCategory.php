<?php
include './helpers/dbconnection.php';
global $conn;
$sql = "Select * from category";
$result = mysqli_query($conn, $sql);
$category =[];
while($row = mysqli_fetch_assoc($result)){
    $category = $row;
}
if($result){
  
    echo json_encode(
        array(
            "success" => true,
            "message" => "Category fetched successfully",
            "data" => $category
        )
        );

}else{
    echo json_encode(
        array(
            "success" => false,
            "message" => "Something went wrong."
        )
    );
}
?>