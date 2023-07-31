<?php
$servername = "localhost";
$username= "root";
$password = "";
$database = "database_practice";

//creating connection
$conn = mysqli_connect("$servername","$username","$password","$database");
//checking connection to mysql
if(!$conn){
	die("Connection failed.".mysqli_connect_error());

}

?>