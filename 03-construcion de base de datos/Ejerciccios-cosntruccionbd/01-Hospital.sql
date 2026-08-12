
CREATE DATABASE hospital_db;
GO


USE hospital_db;
GO

CREATE TABLE paciente(
    id_paciente INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_paciente
    PRIMARY KEY,

    nombre VARCHAR(100) NOT NULL,

    fecha_nacimiento DATE NOT NULL,

    created_at DATETIME2 NOT NULL
    CONSTRAINT df_paciente_created_at
    DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
    CONSTRAINT df_paciente_updated_at
    DEFAULT SYSDATETIME()
);
GO


CREATE TABLE expediente(
    id_expediente INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_expediente
    PRIMARY KEY,

    numero_expediente VARCHAR(20) NOT NULL
    CONSTRAINT uq_expediente_numero
    UNIQUE,

    tipo_sangre VARCHAR(5) NOT NULL
    CONSTRAINT ck_expediente_tipo_sangre
    CHECK (tipo_sangre IN
    ('A+','A-','B+','B-','AB+','AB-','O+','O-')),

    fecha_apertura DATE NOT NULL,

    id_paciente INT NOT NULL
    CONSTRAINT uq_expediente_paciente
    UNIQUE,

    created_at DATETIME2 NOT NULL
    CONSTRAINT df_expediente_created_at
    DEFAULT SYSDATETIME(),

    updated_at DATETIME2 NOT NULL
    CONSTRAINT df_expediente_updated_at
    DEFAULT SYSDATETIME(),

    CONSTRAINT fk_expediente_paciente
    FOREIGN KEY(id_paciente)
    REFERENCES paciente(id_paciente)
);
GO