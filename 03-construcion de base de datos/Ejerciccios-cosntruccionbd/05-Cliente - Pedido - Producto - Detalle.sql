
CREATE DATABASE ventas_db;
GO


USE ventas_db;
GO


CREATE TABLE cliente(
	id_cliente INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_cliente
	PRIMARY KEY,

	nombre_cliente VARCHAR(100) NOT NULL,

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_cliente_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_cliente_updated_at
	DEFAULT SYSDATETIME()
);
GO


CREATE TABLE producto(
	id_producto INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_producto
	PRIMARY KEY,

	nombre_producto VARCHAR(100) NOT NULL
	CONSTRAINT uq_producto_nombre
	UNIQUE,

	precio DECIMAL(10,2) NOT NULL
	CONSTRAINT ck_producto_precio
	CHECK (precio > 0),

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_producto_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_producto_updated_at
	DEFAULT SYSDATETIME()
);
GO


CREATE TABLE pedido(
	id_pedido INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_pedido
	PRIMARY KEY,

	fecha_pedido DATE NOT NULL
	CONSTRAINT df_pedido_fecha
	DEFAULT GETDATE(),

	costo_venta DECIMAL(10,2) NOT NULL
	CONSTRAINT ck_pedido_costo
	CHECK (costo_venta > 0),

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_pedido_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_pedido_updated_at
	DEFAULT SYSDATETIME(),

	id_cliente INT NOT NULL,

	CONSTRAINT fk_pedido_cliente
	FOREIGN KEY (id_cliente)
	REFERENCES cliente(id_cliente)
);
GO

CREATE TABLE detalle(
	id_detalle INT NOT NULL IDENTITY(1,1)
	CONSTRAINT pk_detalle
	PRIMARY KEY,

	cantidad_vendida INT NOT NULL
	CONSTRAINT ck_detalle_cantidad
	CHECK (cantidad_vendida > 0),

	created_at DATETIME2 NOT NULL
	CONSTRAINT df_detalle_created_at
	DEFAULT SYSDATETIME(),

	updated_at DATETIME2 NOT NULL
	CONSTRAINT df_detalle_updated_at
	DEFAULT SYSDATETIME(),

	id_pedido INT NOT NULL,

	id_producto INT NOT NULL,

	CONSTRAINT fk_detalle_pedido
	FOREIGN KEY (id_pedido)
	REFERENCES pedido(id_pedido),

	CONSTRAINT fk_detalle_producto
	FOREIGN KEY (id_producto)
	REFERENCES producto(id_producto)
);
GO