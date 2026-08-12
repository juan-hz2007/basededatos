
CREATE DATABASE empresa_db;
GO


USE empresa_db;
GO


CREATE TABLE sucursal(
    clave INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_sucursal
    PRIMARY KEY,

    nombre VARCHAR(100) NOT NULL,

    ciudad VARCHAR(50) NOT NULL,

    estado VARCHAR(50) NOT NULL,

    telefono VARCHAR(20),

    created_at DATETIME2 NOT NULL
    CONSTRAINT df_sucursal_created_at
    DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
    CONSTRAINT df_sucursal_updated_at
    DEFAULT SYSDATETIME()
);
GO


CREATE TABLE puesto(
    clave INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_puesto
    PRIMARY KEY,

    nombre VARCHAR(60) NOT NULL,

    salario_min DECIMAL(10,2) NOT NULL
    CONSTRAINT ck_puesto_salario_min
    CHECK(salario_min>0),

    salario_max DECIMAL(10,2) NOT NULL
    CONSTRAINT ck_puesto_salario_max
    CHECK(salario_max>=salario_min),

    nivel_jerarquico VARCHAR(50),

    sucursal_id INT NOT NULL,

    created_at DATETIME2 NOT NULL
    CONSTRAINT df_puesto_created_at
    DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
    CONSTRAINT df_puesto_updated_at
    DEFAULT SYSDATETIME(),

    CONSTRAINT fk_puesto_sucursal
    FOREIGN KEY(sucursal_id)
    REFERENCES sucursal(clave)
);
GO


CREATE TABLE departamento(
    clave_departamento INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_departamento
    PRIMARY KEY,

    nombre VARCHAR(100) NOT NULL,

    ubicacion VARCHAR(100),

    presupuesto DECIMAL(12,2)
    CONSTRAINT ck_departamento_presupuesto
    CHECK(presupuesto>0),

    created_at DATETIME2 NOT NULL
    CONSTRAINT df_departamento_created_at
    DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
    CONSTRAINT df_departamento_updated_at
    DEFAULT SYSDATETIME()
);
GO



CREATE TABLE empleado(
    numero_emp INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_empleado
    PRIMARY KEY,

    nombre VARCHAR(50) NOT NULL,

    ap1 VARCHAR(50) NOT NULL,

    ap2 VARCHAR(50),

    correo VARCHAR(100)
    CONSTRAINT uq_empleado_correo
    UNIQUE,

    fecha_nac DATE NOT NULL,

    departamento_id INT NOT NULL,

    puesto_id INT NOT NULL,

    jefe_id INT NULL,

    created_at DATETIME2 NOT NULL
    CONSTRAINT df_empleado_created_at
    DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
    CONSTRAINT df_empleado_updated_at
    DEFAULT SYSDATETIME(),

    CONSTRAINT fk_empleado_departamento
    FOREIGN KEY(departamento_id)
    REFERENCES departamento(clave_departamento),

    CONSTRAINT fk_empleado_puesto
    FOREIGN KEY(puesto_id)
    REFERENCES puesto(clave)
);
GO


ALTER TABLE empleado
ADD CONSTRAINT fk_empleado_jefe
FOREIGN KEY(jefe_id)
REFERENCES empleado(numero_emp);
GO


CREATE TABLE capacitacion(
    id_capacitacion INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_capacitacion
    PRIMARY KEY,

    fecha DATE NOT NULL,

    departamento_id INT NOT NULL,

    created_at DATETIME2 NOT NULL
    CONSTRAINT df_capacitacion_created_at
    DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
    CONSTRAINT df_capacitacion_updated_at
    DEFAULT SYSDATETIME(),

    CONSTRAINT fk_capacitacion_departamento
    FOREIGN KEY(departamento_id)
    REFERENCES departamento(clave_departamento)
);
GO


CREATE TABLE proyecto(
    clave INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_proyecto
    PRIMARY KEY,

    nombre VARCHAR(100) NOT NULL,

    presupuesto DECIMAL(12,2)
    CONSTRAINT ck_proyecto_presupuesto
    CHECK(presupuesto>0),

    fecha_inicio DATE,

    fecha_fin DATE,

    created_at DATETIME2 NOT NULL
    CONSTRAINT df_proyecto_created_at
    DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
    CONSTRAINT df_proyecto_updated_at
    DEFAULT SYSDATETIME()
);
GO

CREATE TABLE participa(
    id_participa INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_participa
    PRIMARY KEY,

    numero_emp INT NOT NULL,

    clave_proyecto INT NOT NULL,

    rol VARCHAR(50),

    horas DECIMAL(5,2),

    fecha_asignacion DATE,

    CONSTRAINT fk_participa_empleado
    FOREIGN KEY(numero_emp)
    REFERENCES empleado(numero_emp),

    CONSTRAINT fk_participa_proyecto
    FOREIGN KEY(clave_proyecto)
    REFERENCES proyecto(clave)
);
GO


CREATE TABLE asistir(
    id_asistencia INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_asistir
    PRIMARY KEY,

    numero_emp INT NOT NULL,

    id_capacitacion INT NOT NULL,

    calificacion DECIMAL(4,2)
    CONSTRAINT ck_asistir_calificacion
    CHECK(calificacion BETWEEN 0 AND 10),

    estatus VARCHAR(30),

    CONSTRAINT fk_asistir_empleado
    FOREIGN KEY(numero_emp)
    REFERENCES empleado(numero_emp),

    CONSTRAINT fk_asistir_capacitacion
    FOREIGN KEY(id_capacitacion)
    REFERENCES capacitacion(id_capacitacion)
);
GO