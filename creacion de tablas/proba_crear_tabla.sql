CREATE DATABASE EUROVISION
GO
USE EUROVISION
GO

--TABLA INTERPRETE
CREATE TABLE INTERPRETE(
    numero int NOT NULL,
    nombre VARCHAR(70) NOT NULL,
    data_nac DATE not NULL,
    num_cancion INT NOT NULL,
    CONSTRAINT PK_INTERPRETE_numero PRIMARY KEY (numero),
    CONSTRAINT UQ_INTERPRETE_nombre UNIQUE (nombre)
);

--TABLA CANCION
CREATE TABLE CANCION(
    numero INT NOT NULL,
    titulo VARCHAR(80),
    id_pais INT NOT NULL,
    CONSTRAINT PK_CANCION_numero PRIMARY KEY (numero)
);

--TABLA PAIS
CREATE TABLE PAIS(
    identificador INT NOT NULL,
    denominacion VARCHAR(70) NOT NULL,
    id_pais_vota_a INT NOT NULL,
    id_pais_votado_por INT NOT NULL
    CONSTRAINT PK_PAIS_identificador PRIMARY KEY (identificador),
    CONSTRAINT UQ_PAIS_denominacion UNIQUE (denominacion)
);

--TABLA VOTACION
CREATE TABLE VOTACION(
    puntos INT NOT NULL,
    id_pais_vota_a INT NOT NULL,
    id_pais_votado_por INT NOT NULL
    CONSTRAINT PK_VOTACION_id_voto PRIMARY KEY ( id_pais_vota_a,
    id_pais_votado_por)
);

/**** VALORES POR DEFECTO ****************/
ALTER TABLE VOTACION
ADD CONSTRAINT DF_VOTACION_puntos DEFAULT 0 FOR puntos;

/*** CLAVES FORÁNEAS ****************/
ALTER TABLE INTERPRETE
ADD
CONSTRAINT FK_INTERPRETE_numero