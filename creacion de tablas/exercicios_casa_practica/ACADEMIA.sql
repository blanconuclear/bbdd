CREATE DATABASE ACADEMIA;
GO
USE ACADEMIA;
GO


--drop database ACADEMIA;

CREATE TABLE EMPLEADO(
    codigo TINYINT NOT NULL,
    tipo_doc VARCHAR(5) NOT NULL,
    num_doc CHAR(15),
    tel1 CHAR(9) NULL,
    tel2 CHAR(9) NULL,
    tel3 CHAR(9) NULL,
    fecha_contrato DATE NOT NULL,

    CONSTRAINT PK_EMPLEADO_codigo PRIMARY KEY (codigo)
)


CREATE TABLE EDICION(
    numero TINYINT NOT NULL,
    fecha_hora_inicio DATETIME NOT NULL,
    cod_empleado TINYINT NOT NULL, 
    cod_curso TINYINT NOT NULL,

    CONSTRAINT PK_EDICION_numero PRIMARY KEY (numero)
)

CREATE TABLE CURSO(
    codigo tinyint not null,
    titulo varchar(80) not null,
	num_horas tinyint not null,

    CONSTRAINT PK_CURSO_codigo PRIMARY KEY (codigo),
    CONSTRAINT UQ_CURSO_titulo UNIQUE (titulo)
)

CREATE TABLE PRERREQUISITO(
    cod_es_prerrequisito_de TINYINT NOT NULL,
    cod_tiene_por_requisito_a TINYINT NOT NULL,
    tipo CHAR(1) NULL,

    CONSTRAINT PK_PRERREQUISITO_cod_es_prerrequisito_de PRIMARY KEY (cod_es_prerrequisito_de),
    CONSTRAINT UQ_PRERREQUISITO_cod_tiene_por_requisito_a UNIQUE (cod_tiene_por_requisito_a)
)




--FK

ALTER TABLE EDICION
ADD
CONSTRAINT FK_EDICION_cod_empleado FOREIGN KEY (cod_empleado)
REFERENCES EMPLEADO (codigo),

CONSTRAINT FK_EDICION_cod_curso FOREIGN KEY (cod_curso)
REFERENCES CURSO (codigo)


ALTER TABLE PRERREQUISITO
ADD
CONSTRAINT FK_PRERREQUISITO_cod_es_prerrequisito_de FOREIGN KEY (cod_es_prerrequisito_de)
REFERENCES CURSO (codigo),

CONSTRAINT FK_PRERREQUISITO_cod_tiene_por_requisito_a FOREIGN KEY (cod_tiene_por_requisito_a)
REFERENCES CURSO (codigo)
