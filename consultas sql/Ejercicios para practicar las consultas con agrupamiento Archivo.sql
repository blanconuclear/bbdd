
--1.1. Media de ventas de todas las oficinas.
SELECT AVG(O.VENTAS) AS MEDIA_VENTAS
FROM OFICINA O

--1.2. Gasto total realizado por el cliente ACME MFG.
SELECT SUM(P.IMPORTE) AS GASTO_TOTAL
FROM CLIENTE C INNER JOIN PEDIDO P
ON C.NUM_CLIE=P.CLIE
WHERE C.EMPRESA = 'ACME MFG.'

--1.3. Gasto total realizado por cada cliente. En el resultado aparecer� el nombre de la empresa cliente y
--en una segunda columna el importe del gasto en pedidos que lleva realizado el cliente hasta ahora.
--En el resultado deber�n aparecer primero los clientes con mayor gasto.
SELECT C.EMPRESA, ISNULL(SUM(P.IMPORTE),0) AS 'GASTO TOTAL'
FROM CLIENTE C LEFT JOIN PEDIDO P
ON C.NUM_CLIE=P.CLIE
GROUP BY C.NUM_CLIE, C.EMPRESA
ORDER BY [GASTO TOTAL] DESC

--1.4. Realiza de nuevo la consulta anterior, pero ahora s�lo deber�n aparecer los clientes que hayan
--realizado m�s de 10000 euros de gasto total.
SELECT C.EMPRESA, ISNULL(SUM(P.IMPORTE),0) AS 'GASTO TOTAL'
FROM CLIENTE C LEFT JOIN PEDIDO P
ON C.NUM_CLIE=P.CLIE
GROUP BY C.NUM_CLIE, C.EMPRESA
HAVING ISNULL(SUM(P.IMPORTE),0)>10000
ORDER BY [GASTO TOTAL] DESC

--1.5. Realiza de nuevo la consulta anterior, pero ahora s�lo deber�n aparecer los clientes que hayan
--realizado m�s de 10000 euros de gasto total y adem�s hayan hecho m�s de 2 pedidos.
SELECT C.EMPRESA, ISNULL(SUM(P.IMPORTE),0) AS 'GASTO TOTAL'
FROM CLIENTE C LEFT JOIN PEDIDO P
ON C.NUM_CLIE=P.CLIE
GROUP BY C.NUM_CLIE, C.EMPRESA
HAVING ISNULL(SUM(P.IMPORTE),0) > 10000 AND COUNT(P.NUM_PEDIDO) > 2
ORDER BY [GASTO TOTAL] DESC

--1.6. Nombre de aquellos clientes cuyo l�mite de cr�dito supera el l�mite de cr�dito medio.
SELECT  C.EMPRESA
FROM CLIENTE C
WHERE C.LIMITE_CREDITO>(
						SELECT AVG(C.LIMITE_CREDITO) FROM CLIENTE C
)

--1.7. C�digo y descripci�n del producto o productos con el precio menor.
SELECT P.ID_PRODUCTO+' '+P.DESCRIPCION AS 'PRODUCTOS PRECIO MENOR'
FROM PRODUCTO P
WHERE P.PRECIO = (
					SELECT MIN(PRECIO) FROM PRODUCTO
)

--1.8. N�mero total de pedidos que se han realizado del producto con descripci�n ARTICULO TIPO 2.
SELECT COUNT(PE.NUM_PEDIDO) AS 'NUM ARTICULOS TIPO 2'
FROM PEDIDO PE INNER JOIN PRODUCTO P
ON PE.PRODUCTO=P.ID_PRODUCTO
AND PE.FAB=P.ID_FAB
WHERE P.DESCRIPCION = 'ARTICULO TIPO 2'

--1.9. N�mero total de pedidos que se han realizado del producto con descripci�n ARTICULO TIPO 2 cuyo
--importe supera los 800 euros.
SELECT COUNT(PE.NUM_PEDIDO) AS 'NUM ARTICULOS TIPO 2'
FROM PEDIDO PE INNER JOIN PRODUCTO P
ON PE.PRODUCTO=P.ID_PRODUCTO
AND PE.FAB=P.ID_FAB
WHERE P.DESCRIPCION = 'ARTICULO TIPO 2'
AND PE.IMPORTE > 800

--1.10. N�mero total de pedidos de cada producto. En el resultado aparecer� la clave de cada producto, la
--descripci�n y el n�mero de pedidos que se han realizado de ese producto.
SELECT ISNULL(COUNT(PE.NUM_PEDIDO),0) AS 'NUMERO TOTAL PEDIDO', P.ID_FAB,P.ID_PRODUCTO,P.DESCRIPCION
FROM PEDIDO PE RIGHT JOIN PRODUCTO P
ON PE.PRODUCTO=P.ID_PRODUCTO
AND PE.FAB=P.ID_FAB
GROUP BY P.ID_FAB,P.ID_PRODUCTO,P.DESCRIPCION
ORDER BY [NUMERO TOTAL PEDIDO] DESC

--1.11. N�mero de t�tulos diferentes que tienen los representantes de ventas.
SELECT COUNT(DISTINCT R.TITULO) AS 'NUMERO DE TITULOS'
FROM REPVENTAS R 

--1.12. Nombre de los empleados que son directores de m�s de una oficina.
SELECT R.NOMBRE
FROM REPVENTAS R JOIN OFICINA O
ON R.NUM_EMPL=O.DIR
GROUP BY O.DIR,R.NOMBRE
HAVING COUNT(O.OFICINA)>1

--1.13. Nombre de los vendedores que han realizado m�s de 3 pedidos.
SELECT R.NOMBRE
FROM REPVENTAS R JOIN PEDIDO P
ON R.NUM_EMPL=P.REP
GROUP BY R.NOMBRE
HAVING COUNT(P.NUM_PEDIDO)>3

--1.14. N�mero de oficinas que hay por regi�n. Aparecer� el nombre de la regi�n y en la misma columna
--separada por un gui�n, la cantidad de oficinas situadas en esa regi�n.
SELECT RTRIM(O.REGION)+' - '+CAST(COUNT(O.OFICINA)AS CHAR) AS 'TODO'
FROM OFICINA O
GROUP BY O.REGION

--1.15. N�mero total de empleados que hay en cada oficina. Aparecer� la ciudad de la oficina y en una
--segunda columna la cantidad de empleados que trabajan en la misma.

SELECT O.CIUDAD, COUNT(R.NUM_EMPL) AS 'NUMERO TOTAL EMPLEADOS'
FROM REPVENTAS R  LEFT JOIN OFICINA O
ON R.OFICINA_REP=O.OFICINA
GROUP BY O.CIUDAD