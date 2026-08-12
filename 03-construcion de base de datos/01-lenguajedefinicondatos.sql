-- Construccion de Bases de datos con SQL-LDD (Create, Alter, Drop)

-- Crear una base de datos

CREATE DATABASE universidad;
GO 

-- Usar la base de datos --
USE universidad;
GO

-- Crear una tabla

CREATE TABLE alumno (
	alumno_id INT, 
	nombre VARCHAR (50),
	apellido_paterno VARCHAR (20),
	apellido_materno VARCHAR (20),
	fecha_nacimiento DATE,
	correo VARCHAR (50)
);
GO

DROP TABLE alumno;

INSERT INTO alumno
VALUES (1, 'Maria', 'Perez', 'Gonzalez', '1986-04-07', 'correo@correo.com');

INSERT INTO alumno
VALUES (1, 'Kevin', 'Lopez', 'Nuñez', '1942-05-10', 'correo@correo.com');

SELECT *
FROM alumno;

-- Restricciones  --
/*
Las restricciones son reglas que garantizan la integridad de los datos

Las mas utilizadas son:
- PRIMARY KEY
- FOREIGN KEY
- NOT NULL
-UNIQUE 
- CHECK
- DEFAULT

*/

-- PRIMARY KEY

CREATE TABLE alumno(
alumno_id INT PRIMARY KEY,
nombre VARCHAR (100),
correo VARCHAR (50),

);
GO

INSERT INTO alumno
VALUES (1, 'Luis', 'correo@Luis.com');

INSERT INTO alumno
VALUES (3, 'Jose', 'correo@Luis.com');


DROP TABLE alumno;


CREATE TABLE alumno(
alumno_id INT PRIMARY KEY,
nombre VARCHAR (100),
correo VARCHAR (50),
CONSTRAINT pk_alumno
PRIMARY KEY (alumno_id)

);
GO

INSERT INTO alumno
VALUES (1, 'Luis', 'correo@Luis.com');

INSERT INTO alumno
VALUES (3, 'Jose', 'correo@Luis.com');

DROP TABLE alumno;

-- PRIMARY KEY CON IDENTITY

CREATE TABLE alumno(
alumno_id INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR (100),
correo VARCHAR (50),

);
GO

INSERT INTO alumno
VALUES ('Luis', 'correo@Luis.com');

INSERT INTO alumno
VALUES ('Jose', 'correo@Luis.com');

SELECT * FROM alumno;

CREATE TABLE alumno(
alumno_id INT NOT NULL IDENTITY(1,1),
nombre VARCHAR (50),
correo VARCHAR (50),
CONSTRAINT pk_alumno
PRIMARY KEY (alumno_id)

);
GO

-- NOT NULL
CREATE TABLE profesor(
profesor_id INT NOT NULL IDENTITY (1,1),
numero_nomina VARCHAR (20) NOT NULL,
nombre VARCHAR (15) NOT NULL,
apellido_materno VARCHAR (20) NOT NULL,
apellido_paterno VARCHAR (20) NULL,
fecha_ingreso DATE,
CONSTRAINT pk_profesor
PRIMARY KEY (profesor_id)

);
GO

INSERT INTO profesor
VALUES ('568265ED', 'Pedro', 'Hernandez', NULL, '2027-05-07');

SELECT *
FROM profesor;

INSERT INTO profesor (numero_nomina, nombre, apellido_materno)
VALUES ('jjdhugug1', 'Mateo', 'Lopez')

-- Restriccion UNIQUE


CREATE TABLE categoria (
	categoria_id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nombre VARCHAR (20) NOT NULL UNIQUE,
	activo BIT NOT NULL, 

);
GO

INSERT INTO categoria
VALUES (UPPER('Carnes frias'), 1);

INSERT INTO categoria
VALUES (UPPER('Carnes frias'), 1);


DROP TABLE categoria;
GO

CREATE TABLE categoria (
	categoria_id INT NOT NULL IDENTITY(1,1),
	CONSTRAINT pk_categoria
	PRIMARY KEY (categoria_id),
	nombre VARCHAR (20) NOT NULL
	CONSTRAINT uq_categoria_nombre
	UNIQUE,
	activo BIT NOT NULL

);
GO


DROP TABLE categoria;
GO

CREATE TABLE categoria (
	categoria_id INT NOT NULL IDENTITY(1,1),
	nombre VARCHAR (20) NOT NULL,
	activo BIT NOT NULL,
	CONSTRAINT pk_categoria
	PRIMARY KEY (categoria_id),
	CONSTRAINT uq_categoria_nombre
	UNIQUE (nombre)

);
GO

-- RESTRICCION DEFAULT

CREATE TABLE categoria (
	categoria_id INT NOT NULL IDENTITY(1,1),
	nombre VARCHAR (20) NOT NULL,
	activo BIT NOT NULL DEFAULT 1,
	CONSTRAINT pk_categoria
	PRIMARY KEY (categoria_id),
	CONSTRAINT uq_categoria_nombre
	UNIQUE (nombre)

);
GO


INSERT INTO categoria (nombre, activo)
VALUES('Carnes frias', DEFAULT);

INSERT INTO categoria (nombre)
VALUES('Lacteos');

SELECT *
FROM categoria;


-- TODO: CREAR LAS TABLAS DE LAS OTRAS DOS FORMAS
-- TODO: CHECK


CREATE DATABASE empresa_patito;
Go

USE empresa_patito;
Go

-- Primera forma de construccion (no utilizar en el futuro)

CREATE TABLE producto(
	producto_id INT IDENTITY (1,1) PRIMARY KEY,
	nombre VARCHAR (20) NOT NULL UNIQUE,
	descripcion VARCHAR(80),
	 precio DECIMAL (10,2) NOT NULL CHECK (precio>0.0),
	 existencia INT NOT NULL CHECK (existencia>0 AND existencia<=100),
	 activo BIT NOT NULL DEFAULT 1,
	 tipo CHAR(1) NOT NULL CHECK (tipo = 'r' OR tipo = 'p')

);
DROP TABLE producto;

-- Segunda forma de construccion (Restriccion por columna)
CREATE TABLE producto(
	producto_id INT IDENTITY (1,1)
	CONSTRAINT pk_producto
	PRIMARY KEY,
	nombre VARCHAR (20) NOT NULL
	CONSTRAINT uq_producto_nombre
	UNIQUE,
	descripcion VARCHAR(80),
	 precio DECIMAL (10,2) NOT NULL,
	 CONSTRAINT ck_producto_precio
	 CHECK (precio >0.0),
	 existencia INT NOT NULL,
	 CHECK (existencia BETWEEN 1 AND 100),
	 activo BIT NOT NULL 
	 CONSTRAINT df_producto_activo
	 DEFAULT 1,
	 tipo CHAR(1) NOT NULL
	 CONSTRAINT ck_producto_tipo
	 CHECK (tipo IN ('r','p'))

);
GO


-- Tercer forma de creacion (Definicion al final)
CREATE TABLE producto(
	producto_id INT IDENTITY (1,1),
	nombre VARCHAR (20) NOT NULL ,
	descripcion VARCHAR(80),
	 precio DECIMAL (10,2) NOT NULL,
	 existencia INT NOT NULL ,
	 activo BIT NOT NULL
	 CONSTRAINT df_producto_activo
	 DEFAULT 1,
	 tipo CHAR(1) NOT NULL,
	 CONSTRAINT pk_producto
	 PRIMARY KEY (producto_id),
	 CONSTRAINT uq_producto_nombre
	 UNIQUE (nombre),
	 CONSTRAINT ck_producto_precio
	 CHECK (precio>0.0),
	 CONSTRAINT ck_producto_existencia
	 CHECK (existencia BETWEEN 1 AND 100),
	 CONSTRAINT ck_producto_tipo
	 CHECK (tipo in('r', 'p'))


);
GO


INSERT INTO producto
values ('Pitufo', 'Azulito', 12.50,99,DEFAULT,'e');


INSERT INTO producto
values ('Quemado', 'sabroso', -12.50,34,DEFAULT,'e');

INSERT INTO producto(nombre,precio, existencia, tipo)
values ('Pantera rosa', 89.9,56,'p');

-- Restriccion Foreign key (Integridad Referencial)

CREATE TABLE proveedor(
	proveedor_id INT NOT NULL IDENTITY (1,1),
	empresa VARCHAR (20) NOT NULL,
	limite_credito NUMERIC(10,2) NOT NULL,
	activo BIT NOT NULL
	CONSTRAINT df_proveedor_activo
	DEFAULT 1,
	created_at DATETIME2 NOT NULL
	CONSTRAINT df_proveedor_created_at
	DEFAULT SYSDATETIME(),
	update_at DATETIME2 NOT NULL
	CONSTRAINT df_proveedor_update_at
	DEFAULT SYSDATETIME()
	CONSTRAINT pk_proveedor
	PRIMARY KEY (proveedor_id),
	CONSTRAINT uq_proveedor_empresa
	UNIQUE (empresa),
	CONSTRAINT ck_proveedor_limite_credito
	CHECK (limite_credito BETWEEN 100 AND 100000)

	);

	CREATE TABLE contacto_proveedor(
		constacto_id INT IDENTITY (1,1)
		CONSTRAINT pk_contacto_proveedor
		PRIMARY KEY,
		nombre VARCHAR(30) NOT NULL,
		apellido_paterno VARCHAR (15) NOT NULL,
		apellido_materno VARCHAR (15) NULL,
		telefono VARCHAR (18) NOT NULL,
		proveedor_id INT NOT NULL,
		CONSTRAINT fk_contacto_proveedor_proveedor
		FOREIGN KEY (proveedor_id)
		REFERENCES proveedor (proveedor_id)

);
GO

INSERT INTO proveedor(empresa, limite_credito)
VALUES ('Coca-Cola', 7800),
		('Pepsi', 4585),
		('Bimbo', 10000);


SELECT *
FROM proveedor;

INSERT INTO contacto_proveedor(nombre, apellido_paterno,apellido_materno, telefono, proveedor_id)
VALUES ('Luis', 'Aguilar', NULL, '54813111',1);

INSERT INTO contacto_proveedor(nombre, apellido_paterno,apellido_materno, telefono, proveedor_id)
VALUES ('Cecilia', 'Lopez', 'Godinez', '9594632',1);

INSERT INTO contacto_proveedor(nombre, apellido_paterno,apellido_materno, telefono, proveedor_id)
VALUES ('Karen', 'Reyez', 'Zavaleta', '844966',1);

INSERT INTO contacto_proveedor(nombre, apellido_paterno,apellido_materno, telefono, proveedor_id)
VALUES ('Camila', 'Hernandez', 'Rosa', '97846',3);



SELECT *
FROM contacto_proveedor;

SELECT *
FROM proveedor;


-- Elimina todos los registros de la tabla y reinicia los IDENTITIES y que np tenga referencias
TRUNCATE TABLE contacto_proveedor;
DROP TABLE contacto_proveedor;

DROP TABLE proveedor;
-- ON DELETE y ON UPDATE NO ACTION
CREATE TABLE proveedor(
	proveedor_id INT NOT NULL,
	empresa VARCHAR (20) NOT NULL,
	limite_credito NUMERIC(10,2) NOT NULL,
	activo BIT NOT NULL
	CONSTRAINT df_proveedor_activo
	DEFAULT 1,
	created_at DATETIME2 NOT NULL
	CONSTRAINT df_proveedor_created_at
	DEFAULT SYSDATETIME(),
	update_at DATETIME2 NOT NULL
	CONSTRAINT df_proveedor_update_at
	DEFAULT SYSDATETIME()
	CONSTRAINT pk_proveedor
	PRIMARY KEY (proveedor_id),
	CONSTRAINT uq_proveedor_empresa
	UNIQUE (empresa),
	CONSTRAINT ck_proveedor_limite_credito
	CHECK (limite_credito BETWEEN 100 AND 100000)

	);

CREATE TABLE contacto_proveedor(
		constacto_id INT IDENTITY (1,1)
		CONSTRAINT pk_contacto_proveedor
		PRIMARY KEY,
		nombre VARCHAR(30) NOT NULL,
		apellido_paterno VARCHAR (15) NOT NULL,
		apellido_materno VARCHAR (15) NULL,
		telefono VARCHAR (18) NOT NULL,
		proveedor_id INT,
		CONSTRAINT fk_contacto_proveedor_proveedor
		FOREIGN KEY (proveedor_id)
		REFERENCES proveedor (proveedor_id)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION

);
GO

INSERT INTO proveedor(proveedor_id, empresa, limite_credito)
VALUES (1,'Coca-Cola', 7800),
		(2, 'Pepsi', 4585),
		(3, 'Bimbo', 10000);
		


-- Eliminar el padre con no action

DELETE FROM contacto_proveedor 
WHERE proveedor_id = 1;

DELETE FROM proveedor
WHERE proveedor_id = 1;


-- ALTER:TABLE

-- TODO: Se debe revisar el UPDATE NO ACTION Y LAS DEMAS INTEGRIDADES REFERENCIALES