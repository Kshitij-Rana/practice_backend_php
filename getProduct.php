<?php
include './helpers/dbconnection.php';
global $conn;
$sql = "Select * from product join category on category.category_id = product.category ";
$result = mysqli_query($conn, $sql);
$products = [];
while ($response = mysqli_fetch_assoc($result)) {
    $products[] = $response;
}
if ($result) {
    echo json_encode(
        array(
            "success" => true,
            "message" => "Products fetched successfully",
            "data" => $products
        )
    );
} else {
    echo json_encode(
        array(
            "success" => false,
            "message" => "Something went wrong"
        )
    );
}

?>