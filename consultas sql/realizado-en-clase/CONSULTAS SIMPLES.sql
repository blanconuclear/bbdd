--– Proposta 15. Nome de todos os clientes por orde alfabética.
SELECT nome
FROM CLIENTE
ORDER BY nome;

--– Proposta 16. Nome das rexións nas que ten sucursais a empresa.
SELECT DISTINCT rexion
FROM SUCURSAL;

--– Proposta 17. Identificador dos produtos que nos pediron nalgún momento. No
--resultado debe aparecer nunha soa columna o código do fabricante e o identificador
--do produto separados por un guión. A columna do resultado deberá chamarse
--produtos.
SELECT id_produto+ ' - '+cod_fabricante AS PRODUCTOS
FROM PEDIDO;
--– Proposta 18. Información completa das sucursais non dirixidas polo empregado
--número 108.

SELECT *
FROM SUCURSAL
WHERE num_empregado_director !=108;

--– Proposta 19. Nome e límite de crédito do cliente número 1107.
SELECT nome,limite_de_credito
FROM CLIENTE
WHERE numero=1107;

--– Proposta 20. Número e data dos pedidos feitos entre o 1 de agosto e o 31 de
--decembro de 2014. Só debe aparecer a data de cada pedido, sen a hora, co formato
--dd-mm-aaaa. Deben aparecer primeiro no resultado os pedidos máis recentes. Para
--resolver esta consulta non se poden utilizar operadores de comparación (>, <, >=,
--<=, < >, !=).
SELECT numero,CONVERT(char(10),data_pedido,105) AS DATA_PEDIDO
FROM PEDIDO
WHERE data_pedido BETWEEN '1/8/2014' AND '31/12/2014';

--– Proposta 21. Código e nome dos fabricantes cuxo nome ten por segunda letra O.
SELECT codigo,nome
FROM FABRICANTE
WHERE nome LIKE '_O%';

--– Proposta 22. Descrición e prezo dos produtos dos que non temos existencias.
SELECT descricion,prezo
FROM PRODUTO
WHERE existencias = 0;

--– Proposta 23. Número identificador e nome completo dos empregados que non
--teñen xefe.
SELECT numero,nome,ape1,ape2
FROM EMPREGADO
WHERE num_empregado_xefe IS NULL;

--– Proposta 24. Descrición e unidades existentes, dos produtos con existencias maiores
--de 10 unidades e menores de 100. Para resolver esta consulta non se poden utilizar
--operadores de comparación (>, <, >=, <=, < >, !=).
SELECT descricion,existencias
FROM PRODUTO
WHERE existencias BETWEEN 10 AND 100;