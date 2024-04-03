--� Proposta 1. Aumentar o n�mero de prazas das actividades nun 15%.
BEGIN TRAN
SELECT * 
FROM ACTIVIDADE
UPDATE ACTIVIDADE

SET prezo = prezo*1.5

SELECT PREZO
FROM ACTIVIDADE
ROLLBACK;

--� Proposta 2. Cambiar o estado da aula de nome AULA SUR a regular (R).
BEGIN TRAN
SELECT *
FROM AULA

UPDATE AULA
SET ESTADO='R'
WHERE descricion = 'AULA SUR'

SELECT *
FROM AULA

ROLLBACK;

--� Proposta 3. Engadir unha aula nova de n�mero 9, nome AULA NOVA e con
--superficie e estado os mesmos que os da aula COCI�A.
BEGIN TRAN
SELECT *
FROM AULA

INSERT INTO AULA([numero], [descricion], [superficie], [estado])
SELECT 9,'AULA NOVA',superficie,estado
FROM AULA
WHERE descricion='COCI�A'

SELECT *
FROM AULA

ROLLBACK;

--� Proposta 4. Engadir d�as novas cotas, unha cos datos 21, COTA1, 75 e outra cos
--datos 22, COTA2 e 74.3.
BEGIN TRAN
SELECT *
FROM COTA

INSERT INTO COTA([codigo], [nome], [importe])
VALUES( 21,'COTA1',75),
		(22,'COTA2',74.3)

SELECT *
FROM COTA
ROLLBACK

--� Proposta 5. Crear unha t�boa temporal global PROFE_ASISTENTE_ACTI co nif, nome
--e primeiro apelido do profesorado que asiste a actividades.
BEGIN TRAN
SELECT e.nif,e.nome,e.ape1 into #PROFE_ASISTENTE_ACTI
FROM PROFE_CURSA_ACTI pca inner join EMPREGADO e
on pca.num_profesorado=e.numero

select *
from #PROFE_ASISTENTE_ACTI

ROLLBACK

--� Proposta 6. Crear unha t�boa permanente de nome AULA_MALA coas aulas en mal
--estado (Estado=M) e coas mesmas columnas da t�boa AULA. Os nomes dos campos
--de AULA_MALA ser�n codigo, nome, m2 e estado.
BEGIN TRAN
SELECT a.numero as codigo,a.descricion as nome,a.superficie as m2,a.estado INTO ##AULA_MALA
FROM AULA a
WHERE A.estado='M'

SELECT * 
FROM ##AULA_MALA
ROLLBACK


--� Proposta 7. Crear unha t�boa temporal local que sexa unha copia en canto a contido
--e columnas da t�boa ACTIVIDADE e que se chame ACTI2. Antes de pechar a
--transacci�n, farase unha consulta que elimine todas as actividades da t�boa nova
--que non te�an observaci�ns.
--� Proposta 8. Crear unha t�boa temporal local de nome SOCIO2 copia de SOCIO. A
--continuaci�n faremos a consulta que elimine de SOCIO2 aqueles socios que non
--te�en tel�fono alg�n.
--� Proposta 9. Substitu�r os espazos en branco das observaci�ns das actividades, as que
--asisten docentes, por gui�ns baixos(_).
--� Proposta 10. Retrasar nun d�a a data de inicio de t�dalas actividades que a�nda non
--comezaron a d�a de hoxe.