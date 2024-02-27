--Proposta 1. Desexamos co�ecer o c�digo ASCII da vogal E. Na consulta deber�s devolver
--nunha columna a vogal en mai�scula, e nunha segunda o c�digo ASCII que lle corresponde.
SELECT ASCII('E') as Vogal_maiscula, ASCII('e') AS vogal_minuscula;

--� Proposta 2. Consulta que devolve o car�cter que lle corresponde aos seguintes c�digos
--ASCII: 70, 80, 90.
SELECT CHAR(70) AS ASCII_70,CHAR(80) AS ASCII_80,CHAR(90) AS ASCII_90;

--Proposta 3. Queremos obter unha listaxe que en cada li�a te�a o seguinte texto: O
--empregado con nome e apelidos X ten que acadar unha cota de vendas anual de Y. Sendo X
--o nome e os apelidos do empregado, e Y a cota de vendas. � importante fixarse no
--segundo apelido. A listaxe ter� por t�tulo Empregados e cotas. 
SELECT 'O empregado con nome '+nome+' '+RTRIM(ape1 +' '+isnull(ape2,''))+
' ten que acadar unha cota de vendas de ' + ISNULL(cast(cota_de_vendas as varchar(12)),'0')
 as "Empregados e cotas"
FROM EMPREGADO;

--� Proposta 4. Consulta que devolva as datas nas que se contrataron empregados. O formato
--das diferentes datas ser� dd-mm-aaaa e o nome da columna Datas de contrataci�n.
SELECT CONVERT(char(10),E.data_contrato,105) AS Datas_De_contrataci�n
FROM EMPREGADO E;

--� Proposta 5. Queremos obter un nome abreviado das sucursais. Ese nome comporase polos
--tres primeiros caracteres da cidade, os dous �ltimos da rexi�n e separado por un gui�n
--baixo, o n�mero de caracteres do nome da cidade.
SELECT LEFT(S.cidade,3) + 1�(S.rexion,2)+'_'+ CAST(LEN(S.CIDADE) AS VARCHAR(15)) as Abrev_sucursais
FROM SUCURSAL S;

--� Proposta 6. Queremos obter un nome abreviado dos produtos. Ese nome comporase polo
--segundo car�cter do c�digo do fabricante en min�scula, m�is o terceiro, cuarto, quinto e
--sexto da descrici�n do produto. Nunha primeira columna o c�digo aparecer� en
--min�sculas, e nunha segunda en mai�sculas.
SELECT LOWER(SUBSTRING(P.cod_fabricante,2,1)+ SUBSTRING(P.descricion,3,4)) as abrev_produto_minusc, UPPER(SUBSTRING(P.cod_fabricante,2,1)+ SUBSTRING(P.descricion,3,4)) as abrev_produto_mayusc
FROM PRODUTO P;

--� Proposta 7. Listaxe cos nomes dos empregados co formato ape1 ape2, nome. Se alg�n
--empregado non ten segundo apelido, por exemplo Susanne Smith, no resultado aparecer�
--Smith, Sussane, sen espazos antes da coma.
SELECT RTRIM(E.ape1+' '+ISNULL(E.ape2,''))+', '+E.nome AS Empregados
FROM EMPREGADO E

--� Proposta 8. Queremos amosar os distintos t�tulos dos nosos empregados en castel�n, e
--para iso deberemos substitu�r a palabra VENDAS por VENTAS.
SELECT DISTINCT REPLACE(E.titulo, 'VENDAS','VENTAS') AS VENTAS_CASTELAN
FROM EMPREGADO E

--� Proposta 9. Consulta que devolva a seguinte informaci�n de tempo en distintas columnas
--co nome adecuado cada unha:
--� data e hora actuais sen axuste de zona horaria,
--� data e hora actuais con axuste de zona horaria,
--� mes actual en n�mero,
--� mes actual en n�mero (emprega unha funci�n diferente � da anterior columna),
--� ano actual,
--� mes actual en nome,
--� hora actual,
--� nanosegundos actuais.
SELECT 
 getdate() as data_hora_sen_axuste,
 sysdatetimeoffset() as data_hora_con_axuste,
 month(getdate()) as mes_en_numero1,
 datepart(month, getdate()) as mes_en_numero2,
 year(getdate()) as ano_actual,
 datename(month, getdate()) as nome_mes,
 datepart(hour,getdate()) as hora_actual,
 datepart(nanosecond, sysdatetime()) as nanosegundos_actual;


--� Proposta 10. Listaxe que devolva o nome de todos os empregados (nome, ape1, ape2), a
--data de contrato, e nunha �ltima columna a data de contrato adiantada un ano. O formato
--das d�as datas ser� dd/mm/aaaa (con barras).
SELECT E.nome,E.ape1,ISNULL(E.ape2,' ') AS ape2,CONVERT(char(10),E.data_contrato,103) AS data_contrato,
	CONVERT(CHAR(10),DATEADD(YEAR,-1,E.data_contrato),103) AS data_contrato_menos1
	FROM EMPREGADO E;

--� Proposta 11. Listaxe que devolva o n�mero de cada pedido coa data de pedido. Nunha
--terceira columna deber� aparecer a mesma data de pedido pero retrasada dous meses. O
--formato das d�as datas ser� dd-mm-aaaa (con gui�ns).
SELECT CONVERT(char(10),P.data_pedido,105) AS data_pedido,
	   CONVERT(char(10),DATEADD(MONTH,-2,P.data_pedido),105) AS data_pedido_retrasada_2meses
FROM PEDIDO P;

--� Proposta 12. Listaxe que devolva o nome e apelidos (nome, ape1, ape2) de cada
--empregado, a data de contrato e o n�mero de anos que hai que leva traballando na
--empresa cada un deles.
SELECT E.nome,E.ape1,ISNULL(E.ape2,' ') AS ape2,E.data_contrato,
	DATEDIFF(YEAR,E.data_contrato,GETDATE()) AS anos_na_empresa
FROM EMPREGADO E;

--� Proposta 13. Consulta que devolva a descrici�n de cada produto co seu prezo nunha
--segunda columna, e ademais deber�n amosarse en columnas diferentes:
--� o prezo como un enteiro aproximado por defecto,
--� o prezo como un enteiro aproximado por exceso, 
--a ra�z cadrada do prezo,
--� o cadrado do prezo, e,
--� o cubo do prezo.
SELECT P.descricion,P.prezo,
	FLOOR(P.prezo) AS enteiro_aproximado_por_defecto,
	CEILING(P.prezo) AS enteiro_aproximado_por_exceso
FROM PRODUTO P;

--� Proposta 14. Repite a consulta anterior pero agora s� amosaremos a descrici�n, o prezo e
--a ra�z cadrada, pero a ra�z cadrada deber� amosarse con como moito 4 cifras na parte
--enteira e 3 na decimal.
SELECT P.descricion,P.prezo, CONVERT(NUMERIC(7,3),SQRT(P.prezo)) AS raiz_cadrada_do_prezo
FROM PRODUTO P;

--� Proposta 15. Consulta que devolva a seguinte informaci�n do servidor no que est� a nosa
--instancia de SQL Server: idioma, n�mero m�ximo de conexi�ns permitidas, nome do
--servidor e da instancia e versi�n do xestor.
SELECT
@@LANGUAGE AS linguaxe,
@@MAX_CONNECTIONS AS limite_conexions,
@@SERVERNAME AS nome_servidor,
@@SPID AS id_sesion,
@@TEXTSIZE AS tamano_texto,
@@VERSION AS versionSQLServer;

--� Proposta 16. Consulta que amose a descrici�n do produto e as s�as existencias. Nunha
--terceira columna de nome estado_existencias amosarase o seguinte:
--� Se o n�mero de existencias � superior a 20 aparecer� a palabra Suficientes.
--� Se o n�mero de existencias � menor ou igual a 20 aparecer� Insuficientes.
SELECT P.descricion,P.existencias,
	CASE
		WHEN P.existencias > 20 THEN 'SUFICIENTES'
		ELSE 'INSUFICIENTES'
	END AS calificacion
FROM PRODUTO P;