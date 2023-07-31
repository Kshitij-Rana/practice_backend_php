<?php
function getUserId($token){
 global $conn;
 $sql = "SELECT * FROM `personal_acess_token` WHERE token = '$token'";
 $result = mysqli_query($conn, $sql);
 $num = mysqli_num_rows($result);
 
 if ($num == 0){
    return null;
 }else{
    $row = mysqli_fetch_assoc($result);
    

    return $row['user_id'];
 }
}
function isAdmin($token){
    $userId = getUserId($token);
    global $conn;
    $sql = "Select * from user where user_id = '$userId'";
    $result = mysqli_query($conn,$sql);
    if($result){
        $row = mysqli_fetch_assoc($result);
        if ($row['role'] == 'admin'){
            return true;
        }else{
            return false;
        }
    }else{
        return false;
    }
}