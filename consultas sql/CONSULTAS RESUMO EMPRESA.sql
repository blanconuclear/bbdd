--– Proposta 1. Media de unidades vendidas de cada vendedor. O resultado terá dúas
--columnas, na primeira o número identificador do empregado (vendedor) e nunha
--segunda columna a media de unidades vendidas (campo cantidade) nos seus
--pedidos.
SELECT num_empregado,AVG(cantidade)AS MEDIA_U_VENDIDAS
FROM PEDIDO
GROUP BY num_empregado;

--– Proposta 2. Prezo máis barato de produto, prezo máis caro, prezo medio, suma total
--dos prezos de produto, e número de produtos distintos existentes.
SELECT MIN(prezo) AS MINIMO ,MAX(prezo) AS MAXIMO,AVG(prezo) AS MEDIA,SUM(prezo) AS SUMA ,COUNT(identificador) AS CANTIDAD
FROM PRODUTO;

--– Proposta 3. Número de pedidos realizados polo cliente 1103.
SELECT COUNT(numero)AS NUM_PEDIDOS
FROM PEDIDO
WHERE num_cliente='1103';

--– Proposta 4. Número de pedidos realizados por cada cliente. No resultado aparecerá
--o identificador do cliente e na segunda columna o número de pedidos que leva
--feitos cada cliente ata o de agora.
SELECT num_cliente,COUNT(numero) AS TOTAL_PEDIDOS
FROM PEDIDO
GROUP BY num_cliente;

--– Proposta 5. Repite a consulta anterior, pero agora no resultado só poderán aparecer
--os clientes que fixeron máis de 2 pedidos.
SELECT num_cliente,COUNT(numero) AS TOTAL_PEDIDOS
FROM PEDIDO
GROUP BY num_cliente
HAVING COUNT(numero) > 2;

--– Proposta 6. Repite a consulta anterior, pero agora no resultado só poderán aparecer
--os clientes que fixeron máis de 2 pedidos e que ademais teñen unha media de
--unidades mercadas (cantidade) inferior a 10.
SELECT num_cliente,COUNT(numero) AS TOTAL_PEDIDOS
FROM PEDIDO
GROUP BY num_cliente
HAVING COUNT(numero) > 2 AND AVG(cantidade)<10;

--– Proposta 7. Cantidade total de sucursais que hai por rexión. Aparecerá o nome da
--rexión e na mesma columna separado por un guión, a cantidade de sucursais
--situadas nesa rexión.
SELECT rexion + ' - ' +CAST( COUNT(identificador) AS varchar(15)) AS rexion_e_cantidade
FROM SUCURSAL
GROUP BY rexion;
