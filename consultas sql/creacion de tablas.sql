CREATE DATABASE EUROVISION;
GO
USE EUROVISION;
GO
/****** CREACIÓN DE TÁBOAS ******/
--TÁBOA SOCIO
CREATE TABLE INTERPRETE(
	numero int NOT NULL,
	nome varchar(40) NOT NULL,
	data_nac date NULL,
	num_cancion int NOT NULL,
	CONSTRAINT PK_INTERPRETE_numero PRIMARY KEY (numero),
	CONSTRAINT UQ_INTERPRETE_nome UNIQUE (nome)
);

--TÁBOA CANCION
CREATE TABLE CANCION(
	numero int NOT NULL,
	titulo varchar(80) NULL,
	id_pais int NOT NULL,
	CONSTRAINT PK_CANCION_numero PRIMARY KEY (numero)
);

--TÁBOA PAIS
CREATE TABLE PAIS(
	identificador int NOT NULL,
	denominacion varchar(70) NOT NULL
	CONSTRAINT PK_PAIS_identificador PRIMARY KEY (identificador)
);

--TÁBOA VOTACIÓN
CREATE TABLE VOTACION(
	puntos int NOT NULL,
	id_pais_vota_a int NOT NULL,
	id_pais_votado_por int NOT NULL,
	CONSTRAINT PK_VOTACION PRIMARY KEY (id_pais_vota_a,id_pais_votado_por)
)


/**** VALORES POR DEFECTO ****************/
ALTER TABLE VOTACION
ADD CONSTRAINT DF_VOTACION_puntos DEFAULT 0 FOR puntos;


/**** CHECKS - VERIFICACIÓNS ***************/
ALTER TABLE INTERPRETE
ADD CONSTRAINT CHK_INTERPRETE_data_nac CHECK(DATEDIFF(YEAR,GETDATE(),data_nac) > 16);


/*** CLAVES FORÁNEAS ****************/
ALTER TABLE INTERPRETE
ADD
CONSTRAINT FK_INTERPRETE_num_cancion
FOREIGN KEY(num_cancion)
REFERENCES CANCION (numero)
ON UPDATE CASCADE;

ALTER TABLE CANCION
ADD
CONSTRAINT FK_CANCION_id_pais
FOREIGN KEY(id_pais)
REFERENCES CANCION (pais)
ON UPDATE CASCADE;

ALTER TABLE VOTACION
ADD
CONSTRAINT FK_VOTACION_
FOREIGN KEY(id_pais_vota_an)
REFERENCES PAIS (id_pais_vota_a)
ON UPDATE CASCADE,
CONSTRAINT FK_VOTACION_
FOREIGN KEY(id_pais_votado_por)
REFERENCES PAIS (id_pais_votado_por)
ON UPDATE CASCADE;


