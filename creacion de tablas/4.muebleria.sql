CREATE DATABASE MUEBLERIA_EFREN;
GO
USE MUEBLERIA_EFREN;
GO

CREATE TABLE EMPLEADO(
	numero int NOT NULL,
	nif char(9) NOT NULL,
	nombre varchar(30) NOT NULL,
	ap1 varchar(50) NOT NULL,
	ap2 varchar(50) NULL,
	tel1 char(9) NULL,
	tel2 char(9) NULL,
	salario numeric(6,2) NOT NULL,
	ccc_entidad char(4) NOT NULL,
	ccc_oficina char(4) NOT NULL,
	ccc_DC char(2) NOT NULL,
	ccc_numCuenta char(10) NOT NULL,
	cargo varchar(30) NOT NULL CONSTRAINT CHK_PESONA_tipo CHECK (cargo in ('PAP','MON','REP')),
	dieta AS (0.1*salario),

	CONSTRAINT PK_EMPLEADO_numero PRIMARY KEY (numero),
	CONSTRAINT UQ_EMPLEADO_nif UNIQUE (nif)
)


CREATE TABLE PERSONAL_AP(
	num_personal_ap int NOT NULL,
	objetivos_ventas numeric(8,3) NOT NULL 
	CONSTRAINT CHK_PERSONAL_AP_objetivos_ventas CHECK (objetivos_ventas BETWEEN 0 AND 15000.999)
	CONSTRAINT DF_PERSONAL_AP_objetivos_ventas DEFAULT (0),
	funcion char(3)

	CONSTRAINT PK_PERSONAL_AP_num_personal_ap PRIMARY KEY (num_personal_ap),
	CONSTRAINT FK_PERSONAL_AP_num_personal_ap FOREIGN KEY (num_personal_ap)
												REFERENCES EMPLEADO (numero)
)


CREATE TABLE VENDEDOR(
	num_vendedor int NOT NULL

	CONSTRAINT PK_VENDEDOR_num_vendedor PRIMARY KEY (num_vendedor)
	CONSTRAINT FK_VENDEDOR_num_vendedor FOREIGN KEY (num_vendedor)
												REFERENCES PERSONAL_AP (num_personal_ap)
)


CREATE TABLE VIGILA(
	vendedor_vigila_a int NOT NULl,
	vendedor_es_vigilado_por int NOT NULL

	CONSTRAINT PK_VIGILA_vendedor_vigila_a PRIMARY KEY (vendedor_vigila_a),
	CONSTRAINT UQ_VIGILA_vendedor_es_vigilado_por UNIQUE (vendedor_es_vigilado_por),
	CONSTRAINT FK_VIGILA_vendedor_vigila_a FOREIGN KEY (vendedor_vigila_a)
												REFERENCES VENDEDOR (num_vendedor),
	CONSTRAINT FK_VIGILA_vendedor_es_vigilado_pop FOREIGN KEY (vendedor_es_vigilado_por)
												REFERENCES VENDEDOR (num_vendedor)
)

CREATE TABLE MONTADOR(
	num_montador int NOT NULL,

	CONSTRAINT PK_MONTADOR_num_montador PRIMARY KEY (num_montador),
	CONSTRAINT FK_MONTADOR_num_montador FOREIGN KEY (num_montador)
												REFERENCES EMPLEADO (numero)
)

CREATE TABLE MUEBLE(
	identificador tinyint NOT NULl,
	marca varchar(50) NOT NULL,
	precio numeric(7,2) NOT NULL CONSTRAINT CHK_MUEBLE_precio CHECK (precio BETWEEN 0 AND 20000.55),
	fecha_fabricacion date NULL CONSTRAINT CHK_MUEBLE_fecha_fabricacion CHECK (fecha_fabricacion >= '01-01-2000'),
	num_montador int NOT NULL

	CONSTRAINT PK_MUEBLE_identificador PRIMARY KEY (identificador),
	CONSTRAINT FK_MUEBLE_num_montador FOREIGN KEY (num_montador)
												REFERENCES MONTADOR (num_montador)
)

CREATE TABLE REPARTIDOR(
	num_repartidor int NOT NULL,

	CONSTRAINT PK_REPARTIDOR_num_repartidor PRIMARY KEY (num_repartidor),
	CONSTRAINT FK_REPARTIDOR_num_repartidor FOREIGN KEY (num_repartidor)
												REFERENCES EMPLEADO (numero)
)

CREATE TABLE ENTREGA(
	fecha_hora_entrega datetime NOT NULL CONSTRAINT CHK_ENTREGA_fecha_hora_entrega CHECK (fecha_hora_entrega <= getDate()),
	num_repartidor int NOT NULL,
	id_mueble tinyint NOT NULL,
	fecha_hora_devolucion datetime NOT NULL, 
	CONSTRAINT CHK_ENTREGA_fecha_hora_devolucion CHECK (fecha_hora_devolucion > fecha_hora_entrega),

	CONSTRAINT PK_ENTREGA_fecha_hora_entrega_num_repartidor PRIMARY KEY (fecha_hora_entrega,num_repartidor),
	CONSTRAINT FK_ENTREGA_num_repartidor FOREIGN KEY (num_repartidor)
												REFERENCES REPARTIDOR (num_repartidor),
	CONSTRAINT FK_ENTREGA_id_mueble FOREIGN KEY (id_mueble)
												REFERENCES MUEBLE (identificador)



)