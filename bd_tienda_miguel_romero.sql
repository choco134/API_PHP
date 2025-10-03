CREATE DATABASE bd_proyecto;

CREATE TABLE tienda(
    id_tienda INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    direccion VARCHAR(45) NOT NULL,
    logo_tienda VARCHAR(50),
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_tienda)
)ENGINE=INNODB;


CREATE TABLE tipo_instrumento (
    id_tipo_instrumento INT AUTO_INCREMENT NOT NULL,
    tipo VARCHAR(25) NOT NULL, -- Ej: 'Cuerda', 'Viento', etc.
    descripcion VARCHAR(50),
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_tipo_instrumento)
) ENGINE=INNODB;

CREATE TABLE instrumentos(
    id_instrumento INT AUTO_INCREMENT NOT NULL,
    id_tipo_instrumento INT NOT NULL,
    nombre_instrumento VARCHAR(30) NOT NULL,
    descripcion VARCHAR(50),
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_instrumento),
    FOREIGN KEY (id_tipo_instrumento) REFERENCES tipo_instrumento(id_tipo_instrumento)
) ENGINE=INNODB;


CREATE TABLE instrument_musicales(
    id_instrument_musical INT AUTO_INCREMENT NOT NULL,
    id_instrumento INT NOT NULL,
    id_tienda INT NOT NULL,
    marca VARCHAR(20) NOT NULL,
    modelo VARCHAR(30) NOT NULL,
    color CHAR(15) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY(id_instrument_musical),
    FOREIGN KEY(id_instrumento) REFERENCES instrumentos(id_instrumento),
    FOREIGN KEY(id_tienda) REFERENCES tienda(id_tienda)
)ENGINE=INNODB;

CREATE TABLE precio_instrumentos(
    id_precio_instrumento INT AUTO_INCREMENT NOT NULL, 
    id_instrument_musical INT NOT NULL,
    fec_asignacion DATE NOT NULL,
    precio_c FLOAT NOT NULL,
    precio_v FLOAT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_precio_instrumento),
    FOREIGN KEY (id_instrument_musical) REFERENCES instrument_musicales(id_instrument_musical)
)ENGINE=INNODB;

CREATE TABLE empleados(
    id_empleado INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    ap CHAR(15),
    am CHAR(15),
    fec_ini DATE NOT NULL,
    fec_fin DATE,
    sueldo FLOAT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_empleado)
)ENGINE=INNODB;

CREATE TABLE clientes(
    id_cliente INT AUTO_INCREMENT NOT NULL,
    id_tienda INT NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    ap CHAR(15),
    am CHAR(15),
    ci VARCHAR(20) NOT NULL,
    direccion VARCHAR(45),
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (id_tienda) REFERENCES tienda(id_tienda)
)ENGINE=INNODB;

CREATE TABLE ventas(
    id_venta INT AUTO_INCREMENT NOT NULL,
    id_empleado INT NOT NULL,
    id_cliente INT NOT NULL,
    fec_venta DATE NOT NULL,
    monto_total FLOAT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_venta),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
)ENGINE=INNODB;

CREATE TABLE detalles_ventas(
    id_detalle_venta INT AUTO_INCREMENT NOT NULL,
    id_venta INT NOT NULL,
    id_precio_instrumento INT NOT NULL,
    cantidad INT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_detalle_venta),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_precio_instrumento) REFERENCES precio_instrumentos(id_precio_instrumento)
)ENGINE=INNODB;


CREATE TABLE proveedores(
    id_proveedor INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    ap VARCHAR(25),
    am VARCHAR(25),
    direccion VARCHAR(45),
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_proveedor)
)ENGINE=INNODB;

CREATE TABLE compras(
    id_compra INT AUTO_INCREMENT NOT NULL,
    id_proveedor INT NOT NULL,
    fec_compra DATE NOT NULL,
    monto_total FLOAT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_compra),
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
)ENGINE=INNODB;

CREATE TABLE detalles_compras(
    id_detalle_compra INT AUTO_INCREMENT NOT NULL,
    id_compra INT NOT NULL,
    id_instrument_musical INT NOT NULL,
    cantidad INT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_detalle_compra),
    FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
    FOREIGN KEY (id_instrument_musical) REFERENCES instrument_musicales(id_instrument_musical)
)ENGINE=INNODB;

CREATE TABLE inventario(
    id_inventario INT AUTO_INCREMENT NOT NULL,
    id_detalle_venta INT NOT NULL,
    id_detalle_compra INT NOT NULL,
    id_instrument_musical INT NOT NULL,
    cantidad_instrumentos INT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_inventario),
    FOREIGN KEY (id_detalle_venta) REFERENCES detalles_ventas(id_detalle_venta),
    FOREIGN KEY (id_detalle_compra) REFERENCES detalles_compras(id_detalle_compra),
    FOREIGN KEY (id_instrument_musical) REFERENCES instrument_musicales(id_instrument_musical)
)ENGINE=INNODB;

CREATE TABLE ofertas(
    id_oferta INT AUTO_INCREMENT NOT NULL,
    id_tienda INT NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    descripcion VARCHAR(40),
    inicio_fecha DATE NOT NULL,
    fin_fecha DATE NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_oferta),
    FOREIGN KEY (id_tienda) REFERENCES tienda(id_tienda)
)ENGINE=INNODB;

CREATE TABLE personas(
    id_persona INT AUTO_INCREMENT NOT NULL,
    id_tienda INT NOT NULL,
    nombres VARCHAR(25) NOT NULL,
    ap VARCHAR(15),
    am VARCHAR(15),
    ci VARCHAR(20),
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(40) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_persona),
    FOREIGN KEY (id_tienda) REFERENCES tienda(id_tienda)
)ENGINE=INNODB;

CREATE TABLE grupos(
    id_grupo INT AUTO_INCREMENT NOT NULL,
    grupo VARCHAR(30) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_grupo)
)ENGINE=INNODB;

CREATE TABLE opciones(
    id_opcion INT AUTO_INCREMENT NOT NULL,
    id_grupo INT NOT NULL,
    opcion VARCHAR(20) NOT NULL,
    contenido VARCHAR(80) NOT NULL,
    orden INT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_opcion),
    FOREIGN KEY (id_grupo) REFERENCES grupos(id_grupo)
)ENGINE=INNODB;

CREATE TABLE roles(
    id_rol INT AUTO_INCREMENT NOT NULL,
    rol VARCHAR(25) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_rol)
)ENGINE=INNODB;

CREATE TABLE usuarios(
    id_usuario INT AUTO_INCREMENT NOT NULL,
    id_persona INT NOT NULL,
    usuario2 VARCHAR(20) NOT NULL,
    clave VARCHAR(100) NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_usuario),
    FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
)ENGINE=INNODB;

CREATE TABLE usuarios_roles(
    id_usuario_rol INT AUTO_INCREMENT NOT NULL,
    id_rol INT NOT NULL,
    id_usuario INT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_usuario_rol),
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
)ENGINE=INNODB;

CREATE TABLE accesos(
    id_acceso INT AUTO_INCREMENT NOT NULL,
    id_rol INT NOT NULL,
    id_opcion INT NOT NULL,
    fec_insercion TIMESTAMP NOT NULL,
    fec_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario INT NOT NULL,
    estado CHAR(1) NOT NULL,
    PRIMARY KEY (id_acceso),
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
    FOREIGN KEY (id_opcion) REFERENCES opciones(id_opcion)
)ENGINE=INNODB;


INSERT INTO tienda VALUES(1,'MUSIC STORE','MERCADO CENTRAL','logo_tienda.jpg',now(),now(),1,'A');


INSERT INTO personas VALUES (1,1,'MIGUEL','ROMERO','TEJERINA','123','61854146','B.AEROPUERTO',now(),now(),1,'A');
INSERT INTO personas VALUES (2,1,'JUAN','QUISPE','MAMANI','123','61854146','B.AEROPUERTO',now(),now(),1,'A');
INSERT INTO personas VALUES (3,1,'CRISTIAN','CUELLAR','TEJERINA','123','61854146','B.AEROPUERTO',now(),now(),1,'A');
INSERT INTO personas VALUES (4,1,'LUIS','QUINTALLA','JUAREZ','123','61854146','B.AEROPUERTO',now(),now(),1,'A');
INSERT INTO personas VALUES (5,1,'ALVARO','RODRIGUES','JUSTINIANO','123','61854146','B.AEROPUERTO',now(),now(),1,'A');
INSERT INTO personas VALUES (6,1,'GABRIELA','PEREZ','VELASQUEZ','123','61854146','B.AEROPUERTO',now(),now(),1,'A');
INSERT INTO personas VALUES (7,1,'HUGO','ROMERO','JARAMILLO','123','61854146','B.AEROPUERTO',now(),now(),1,'A');
INSERT INTO personas VALUES (8,1,'ABIGAIL','PRADO','MENDOZA','123','61854146','B.AEROPUERTO',now(),now(),1,'A');

INSERT INTO usuarios VALUES(1,1,'admin','$2y$10$Yl8Kx2R6248xwNAyBaMME.b3z3KscrfmZDv6MS6tCU8xBBrdKg9Qi',now(),now(),1,'A');
INSERT INTO usuarios VALUES(2,2,'admin','$2y$10$Yl8Kx2R6248xwNAyBaMME.b3z3KscrfmZDv6MS6tCU8xBBrdKg9Qi',now(),now(),1,'A');
INSERT INTO usuarios VALUES(3,3,'admin','$2y$10$Yl8Kx2R6248xwNAyBaMME.b3z3KscrfmZDv6MS6tCU8xBBrdKg9Qi',now(),now(),1,'A');
INSERT INTO usuarios VALUES(4,4,'admin','$2y$10$Yl8Kx2R6248xwNAyBaMME.b3z3KscrfmZDv6MS6tCU8xBBrdKg9Qi',now(),now(),1,'A');
INSERT INTO usuarios VALUES(5,5,'admin','$2y$10$Yl8Kx2R6248xwNAyBaMME.b3z3KscrfmZDv6MS6tCU8xBBrdKg9Qi',now(),now(),1,'A');
INSERT INTO usuarios VALUES(6,6,'admin','$2y$10$Yl8Kx2R6248xwNAyBaMME.b3z3KscrfmZDv6MS6tCU8xBBrdKg9Qi',now(),now(),1,'A');
INSERT INTO usuarios VALUES(8,7,'admin','$2y$10$Yl8Kx2R6248xwNAyBaMME.b3z3KscrfmZDv6MS6tCU8xBBrdKg9Qi',now(),now(),1,'A');


INSERT INTO roles VALUES(1,'ADMINISTRADOR',now(),now(),1,'A');

INSERT INTO grupos VALUES(1,'HERRAMIENTAS',now(),now(),1,'A');
INSERT INTO grupos VALUES(2,'TIENDA DE INSTRUMENTOS',now(),now(),1,'A');
INSERT INTO grupos VALUES(3,'REPORTES',now(),now(),1,'A');
INSERT INTO grupos VALUES(4,'PRIMER BIMESTRE',now(),now(),1,'A');
INSERT INTO grupos VALUES(5,'SEGUNDO BIMESTRE-BDII',now(),now(),1,'A');
INSERT INTO grupos VALUES(6,'PARAMETROS',now(),now(),1,'A');
INSERT INTO grupos VALUES(7,'API BINANCE',now(),now(),1,'A');

INSERT INTO usuarios_roles VALUES(1,1,1,now(),now(),1,'A');

INSERT INTO opciones VALUES(1,1,'PERSONAS','../privada/personas/personas.php',10,now(),now(),1,'A');
INSERT INTO opciones VALUES(2,1,'USUARIOS','../privada/usuarios/usuarios.php',20,now(),now(),1,'A');
INSERT INTO opciones VALUES(3,1,'GRUPOS','../grupos/grupos.php',30,now(),now(),1,'A');
INSERT INTO opciones VALUES(4,1,'ROLES','../privada/roles/roles.php',40,now(),now(),1,'A');
INSERT INTO opciones VALUES(5,1,'USUARIOS ROLES','../usuarios_roles/usuarios_roles.php',50,now(),now(),1,'A');
INSERT INTO opciones VALUES(6,1,'OPCIONES','../privada/opciones/opciones.php',60,now(),now(),1,'A');
INSERT INTO opciones VALUES(7,1,'ACCESOS','../accesos/accesos.php',70,now(),now(),1,'A');
INSERT INTO opciones VALUES(8,2,'DATOS TIENDA','../tienda/tienda.php',10,now(),now(),1,'A');
INSERT INTO opciones VALUES(9,2,'instrument_musicales','../privada/instrument_musicales/instrument_musicales.php',20,now(),now(),1,'A');
INSERT INTO opciones VALUES(10,2,'precio_instrumentos','../privada/precio_instrumentos/precio_instrumentos.php',30,now(),now(),1,'A');
INSERT INTO opciones VALUES(11,2,'EMPLEADOS','../privada/empleados/empleados.php',40,now(),now(),1,'A');
INSERT INTO opciones VALUES(12,2,'COMPRAS','../privada/compras/compras.php',50,now(),now(),1,'A');
INSERT INTO opciones VALUES(13,2,'VENTAS','../privada/ventas/ventas.php',60,now(),now(),1,'A');
INSERT INTO opciones VALUES(14,2,'PROVEEDORES','../privada/proveedores/proveedores.php',70,now(),now(),1,'A');
INSERT INTO opciones VALUES(15,2,'CLIENTES','../privada/clientes/clientes.php',80,now(),now(),1,'A');
INSERT INTO opciones VALUES(16,3,'Rpt. Personas con Usuarios','../privada/reportes/personas_usuarios.php',10,now(),now(),1,'A');
INSERT INTO opciones VALUES(17,3,'Rpt de Personas por Fecha','../privada/reportes/personas_fechas.php',20,now(),now(),1,'A');
INSERT INTO opciones VALUES(18,4,'EV. CONTINUA','../privada/pagos/pagos.php',20,now(),now(),1,'A');
INSERT INTO opciones VALUES(19,3,'Rpt. Ventas con Clientes','../privada/reportes/ventas_clientes_empleados.php',10,now(),now(),1,'A');
INSERT INTO opciones VALUES(20,3,'Rpt de Ventas por Fecha','../privada/reportes/ventas_fechas.php',20,now(),now(),1,'A');
INSERT INTO opciones VALUES(21,3,'Reportes Estadisticos','../privada/reportes/reportes_estadisticos.php',20,now(),now(),1,'A');
INSERT INTO opciones VALUES(22,5,'Ev.Continua Reportes Estadisticos','../privada/reportes/reportes_exam.php',20,now(),now(),1,'A');
INSERT INTO opciones VALUES(23,6,'Formulario Dinamico','../privada/formu_dinamicos2/formu.php',20,now(),now(),1,'A');
INSERT INTO opciones VALUES(24,6,'Formu Dina Instrumen','../privada/formu_dina_instrumentos/instrumentos.php',20,now(),now(),1,'A');
INSERT INTO opciones VALUES(25,7,'Api Binance','../privada/api_binance/api_binance.php',20,now(),now(),1,'A');


INSERT INTO accesos VALUES(1,1,1,now(),now(),1,'A'); 
INSERT INTO accesos VALUES(2,1,2,now(),now(),1,'A');
INSERT INTO accesos VALUES(3,1,3,now(),now(),1,'A');
INSERT INTO accesos VALUES(4,1,4,now(),now(),1,'A');
INSERT INTO accesos VALUES(5,1,5,now(),now(),1,'A');
INSERT INTO accesos VALUES(6,1,6,now(),now(),1,'A');
INSERT INTO accesos VALUES(7,1,7,now(),now(),1,'A');
INSERT INTO accesos VALUES(8,1,8,now(),now(),1,'A');
INSERT INTO accesos VALUES(9,1,9,now(),now(),1,'A');
INSERT INTO accesos VALUES(10,1,10,now(),now(),1,'A');
INSERT INTO accesos VALUES(11,1,11,now(),now(),1,'A');
INSERT INTO accesos VALUES(12,1,12,now(),now(),1,'A');
INSERT INTO accesos VALUES(13,1,13,now(),now(),1,'A');
INSERT INTO accesos VALUES(14,1,14,now(),now(),1,'A');
INSERT INTO accesos VALUES(15,1,15,now(),now(),1,'A');
INSERT INTO accesos VALUES(16,1,16,now(),now(),1,'A');
INSERT INTO accesos VALUES(17,1,17,now(),now(),1,'A');
INSERT INTO accesos VALUES(18,1,18,now(),now(),1,'A');
INSERT INTO accesos VALUES(19,1,19,now(),now(),1,'A');
INSERT INTO accesos VALUES(20,1,20,now(),now(),1,'A');
INSERT INTO accesos VALUES(21,1,21,now(),now(),1,'A');
INSERT INTO accesos VALUES(22,1,22,now(),now(),1,'A');
INSERT INTO accesos VALUES(23,1,23,now(),now(),1,'A');
INSERT INTO accesos VALUES(24,1,24,now(),now(),1,'A');
INSERT INTO accesos VALUES(25,1,25,now(),now(),1,'A');

INSERT INTO tipo_instrumento (tipo, descripcion, fec_insercion, usuario, estado)
VALUES 
('Cuerda', 'Instrumentos con cuerdas', NOW(), 1, 'A'),
('Viento', 'Instrumentos que producen sonido por aire', NOW(), 1, 'A'),
('Percusión', 'Instrumentos que se golpean', NOW(), 1, 'A'),
('Teclado', 'Instrumentos con teclas', NOW(), 1, 'A'),
('Electrónicos', 'Instrumentos con componentes electrónicos', NOW(), 1, 'A');

INSERT INTO instrumentos (id_tipo_instrumento, nombre_instrumento, descripcion, fec_insercion, usuario, estado)
VALUES
-- Cuerda (id_tipo_instrumento = 1)
(1, 'Guitarra Acústica', 'Cuerpo de madera, 6 cuerdas', NOW(), 1, 'A'),
(1, 'Violín', '4 cuerdas, uso con arco', NOW(), 1, 'A'),
(1, 'Bajo Eléctrico', '4 cuerdas, cuerpo sólido', NOW(), 1, 'A'),
(1, 'Ukelele', 'Pequeño, 4 cuerdas', NOW(), 1, 'A'),
(1, 'Arpa', 'Instrumento de gran tamaño con cuerdas', NOW(), 1, 'A'),

-- Viento (id_tipo_instrumento = 2)
(2, 'Flauta Dulce', 'De plástico, para estudiantes', NOW(), 1, 'A'),
(2, 'Saxofón', 'Saxofón alto, de latón', NOW(), 1, 'A'),
(2, 'Clarinete', 'Cuerpo negro, boquilla simple', NOW(), 1, 'A'),
(2, 'Trompeta', 'Latón, sonido brillante', NOW(), 1, 'A'),
(2, 'Oboe', 'Instrumento de doble lengüeta', NOW(), 1, 'A'),

-- Percusión (id_tipo_instrumento = 3)
(3, 'Batería Acústica', 'Conjunto de tambores y platillos', NOW(), 1, 'A'),
(3, 'Cajón Peruano', 'Percusión de madera, sonido seco', NOW(), 1, 'A'),
(3, 'Congas', 'Tambores altos, se tocan con las manos', NOW(), 1, 'A'),
(3, 'Bongós', 'Pareja de tambores pequeños', NOW(), 1, 'A'),
(3, 'Timbales', 'Percusión metálica, popular en salsa', NOW(), 1, 'A'),

-- Teclado (id_tipo_instrumento = 4)
(4, 'Piano Acústico', '88 teclas, sonido clásico', NOW(), 1, 'A'),
(4, 'Teclado Electrónico', '61 teclas, múltiples sonidos', NOW(), 1, 'A'),
(4, 'Órgano', 'Instrumento con tubos o digital', NOW(), 1, 'A'),
(4, 'Clavicordio', 'Antecesor del piano, cuerdas pulsadas', NOW(), 1, 'A'),
(4, 'Pianola', 'Piano automático con rollo de papel', NOW(), 1, 'A'),

-- Electrónicos (id_tipo_instrumento = 5)
(5, 'Guitarra Eléctrica', 'Cuerpo sólido, micrófonos simples', NOW(), 1, 'A'),
(5, 'Sintetizador', 'Controlador de sonidos electrónicos', NOW(), 1, 'A'),
(5, 'Caja de Ritmos', 'Generador de ritmos digitales', NOW(), 1, 'A'),
(5, 'Sampler', 'Reproduce y manipula sonidos grabados', NOW(), 1, 'A'),
(5, 'Controlador MIDI', 'Interfaz digital para producir música', NOW(), 1, 'A');


INSERT INTO instrument_musicales VALUES(1,21,1,'IBANEZ','JEM','BLANCO',now(),now(),1,'A');
INSERT INTO instrument_musicales VALUES(2,21,1,'IBANEZ','RG7421','NEGRO',now(),now(),1,'A');
INSERT INTO instrument_musicales VALUES(3,3,1,'FENDER','AM PRO II P BASS V','GRIS',now(),now(),1,'A');
INSERT INTO instrument_musicales VALUES(4,17,1,'YAMAHA','P-145','NEGRO',now(),now(),1,'A');
INSERT INTO instrument_musicales VALUES(5,11,1,'PEARL','PEARL EXPORT ESTÁNDAR','AZUL',now(),now(),1,'A');
INSERT INTO instrument_musicales VALUES(6,11,1,'TAMA','TAMA SUPERSTAR CLASIC ROCK','BLANCO',now(),now(),1,'A');
INSERT INTO instrument_musicales VALUES(7,3,1,'FENDER','J-BASS V PF PWT','BLANCO',now(),now(),1,'A');
INSERT INTO instrument_musicales VALUES(8,17,1,'CASIO','CT-X700','NEGRO',now(),now(),1,'A');
INSERT INTO instrument_musicales VALUES(9,21,1,'GIBSON','EPIPHONE DOVE PRO','ROJO',now(),now(),1,'A');
INSERT INTO instrument_musicales VALUES(10,3,1,'GIBSON','SG STANDAD BASS','ROJO',now(),now(),1,'A');

INSERT  INTO precio_instrumentos VALUES(1,1,'2023-09-12',2000,2500,now(),now(),1,'A');
INSERT  INTO precio_instrumentos VALUES(2,2,'2023-09-22',1400,1900,now(),now(),1,'A');
INSERT  INTO precio_instrumentos VALUES(3,3,'2023-12-29',2100,2500,now(),now(),1,'A');
INSERT  INTO precio_instrumentos VALUES(4,4,'2023-08-30',1700,2000,now(),now(),1,'A');
INSERT  INTO precio_instrumentos VALUES(5,5,'2024-02-15',1500,2000,now(),now(),1,'A');
INSERT  INTO precio_instrumentos VALUES(6,6,'2023-11-24',2200,2400,now(),now(),1,'A');
INSERT  INTO precio_instrumentos VALUES(7,7,'2024-03-19',1900,2300,now(),now(),1,'A');
INSERT  INTO precio_instrumentos VALUES(8,8,'2024-01-01',3000,3400,now(),now(),1,'A');
INSERT  INTO precio_instrumentos VALUES(9,1,'2024-02-10',2500,2800,now(),now(),1,'A');
INSERT  INTO precio_instrumentos VALUES(10,1,'2023-10-27',1600,2000,now(),now(),1,'A');

INSERT INTO empleados VALUES (1,'MARIA','RODRIGUEZ','GARCIA','2023-05-10','2024-01-01',1000,now(),now(),1,'A');
INSERT INTO empleados VALUES (2,'JUAN','MARTINEZ','LOPEZ','2023-06-13','2023-12-23',1000,now(),now(),1,'A');
INSERT INTO empleados VALUES (3,'ANA','PEREZ','FERNANDEZ','2023-05-01','2023-12-29',1000,now(),now(),1,'A');
INSERT INTO empleados VALUES (4,'CARLOS','GOMEZ','MARTIN','2023-09-19','2024-02-24',1000,now(),now(),1,'A');
INSERT INTO empleados VALUES (5,'LAURA','SANCHEZ','RUIZ','2023-10-30','2024-05-19',1000,now(),now(),1,'A');
INSERT INTO empleados VALUES (6,'PEDRO','DIAZ','HERNANDEZ','2023-10-28','2024-02-28',1000,now(),now(),1,'A');
INSERT INTO empleados VALUES (7,'JULIA','LOPEZ','GUTIERREZ','2023-10-10','2024-03-10',1000,now(),now(),1,'A');
INSERT INTO empleados VALUES (8,'MIGUEL','FERNANDEZ','PEREZ','2024-01-01','2024-05-23',1000,now(),now(),1,'A');
INSERT INTO empleados VALUES (9,'SOFIA','MARIN','JIMENEZ','2024-01-10','2024-05-29',1000,now(),now(),1,'A');
INSERT INTO empleados VALUES (10,'JULIO DIEGO','RAMIREZ','SANCHEZ','2023-02-15','2024-04-25',1000,now(),now(),1,'A');

INSERT INTO clientes VALUES(1,1,'ANDREA','GONZALES','RAMIREZ','34572450','B.MORROS BLANCOS',now(),now(),1,'A');
INSERT INTO clientes VALUES(2,1,'JAVIER','RUIZ','MOLINA','34342343','B.EL TEJAR',now(),now(),1,'A');
INSERT INTO clientes VALUES(3,1,'MARTA','TORREZ','SANCHEZ','49688924','B.AEROPUERTO',now(),now(),1,'A');
INSERT INTO clientes VALUES(4,1,'ALEJANDRO','LOPEZ','MARTINEZ','97899678','B.SIMON BOLIVAR',now(),now(),1,'A');
INSERT INTO clientes VALUES(5,1,'LUCIA','RODRIGUEZ','PEREZ','89007644','B.ALTO SENAC',now(),now(),1,'A');
INSERT INTO clientes VALUES(6,1,'JUAN PABLO','RODRIGUEZ','FERNANDEZ','70658367','B.SAN SALVADOR',now(),now(),1,'A');
INSERT INTO clientes VALUES(7,1,'ISABEL','MARTINEZ','ESMERALDA','56443332','B.SAN JORGE',now(),now(),1,'A');
INSERT INTO clientes VALUES(8,1,'SERGIO','HERNANDEZ','GOMEZ','90785323','B.SAN JORGE II',now(),now(),1,'A');
INSERT INTO clientes VALUES(9,1,'ELENA','PEREZ','LOPEZ','89623418','B.AEROPUERTO',now(),now(),1,'A');
INSERT INTO clientes VALUES(10,1,'ALVARO','MARTIN','','66856756','B.SAN MATEO',now(),now(),1,'A');
INSERT INTO clientes VALUES(11,1,'ALVARO','LEON','','66812323','B.SAN MATEO',now(),now(),1,'A');
INSERT INTO clientes VALUES(12,1,'ALVARO','PEREZ','','66856232','B.SAN MATEO',now(),now(),1,'A');

INSERT INTO ventas VALUES(1,1,1,'2023-12-10',2500,now(),now(),1,'A');
INSERT INTO ventas VALUES(2,2,2,'2023-10-29',1900,now(),now(),1,'A');
INSERT INTO ventas VALUES(3,6,3,'2024-02-13',2500,now(),now(),1,'A');
INSERT INTO ventas VALUES(4,4,4,'2023-11-25',2000,now(),now(),1,'A');
INSERT INTO ventas VALUES(5,10,5,'2024-04-17',2000,now(),now(),1,'A');
INSERT INTO ventas VALUES(6,7,6,'2024-01-28',2400,now(),now(),1,'A');
INSERT INTO ventas VALUES(7,9,7,'2024-05-11',2300,now(),now(),1,'A');
INSERT INTO ventas VALUES(8,8,8,'2024-04-16',3400,now(),now(),1,'A');
INSERT INTO ventas VALUES(9,5,9,'2024-05-02',2800,now(),now(),1,'A');
INSERT INTO ventas VALUES(10,3,10,'2023-12-25',2000,now(),now(),1,'A');

INSERT INTO detalles_ventas VALUES(1,1,1,1,now(),now(),1,'A');
INSERT INTO detalles_ventas VALUES(2,2,2,1,now(),now(),1,'A');
INSERT INTO detalles_ventas VALUES(3,3,3,1,now(),now(),1,'A');
INSERT INTO detalles_ventas VALUES(4,4,4,1,now(),now(),1,'A');
INSERT INTO detalles_ventas VALUES(5,5,5,1,now(),now(),1,'A');
INSERT INTO detalles_ventas VALUES(6,6,6,1,now(),now(),1,'A');
INSERT INTO detalles_ventas VALUES(7,7,7,1,now(),now(),1,'A');
INSERT INTO detalles_ventas VALUES(8,8,8,1,now(),now(),1,'A');
INSERT INTO detalles_ventas VALUES(9,9,9,1,now(),now(),1,'A');
INSERT INTO detalles_ventas VALUES(10,10,10,1,now(),now(),1,'A');

INSERT INTO proveedores VALUES(1,'LUIS','PEREZ','CAMACHO','B.SAN JORGE',now(),now(),1,'A');
INSERT INTO proveedores VALUES(2,'MIGUEL', 'ROMERO','CUELLAR','B.CONSTRUCTOR',now(),now(),1,'A');
INSERT INTO proveedores VALUES(3,'ALVARO','JUSTINIANO','PRADO','B.PORTILLO',now(),now(),1,'A');
INSERT INTO proveedores VALUES(4,'JUAN', 'ALVAREZ','QUISPE','B.MORROS BLANCOS',now(),now(),1,'A');
INSERT INTO proveedores VALUES(5,'CRISTIAN','PEREZ','MAMANI','B.AEROPUERTO',now(),now(),1,'A');
INSERT INTO proveedores VALUES(6,'JULIAN','ALCOBA','ZAMORA','B.SAN GERONIMO',now(),now(),1,'A');
INSERT INTO proveedores VALUES(7,'JOSE','JARAMILLO','QUINTANA','B.EL TEJAR',now(),now(),1,'A');
INSERT INTO proveedores VALUES(8,'LAZARO','MENDOZA','CAMACHO','B.LOS OLIVOS',now(),now(),1,'A');
INSERT INTO proveedores VALUES(9,'PABLO','TEJERINA','SANDOVAL','B.SAN JORGE II',now(),now(),1,'A');
INSERT INTO proveedores VALUES(10,'RICHAR','QUISPE','CAMACHO','B.SAN SALVADOR',now(),now(),1,'A');

INSERT INTO compras VALUES (1,1,'2023-09-05',2000,now(),now(),1,'A');
INSERT INTO compras VALUES (2,3,'2023-08-25',1400,now(),now(),1,'A');
INSERT INTO compras VALUES (3,2,'2023-10-03',2100,now(),now(),1,'A');
INSERT INTO compras VALUES (4,4,'2023-08-20',1700,now(),now(),1,'A');
INSERT INTO compras VALUES (5,7,'2024-02-10',1500,now(),now(),1,'A');
INSERT INTO compras VALUES (6,8,'2023-11-23',2200,now(),now(),1,'A');
INSERT INTO compras VALUES (7,5,'2024-01-19',1900,now(),now(),1,'A');
INSERT INTO compras VALUES (8,6,'2023-12-20',3000,now(),now(),1,'A');
INSERT INTO compras VALUES (9,9,'2024-01-29',2500,now(),now(),1,'A');
INSERT INTO compras VALUES (10,10,'2023-09-12',1600,now(),now(),1,'A');
INSERT INTO compras VALUES (11,1,'2023-09-12',1500,now(),now(),1,'A');



INSERT INTO detalles_compras VALUES (1,1,1,1,now(),now(),1,'A');
INSERT INTO detalles_compras VALUES (2,2,2,1,now(),now(),1,'A');
INSERT INTO detalles_compras VALUES (3,3,3,1,now(),now(),1,'A');
INSERT INTO detalles_compras VALUES (4,4,4,1,now(),now(),1,'A');
INSERT INTO detalles_compras VALUES (5,5,5,1,now(),now(),1,'A');
INSERT INTO detalles_compras VALUES (6,6,6,1,now(),now(),1,'A');
INSERT INTO detalles_compras VALUES (7,7,7,1,now(),now(),1,'A');
INSERT INTO detalles_compras VALUES (8,8,8,1,now(),now(),1,'A');
INSERT INTO detalles_compras VALUES (9,9,9,1,now(),now(),1,'A');
INSERT INTO detalles_compras VALUES (10,10,10,1,now(),now(),1,'A');

INSERT INTO inventario VALUES(1,1,1,1,1,now(),now(),1,'A'); 
INSERT INTO inventario VALUES(2,2,2,2,2,now(),now(),1,'A');
INSERT INTO inventario VALUES(3,3,3,3,2,now(),now(),1,'A');
INSERT INTO inventario VALUES(4,4,4,4,1,now(),now(),1,'A');
INSERT INTO inventario VALUES(5,5,5,5,1,now(),now(),1,'A');
INSERT INTO inventario VALUES(6,6,6,6,2,now(),now(),1,'A');
INSERT INTO inventario VALUES(7,7,7,7,4,now(),now(),1,'A');
INSERT INTO inventario VALUES(8,8,8,8,2,now(),now(),1,'A');
INSERT INTO inventario VALUES(9,9,9,9,1,now(),now(),1,'A');
INSERT INTO inventario VALUES(10,10,10,10,3,now(),now(),1,'A');

INSERT INTO ofertas VALUES(1,1,'DIA DEL COMPOSITOR','10% DESCUENTO TODO','2023-01-15','2023-01-30',now(),now(),1,'A');
INSERT INTO ofertas VALUES(2,1,'CARNAVAL','10% DESCUENTO GUITARRAS','2023-02-28','2023-03-28',now(),now(),1,'A');
INSERT INTO ofertas VALUES(3,1,'DIA DE TARIJA','10% DESCUENTO BATERIAS','2023-04-15','2023-05-15',now(),now(),1,'A');
INSERT INTO ofertas VALUES(4,1,'DIA DEL PADRE','30% DESCUENTO GUITARRAS','2023-03-19','2023-04-19',now(),now(),1,'A');
INSERT INTO ofertas VALUES(5,1,'DIA DEL TRABAJADOR','10% DESCUENTO BAJOS','2023-05-01','2023-06-01',now(),now(),1,'A');
INSERT INTO ofertas VALUES(6,1,'DIA DE LA MADRE','30% DESCUENTO TECLADOS','2023-05-27','2023-06-27',now(),now(),1,'A');
INSERT INTO ofertas VALUES(7,1,'DIA DE LA MUSICA','10% DESCUENTO EN TODO','2023-06-21','2023-07-21',now(),now(),1,'A');
INSERT INTO ofertas VALUES(8,1,'DIA DEL MUSICO','20% DESCUENTO EN TODO','2023-11-22','2023-08-22',now(),now(),1,'A');
INSERT INTO ofertas VALUES(9,1,'FELIZ NAVIDAD','30% DESCUENTO BATERIAS','2023-12-25','2023-01-20',now(),now(),1,'A');
INSERT INTO ofertas VALUES(10,1,'FELIZ AÑO NUEVO','30% DESCUENTO EN TODO','2024-01-01','2023-02-01',now(),now(),1,'A');






