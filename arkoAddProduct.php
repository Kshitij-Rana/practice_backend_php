<?php
include './helpers/dbconnection.php';
include './helpers/authentication.php';

global $conn;
if(
    isset($_POST['title']) && isset($_POST['category']) && isset($_POST['description']) && isset($_POST['price']) && isset($_POST['token']) && $_FILES['image']
){
    $title = $_POST['title'];
    $category = $_POST['category'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $token = $_POST['token'];
    $image = $_FILES['image']['name'];
    $image_tmp_name = $_FILES['image']['tmp_name'];
    $image_size = $_FILES['image']['size'];

    $checkAdmin = isAdmin($token);
    if (!$checkAdmin){
        echo json_encode(
            array(
                "success" => false,
                "message" => "You are not authorized to add product."
            )
            );
            die();
    }
    if($image_size > 5000000){
        echo json_encode(
            array(
                "success" => false,
                "message" => "Sorry! You cannot upload file which size is more than 5MB"
            )
        );
        die();
    }
    $image_new_name = time() . "_" . $image;
    $upload_path = 'images/' . $image_new_name;

    if(!move_uploaded_file($image_tmp_name,$upload_path)){
        echo json_encode(
            array(
                "success" => false,
                "message" => "Image not uploaded. Some issues found"
            )
            );
            die();
    }
    $sql = "INSERT INTO `product`(`title`, `category`, `description`, `price`,`image`) VALUES ('$title','$category','$description','$price','$upload_path')";
    $result = mysqli_query($conn , $sql);

    if($result){
        echo json_encode(
            array(
                "success" => true,
                "message" => "Product added successfully"
            )
        );
    }else{
        echo json_encode(
            array(
                "success" => false,
                "message" => "Something went wrong"
            )
            );
    }
}else{
    echo json_encode(
        array(
            "success" => false,
            "message" => "Please enter all the fields",
            "required fields" => "token,title,description,category,price,image"
        )
        );
}

?>
