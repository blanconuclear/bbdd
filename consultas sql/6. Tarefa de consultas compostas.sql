--Proposta 1. Empregando unha consulta composta realizar unha listaxe do código do
--fabricante e identificador daqueles produtos con prezo superior a 60€ ou que teñan
--pedidos de cantidade inferior a 5 unidades. O resultado aparecerá ordenado por fabricante
--e para o mesmo fabricante por produto.

SELECT P.cod_fabricante,P.identificador
FROM PRODUTO P
WHERE P.prezo > 60
UNION
SELECT
FROM FABRICANTE


--– Proposta 2. Empregando unha consulta composta amosar os código dos empregados que
--non fixeron pedidos. Deberán aparecer primeiro os empregados con código maior.


--– Proposta 3. Empregando unha consulta composta amosar o código dos clientes que
--fixeron pedidos e con límite de crédito maior ou igual a 40000. Usa unha diferenza para
--resolver esta consulta.


--– Proposta 4. Empregando unha consulta composta amosar os código dos clientes que
--fixeron pedidos e con límite de crédito maior ou igual a 40000. Usa unha intersección para
--resolver esta consulta. Ordena o resultado por código de cliente en orde ascendente.




--– Proposta 5. Empregando unha consulta composta amosar o código dos empregados que
--son directores dalgunha sucursal ou que teñen unha cota de vendas superior a 250000€.
--– Debes propoñer dúas solucións:
--– na primeira só pode aparecer unha vez cada empregado no resultado, e,
--– na segunda se un empregado é director dunha sucursal e ademais ten unha cota
--superior a 250000€, aparecerá no resultado máis dunha vez.