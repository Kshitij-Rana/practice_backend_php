<?php
include '../helpers/dbconnection.php';
include '../helpers/Authentication.php';

if(!isset($_POST['token'])){
    echo json_encode(array(
        "success" => false,
        "message" => "Token is required!"
    ));
}
$token =$_POST['token'];
$isAdmin = isAdmin($token);

if(!$isAdmin){
    echo json_encode(
        array(
            "success" => false,
            "message" => "You are not authorized.You are not admin!"
        )
        );
}
if(isset($_POST['full_name']) && isset($_POST['email']) && $_POST['password']){
    global $conn;
    $email = $_POST['email'];
    $fullname = $_POST['full_name'];
    $password = $_POST['password'];

    $sql = "select * from users where email = '$email'";
    $result = mysqli_query($conn,$sql);
    $num = mysqli_num_rows($result);
    if($num > 0){
        echo json_encode(
            array(
                "success" => false,
                "message" => "Email address already exists!"
            )
            );
            return;
    }else{
        $hash_password = password_hash($password,PASSWORD_DEFAULT);
        $sql = "insert into user (full_name,email,password,role) values('$fullname','$email','$hash_password','admin')";
        $result = mysqli_query($conn,$sql);
        if($result){
            echo json_encode(array(
                "success" => true,
                "message" => "User Registered!"
            ));
        }else{
            echo json_encode(
                array(
                    "success" => false,
                    "message" => "Admin add garda bigriyo".mysqli_error($conn)
                )
                );
        }
    }

} else {
    echo json_encode(
        array(
            "success" => false,
            "message" => "Please fill all the fields!",
            "required fields" => "fullname, email, password"
        )
    );
}
