<?php
include './helpers/dbconnection.php';
include './helpers/Authentication.php';

if(isset($_POST['category_title']) && isset($_POST['token'])){

global $conn;//uta ko function tancha
$title=$_POST['category_title'];
$token=$_POST['token'];
$checkAdmin = isAdmin($token);
if (!$checkAdmin){
    echo json_encode(
        array(
            "success" => false,
            "message" => "You are not authorized."
        )
        );
        die();
}

$sql = "Select * from category where title = '$title'";//query lagako
$result = mysqli_query($conn,$sql);
$num = mysqli_num_rows($result);

if($num > 0 ){
    echo json_encode(
        array(
            "success" =>false,
            "message" =>"Category title already exists!"
        )
    );
    return;
}else{
    $Query = "INSERT INTO `category`( `category_title`) VALUES ('$title')";
    $result = mysqli_query($conn,$Query);
    if($result){
        echo json_encode(
            array(
                "message" =>"Category added!",
                "success" => true,
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


}
}
?>