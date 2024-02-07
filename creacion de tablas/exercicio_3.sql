CREATE DATABASE VIDEOTECA_EFREN;
GO
USE VIDEOTECA_EFREN;
GO

CREATE TABLE PRODUCTORA(
identificador int NOT NULL,
NOMBRE varchar(30) NOT NULL,

CONSTRAINT PK_PRODUCTORA_identificador PRIMARY KEY (identificador),
CONSTRAINT UQ_PRODUCTORA_NOMBRE UNIQUE (nombre)
);

CREATE TABLE PELICULA(
codigo int NOT NULL,
titulo varchar(150) NOT NULL,
fecha_estreno date NULL CONSTRAINT CHK_PELICULA_fecha_estreno CHECK (fecha_estreno <= GETDATE()) ,
id_productora int NULL,

CONSTRAINT PK_PELICULA_codigo PRIMARY KEY (codigo),
CONSTRAINT UQ_PELICULA_titulo UNIQUE (titulo),
CONSTRAINT FK_PELICULA_id_productora FOREIGN KEY (id_productora)
									REFERENCES PRODUCTORA (identificador) ON UPDATE CASCADE
);

CREATE TABLE CAJA(
numero tinyint NOT NULL,
estanteria int NOT NULL,
balda int NOT NULL CONSTRAINT DF_CAJA_BALDA DEFAULT(0),

CONSTRAINT PK_CAJA_numero PRIMARY KEY (numero)
);



CREATE TABLE COPIA(
numero int NOT NULL,
formato char(1) NOT NULL CONSTRAINT CHK_COPIA_formato CHECK (formato IN('D','V','S')),
cod_pelicula int NOT NULL,
num_caja tinyint NOT NULL,

CONSTRAINT PK_COPIA_numero_cod_pelicula PRIMARY KEY (numero,cod_pelicula),
CONSTRAINT UK_COPIA_num_caja UNIQUE (num_caja),
CONSTRAINT FK_COPIA_cod_pelicula FOREIGN KEY (cod_pelicula)
								REFERENCES PELICULA (codigo) ON UPDATE CASCADE,
CONSTRAINT FK_COPIA_num_caja FOREIGN KEY (num_caja)
								REFERENCES CAJA (numero) ON UPDATE CASCADE
);


CREATE TABLE PERSONA(
codigo int NOT NULL,
nombre varchar(50) NOT NULL,
ap1 varchar(50) NOT NULL,
ap2 varchar(50) NULL,
tipo_doc char(5),
num_doc varchar(15),
tipo char(3) NOT NULL CONSTRAINT CHK_PESONA_tipo CHECK (tipo in ('EMP','SOC')),

CONSTRAINT PK_PERSONA_codigo PRIMARY KEY (codigo),
CONSTRAINT UQ_PERSONA_tipo_doc_num_doc UNIQUE (tipo_doc,num_doc)
);

CREATE TABLE EMPLEADO(
cod_emple int NOT NULL

CONSTRAINT PK_EMPLEADO_cod_emple PRIMARY KEY (cod_emple),
CONSTRAINT FK_EMPLEADO_cod_emple  FOREIGN KEY (cod_emple)
									REFERENCES PERSONA (codigo) ON UPDATE CASCADE
);

CREATE TABLE MANDA_EN(
cod_emple_supervisa_a int NOT NULL,
cod_emple_es_supervisada_por int NOT NULL,

CONSTRAINT PK_MANDA_EN_cod_emple_supervisa_a PRIMARY KEY (cod_emple_supervisa_a),
CONSTRAINT UQ_MANDA_EN_cod_emple_es_supervisada_por UNIQUE (cod_emple_es_supervisada_por),

CONSTRAINT FK_MANDA_EN_cod_emple_supervisa_a FOREIGN KEY (cod_emple_supervisa_a)
									      REFERENCES EMPLEADO (cod_emple) ON UPDATE NO ACTION,

CONSTRAINT FK_MANDA_EN_cod_emple_es_supervisada_por FOREIGN KEY (cod_emple_es_supervisada_por)
									               REFERENCES EMPLEADO (cod_emple) ON UPDATE NO ACTION
);

CREATE TABLE SOCIO(
cod_socio int NOT NULL

CONSTRAINT PK_EMPLEADO_cod_socio PRIMARY KEY (cod_socio),
CONSTRAINT FK_EMPLEADO_cod_socio  FOREIGN KEY (cod_socio)
									REFERENCES PERSONA (codigo) ON UPDATE CASCADE
)


CREATE TABLE ALQUILA(
cod_socio int NOT NULL,
num_copia int NOT NULL,
cod_pelicula int NOT NULL,

CONSTRAINT PK_ALQUILA_socio_pelicula_copia PRIMARY KEY (cod_socio,cod_pelicula),

CONSTRAINT FK_ALQUILA_cod_socio FOREIGN KEY (cod_socio)
								REFERENCES SOCIO (cod_socio) ON UPDATE CASCADE,

CONSTRAINT FK_ALQUILA_pelicula_copia FOREIGN KEY (num_copia,cod_pelicula)
								REFERENCES COPIA (numero,cod_pelicula) ON UPDATE CASCADE
)

























