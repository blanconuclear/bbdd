----� Proposta 1. Nome e apelidos (cada un nunha columna) de todos os empregados.
SELECT nome,ape1,ape2
FROM EMPREGADO;

--� Proposta 2. N�mero, nome e apelidos (cada un nunha columna) de todos empregados.
SELECT numero,nome,ape1,ape2
FROM EMPREGADO;

--� Proposta 3. N�mero, nome e apelidos (cada un nunha columna) de todos os empregados por orde alfab�tica de apelidos e nome.
SELECT numero,nome,ape1,ape2
FROM EMPREGADO
ORDER BY ape1,ape2,nome;

--� Proposta 4. N�mero, nome e apelidos (cada un nunha columna) de todos os empregados por orde alfab�tica de apelidos e nome. Os nomes das columnas no resultado ser�n: num_socio, nome_socio, apelido1, apelido2.
SELECT numero AS num_socio,nome AS nome_socio,ape1 AS apelido1,ape2 AS apelido2
FROM EMPREGADO
ORDER BY ape1,ape2,nome;

--� Proposta 5. N�mero, nome completo (os 4 campos nunha �nica columna, de nome
--socio, co formato numero - ape1 ape2, nome) e salario de todos os empregados. No
--resultado deber�n aparecer primeiro os que m�is cobran.
SELECT CAST(numero as varchar(5))+'-'+ape1+' '+ape2+', '+nome as socio,salario_mes
FROM EMPREGADO
ORDER BY salario_mes DESC;

--� Proposta 6. N�mero, nome completo (os 4 campos nunha �nica columna, de nome
--socio, co formato numero - ape1 ape2, nome) e salario de todo o profesorado. No
--resultado deber�n aparecer primeiro os que m�is cobran. O campo cargo cont�n
--PRF para o profesorado, e ADM se � un ou unha administrativo.
SELECT CAST(numero as varchar(5))+'-'+ape1+' '+ape2+', '+nome as socio,salario_mes
FROM EMPREGADO
WHERE cargo ='PRF'
ORDER BY salario_mes DESC;

--� Proposta 7. N�mero identificador do profesorado que imparte clases. Como �
--l�xico, se un profesor imparte m�is dunha actividade, o seu n�mero s� pode
--aparecer unha vez.
SELECT DISTINCT num_profesorado_imparte 
FROM ACTIVIDADE;

--� Proposta 8. N�mero identificador das actividades �s que asiste profesorado, � dicir,
--cursadas por profesorado.
SELECT id_actividade
FROM PROFE_CURSA_ACTI;

--� Proposta 9. Nome, importe, e importe rebaixado un 20%, da actividade de nome
--xadrez.
SELECT nome,prezo,prezo*0.8
FROM ACTIVIDADE;

--� Proposta 10. NIF, nome e apelidos dos socios dos que non temos tel�fono gardado.
SELECT nif,nome,ape1,ape2
FROM SOCIO
WHERE telefono1 IS NULL 
AND telefono2 IS NULL;

--� Proposta 11. NIF, nome, apelidos e data de nacemento dos socios nados entre 1980
--e 1990, ambos inclu�dos.
SELECT nif,nome,ape1,ape2,data_nac
FROM SOCIO
WHERE data_nac BETWEEN '1980' AND '1990';

--� Proposta 12. Todos os datos das actividades cuxo nome cont�n a letra T.
SELECT *
FROM ACTIVIDADE
WHERE nome LIKE '%T%';

--� Proposta 13. Nome e importe das cotas cun custo de 30 ou 100 euros.
SELECT nome,importe
FROM COTA
WHERE importe=30 OR importe=100;

--� Proposta 14. Nome e n�mero de prazas das actividades que non te�en nin 15 nin 20
--prazas.
SELECT nome, num_prazas
FROM ACTIVIDADE
WHERE num_prazas != 15 AND num_prazas != 20;


