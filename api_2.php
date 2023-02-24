<?php
header('Access-Control-Allow-Origin: *'); 
header('Content-Type: application/json');
include_once "usuarios.php";
include_once "DB_class.php";
$response = file_get_contents("php://input");
$data= json_decode($response);


$modelo = new model_user;
$resultado = [];


$_metodo = $_SERVER['REQUEST_METHOD'];


switch($_metodo){
    case 'GET':
        $_ID = $_GET['id'];
        $_Nombre = $_GET ['nombre'];
        echo ":: ",$_metodo ."  id ::" . $_ID ."  nombre ::" . $_Nombre;

        //$resultado=json_encode($modelo->get_all());
        
        //echo $resultado;
        $db = new DB;
        $sqlQuery = "SELECT * FROM tbl_usuarios";
        $data = $db->getAll($sqlQuery);
        echo json_encode($data);

        break;
    case 'POST':
        $db = new DB;
        $lel['lectura']=$data->lectura;
        //C22A2A1B
        $query = "SELECT 1 FROM cards WHERE `tarjeta` ='$lel'";
        //echo ":::::". $_metodo;
        //echo "---->" .$data->nombre;
        //invocar el insert $ data
        $ejemplo = json_encode($_POST["lectura"]);
        $insert['lectura']=$ejemplo;
        //$insert['acceso']=0;
        // $insert['apellido_paterno'] = $data->apellido_paterno;
        // $insert['apellido_materno'] = $data->apellido_materno;
        // $insert['email'] = $data->email;
        // $insert['password'] = md5($data->password);
        // $insert['perfil'] = $data->perfil;
      //  echo json_encode($data->value);
        //echo json_encode($insert);
        //$auxiliar = json_encode($_POST["value"]);
     //   echo json_encode($_POST);

        $ejemplo = json_encode($_POST["lectura"]);

        //echo $ejemplo;
        
       // echo json_encode($response["lectura"]);
        

        //$result = $db->insert($insert,'log');
        $comprobacion = $db->execQuery($query);
        echo json_encode($query);

        echo json_encode($comprobacion);

        if ($comprobacion[0]){
            // $query2 = "INSERT INTO `tbl_log` (`clave`, `status_acces`) VALUES ('{$tarjeta}',0)";
            // $result2 = $db->execQuery($query2);
            //echo json_encode($query);
            $insert['acceso']=0;
            $insert['lectura']=$data->lectura;
            $result = $db->insert($insert,'log');
            $data=['success'=> 'n'];
            echo json_encode($data);
        } else{
            // $query2 = "INSERT INTO `tbl_log` (`clave`, `status_acces`) VALUES ('{$tarjeta}',1)";
            // $result2 = $db->execQuery($query2);
            //echo json_encode($query);
            $insert['acceso']=1;
            $insert['lectura']=$data->lectura;
            $result = $db->insert($insert,'log');
            $data=['success'=> 's'];
            echo json_encode($data);
        }

        echo json_encode($result);
        break;

    case 'PUT':
        echo ":::::". $_metodo;
        echo "---->" .$data->nombre;
    break;

    case 'DELETE':
        echo ":::::". $_metodo;
        echo "---->" .$data->nombre;
    break;

    default:
        echo json_encode("INVALID_RESPONSE_METHOD");
        break;
}