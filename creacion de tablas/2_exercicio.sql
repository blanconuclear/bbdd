CREATE DATABASE LIGA_EFREN;
GO
USE LIGA_EFREN;
GO

CREATE TABLE EQUIPO(
identificador int NOT NULL,
nombre varchar(30) NOT NULL,
cif char(9) NOT NULL,
presupuesto float NOT NULL,
cod_division int NOT NULL, --FORANEA DE DIVISION
num_campo int NOT NULL --FORENEA DE CAMPO

CONSTRAINT PK_EQUIPO_identificador PRIMARY KEY (identificador),
CONSTRAINT UQ_EQUIPO_nombre UNIQUE (nombre),
CONSTRAINT UQ_EQUIPO_cif UNIQUE (cif),
CONSTRAINT UQ_EQUIPO_num_campo UNIQUE (num_campo)

);

CREATE TABLE PARTIDO(
fechaHora datetime NOT NULL,
observaciones varchar(150) NULL,
id_equipo_local int NOT NULL,
id_equipo_visitante int NOT NULL,

CONSTRAINT PK_PARTIDO_equipo_local_fechaHora PRIMARY KEY(id_equipo_local, fechaHora)

)

CREATE TABLE DIVISION(
codigo int NOT NULL,
nombre char(70) NOT NULL,
categoria varchar(4) NOT NULL,

CONSTRAINT PK_DIVISION_codigo PRIMARY KEY (codigo),
CONSTRAINT UQ_DIVISION_nombre UNIQUE (nombre)
)


CREATE TABLE CAMPO(
numero int NOT NULL,
nombre varchar(100) NOT NULL,
capacidad int NOT NULL

CONSTRAINT PK_CAMPO_numero PRIMARY KEY (numero),
CONSTRAINT UQ_CAMPO_nombre UNIQUE (nombre)
)

/**** CHECKS ****************/
ALTER TABLE DIVISION
ADD
CONSTRAINT DF_DIVISION_categoria DEFAULT ('1DIV') FOR categoria;

ALTER TABLE CAMPO
ADD
CONSTRAINT CHK_CAMPO_capacidad CHECK (capacidad >= 500);


/*** CLAVES FORÁNEAS ****************/
ALTER TABLE EQUIPO
ADD 
CONSTRAINT FK_EQUIPO_cod_division 
    FOREIGN KEY (cod_division) REFERENCES DIVISION (codigo) ON UPDATE CASCADE,

CONSTRAINT FK_EQUIPO_num_campo
    FOREIGN KEY (num_campo) REFERENCES CAMPO (numero) ON UPDATE CASCADE;

ALTER TABLE PARTIDO
ADD
CONSTRAINT FK_PARTIDO_id_equipo_local
 FOREIGN KEY (id_equipo_local) REFERENCES EQUIPO (identificador) ON UPDATE NO ACTION,

CONSTRAINT FK_PARTIDO_id_equipo_visitante
FOREIGN KEY (id_equipo_visitante) REFERENCES EQUIPO (identificador) ON UPDATE NO ACTION;