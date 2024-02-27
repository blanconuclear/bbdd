---

--1. Nome de todos os fabricantes dos que se fixeron pedidos. Debes
--propo�er d�as soluci�ns, unha coa sintaxe coa condici�n de combinaci�n no
--WHERE, e outra coa sintaxe coa condici�n de combinaci�n no FROM.
--� Proposta
SELECT distinct f.nome
FROM FABRICANTE f
JOIN PEDIDO p
ON f.codigo=p.cod_fabricante;

--2. Nome de todos os fabricantes, fix�ranse ou non pedidos. Se tiveron
--pedidos aparecer� o nome e nunha segunda columna o n�mero de pedido. Se dun
--fabricante se fixeron m�is dun pedido, aparecer� tantas veces como pedidos se lle
--fixeron. No caso de non ter pedido, como n�mero de pedido deber� aparecer o
--valor 99.
SELECT f.nome,ISNULL( p.numero,99)
FROM FABRICANTE f left join PEDIDO p
on f.codigo=p.cod_fabricante;

--3. Nome de todos os fabricantes, fix�ranse ou non pedidos. Se tiveron
--pedidos aparecer� o nome e nunha segunda columna o n�mero de pedido. Se dun
--fabricante se fixeron m�is dun pedido, aparecer� tantas veces como pedidos se lle
--fixeron. No caso de non ter pedido, como n�mero de pedido deber� aparecer a
--frase 'Sen pedidos.'.
SELECT f.nome ,ISNULL(cast(p.numero as varchar(11)),'Sen pedidos') as n�_pedido
FROM FABRICANTE f LEFT JOIN PEDIDO p
ON f.codigo=P.cod_fabricante;

--4. C�digo dos produtos (co formato cod_fabricante-id_produto) e
--descrici�n, dos produtos que non foron pedidos nunca.
SELECT p.cod_fabricante+'-'+p.identificador as id_produto,
 p.descricion
FROM PRODUTO p LEFT JOIN PEDIDO pe
ON p.identificador=pe.id_produto
AND p.cod_fabricante=pe.cod_fabricante
WHERE pe.numero IS NULL;
;

--5. Produto cartesiano entre a t�boa de sucursais e a de empregados.
--Nunha primeira columna aparecer� a cidade da sucursal e na segunda o nome
--completo do empregado (co formato nome ape1 ape2). D�bense propo�er d�as
--soluci�ns, segundo a sintaxe empregada para o produto cartesiano.

SELECT s.cidade,
 e.nome+' '+e.ape1+' '+isnull(e.ape2,'') as empregado
FROM SUCURSAL s, EMPREGADO e;

SELECT s.cidade, e.nome+' '+e.ape1+' '+ ISNULL(e.ape2,' ') as nome_compreto
FROM SUCURSAL s CROSS JOIN EMPREGADO e;

--6. N�mero e nome completo (co formato nome ape1 ape2) de todos os
--empregados, as� como a cidade da sucursal que dirixen, se � que dirixen algunha. Na
--terceira columna, de nome sucursal_que_dirixe, nas filas dos empregados que non
--son directores de sucursais, deber� aparecer a frase 'Non � director.'.
SELECT E.numero, E.nome+' '+E.ape1+' '+ISNULL(E.ape2,'') AS nome,ISNULL(S.cidade,'Non � director')as cidade
FROM EMPREGADO E LEFT JOIN SUCURSAL S
ON E.numero= S.num_empregado_director;


--7. N�mero e nome completo dos empregados que te�en xefe, co n�mero
--e o nome completo do seu xefe nunha segunda columna. (Revisa o concepto
--� Autocombinaci�n ou self join). Nas columnas aparecer�n o n�mero separado do
--nome completo por un gui�n.
SELECT EMPRE.numero,EMPRE.nome+' '+EMPRE.ape1+' '+ISNULL(EMPRE.ape2,'')
FROM EMPREGADO EMPRE INNER JOIN EMPREGADO XEFE
ON EMPRE.num_empregado_xefe=XEFE.numero
WHERE EMPRE.num_empregado_xefe=XEFE.numero;


--8. N�mero e nome completo de todos os empregados, co n�mero e o
--nome completo do seu xefe nunha segunda columna. Nas columnas aparecer�n o
--n�mero separado do nome completo por un gui�n. Se alg�n empregado non tivese
--xefe, na segunda columna debe aparecer a frase 'Xefe por designar.'. 
SELECT cast(em.numero as varchar(5))+'-'+
 em.nome+' '+em.ape1+' '+isnull(em.ape2,'') as empregado,
 isnull(cast(xefe.numero as varchar(5))+'-'+
 xefe.nome+' '+xefe.ape1+' '+isnull(xefe.ape2,''),'Xefe por
designar') a
FROM EMPREGADO em LEFT JOIN EMPREGADO xefe
ON em.num_empregado_xefe=xefe.numero;












