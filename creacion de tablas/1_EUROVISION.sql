CREATE DATABASE EUROVISION_EFREN;
GO
USE EUROVISION_EFREN;
GO

CREATE TABLE INTERPRETE(
    numero int NOT NULL,
    nombre varchar(30) NOT NULL,
    fechanac DATE NULL,
    num_cancion int NOT NULL,
    CONSTRAINT PK_INTERPRETE_numero PRIMARY KEY (numero),
    CONSTRAINT UQ_INTERPRETE_nombre UNIQUE (nombre)
);

CREATE TABLE CANCION(
    numero int NOT NULL,
    titulo varchar(30) NULL,
    id_pais int NOT NULL,
    CONSTRAINT PK_CANCION_numero PRIMARY KEY (numero),
    CONSTRAINT UQ_CANCION_id_pais UNIQUE (id_pais)
);

CREATE TABLE PAIS(
    identificador int NOT NULL,
    denominacion varchar(70) NOT NULL,
    CONSTRAINT PK_PAIS_numero PRIMARY KEY (identificador),
	CONSTRAINT UQ_PAIS_decominacion UNIQUE (denominacion)
);

CREATE TABLE VOTACION(
    id_pais_vota_a int NOT NULL,
    id_pais_votado_por int NOT NULL,
    puntos int NULL,
    CONSTRAINT PK_VOTACION PRIMARY KEY (id_pais_vota_a, id_pais_votado_por)
);

/**** VALORES POR DEFECTO ****************/
ALTER TABLE VOTACION
ADD CONSTRAINT DF_VOTACION_puntos DEFAULT (0) FOR puntos;

/**** CHECKS - VERIFICACIÓNS ***************/
ALTER TABLE INTERPRETE
ADD CONSTRAINT CHK_INTERPRETE_fechanac CHECK (DATEDIFF(YEAR,GETDATE(),fechanac) > 16);

/*** CLAVES FORÁNEAS ****************/
ALTER TABLE INTERPRETE
ADD 
CONSTRAINT FK_INTREPRETE_num_cancion 
    FOREIGN KEY (num_cancion) REFERENCES CANCION (numero) ON UPDATE CASCADE;

ALTER TABLE CANCION
ADD 
CONSTRAINT FK_CANCION_id_pais
    FOREIGN KEY (id_pais) REFERENCES PAIS (identificador) ON UPDATE CASCADE;

ALTER TABLE VOTACION
ADD 
CONSTRAINT FK_VOTACION_id_pais_vota_a
    FOREIGN KEY (id_pais_vota_a) REFERENCES PAIS (identificador) ON UPDATE NO ACTION,
CONSTRAINT FK_VOTACION_id_pais_votado_por
    FOREIGN KEY (id_pais_votado_por) REFERENCES PAIS (identificador) ON UPDATE NO ACTION