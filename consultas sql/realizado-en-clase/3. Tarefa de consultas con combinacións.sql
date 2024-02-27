---

--1. Nome de todos os fabricantes dos que se fixeron pedidos. Debes
--propoñer dúas solucións, unha coa sintaxe coa condición de combinación no
--WHERE, e outra coa sintaxe coa condición de combinación no FROM.
--– Proposta
SELECT distinct f.nome
FROM FABRICANTE f
JOIN PEDIDO p
ON f.codigo=p.cod_fabricante;

--2. Nome de todos os fabricantes, fixéranse ou non pedidos. Se tiveron
--pedidos aparecerá o nome e nunha segunda columna o número de pedido. Se dun
--fabricante se fixeron máis dun pedido, aparecerá tantas veces como pedidos se lle
--fixeron. No caso de non ter pedido, como número de pedido deberá aparecer o
--valor 99.
SELECT f.nome,ISNULL( p.numero,99)
FROM FABRICANTE f left join PEDIDO p
on f.codigo=p.cod_fabricante;

--3. Nome de todos os fabricantes, fixéranse ou non pedidos. Se tiveron
--pedidos aparecerá o nome e nunha segunda columna o número de pedido. Se dun
--fabricante se fixeron máis dun pedido, aparecerá tantas veces como pedidos se lle
--fixeron. No caso de non ter pedido, como número de pedido deberá aparecer a
--frase 'Sen pedidos.'.
SELECT f.nome ,ISNULL(cast(p.numero as varchar(11)),'Sen pedidos') as nº_pedido
FROM FABRICANTE f LEFT JOIN PEDIDO p
ON f.codigo=P.cod_fabricante;

--4. Código dos produtos (co formato cod_fabricante-id_produto) e
--descrición, dos produtos que non foron pedidos nunca.
SELECT p.cod_fabricante+'-'+p.identificador as id_produto,
 p.descricion
FROM PRODUTO p LEFT JOIN PEDIDO pe
ON p.identificador=pe.id_produto
AND p.cod_fabricante=pe.cod_fabricante
WHERE pe.numero IS NULL;
;

--5. Produto cartesiano entre a táboa de sucursais e a de empregados.
--Nunha primeira columna aparecerá a cidade da sucursal e na segunda o nome
--completo do empregado (co formato nome ape1 ape2). Débense propoñer dúas
--solucións, segundo a sintaxe empregada para o produto cartesiano.

SELECT s.cidade,
 e.nome+' '+e.ape1+' '+isnull(e.ape2,'') as empregado
FROM SUCURSAL s, EMPREGADO e;

SELECT s.cidade, e.nome+' '+e.ape1+' '+ ISNULL(e.ape2,' ') as nome_compreto
FROM SUCURSAL s CROSS JOIN EMPREGADO e;

--6. Número e nome completo (co formato nome ape1 ape2) de todos os
--empregados, así como a cidade da sucursal que dirixen, se é que dirixen algunha. Na
--terceira columna, de nome sucursal_que_dirixe, nas filas dos empregados que non
--son directores de sucursais, deberá aparecer a frase 'Non é director.'.
SELECT E.numero, E.nome+' '+E.ape1+' '+ISNULL(E.ape2,'') AS nome,ISNULL(S.cidade,'Non é director')as cidade
FROM EMPREGADO E LEFT JOIN SUCURSAL S
ON E.numero= S.num_empregado_director;


--7. Número e nome completo dos empregados que teñen xefe, co número
--e o nome completo do seu xefe nunha segunda columna. (Revisa o concepto
--– Autocombinación ou self join). Nas columnas aparecerán o número separado do
--nome completo por un guión.
SELECT EMPRE.numero,EMPRE.nome+' '+EMPRE.ape1+' '+ISNULL(EMPRE.ape2,'')
FROM EMPREGADO EMPRE INNER JOIN EMPREGADO XEFE
ON EMPRE.num_empregado_xefe=XEFE.numero
WHERE EMPRE.num_empregado_xefe=XEFE.numero;


--8. Número e nome completo de todos os empregados, co número e o
--nome completo do seu xefe nunha segunda columna. Nas columnas aparecerán o
--número separado do nome completo por un guión. Se algún empregado non tivese
--xefe, na segunda columna debe aparecer a frase 'Xefe por designar.'. 
SELECT cast(em.numero as varchar(5))+'-'+
 em.nome+' '+em.ape1+' '+isnull(em.ape2,'') as empregado,
 isnull(cast(xefe.numero as varchar(5))+'-'+
 xefe.nome+' '+xefe.ape1+' '+isnull(xefe.ape2,''),'Xefe por
designar') a
FROM EMPREGADO em LEFT JOIN EMPREGADO xefe
ON em.num_empregado_xefe=xefe.numero;












