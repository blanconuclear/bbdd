--� Proposta 1. Media de unidades vendidas de cada vendedor. O resultado ter� d�as
--columnas, na primeira o n�mero identificador do empregado (vendedor) e nunha
--segunda columna a media de unidades vendidas (campo cantidade) nos seus
--pedidos.
SELECT num_empregado,AVG(cantidade)AS MEDIA_U_VENDIDAS
FROM PEDIDO
GROUP BY num_empregado;

--� Proposta 2. Prezo m�is barato de produto, prezo m�is caro, prezo medio, suma total
--dos prezos de produto, e n�mero de produtos distintos existentes.
SELECT MIN(prezo) AS MINIMO ,MAX(prezo) AS MAXIMO,AVG(prezo) AS MEDIA,SUM(prezo) AS SUMA ,COUNT(identificador) AS CANTIDAD
FROM PRODUTO;

--� Proposta 3. N�mero de pedidos realizados polo cliente 1103.
SELECT COUNT(numero)AS NUM_PEDIDOS
FROM PEDIDO
WHERE num_cliente='1103';

--� Proposta 4. N�mero de pedidos realizados por cada cliente. No resultado aparecer�
--o identificador do cliente e na segunda columna o n�mero de pedidos que leva
--feitos cada cliente ata o de agora.
SELECT num_cliente,COUNT(numero) AS TOTAL_PEDIDOS
FROM PEDIDO
GROUP BY num_cliente;

--� Proposta 5. Repite a consulta anterior, pero agora no resultado s� poder�n aparecer
--os clientes que fixeron m�is de 2 pedidos.
SELECT num_cliente,COUNT(numero) AS TOTAL_PEDIDOS
FROM PEDIDO
GROUP BY num_cliente
HAVING COUNT(numero) > 2;

--� Proposta 6. Repite a consulta anterior, pero agora no resultado s� poder�n aparecer
--os clientes que fixeron m�is de 2 pedidos e que ademais te�en unha media de
--unidades mercadas (cantidade) inferior a 10.
SELECT num_cliente,COUNT(numero) AS TOTAL_PEDIDOS
FROM PEDIDO
GROUP BY num_cliente
HAVING COUNT(numero) > 2 AND AVG(cantidade)<10;

--� Proposta 7. Cantidade total de sucursais que hai por rexi�n. Aparecer� o nome da
--rexi�n e na mesma columna separado por un gui�n, a cantidade de sucursais
--situadas nesa rexi�n.
SELECT rexion + ' - ' +CAST( COUNT(identificador) AS varchar(15)) AS rexion_e_cantidade
FROM SUCURSAL
GROUP BY rexion;
