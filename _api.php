<?php

include_once "usuarios.php";

$postdata = file_get_contents("php://input");
$request = json_decode($postdata);

$u_model = new model_user;
$result = [];

switch ($_SERVER['REQUEST_METHOD']) {
    case 'GET':
        if (isset($_GET['id'])) {
            $user_id = $_GET['id'];
            $result = $u_model->get_only($user_id);
        } else {
            $result = $u_model->get_all();
        }
        echo json_encode(["GET" => $result]);
        break;

    case 'POST':
        $result = $u_model->create($request);
        echo json_encode(["POST" => $result]);
        //echo json_encode($request);
        break;

    case 'PUT':
        $result = $u_model->update($request);
        echo json_encode(["PUT" => $result]);
        break;

    case 'DELETE':
        $result = $u_model->delete($request);
        echo json_encode(["DELET" => $result]);
        break;

    default:
        echo json_encode("INVALID_RESPONSE_METHOD");
        break;
}
