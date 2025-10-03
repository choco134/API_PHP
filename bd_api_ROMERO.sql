CREATE DATABASE bd_api_ROMERO;
USE bd_api_ROMERO;

CREATE TABLE categorias(
    cat_id INT PRIMARY KEY AUTO_INCREMENT,
    cat_nombre VARCHAR(50) NOT NULL,
    cat_obs VARCHAR(200) NOT NULL,
    est INT NOT NULL
)ENGINE=InnoDB;

INSERT INTO categorias(cat_nombre, cat_obs, est)VALUES
('televisores', 'observacion tv',1),
('refrigeradores', 'observacion refrigerador',1),
('laptos','obervacion laptop',1),
('microondas','observacion microondas',1);

CREATE TABLE productos(
    prod_id INT(11) NOT NULL AUTO_INCREMENT,
    prod_nom VARCHAR(250) NOT NULL,
    prod_desc VARCHAR(250) NOT NULL,
    prod_precio DECIMAL(10,2) NOT NULL,
    cat_id INT(11)  NOT NULL,
    est INT(11) NOT NULL,
    PRIMARY KEY (prod_id),
    FOREIGN KEY (cat_id) REFERENCES categorias(cat_id)  
)ENGINE=InnoDB;

INSERT INTO productos(prod_nom,prod_desc,prod_precio,cat_id,est)VALUES
('Smart TV 50" 4k','televisor de alta definicion con tecnologia Smart TV',450.00,1,1),
('Refrigerador No Frost 300L"','Refrigerador con congelador y sistema de enfriamiento No Frost',600.00,2,1),
('Laptop Gaming 16GB RAM','Portatil de alto rendimineto para juegos y tareas exigentes',980.00,3,1),
('Microondas de 20L','Microondas con panel digital y multiples funciones preestablecidas',85.00,4,1),
('Refrigerador Mini bar','Refrigerador compacto ideal para espacios pequeños',150.00,2,1);
