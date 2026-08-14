/*========================================================

SQL-DQL EN SQL SERVER

ARCHIVO:04-practice.SQL

DESCRIPCION :CREA LA BASE DE DATOS PARA EL LENGUAJE SQL

=========================================================*/

SELECT * FROM [dbo].[categorias];
SELECT * FROM [dbo].[ciudades];
SELECT * FROM [dbo].[clientes];
SELECT * FROM [dbo].[departamentos];
SELECT * FROM [dbo].[detalle_ventas];
SELECT * FROM [dbo].[empleados];
SELECT * FROM [dbo].[estados];
SELECT * FROM [dbo].[productos];
SELECT * FROM [dbo].[proveedores];
SELECT * FROM [dbo].[ventas];   

SELECT COUNT(*) FROM [dbo].[categorias];
SELECT COUNT(*) FROM [dbo].[ciudades];
SELECT COUNT(*) FROM [dbo].[clientes];
SELECT COUNT(*) FROM [dbo].[departamentos];
SELECT COUNT(*) FROM [dbo].[detalle_ventas];
SELECT COUNT(*) FROM [dbo].[empleados];
SELECT COUNT(*) FROM [dbo].[estados];
SELECT COUNT(*) FROM [dbo].[productos];
SELECT COUNT(*) FROM [dbo].[proveedores];
SELECT COUNT(*) FROM [dbo].[ventas];

/*========================================================

-- INSTRUCCION SELECT , ES LA INSTRUCCION MAS UTILIZADA EN 
SQL. SU OBJTIVO ES CONSULTAR INFORMACION DE UNA O VARIAS TABLAS

sintaxis 

SELECT 
	columna_1,
	columna_2,
	columna_3,
	columna_n,
FROM nombre_tabla;

=========================================================*/

SELECT *
FROM estados; -- no es recomendable usarla cuando hay muchos datos 

SELECT
	nombre
FROM estados;


-- MOSTRAR los nombres de los departamentos
SELECT nombre
FROM departamentos;
GO
-- mostrar el nombre del provedor , el telefono y su contacto 
SELECT 
	empresa,
	telefono,
	contacto
FROM proveedores;
GO

-- alias de columnas 


-- muestra los nombres de los estados
SELECT 
	nombre 
FROM estados;
GO

SELECT 
	nombre AS' nombre del estado'
FROM estados;
GO

SELECT 
	nombre nombredelestado
FROM estados;
GO

SELECT 
	nombre [nombre del estado]
FROM estados;
GO

SELECT 
	nombre AS [nombre del estado]
FROM estados;
GO


SELECT COUNT(*) AS [total de ventas detalle]
FROM detalle_ventas;
GO


--Mostrar el codigo , nombre y prpecio pero con nombres mas adecuados para el ussurio 

SELECT 
	codigo AS codigo_producto,
	nombre AS producto,
	precio AS precio_unitario
FROM productos;


SELECT 
	UPPER (codigo) AS codigo_producto,
	UPPER (nombre) AS producto,
	UPPER (precio) AS precio_unitario
FROM productos;

--orden logico de una consulta SELECT 

-- orden de como escribimos la consulta 
-- SELECT
-- FROM
-- WHERE
-- GROUP BY
-- HAVING
-- ORDER BY

-- ORDEN DE EJECUCIOIN de sql server
FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
