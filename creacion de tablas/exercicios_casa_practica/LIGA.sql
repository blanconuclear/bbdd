IF EXISTS (SELECT * FROM sys.databases WHERE name = 'LIGA')
BEGIN
    DROP DATABASE LIGA;
END
GO


CREATE DATABASE LIGA;
GO
USE LIGA;
GO

CREATE TABLE EQUIPO(
    identificador INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    cif CHAR(9) NOT NULL,  
    presupuesto DECIMAL(14,2) NOT NULL, 
    cod_division INT NOT NULL,
    num_campo INT NOT NULL,

    CONSTRAINT PK_EQUIPO_identificador PRIMARY KEY (identificador),
    CONSTRAINT UQ_EQUIPO_nombre UNIQUE (nombre),
    CONSTRAINT UQ_EQUIPO_cif UNIQUE (cif),
    CONSTRAINT UQ_EQUIPO_num_campo UNIQUE (num_campo),
);


CREATE TABLE PARTIDO(
    fecha_hora DATETIME NOT NULL,
    observaciones VARCHAR(150) NULL,
    id_equipo_local INT NOT NULL,
    id_equipo_visitante INT NOT NULL,

    CONSTRAINT PK_PARTIDO_equipo_local_fecha_hora PRIMARY KEY (fecha_hora,id_equipo_local)
);

CREATE TABLE CAMPO(
    numero INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,

    CONSTRAINT PK_CAMPO_numero PRIMARY KEY (numero),
    CONSTRAINT UQ_CAMPO_nombre UNIQUE (nombre)
)

CREATE TABLE DIVISION(
    codigo INT NOT NULL,
    nombre VARCHAR(70) NOT NULL,
    categoria CHAR(4) NULL,

    CONSTRAINT PK_DIVISION_codigo PRIMARY KEY (codigo),
    CONSTRAINT UQ_DIVISION_nombre UNIQUE (nombre)
)

--FK

ALTER TABLE EQUIPO
ADD
CONSTRAINT FK_EQUIPO_cod_divisiono
FOREIGN KEY (cod_division)
REFERENCES DIVISION (codigo),

CONSTRAINT FK_EQUIPO_num_campo
FOREIGN KEY (num_campo)
REFERENCES CAMPO (numero)

ALTER TABLE PARTIDO
ADD
CONSTRAINT FK_PARTIDO_id_equipo_local 
FOREIGN KEY (id_equipo_local)
REFERENCES EQUIPO (identificador),

CONSTRAINT FK_PARTIDO_id_equipo_visitante 
FOREIGN KEY (id_equipo_visitante)
REFERENCES EQUIPO (identificador)



