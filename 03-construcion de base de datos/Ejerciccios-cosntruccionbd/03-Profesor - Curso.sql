/*=========================================================
    CREAR LA BASE DE DATOS
=========================================================*/
CREATE DATABASE cursos_db;
GO

/*=========================================================
    UTILIZAR LA BASE DE DATOS
=========================================================*/
USE cursos_db;
GO

/*=========================================================
    CREAR TABLA PROFESOR
=========================================================*/
CREATE TABLE profesor(
	id_profesor INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_profesor
	PRIMARY KEY,

	nombre VARCHAR(50) NOT NULL,

	apellido_paterno VARCHAR(50) NOT NULL,

	apellido_materno VARCHAR(50) NOT NULL,

	especialidad VARCHAR(100) NOT NULL,

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_profesor_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_profesor_updated_at
	DEFAULT SYSDATETIME()
);
GO

/*=========================================================
    CREAR TABLA CURSO
=========================================================*/
CREATE TABLE curso(
	id_curso INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_curso
	PRIMARY KEY,

	nombre VARCHAR(100) NOT NULL
	CONSTRAINT uq_curso_nombre
	UNIQUE,

	creditos INT NOT NULL
	CONSTRAINT ck_curso_creditos
	CHECK (creditos > 0),

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_curso_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_curso_updated_at
	DEFAULT SYSDATETIME(),

	id_profesor INT NOT NULL,

	CONSTRAINT fk_curso_profesor
	FOREIGN KEY (id_profesor)
	REFERENCES profesor(id_profesor)
);
GO