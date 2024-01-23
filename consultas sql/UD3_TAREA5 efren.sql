--5.1. Todos los datos (todos los campos de la relación AULA) de las aulas cuyo estado sea ‘Bueno’
--(estado=’B’).
SELECT * FROM AULA WHERE estado='B';
--5.2. Todos los datos (todos los campos de la relación ACTIVIDAD) de las actividades con precio menor de
--50 euros.
SELECT * FROM ACTIVIDADE WHERE prezo<50;
--5.3. Nombre de las cuotas no gratuitas.
SELECT nome FROM COTA WHERE importe=0;
--5.4. Identificador de las actividades realizadas por el socio con número 1004.
SELECT id_actividade
FROM SOCIO_REALIZA_ACTI
WHERE num_socio=1004;
--5.5. NIF del profesor que imparte la actividad de nombre ‘TENIS’.
SELECT e.nif
FROM ACTIVIDADE a, EMPREGADO e
WHERE a.nome='TENIS PARA PRINCIPIANTES' AND
	  a.num_profesorado_imparte=e.numero;


SELECT e.nif
FROM ACTIVIDADE a
JOIN EMPREGADO e
ON a.num_profesorado_imparte=e.numero
WHERE a.nome='TENIS PARA PRINCIPIANTES';
--5.6. Nombre completo de los profesores que realizan (cursan) alguna actividad.
SELECT e.nome,e.ape1,e.ape2
FROM EMPREGADO e 
JOIN PROFE_CURSA_ACTI pa
ON e.numero=pa.num_profesorado;

--5.7. Importe de la cuota que debe pagar el socio número 1003.
SELECT importe 
FROM COTA c 
JOIN SOCIO s
ON s.cod_cuota=c.codigo
WHERE s.numero=1003;

--5.8. Horas extras realizadas por el empleado con NSS 1534567891012
SELECT horas_extras
FROM EMPREGADO e 
JOIN ADMINISTRATIVO a
ON e.numero=a.num_adm
WHERE e.nss='151515151515';

--5.9. Nombre de las actividades en las que hay morosos apuntados.
SELECT nome
FROM ACTIVIDADE a 
JOIN SOCIO_REALIZA_ACTI s
ON a.identificador=s.id_actividade
WHERE s.pagada='N';

--5.10. Nombre y fecha de inicio de las actividades que se imparten en aulas en mal estado (estado=’M’).
SELECT a.nome,a.data_ini
FROM ACTIVIDADE a 
JOIN AULA au
ON a.num_aula=au.numero
WHERE au.estado='M';

--5.11. Nombre completo, dirección, profesión y tipo de aquellos socios que deben la cuota anual.
SELECT nome, ape1,ape2,cod_provincia_enderezo,codpostal_enderezo,
localidade_enderezo,num_casa_enderezo,piso_enderezo,rua_enderezo,tipo,tipo_via_enderezo
FROM SOCIO
WHERE SOCIO.abonada != 'S';

--5.12. Salario del profesor que imparte la actividad de nombre ‘COCINA’.
SELECT E.salario_mes
FROM EMPREGADO e 
JOIN ACTIVIDADE a
ON e.numero=a.num_profesorado_imparte
WHERE a.nome='XADREZ';

--5.13. Plazas de las actividades que imparte el profesor con NIF ‘22222222-B’.
SELECT num_prazas
FROM EMPREGADO e 
JOIN PROFESORADO p
ON e.numero=p.num_prof 
JOIN ACTIVIDADE a
ON p.num_prof=a.num_profesorado_imparte
WHERE e.nif='22222222B';

--5.14. Nombre de las actividades que empiezan antes del 12 de diciembre de 2005, es decir con fecha de
--inicio menor que esa.
SELECT ACTIVIDADE.nome
FROM ACTIVIDADE
WHERE ACTIVIDADE.data_ini < '2015-12-12';

--5.15. Nombre completo de todas las personas que pueden cursar actividades.
SELECT nome,ape1,ape2
FROM SOCIO S
UNION ALL
SELECT nome,ape2,ape2
FROM EMPREGADO E
WHERE E.cargo='PRF';

--5.16. NIF, NSS y nombre completo de todos aquellos profesores que no cursan actividades.
SELECT nif,nss,nome,ape1,ape2
FROM EMPREGADO E
WHERE E.numero NOT IN
(SELECT num_profesorado FROM PROFE_CURSA_ACTI);

--5.17. Nombre de la actividad y nombre completo del profesor que la imparte, para aquellas actividades
--cursadas por algún profesor.
SELECT A.nome,E.nome,E.ape1,E.ape2
FROM ACTIVIDADE A 
JOIN PROFE_CURSA_ACTI PCA
ON A.identificador=PCA.id_actividade 
JOIN EMPREGADO E
ON PCA.num_profesorado=E.numero;

--5.18. Nombre de cada actividad, nombre completo del profesor que la imparte y descripción del aula que
--tiene asignada.

SELECT A.nome,E.nome,E.ape1,E.ape2,AU.descricion
FROM EMPREGADO E
JOIN ACTIVIDADE A
ON E.numero=A.num_profesorado_imparte
JOIN AULA AU
ON A.num_aula=AU.numero;

--5.19. Número y nombre completo de todos los socios que están apuntados a actividades que comenzaron
--antes del mes de julio de 2005.
SELECT S.numero,S.nome,S.ape1,S.ape2
FROM ACTIVIDADE A
JOIN SOCIO_REALIZA_ACTI SRA
ON A.identificador=SRA.id_actividade
JOIN SOCIO S
ON SRA.num_socio=S.numero
WHERE A.data_ini < '2015-07-01';

--5.20. Nombre completo de aquellos socios que cursan actividades impartidas en aulas con superficie
--superior a 50 metros cuadrados.
SELECT S.nome,S.ape1,S.ape2
FROM SOCIO S
JOIN SOCIO_REALIZA_ACTI SRA
ON S.numero=SRA.num_socio
JOIN ACTIVIDADE A
ON SRA.id_actividade=A.identificador
JOIN AULA AU
ON A.num_aula=AU.numero
WHERE AU.superficie > '50';

--5.21. NSS de los profesores que imparten clase en aulas en mal estado(estado=’M’).






--5.22. NSS de los socios que tienen asignadas cuotas gratuitas.
--5.23. Nombre completo de TODAS las personas de la sociedad cultural y deportiva que viven en
--Bertamiráns.
--5.24. Número identificativo de los profesores que cursan actividades.
--5.25. Número identificativo de aquellos profesores que no cursan actividades.
--5.26. Nombre completo y localidad de los socios que asisten a la actividad ‘COCINA’.
--5.27. Nombre completo y localidad de los profesores que asisten a la actividad ‘COCINA’.
--5.28. Nombre completo y localidad de las personas de la sociedad cultural y deportiva que asisten a la
--actividad ‘COCINA’.
--5.29. NIF y nombre de los administrativos que no han hecho horas extras.
--5.30. Nombre completo de los profesores de la especialidad de ‘IDIOMAS’.
--5.31. Nombre completo de los administrativos que han hecho horas extras.
--5.32. Nombre completo de los profesores de la especialidad ‘IDIOMAS’ y administrativos que han hecho
--horas extras.
--5.33. Nombre y NIF de los administrativos que viven en Santiago de Compostela y que han hecho horas
--extras.
--5.34. Nombre y NIF de los administrativos que viven en Santiago de Compostela y que NO han hecho horas
--extras.
--5.35. Nombre y teléfonos de los profesores con sueldo superior a 1.200€.
--5.36. Nombre de las actividades de las que se desconoce quién las va a impartir.
--5.37. Nombre de las actividades que tienen profesor asignado. Hazlo de 2 maneras, en la primera usando el
--operador de selección y en la segunda usando el operador diferencia.
--5.38. Nombre y teléfono de los socios que asisten a clase de actividades con más de 10 plazas.
--5.39. Importe de las cuotas anuales asignadas a socios nacidos antes del año 2000.
--5.40. Nombre e importe de la/s cuota/s asignada/s a los socios de tipo COMÚN.
--5.41. Nombre de las actividades a las que asisten socios que tienen asignadas cuotas anuales gratuitas.
--5.42. NIF y NSS de los profesores que imparten actividades en las que están matriculados socios que deben
--la cuota anual.
--5.43. Nombre completo de los socios de los que se desconoce su profesión.
--5.44. Nombre completo y fecha de nacimiento de los socios que no participan en actividades.
--5.45. Nombre completo y fecha de nacimiento de los socios que participan en actividades de precio
--superior a 100€.
--5.46. Actividades sin observaciones a resaltar.
--5.47. Nombre de la actividad que se imparte en el AULA número 6.
--5.48. Nombre e importe de la/s cuota/s asignada/s a los socios que deben alguna actividad.
--5.49. Nombre y teléfonos de los profesores con sueldo inferior a 1.200€ y que asisten a actividades.
--5.50. Información completa de los administrativos que trabajan en la sociedad