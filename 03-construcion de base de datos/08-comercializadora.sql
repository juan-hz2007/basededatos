/*=========================================================
    ELIMINAR LA BASE DE DATOS SI YA EXISTE
=========================================================*/

IF DB_ID('comercializadora') IS NOT NULL
BEGIN
    ALTER DATABASE comercializadora
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE comercializadora;
END;
GO

/*=========================================================
    CREAR BASE DE DATOS
=========================================================*/

CREATE DATABASE comercializadora;
GO

/*=========================================================
    UTILIZAR LA BASE DE DATOS
=========================================================*/

USE comercializadora;
GO

/*=========================================================
    TABLA OFICINA
=========================================================*/

CREATE TABLE oficina(
    oficina_id INT NOT NULL IDENTITY(1,1)
        CONSTRAINT pk_oficina PRIMARY KEY,

    ciudad VARCHAR(30) NOT NULL
        CONSTRAINT uq_oficina_ciudad UNIQUE,

    region VARCHAR(20) NOT NULL
        CONSTRAINT ck_oficina_region
        CHECK(region IN ('Este','Oeste')),

    objetivo DECIMAL(10,2) NOT NULL
        CONSTRAINT ck_oficina_objetivo
        CHECK(objetivo > 0),

    venta DECIMAL(10,2) NOT NULL
        CONSTRAINT ck_oficina_venta
        CHECK(venta >= 0),

    created_at DATETIME2 NOT NULL
        CONSTRAINT df_oficina_created
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        CONSTRAINT df_oficina_updated
        DEFAULT SYSDATETIME()
);
GO

/*=========================================================
    TABLA REPRESENTANTE
=========================================================*/

CREATE TABLE representante(

    representante_id INT NOT NULL IDENTITY(1,1)
        CONSTRAINT pk_representante PRIMARY KEY,

    nombre VARCHAR(50) NOT NULL,

    edad INT NOT NULL
        CONSTRAINT ck_representante_edad
        CHECK(edad >= 18),

    puesto VARCHAR(40) NOT NULL,

    oficina_id INT NOT NULL,

    created_at DATETIME2 NOT NULL
        CONSTRAINT df_representante_created
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        CONSTRAINT df_representante_updated
        DEFAULT SYSDATETIME(),

    CONSTRAINT fk_representante_oficina
        FOREIGN KEY(oficina_id)
        REFERENCES oficina(oficina_id)

);
GO

/*=========================================================
    TABLA CLIENTE
=========================================================*/

CREATE TABLE cliente(

    cliente_id INT NOT NULL IDENTITY(1,1)
        CONSTRAINT pk_cliente PRIMARY KEY,

    empresa VARCHAR(30) NOT NULL
        CONSTRAINT uq_cliente_empresa UNIQUE,

    limite_credito DECIMAL(10,2) NOT NULL
        CONSTRAINT ck_cliente_limite
        CHECK(limite_credito BETWEEN 1000 AND 100000),

    representante_id INT NOT NULL,

    created_at DATETIME2 NOT NULL
        CONSTRAINT df_cliente_created
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        CONSTRAINT df_cliente_updated
        DEFAULT SYSDATETIME(),

    CONSTRAINT fk_cliente_representante
        FOREIGN KEY(representante_id)
        REFERENCES representante(representante_id)

);
GO

/*=========================================================
    TABLA PRODUCTO
=========================================================*/

CREATE TABLE producto(

    producto_id CHAR(5) NOT NULL
        CONSTRAINT pk_producto PRIMARY KEY,

    fabricante_id CHAR(3) NOT NULL,

    descripcion VARCHAR(40) NOT NULL
        CONSTRAINT uq_producto_descripcion UNIQUE,

    precio DECIMAL(10,2) NOT NULL
        CONSTRAINT ck_producto_precio
        CHECK(precio > 0),

    existente INT NOT NULL
        CONSTRAINT ck_producto_existencia
        CHECK(existente BETWEEN 1 AND 100),

    created_at DATETIME2 NOT NULL
        CONSTRAINT df_producto_created
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        CONSTRAINT df_producto_updated
        DEFAULT SYSDATETIME()

);
GO

/*=========================================================
    TABLA PEDIDO
=========================================================*/

CREATE TABLE pedido(

    pedido_id INT NOT NULL IDENTITY(1,1)
        CONSTRAINT pk_pedido PRIMARY KEY,

    fecha_pedido DATE NOT NULL
        CONSTRAINT df_pedido_fecha
        DEFAULT GETDATE(),

    cliente_id INT NOT NULL,

    representante_id INT NOT NULL,

    created_at DATETIME2 NOT NULL
        CONSTRAINT df_pedido_created
        DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
        CONSTRAINT df_pedido_updated
        DEFAULT SYSDATETIME(),

    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY(cliente_id)
        REFERENCES cliente(cliente_id),

    CONSTRAINT fk_pedido_representante
        FOREIGN KEY(representante_id)
        REFERENCES representante(representante_id)

);
GO

/*===================================================
SELECT en SQL Server:
muestra solo las columnas que necesitas
=====================================================*/

USE comercial_db;
GO

SELECT *
FROM productos;
GO

SELECT 
	codigo, 
	nombre, 
	precio
FROM productos;

SELECT 
	precio, 
	nombre, 
	codigo
FROM productos;

SELECT 
	precio, 
	nombre, 
	codigo
FROM productos;

/*===================================================
Alias de columnas y alias de tablas con AS
=====================================================*/

SELECT 
	codigo AS codigo_producto, 
	nombre AS nombre_producto, 
	precio AS precio_prodcuto
FROM productos;


SELECT 
	codigo AS [codigo producto], 
	nombre AS [nombre_producto], 
	precio AS [precio producto]
FROM productos;

SELECT 
	p.codigo AS codigo_producto, 
	p.nombre, 
	p.precio
FROM productos AS p;

SELECT 
	productos.codigo AS codigo_producto, 
	productos.nombre, 
	productos.precio
FROM productos;


/*===================================================
Columnas calculadas y operadores aritméticos en SQL Server
=====================================================*/

SELECT
	precio * existencia AS valor_inventario
FROM productos;
GO

SELECT
	nombre, 
	apellido_paterno, 
	salario, 
	salario + 1000 AS salario_simulado	
FROM empleados;
GO



SELECT
    p.codigo AS [Código], 
	p.nombre AS [producto], 
	p.precio AS [Precio Unitario],
	p.existencia AS [Existencia],
	precio * existencia AS valor_inventario
FROM productos AS p;
GO

SELECT
    p.codigo AS [Código], 
	p.nombre AS [producto], 
	p.precio AS [Precio Unitario],
	p.existencia AS [Existencia],
	p.precio - 10 AS precio_promocional,
	p.precio / 2.0 AS mitad_precio,
	(existencia % 10.0) AS precio,
	precio * existencia AS valor_inventario
FROM productos AS p;
GO

SELECT
	precio * existencia 
FROM productos;
GO

/*===================================================
Eliminar valores repetidos con DISTINCT
=====================================================*/

SELECT DISTINCT
	sexo
FROM clientes;
GO

SELECT DISTINCT 
	descuento AS [Porcentaje de descuento]
FROM detalle_ventas;
GO

SELECT DISTINCT
	id_categoria, 
	id_proveedor
FROM productos;
GO

SELECT DISTINCT
	id_cliente, 
	id_empleado
FROM ventas;
GO


/*===================================================
Limitar filas con TOP y TOP PERCENT
=====================================================*/

--SELECT TOP (cantidad)
--	columna_1, 
--	columna_2
--FROM tabla;

SELECT TOP (5)
	id_producto, 
	codigo, 
	nombre, 
	precio
FROM productos;
GO

-- Solicitar los cinco productos de mayor precio

SELECT TOP (5)
	codigo, 
	nombre, 
	precio
FROM productos
ORDER BY precio DESC;
GO


SELECT TOP (5)
	codigo, 
	nombre, 
	precio, 
	existencia, 
	(precio * existencia) AS valor_inventario
FROM productos
ORDER BY precio DESC;
GO

SELECT TOP (10) PERCENT
	id_producto,
	codigo, 
	nombre
FROM productos;


SELECT TOP (15) PERCENT
    c.id_cliente AS [Cliente],
    c.nombre AS [Nombre],
    c.apellido_paterno AS [Apellido paterno],
    c.correo AS [Correo]
FROM clientes AS c;

