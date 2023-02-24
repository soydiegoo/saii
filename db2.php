<?php
namespace db; 
use mysqli;

header('Access-Control-Allow-Origin: *'); 
header('Content-Type: application/json');


class db{//Declaramos la clase en php
    static $host ="localhost";
    static $dbname ="arduino_1";
    //static $dbname ="db_angularsistemasa";
    static $username ="root";
    static $password ="";

    public static function connect(){ //creamos un metodo estatico y le agregamos un nombre 
        return new mysqli(
            self::$host,
            self::$username,
            self::$password, 
            self::$dbname
        );//CONEXION A LA BASE DE DATOS MEDIANTE EL METODO
    }
    public static function query($query){
        $results = []; //Arreglo donde se guarda
        $db = self::connect();
        $result = $db->query($query);
        
        if (!is_bool($result)){
            while($row = $result->fetch_object()){ //recorrido a result, SI LA VARIABLE ROW ES IGIUAL AL RESULT EJECUTA EL QUERY , Y EXTRAME COMO OBJETOS LA CONSULTA.
                $results[] = $row;//CONSULTO
            }
            return $results;//RETORNO
        }else{
            return $result;
        }
        $db->close();//CIERRO 

    }
    public static function insertGen($response){
        $tabla = $response['tabla'];
        unset($response['tabla']);

        $keys = array_keys($response);
        $values = array_values($response);
    
        $campos = '';
        $valores = '';
    
        for($i = 0; $i < count($keys); $i++){
            if(!$i == 0){
                $campos = $campos.', '.$keys[$i];  
                $valores = $valores.", '".$values[$i]."'"; 
            }else{
                $campos = $campos.' '.$keys[$i];  
                $valores = $valores."'".$values[$i]."'"; 
            }
            
        }
        $query = 'INSERT INTO '.$tabla.' ('.$campos.') VALUES ('.$valores.')';
        return self::query($query);
        
    }
    public static function updateGen($response){
        $tabla = $response['tabla'];
        unset($response['tabla']);

        $id = $response['id'];
        unset($response['id']);

        $keys = array_keys($response);
        $values = array_values($response);
    
        $set = '';
    
        for($i = 0; $i < count($keys); $i++){
            if(!$i == 0){
                $set = $set.', '.$keys[$i]." = '".$values[$i]."'";  
            }else{
                $set = $set.' '.$keys[$i]. " = '".$values[$i]."'";  
            }
            
        }
        $query = 'UPDATE '.$tabla.' SET '.$set.' WHERE id_Municipio ='.$id;
        return self::query($query);
    }
    public static function deleteGen($response){
        $tabla = $response['tabla'];
        unset($response['tabla']);

        $id = $response['id'];
        unset($response['id']);

        $query = 'DELETE FROM '.$tabla.' WHERE id_municipio ='.$id;
        return self::query($query);
    }
    function begin(){
        if($this->con == true){
          mysqli_query($this->con, "BEGIN");
        }
    }
    function commit(){
        if($this->con == true){
          mysqli_query($this->con, "COMMIT");
        }
      }
      function rollback(){
        if($this->con == true){
          mysqli_query($this->con, "ROLLBACK");
        }
      }
}
