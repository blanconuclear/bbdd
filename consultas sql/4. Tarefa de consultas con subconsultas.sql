--– Proposta 1. Nome de todos os fabricantes dos que hai produtos na BD. Non se permite
--usar combinacións nesta consulta.
SELECT nome 
FROM FABRICANTE
WHERE codigo IN(SELECT cod_fabricante 
				FROM PRODUTO);

--– Proposta 2. Nome de todos os fabricantes dos que non hai produtos na BD. Non se
--permite usar combinacións nesta consulta.
SELECT nome
FROM FABRICANTE
WHERE codigo NOT IN(SELECT cod_fabricante 
					FROM PRODUTO);


--– Proposta 3. Número de pedido, cantidade e data de pedido para aqueles pedidos recibidos
--nos días en que un novo empregado foi contratado. Non se permite usar combinacións
--nesta consulta.
SELECT numero, cantidade, data_pedido
FROM PEDIDO
WHERE data_pedido IN (SELECT data_contrato
						FROM EMPREGADO);


--– Proposta 4. Cidade e obxectivo das sucursais cuxo obxectivo supera a media das cotas de
--todos os vendedores da BD. Non se permite usar combinacións nesta consulta.
SELECT cidade,obxectivo
FROM SUCURSAL
WHERE obxectivo > (SELECT AVG(cota_de_vendas) 
					FROM EMPREGADO);


--– Proposta 5. Número de empregado e cantidade media dos pedidos daqueles empregados
--cuxa cantidade media de pedido é superior á cantidade media global (de todos os
--pedidos). Non se permite usar combinacións nesta consulta.
SELECT num_empregado, avg(cantidade) as cant_media
FROM PEDIDO
GROUP BY num_empregado
HAVING avg(cantidade) > (SELECT avg(cantidade) 
						FROM PEDIDO);


--– Proposta 6. Nome dos clientes que aínda non fixeron pedidos. Non se permite usar
--combinacións nesta consulta.
SELECT nome
FROM CLIENTE
WHERE numero NOT IN(SELECT num_cliente 
					FROM PEDIDO);

--– Proposta 7. Nome completo dos empregados cuxas cotas son iguais ou superiores ao
--obxectivo da sucursal da cidade de Vigo. Ten en conta que se a cota dun vendedor
--(empregado) é nula debemos considerala como un 0, e do mesmo xeito actuaremos co
--obxectivo da sucursal. Non se permite usar combinacións nesta consulta.
SELECT E.nome, E.ape1, ISNULL(E.ape2,'')
FROM EMPREGADO E
WHERE ISNULL(E.cota_de_vendas,0)>=(SELECT ISNULL(S.obxectivo,0)
									FROM SUCURSAL S
									WHERE S.cidade='vigo');

--– Proposta 8. Nome dos produtos para os que existe polo menos un pedido que ten unha
--cantidade de polo menos 20 unidades. Hai que lembrar que a identificación dun produto
--faise pola combinación do código do fabricante e o do produto. A solución deberá facerse
--empregando o predicado EXISTS cunha subconsulta correlacionada. Non se permite usar
--combinacións.
SELECT PR.descricion
FROM PRODUTO PR
WHERE EXISTS(SELECT P.cantidade
			FROM PEDIDO P
			WHERE P.cantidade >=20 AND P.cod_fabricante=PR.cod_fabricante AND P.id_produto=PR.identificador);


--– Proposta 9. Cidades das sucursais onde exista algún empregado cuxa cota de vendas
--represente máis do 80% do obxectivo da oficina onde traballa. Para resolver esta consulta
--deberase empregar unha subconsulta correlacionada precedida de ANY.
SELECT S.cidade
FROM SUCURSAL S
WHERE 0.80*S.obxectivo<ANY(SELECT E.cota_de_vendas
							FROM EMPREGADO E
							WHERE E.id_sucursal_traballa=S.identificador);


--– Proposta 10. Nome dos clientes cuxos empregados asignados traballan en sucursais da
--rexión OESTE. Non se poden usar joins, só subconsultas encadeadas.
SELECT C.nome
FROM CLIENTE C
WHERE C.num_empregado_asignado IN(SELECT numero
								  FROM EMPREGADO
								  WHERE id_sucursal_traballa IN (SELECT identificador
															     FROM SUCURSAL
														         WHERE rexion='OESTE'));
