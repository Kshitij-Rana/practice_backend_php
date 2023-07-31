<?php
include './helpers/dbconnection.php';
include './helpers/authentication.php';
if(
    isset($_POST['title']) && isset($_POST['category']) && isset($_POST['price']) && isset($_POST['description']) && $_POST['image'] && isset($_POST['token'])
){
    global $conn;
    
    $title = $_POST['title'];
    $category = $_POST['category'];
    $price = $_POST['price'];
    $description = $_POST['description'];
    $token = $_POST['token'];

    $checkAdmin = isAdmin($token);

    if(!$checkAdmin){
        echo json_encode(
            array(
                "success" => false,
                "message" => "You are not authorized!"
            )
            );
            die();
    }
    $image_name = $_FILES['image']['name'];
    $image_tmp_name = $_FILES['image']['tmp_name'];
    $image_size = $_FILES['image']['size'];

    if($image_size > 5000000){
        echo json_encode(
            array(
                "success" => false,
                "message" => "Image size must be less than 5MB!"
            )
            );
            die();
    }
    $image_new_name = time() . '_' . $image_name;
    $upload_path = 'images/' . $image_new_name; 

    if(!move_uploaded_file($image_tmp_name,$upload_path)){
        echo json_encode(
            array(
                "success" => false,
                "message" => "Image upload failed"
            )
            );
            die();

    }

    $sql = "INSERT INTO `product`(`title`, `category`, `description`, `price`,`image`) VALUES ('$title','$category','$description','$price','$upload_path')";
    $result = mysqli_query($conn,$sql);

    if($result){
        echo json_encode(
            array(
                "success" => true,
                "message" => "Product added successfully!"
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
            "message" => "Please fill all the fields",
            "required fields" => "token, title,description,price,category,image"
        )
    );
}

?>
