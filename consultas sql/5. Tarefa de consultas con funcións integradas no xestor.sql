--Proposta 1. Desexamos coñecer o código ASCII da vogal E. Na consulta deberás devolver
--nunha columna a vogal en maiúscula, e nunha segunda o código ASCII que lle corresponde.
SELECT ASCII('E') as Vogal_maiscula, ASCII('e') AS vogal_minuscula;

--– Proposta 2. Consulta que devolve o carácter que lle corresponde aos seguintes códigos
--ASCII: 70, 80, 90.
SELECT CHAR(70) AS ASCII_70,CHAR(80) AS ASCII_80,CHAR(90) AS ASCII_90;

--Proposta 3. Queremos obter unha listaxe que en cada liña teña o seguinte texto: O
--empregado con nome e apelidos X ten que acadar unha cota de vendas anual de Y. Sendo X
--o nome e os apelidos do empregado, e Y a cota de vendas. É importante fixarse no
--segundo apelido. A listaxe terá por título Empregados e cotas. 
SELECT 'O empregado con nome '+nome+' '+RTRIM(ape1 +' '+isnull(ape2,''))+
' ten que acadar unha cota de vendas de ' + ISNULL(cast(cota_de_vendas as varchar(12)),'0')
 as "Empregados e cotas"
FROM EMPREGADO;

--– Proposta 4. Consulta que devolva as datas nas que se contrataron empregados. O formato
--das diferentes datas será dd-mm-aaaa e o nome da columna Datas de contratación.
SELECT CONVERT(char(10),E.data_contrato,105) AS Datas_De_contratación
FROM EMPREGADO E;

--– Proposta 5. Queremos obter un nome abreviado das sucursais. Ese nome comporase polos
--tres primeiros caracteres da cidade, os dous últimos da rexión e separado por un guión
--baixo, o número de caracteres do nome da cidade.
SELECT LEFT(S.cidade,3) + 1º(S.rexion,2)+'_'+ CAST(LEN(S.CIDADE) AS VARCHAR(15)) as Abrev_sucursais
FROM SUCURSAL S;

--– Proposta 6. Queremos obter un nome abreviado dos produtos. Ese nome comporase polo
--segundo carácter do código do fabricante en minúscula, máis o terceiro, cuarto, quinto e
--sexto da descrición do produto. Nunha primeira columna o código aparecerá en
--minúsculas, e nunha segunda en maiúsculas.
SELECT LOWER(SUBSTRING(P.cod_fabricante,2,1)+ SUBSTRING(P.descricion,3,4)) as abrev_produto_minusc, UPPER(SUBSTRING(P.cod_fabricante,2,1)+ SUBSTRING(P.descricion,3,4)) as abrev_produto_mayusc
FROM PRODUTO P;

--– Proposta 7. Listaxe cos nomes dos empregados co formato ape1 ape2, nome. Se algún
--empregado non ten segundo apelido, por exemplo Susanne Smith, no resultado aparecerá
--Smith, Sussane, sen espazos antes da coma.
SELECT RTRIM(E.ape1+' '+ISNULL(E.ape2,''))+', '+E.nome AS Empregados
FROM EMPREGADO E

--– Proposta 8. Queremos amosar os distintos títulos dos nosos empregados en castelán, e
--para iso deberemos substituír a palabra VENDAS por VENTAS.
SELECT DISTINCT REPLACE(E.titulo, 'VENDAS','VENTAS') AS VENTAS_CASTELAN
FROM EMPREGADO E

--– Proposta 9. Consulta que devolva a seguinte información de tempo en distintas columnas
--co nome adecuado cada unha:
--– data e hora actuais sen axuste de zona horaria,
--– data e hora actuais con axuste de zona horaria,
--– mes actual en número,
--– mes actual en número (emprega unha función diferente á da anterior columna),
--– ano actual,
--– mes actual en nome,
--– hora actual,
--– nanosegundos actuais.
SELECT 
 getdate() as data_hora_sen_axuste,
 sysdatetimeoffset() as data_hora_con_axuste,
 month(getdate()) as mes_en_numero1,
 datepart(month, getdate()) as mes_en_numero2,
 year(getdate()) as ano_actual,
 datename(month, getdate()) as nome_mes,
 datepart(hour,getdate()) as hora_actual,
 datepart(nanosecond, sysdatetime()) as nanosegundos_actual;


--– Proposta 10. Listaxe que devolva o nome de todos os empregados (nome, ape1, ape2), a
--data de contrato, e nunha última columna a data de contrato adiantada un ano. O formato
--das dúas datas será dd/mm/aaaa (con barras).
SELECT E.nome,E.ape1,ISNULL(E.ape2,' ') AS ape2,CONVERT(char(10),E.data_contrato,103) AS data_contrato,
	CONVERT(CHAR(10),DATEADD(YEAR,-1,E.data_contrato),103) AS data_contrato_menos1
	FROM EMPREGADO E;

--– Proposta 11. Listaxe que devolva o número de cada pedido coa data de pedido. Nunha
--terceira columna deberá aparecer a mesma data de pedido pero retrasada dous meses. O
--formato das dúas datas será dd-mm-aaaa (con guións).
SELECT CONVERT(char(10),P.data_pedido,105) AS data_pedido,
	   CONVERT(char(10),DATEADD(MONTH,-2,P.data_pedido),105) AS data_pedido_retrasada_2meses
FROM PEDIDO P;

--– Proposta 12. Listaxe que devolva o nome e apelidos (nome, ape1, ape2) de cada
--empregado, a data de contrato e o número de anos que hai que leva traballando na
--empresa cada un deles.
SELECT E.nome,E.ape1,ISNULL(E.ape2,' ') AS ape2,E.data_contrato,
	DATEDIFF(YEAR,E.data_contrato,GETDATE()) AS anos_na_empresa
FROM EMPREGADO E;

--– Proposta 13. Consulta que devolva a descrición de cada produto co seu prezo nunha
--segunda columna, e ademais deberán amosarse en columnas diferentes:
--– o prezo como un enteiro aproximado por defecto,
--– o prezo como un enteiro aproximado por exceso, 
--a raíz cadrada do prezo,
--– o cadrado do prezo, e,
--– o cubo do prezo.
SELECT P.descricion,P.prezo,
	FLOOR(P.prezo) AS enteiro_aproximado_por_defecto,
	CEILING(P.prezo) AS enteiro_aproximado_por_exceso
FROM PRODUTO P;

--– Proposta 14. Repite a consulta anterior pero agora só amosaremos a descrición, o prezo e
--a raíz cadrada, pero a raíz cadrada deberá amosarse con como moito 4 cifras na parte
--enteira e 3 na decimal.
SELECT P.descricion,P.prezo, CONVERT(NUMERIC(7,3),SQRT(P.prezo)) AS raiz_cadrada_do_prezo
FROM PRODUTO P;

--– Proposta 15. Consulta que devolva a seguinte información do servidor no que está a nosa
--instancia de SQL Server: idioma, número máximo de conexións permitidas, nome do
--servidor e da instancia e versión do xestor.
SELECT
@@LANGUAGE AS linguaxe,
@@MAX_CONNECTIONS AS limite_conexions,
@@SERVERNAME AS nome_servidor,
@@SPID AS id_sesion,
@@TEXTSIZE AS tamano_texto,
@@VERSION AS versionSQLServer;

--– Proposta 16. Consulta que amose a descrición do produto e as súas existencias. Nunha
--terceira columna de nome estado_existencias amosarase o seguinte:
--– Se o número de existencias é superior a 20 aparecerá a palabra Suficientes.
--– Se o número de existencias é menor ou igual a 20 aparecerá Insuficientes.
SELECT P.descricion,P.existencias,
	CASE
		WHEN P.existencias > 20 THEN 'SUFICIENTES'
		ELSE 'INSUFICIENTES'
	END AS calificacion
FROM PRODUTO P;