<?php
header('Content-Type: application/json');
require_once ('../config/conexion.php');
require_once ('../model/Producto.php');

$categoria = new Producto();

$body = json_decode(file_get_contents("php://input"), true);

switch ($_GET["op"]){
    case "GetAll":
        $datos = $categoria->get_productos();
        echo json_encode($datos);
    break;
    case "GetId":
        $datos = $categoria->get_producto_x_id($body["prod_id"]);
        echo json_encode($datos);
        break;
    case "GetxCat":
        $datos = $categoria->get_productos_por_categoria($body["cat_id"]);
        echo json_encode($datos);
        break;
    case "Insert":
        $datos = $categoria->insert_producto($body["prod_nom"], $body["prod_desc"], $body["prod_precio"], $body["cat_id"]);
        echo json_encode("Producto Agregado");
        break;
    case "Update":
        $datos = $categoria->update_producto($body["prod_id"], $body["prod_nom"], $body["prod_desc"], $body["prod_precio"], $body["cat_id"]);
        echo json_encode("Producto Actualizado");
        break;
    case "Delete":
        $datos = $categoria->delete_producto($body["prod_id"]);
        echo json_encode("Producto Eliminada");
        break;
}
?>