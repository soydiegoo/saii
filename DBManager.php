<?php


class DBManager {

  /**
  * Gestiona la conexión con la base de datos
  */

  private $dbhost = 'localhost';

  private $dbuser = 'root';

  private $dbpass = '';

  private $dbname = 'arduino_2';

  public function conexion () {

  /**
  * @return object link_id con la conexión
  */

  $link_id = new mysqli($this->dbhost,$this->dbuser,$this->dbpass,$this->dbname);

    if ($link_id->connect_error) {

      $arrayError = array("error1"=>($link_id->connect_errno),
                        "error2"=>$link_id->connect_error);
      $error = json_encode($arrayError);
      //echo "Error de Connexion ($link_id->connect_errno) $link_id->connect_error\n";

      header('Location: error_conexion.php?error='.$error);

      //exit;

    } else {
      //echo "Conectado";
      return $link_id;

    }

  }


} ?>
