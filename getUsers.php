<?php
include 'helpers/dbconnection.php';
include 'helpers/Authentication.php';
if(
    isset($_POST['token'])){
        $token = $_POST['token'];
        $isAdmin = isAdmin($token);

        if(!$isAdmin){
            echo json_encode(
                array(
                    "success" => false,
                    "message" => "You are not authorized"
                )
                ); die;
        }
        global $conn;
        $sql = "select user_id,full_name,email from user";
        $result = mysqli_query($conn,$sql);
        if($result){
            $users=[];
            echo json_encode(
                array(
                    "success" => true,
                    "message" => "Users fetched successfully",
                    "data" => $users
                )
                );
        }else{
            echo json_encode(
                array(
                    "success" => false,
                    "message" => "Fetching users failed"
                )
                );
        }
        
    }else{
        echo json_encode(
            array(
                "success" => false,
                "message" => "Token required"
            )
            );
    }