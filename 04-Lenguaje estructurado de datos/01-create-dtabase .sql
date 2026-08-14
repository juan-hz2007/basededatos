/*========================================================

SQL-DQL EN SQL SERVER

ARCHIVO:01-CREATE-DATABASE.SQL

DESCRIPCION :CREA LA BASE DE DATOS PARA EL LENGUAJE SQL

=========================================================*/

USE master;
GO

IF DB_ID('comercial_db')IS NOT NULL
BEGIN 
	ALTER DATABASE comercial_db
	SET SINGLE_USER
	WITH ROLLBACK IMMEDIATE;

	DROP DATABASE comercial_db;

END;
GO

CREATE DATABASE comercial_db;
GO 

USE comercial_db;
GO

PRINT 'la base de datos comercial_db se creo correctamente';

-- SELECT DB_ID('comercial_db');



