<?php

include_once "./DB_class.php";

class model_user
{
    // post
    function create($data)
    {
        $DB = new DB;
        $result = [];
        $array['lectura']=$data->lectura;
        // $array['nombre'] = $data->nombre;
        // $array['apellido_paterno'] = $data->apellido_paterno;
        // $array['apellido_materno'] = $data->apellido_materno;
        // $array['email'] = $data->email;
        // $array['password'] = md5($data->password);
        // $array['perfil'] = $data->perfil;
        try {
            //intentamos insertar en la tabla
            $result = $DB->insert($array, 'log');
        } catch (\Throwable $th) {
            $result = ["error" => true];
        }

        return $result;
    }

    function get_all()
    {
        $DB = new DB;
        $result = [];
        $sql = "SELECT * FROM tbl_usuarios";
        try {
            $result = $DB->getAll($sql);
        } catch (\Throwable $th) {
            $result = ["error" => true];
        }
        return $result;
    }

    function get_only($id_usuario)
    {
        $DB = new DB;
        $result = [];
        $sql = "SELECT * FROM tbl_usuarios WHERE id_usuario = '$id_usuario'";
        try {
            $result = $DB->getAll($sql);
        } catch (\Throwable $th) {
            $result = ["error" => true];
        }
        return $result;
    }

    function update($data)
    {
        $DB = new DB;
        $result = [];
        $array['nombre'] = $data->nombre;
        $array['apellido_paterno'] = $data->apellido_paterno;
        $array['apellido_materno'] = $data->apellido_materno;
        $array['email'] = $data->email;
        $array['password'] = md5($data->password);
        $array['perfil'] = $data->perfil;
        $q_where = "id_usuario = {$data->id_usuario}";
        try {
            $result = $DB->update($array, 'tbl_usuarios', $q_where);
        } catch (\Throwable $th) {
            $result = ["error" => true];
        }
        return $result;
    }

    function delete($data)
    {
        $DB = new DB;
        $result = [];
        $array['activo'] = $data->activo;
        $q_where = "id_usuario = {$data->id_usuario}";
        try {
            $result = $DB->update($array, 'tbl_usuarios', $q_where);
        } catch (\Throwable $th) {
            $result = ["error" => true];
        }
        return $result;
    }
}
