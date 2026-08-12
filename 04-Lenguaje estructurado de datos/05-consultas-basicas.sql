USE comercial_db;

-- utliza el operador asterisco (*) , no es muy recomendada
-- *, todas las columnas 

SELECT *
FROM productos;


-- seleccionar columnas necesarias (proyeccion)

SELECT 
  nombre
FROM estados;
GO

SELECT 
	codigo,
	nombre,
	precio
FROM productos;
GO

SELECT 
	nombre,apellido_paterno,telefono,correo
FROM clientes;
GO


SELECT 
	nombre,
	apellido_paterno,
	telefono,
	correo
FROM clientes;
GO

-- Alias de Columna 
-- Es un nombre temporal asignado a una columna ddentro del 
-- resiltado una consulta 

SELECT 
codigo AS codigo_producto,
nombre AS nombre_producto,
precio AS precio_unitario
FROM productos;


SELECT 
codigo,
nombre,
precio
FROM productos;



SELECT 
codigo AS [codigo producto],
nombre AS [nombre producto],
precio AS [precio unitario]
FROM productos;


SELECT 
codigo AS 'codigo producto',
nombre AS 'nombre producto',
precio AS 'precio unitario'
FROM productos;



-- otra forma de poner alias (no recom endada)

SELECT 
codigo  codigo_producto,
nombre  nombre_producto,
precio  precio_unitario
FROM productos;


-- alias de tabla

SELECT 
p.codigo,
p.nombre,
p.precio
FROM productos;


SELECT 
productos.codigo,
productos.nombre,
productos.precio
FROM productos AS p;

SELECT *
categoria.id_categoria AS [numerocategoria],
categoria.nombre AS [nombre_categoria],
id_producto AS [nombre producto],
nombre AS nombre_producto,
productos.nombre AS [nombre_producto],
precio,
existencia
FROM categorias
INNER JOIN 
productos
ON categorias.id_categoria = productos.id_categoria;



SELECT *
c.id_categoria AS [numerocategoria],
c.nombre AS [nombre_categoria],
p.id_producto AS [nombre producto],
nombre AS nombre_producto,
productos.nombre AS [nombre_producto],
precio,
existencia
FROM categorias
INNER JOIN 
productos
ON categorias.id_categoria = productos.id_categoria;

--Columnas calculadas 
-- selccionar los datos de los productos y el valor del inventario 

/*
()
*, /
%
+,-
*/



	SELECT 
	p.codigo AS #,
	p.nombre AS [nombre producto],
	p.precio AS [precio producto],
	p.existencia AS [existencia producto],
	(precio * existencia) AS valor_iventario
	FROM prodcutos AS p;

    -- TODO : ver eejemplo con campos calcular y operadores aritmetcios

	

-- selecionar los datos de las ventas , numero de ventas , cantidad vendidad,
-- precio, descuento y calcular el importe bruto , importe con descuento y 
-- el importe neto (importe bruto por 1 menos el descuento entre 100)

SELECT 
dv.id_venta AS [#venta],
dv.cantidad AS [cantidad_vendidad],
dv.precio AS [precio_venta],
dv.descuento AS [descuento],
(dv.cantidad * dv.precio) AS [importe_bruto],
(dv.cantidad * dv.precio * descuento / 100.0) AS importe_descuento,
dv.cantidad * dv.precio * (1 - descuento / 100.0) AS 'importe_neto'
FROM detalle_venta AS dv;

-- USO DE DISTINCT 
--ELIMINA DE RESULTADO LAS FILAS QUE TENGAN VALORES REPETIDOS EN TODAS LA COLUMNAS SELECCIONADAS 
/*=================================================================================
		SELECT DISTINCT columna 
		FROM tabla;
*/==================================================================================

-- ejemplo sin distincnt 
-- selecciona los sexos de los clientes 

SELECT sexo 
FROM clientes;

-- selecciona los distintos descyentos que se  han aplicacdo a las ventas 
SELECT DISTINCT 
.dv descuentos 
FROM detalle_venta AS dv;

-- Seleccionar los distintos departamentos a los que pertenecen los empleados 

SELECT DISTINCT
	e.id_departamentos AS [departamentos]
FROM empleados AS e ;

-- DISTINCT para varias columnas 
-- se utiliza cuando se  varias columnas se evalua la comparcion completa 
SELECT DISTINCT
p.id_categoria,
p.id_proveedor
FROM productos AS p
ORDER BY p.id_categoria, p.id_proveedor;

-- USO DE TOP 
-- este limita la cantidad de filas devueltas por una consulta

/*==============================================================
SELECT TOP (cantidad)
columna_1
columna_2
columna_n
=========================================================================*/

-- seleccionar los 5 elementos encontrados en la tabla 

SELECT TOP (15)
id_producto
codigo
FROM  productos AS p
ORDER BY id_productos DESC;

--seleccionare los primero 5 productos que aparescan en la consulta mostrando el codigo nombre preio existencia y el valor del inventario de la tabla 
-- productos 

SELECT 
p.codigo
p.nombre
p.precio
p.existencia 
(p.precio * p.existencia) AS valor_inventario
FROM productos AS p, 

--TOP CON PORCENTAJE 
-- SQL LIMTA ELK REUKATDO MIDIENTE PORCEBTAJE 

/*
SELECT TOP (porcentaje) PERCENT 
columnas 
FROM tabla;
*/

-- seleccionar el 10 por cienrto de la tabal productos 
--mstando el numero deproducto codigo y el nombre 

SELECT TOP (10) PERCENT
p.id_producto,
p.codigo,
p.nombre
FROM productos AS p;
GO 

-- sleccionar los 3 primeros descuentos distintos 

SELECT DISTINCT (3)
descuentos 
FROM detalle_ventas AS dv;