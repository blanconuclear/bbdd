-- Verifica si la base de datos EUROVISION existe, si sí, bórrala
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'EUROVISION')
BEGIN
    DROP DATABASE EUROVISION;
END
GO

-- Crea la base de datos EUROVISION
CREATE DATABASE EUROVISION;
GO

-- Crea la tabla INTERPRETE
CREATE TABLE INTERPRETE(
    numero int NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    fecha_nac DATE NULL constraint CHK_INTERPRETE_fecha_nac CHECK (DATEDIFF(year,getdate(),fecha_nac) >= 16),
    num_cancion INT NOT NULL,

    CONSTRAINT PK_INTERPRETE_numero PRIMARY KEY (numero),
    CONSTRAINT UQ_INTERPRETE_nombre UNIQUE (nombre),
    -- El nombre de la tabla referenciada debe ser CANCION en lugar de CANCION
 
);

-- Crea la tabla CANCION
CREATE TABLE CANCION(
    numero INT NOT NULL,
    titulo VARCHAR(80) NOT NULL,
    id_pais INT NOT NULL,

    CONSTRAINT PK_CANCION_numero PRIMARY KEY (numero),
    CONSTRAINT UQ_CANCION_id_pais  UNIQUE (id_pais),
    
);

-- Crea la tabla PAIS
CREATE TABLE PAIS(
    identificador INT NOT NULL,
    denominacion VARCHAR(70) NOT NULL

	CONSTRAINT PK_PAIS_identificador PRIMARY KEY (identificador)
);

-- Crea la tabla VOTACION
CREATE TABLE VOTACION(
    id_vota_a INT NOT NULL,
    id_es_votado_por INT NOT NULL,
    puntos INT NOT NULL CONSTRAINT DF_VOTACION_puntos DEFAULT (0),
    CONSTRAINT PK_VOTACION PRIMARY KEY (id_vota_a,id_es_votado_por),
    
);


ALTER TABLE INTERPRETE
ADD
CONSTRAINT FK_INTERPRETE_num_cancion FOREIGN KEY (num_cancion)
                                    REFERENCES CANCION (numero);

ALTER TABLE CANCION
ADD
CONSTRAINT FK_CANCION_id_pais FOREIGN KEY (id_pais) 
                                REFERENCES PAIS (identificador);

ALTER TABLE VOTACION
ADD
CONSTRAINT FK_PAIS_vota_a FOREIGN KEY (id_vota_a)
                            REFERENCES PAIS (identificador),
    CONSTRAINT FK_PAIS_es_votado_por FOREIGN KEY (id_es_votado_por)
                            REFERENCES PAIS (identificador);