--Proposta 1. Empregando unha consulta composta realizar unha listaxe do c�digo do
--fabricante e identificador daqueles produtos con prezo superior a 60� ou que te�an
--pedidos de cantidade inferior a 5 unidades. O resultado aparecer� ordenado por fabricante
--e para o mesmo fabricante por produto.

SELECT P.cod_fabricante,P.identificador
FROM PRODUTO P
WHERE P.prezo > 60
UNION
SELECT
FROM FABRICANTE


--� Proposta 2. Empregando unha consulta composta amosar os c�digo dos empregados que
--non fixeron pedidos. Deber�n aparecer primeiro os empregados con c�digo maior.


--� Proposta 3. Empregando unha consulta composta amosar o c�digo dos clientes que
--fixeron pedidos e con l�mite de cr�dito maior ou igual a 40000. Usa unha diferenza para
--resolver esta consulta.


--� Proposta 4. Empregando unha consulta composta amosar os c�digo dos clientes que
--fixeron pedidos e con l�mite de cr�dito maior ou igual a 40000. Usa unha intersecci�n para
--resolver esta consulta. Ordena o resultado por c�digo de cliente en orde ascendente.




--� Proposta 5. Empregando unha consulta composta amosar o c�digo dos empregados que
--son directores dalgunha sucursal ou que te�en unha cota de vendas superior a 250000�.
--� Debes propo�er d�as soluci�ns:
--� na primeira s� pode aparecer unha vez cada empregado no resultado, e,
--� na segunda se un empregado � director dunha sucursal e ademais ten unha cota
--superior a 250000�, aparecer� no resultado m�is dunha vez.