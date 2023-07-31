<?php
function getUserId($token){
   global $conn;
   $sql ="Select * from personal_acess_token where token = '$token'";
   $result = mysqli_query($conn,$sql);
   $num = mysqli_fetch_assoc($result);
   if($num == 0){
    return null;
   } else{
    $row = mysqli_fetch_assoc($result);
    return $row['token'];
   }

}


function isAdmin($token){
    global $conn;
    $userId = getUserId($token);
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
?>