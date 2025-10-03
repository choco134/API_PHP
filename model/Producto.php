<?php
require_once("../config/conexion.php");
class Producto extends Conectar{

    public function get_productos(){
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM productos WHERE est = 1";
        $sql = $conectar->prepare($sql);
        $sql->execute();
        return $resultado = $sql->fetchAll(PDO::FETCH_ASSOC);
    }
    public function get_productos_por_categoria($cat_id){
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM productos WHERE est = 1 AND cat_id = ?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $cat_id);
        $sql->execute();
        return $resultado = $sql->fetchAll(PDO::FETCH_ASSOC);
    }
    
    public function get_producto_x_id($cat_id){
        $conectar = parent::conexion();
        parent::set_names();
        $sql = "SELECT * FROM productos WHERE est = 1 AND prod_id = ?";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $cat_id);
        $sql->execute();
        return $resultado = $sql->fetchAll(PDO::FETCH_ASSOC);
    }

    public function insert_producto($prod_nom,$prod_desc,$prod_precio,$cat_id){
        $conectar = parent::conexion();
        parent::set_names();

        $sql = "INSERT INTO productos (prod_id, prod_nom, prod_desc,prod_precio,cat_id, est) VALUES (NULL, ?,?,?, ?, '1');";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $prod_nom);
        $sql->bindValue(2, $prod_desc);
        $sql->bindValue(3, $prod_precio);
        $sql->bindValue(4, $cat_id);
        $sql->execute();
        return $resultado = $sql->fetchAll(PDO::FETCH_ASSOC);
    }

    public function update_producto($prod_id, $prod_nom,$prod_desc,$prod_precio,$cat_id){
        $conectar = parent::conexion();
        parent::set_names();

        $sql = "UPDATE productos SET prod_nom = ?, prod_desc = ?,prod_precio = ?,cat_id = ? WHERE prod_id = ?;";
        $sql = $conectar->prepare($sql);
        $sql->bindValue(1, $prod_nom);
        $sql->bindValue(2, $prod_desc);
        $sql->bindValue(3, $prod_precio);
        $sql->bindValue(4, $cat_id);
        $sql->bindValue(5, $prod_id);
        $sql->execute();
        return $resultado = $sql->fetchAll(PDO::FETCH_ASSOC);
    }

    public function delete_producto($prod_id){
    $conectar = parent::conexion();
    parent::set_names();

    $sql = "UPDATE productos SET est = 0 WHERE prod_id = ?";
    $sql = $conectar->prepare($sql);
    $sql->bindValue(1, $prod_id);
    $sql->execute();
    return $resultado = $sql->fetchAll(PDO::FETCH_ASSOC);
    }
}
?>