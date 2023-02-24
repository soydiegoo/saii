<?php
require_once "config/db2.php";
use DB\db as db;
$tarjeta = $_POST['value'];
$query = "SELECT 1 FROM tbl_usuarios WHERE `idtarjeta` = '$tarjeta'";
$result = db::query($query);

if (!isset ($result[0])){
    $query = "INSERT INTO `tbl_log` (`clave`, `status_acces`) VALUES ('{$tarjeta}',0)";
    $result = db::query($query);
    //echo json_encode($query);
    $data=['success'=> 'n'];
} else{
    $query = "INSERT INTO `tbl_log` (`clave`, `status_acces`) VALUES ('{$tarjeta}',1)";
    $result = db::query($query);
    //echo json_encode($query);
    $data=['success'=> 's'];
} 
//echo json_encode($_POST);
/*if(! $result){
    $data=['success'=>'x'];
} else {
    $data=['success'=>'y'];
}*/
echo json_encode($data);


?>