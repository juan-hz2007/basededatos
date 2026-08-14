/*
DEiscrpcion : recuperar las filas que complan las condiciones mediante 
el WHERE 
*/

/*
SINTAXIS GENERAL:

SELECT
columna_1
columna_2
columna_3
FROM tabla
WHERE condicion;


OERDEN SINTATICO (COMSULTAS)

SELECT FROM 
JOIN / ON
WHERE
GROUP
HAVING 
ORDER BY 

ORDERN DE EJECUCION 
FROM / JOIN WHERE
HAVING SELECT
ORDER BY   
TOP 
*/

-- seleccionar los datos de los clientes donde su numero de cliente sea 25 
SELECT 
c.id_clientes AS numero_clientes,
UPPER(CONCAT(c.nombre, '',
	c.apellido_paterno, '',
	c.appeido_materno)) AS [nombre_completo]
FROM clientes AS c;
WHERE c.id_clientes = 25;
-- sleecionar todas las cetegorias que tengan que sean computo 
SELECT
c.id_categoria,
c.nombre
FROM categoria AS c;
WHERE c.nombre = 'computo';
-- seleccionra los datos de los clientes  del lciente 1 
	
-- selecconar los datos de los lciente que no pertetnecen al deprtamwnto 1 

-- seleccionar lso procutos cuyo precio sea superiro a $490 

-- seleccionar los proctos con existencia critirca inferiro a 10 unidades 

-- seleciionar los emplados con salario de 3000 y mas 

-- seleccionar todas las ventas realizadas el 24 de diciembre de 2025 
SELECT 
v.id_venta,
v.fecha,
v.id_clientes
v.id_empleados
FROM ventas AS v
	WHERE fecha = '2025-12-24';


	
SELECT 
	v.id_venta,
	v.fecha,
	YEAR(v.fecha) AS [Año],
	MONTH (v.fecha) AS [Mes],
	DAY (v.fecha) AS [Dia],
	FORMAT (v.fecha, 'MMMM') AS [Mes en Ingles],
	FORMAT (v.fecha, 'MMMM', 'es-ES') AS [Mes en Español],
	v.id_cliente,
	v.id_empleado
FROM ventas AS v
WHERE fecha = '2025-12-24';


-- comparaciones con expresiones calculadas
-- WHERE tambien puede evaluar un calculo

--Mostrar productos cuyu valor sea mayor a $50,000

SELECT 
p.codigo,
p.nombre,
p.precio,
p.existencia ,
(p.precio * p.existencia) AS valor_iventario
FROM productos AS p
WHERE (p.precio * p.existencia) > 50000
ORDER BY  valor_iventario DESC;
GO

-- OPERDOR LOGICO AND 
--Mostrar productos con precio entre $200 y $300 que demas tengan menos de 50 unidades 


SELECT 
p.codigo,
p.nombre,
p.precio,
p.existencia ,
(p.precio * p.existencia) AS valor_iventario
FROM productos AS p 
WHERE p.precio >= 200
AND 
p.precio<=300
AND
p.existencia < 50;

--Clausula BETWEEN (EQUIVALENTE A UN RENGO)

SELECT 
p.codigo,
p.nombre,
p.precio,
p.existencia ,
(p.precio * p.existencia) AS valor_iventario
FROM productos AS p 
WHERE p.precio BETWEEN 200 AND 300
AND 
p.existencia < 50;

-- Mostra los empleados del deprtamento 1 cuyo salario sea supeiror a $25000
	
	SELECT
	e.id_empleados,
	e.nombre,
	e.salario,
	e.id_departemento
	FROM empleados AS e
	WHERE e.id_departamento = 1
	AND
	e.salario > 25000;
	--Mostrar los productos con existencia inferiro a 10 o superior a 190
	
SELECT 
p.codigo,
p.nombre,
p.precio,
p.existencia ,
(p.precio * p.existencia) AS valor_iventario
FROM productos AS p 
WHERE p.existencia  < 10
OR 
p.existencia > 190;

	-- Seleccionar productos que no tengan precio mayor a 400

	SELECT 
p.codigo,
p.nombre,
p.precio,
p.existencia ,
(p.precio * p.existencia) AS valor_iventario
FROM productos AS p 
WHERE NOT (p.precio > 400);



	SELECT 
p.codigo,
p.nombre,
p.precio,
p.existencia ,
(p.precio * p.existencia) AS valor_iventario
FROM productos AS p 
WHERE p.precio <= 400;


-- Seleccionar los empleados que pertenecescan al departamento 1 y departamwento 2 y con salario mayor 
--  a $25000

SELECT
	e.id_empleados,
	e.nombre,
	e.salario,
	e.id_departemento
	FROM empleados AS e
	WHERE (e.id_departamento =1 
	OR 
	e.id_departamento = 2)
	AND salario >25000

	-- OPERADOR BETWEEN 
	-- BETWEEN permite combrar si un valor se encuentra dentro de un rango
	--exclusivo

	
SELECT
	e.id_empleados,
	e.nombre,
	e.salario,
	e.id_departemento
	FROM empleados AS e


	/*==============================================================================================================
	SINTAXIS 
	
	WHERE columna BETWEEN limite_inferior AND 
	operador BETWEEN X
	================================================================================================================*/

	--M ostar los empleados con salario entre $15,0000.0
	-- y $ 20000 , incluyendo ambos limites

	SELECT
	e.id_empleados,
	e.nombre,
	e.salario,
	e.id_departemento
	FROM empleados AS e
	WHERE e.salario BETWEEN 15000.0 AND 2000.0
	ORDER BY 3 DESC ;

	
	SELECT
	e.id_empleados,
	e.nombre,
	e.salario,
	e.id_departemento
	FROM empleados AS e
	WHERE e.salario >= 15000
	AND 
	e.salario <= 20000;


	-- Seleccionbar los productos donde el precio este entre $100 y $200


	-- Seleccionar las ventas realizadas del 1 de enero de 2025 al 
	--10 de enero de 2025

	SELECT 
	v.id_venta AS numero_venta,
	v.id_cliente AS cliente,
	v.id_empleado AS vendedor,
	v.fecha AS fecha_venta,
	UPPER (FORMAT ( v.fecha,'MMM','es-ES')) AS [Mes_venta],
	UPPER (FORMAT ( v.fecha,'dddd','es-ES')) AS [dia_venta],
	DATEPART(YEAR,v.fecha) AS [año_venta] 
	FROM ventas AS v
	WHERE v.fecha BETWEEN '2025-01-01' AND '2025-01-10'
	ORDER BY fecha_venta ASC ;

	-- NOT BETWEEN 
	-- recuperra los valores que se encuentra afuera de un rango

	--selecciona los productos que nose encuentren en el rango de precio 
	-- de 100 y 400
		SELECT 
p.codigo,
p.nombre,
p.precio,
p.existencia ,
(p.precio * p.existencia) AS valor_iventario
FROM productos AS p 
	WHERE p.precio NOT BETWEEN 100 AND 400;

	-- oprador IN
	-- permitir comprpobar un a columna con una lista de valores

	/*=============================================================
			WHERE columna IN (valor_1, valor_2, valor_n)

			Es equivalente a varias condiciones conectadas con OR 
	===============================================================*/


	--mostra los productos pertenecientes a las categorias 1, 7 , 12 
	SELECT
	p.codigo,
	p.nombre,
	p.precio,
	p.id_categoria
	FROM productos AS p
	WHERE p.id_categoria IN (1, 7, 12)
	ORDER BY p.id_categoria ;

		SELECT
	p.codigo,
	p.nombre,
	p.precio,
	p.id_categoria
	FROM productos AS p
	WHERE p.id_categoria = 1
	OR
	p.id_categoria = 7
	OR p.id_categoria = 12
	ORDER BY p.id_categoria;

	--Seleccionar los departamentos de ventas , TI y direccion

	SELECT 
	d.id_departamento,
	d.nombre
	FROM departamento AS d
	WHERE d.nombre IN ( 'ventas ',  'ti ',  'dirrecion ');


	-- TODO revisar NOT IN y like 

	-- NOT IN 
	--EXCLUYE LOS VALORES INXLUIDOS EN LA LISTA 

	--Mostrar los datos de los emplados que no perteneescan ni al departamento 1 ni al 2

	SELECT 
	e.id_empleado,
	e.nombre
	e.id_departemento
	FROM empleqados AS e
	WHERE e.id_departamento NOT IN (1,2);

	/*============================================================================================

	operador like 

	LIKE permite buscar patrones dentro de valores de texto

	SINTAXIS

	WHRERE columna LIKE patron

	los principales son:

	comodin            significado
		%				Cero, uno a varios caracteres 
		-                Exactamente un caracter
		[abc]             un caracter incluido en la lista
		[a-f]              un caracter inbcluido en el rango
		[^abc]             unj carcter no  incluido en la lista     

============================================================================================*/




--comidin %
-- el sikbolo % representa cualquier cantidad de carecteres , incluyendo cero caracteres

-- comienza con

-- WHERE nombre LIKE 'Cliente1%'


--Significado: valores que comienzan con Cliente1

--TERMINA CON
--WHERE correo LIKE %mail.com
-- Significa : valores que terminan con mail.com

--CONTIENE
-- WHERE nombre LIKE '%a%'
-- Significa : valores que contienen el caracter a en cualquier posicion 

-- Mostrar los productos donde el codigo comiemce con P001

SELECT 
p.codigo,
p.nombre
p.precio
FROM productos AS p
WHERE p.codigo LIKE 'P001%';


-- Mostar los ddatos de los cleintes en donde su correo termine con 10@mail.com

SELECT
c.id_cliente 
c.nombre
c.correo
FROM clientes AS c
WHERE c.correo LIKE '%10@mail.com';

--MOSTar los datos de losmproductos donde el nombre contenga el carecter 1

SELECT 
p.codigo
p.nombre
p.precio
FROM productos AS p
WHERE p.nombre LIKE '%1%';

--comodin de un caracter 
-- el guion bajo _ representa exactamente un caracter 

-- SELECCIONA LOS DATOS DE LOS PRODUCTOS DONDE EL CODIGO COMIENCE CON P000 Y despues exactamente 
-- un careter adicional 
SELECT 
p.codigo
p.nombre
p.precio
FROM productos AS p 
WHERE p.codigo LIKE 'P000_';


SELECT 
p.codigo
p.nombre
p.precio
FROM productos AS p 
WHERE p.codigo LIKE 'P000%';

SELECT 
p.codigo
p.nombre
p.precio
FROM productos AS p 
WHERE p.codigo LIKE 'P0_0__';











