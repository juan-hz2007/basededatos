
CREATE DATABASE comercializadora_db;
GO


USE comercializadora_db;
GO


CREATE TABLE oficina(
	num_oficina INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_oficina
	PRIMARY KEY,

	ciudad VARCHAR(50) NOT NULL,

	region VARCHAR(30) NOT NULL,

	ventas DECIMAL(12,2) NOT NULL
	CONSTRAINT ck_oficina_ventas
	CHECK(ventas >= 0),

	objetivo DECIMAL(12,2) NOT NULL
	CONSTRAINT ck_oficina_objetivo
	CHECK(objetivo > 0),

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_oficina_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_oficina_updated_at
	DEFAULT SYSDATETIME()
);
GO


CREATE TABLE representante(
	num_emp INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_representante
	PRIMARY KEY,

	nombre VARCHAR(50) NOT NULL,

	ap1 VARCHAR(50) NOT NULL,

	ap2 VARCHAR(50) NOT NULL,

	fecha_contrato DATE NOT NULL,

	puesto VARCHAR(40) NOT NULL,

	edad INT NOT NULL
	CONSTRAINT ck_representante_edad
	CHECK(edad >=18),

	ventas DECIMAL(12,2) NOT NULL
	CONSTRAINT ck_representante_ventas
	CHECK(ventas>=0),

	num_oficina INT NOT NULL,

	jefe INT NULL,

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_representante_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_representante_updated_at
	DEFAULT SYSDATETIME(),

	CONSTRAINT fk_representante_oficina
	FOREIGN KEY(num_oficina)
	REFERENCES oficina(num_oficina)
);
GO

ALTER TABLE representante
ADD CONSTRAINT fk_representante_jefe
FOREIGN KEY(jefe)
REFERENCES representante(num_emp);
GO


CREATE TABLE cliente(
	num_cliente INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_cliente
	PRIMARY KEY,

	nombre_cliente VARCHAR(100) NOT NULL,

	limite_credito DECIMAL(12,2) NOT NULL
	CONSTRAINT ck_cliente_credito
	CHECK(limite_credito>0),

	num_emp INT NOT NULL,

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_cliente_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_cliente_updated_at
	DEFAULT SYSDATETIME(),

	CONSTRAINT fk_cliente_representante
	FOREIGN KEY(num_emp)
	REFERENCES representante(num_emp)
);
GO


CREATE TABLE pedido(
	num_pedido INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_pedido
	PRIMARY KEY,

	fecha_pedido DATE NOT NULL
	CONSTRAINT df_pedido_fecha
	DEFAULT GETDATE(),

	num_cliente INT NOT NULL,

	num_emp INT NOT NULL,

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_pedido_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_pedido_updated_at
	DEFAULT SYSDATETIME(),

	CONSTRAINT fk_pedido_cliente
	FOREIGN KEY(num_cliente)
	REFERENCES cliente(num_cliente),

	CONSTRAINT fk_pedido_representante
	FOREIGN KEY(num_emp)
	REFERENCES representante(num_emp)
);
GO


CREATE TABLE producto(
	num_producto INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_producto
	PRIMARY KEY,

	descripcion VARCHAR(120) NOT NULL,

	fabricante VARCHAR(100) NOT NULL,

	precio DECIMAL(10,2) NOT NULL
	CONSTRAINT ck_producto_precio
	CHECK(precio>0),

	existencia INT NOT NULL
	CONSTRAINT ck_producto_existencia
	CHECK(existencia>=0),

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_producto_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_producto_updated_at
	DEFAULT SYSDATETIME()
);
GO


CREATE TABLE incluye(
	id_incluye INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_incluye
	PRIMARY KEY,

	num_pedido INT NOT NULL,

	num_producto INT NOT NULL,

	cantidad INT NOT NULL
	CONSTRAINT ck_incluye_cantidad
	CHECK(cantidad>0),

	importe DECIMAL(12,2) NOT NULL
	CONSTRAINT ck_incluye_importe
	CHECK(importe>0),

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_incluye_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_incluye_updated_at
	DEFAULT SYSDATETIME(),

	CONSTRAINT fk_incluye_pedido
	FOREIGN KEY(num_pedido)
	REFERENCES pedido(num_pedido),

	CONSTRAINT fk_incluye_producto
	FOREIGN KEY(num_producto)
	REFERENCES producto(num_producto)
);
GO