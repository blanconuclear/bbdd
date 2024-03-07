--BD EMPLEADOS. Consulta que devuelve en una primera columna la descripción y el precio de
--todos los productos, separados por una barra invertida (por ejemplo ARTICULO TIPO2 \ 76), y en
--una segunda columna el gasto total en pedidos de ese producto. Entre la descripción y la barra
--invertida sólo puede existir un espacio en blanco y entre la barra invertida y el precio otro espacio
--en blanco.
--En el resultado sólo podrán aparecer aquellos productos cuyo gasto medio es menor de 3000€.
--La primera columna se llamará Producto y la segunda Gasto total.
--Si de algún producto no se han realizado pedidos en la columna del Gasto total deberá aparecer la
--frase PRODUCTO QUE TODAVIA NO SE HA VENDIDO.
--La columna del gasto total deberá mostrar los importes con 6 dígitos como máximo en la parte
--entera y 2 decimales.
--Deberán aparecer primero en el resultado los productos con mayor gasto total.


select TRIM(p.DESCRIPCION) +' \ '+ (CONVERT(varchar(5),COUNT(p.PRECIO))) AS PRODUCTO,ISNULL(CAST(CAST(sum(pe.IMPORTE)AS numeric(8,2)) AS CHAR),'PRODUCTO QUE TODAVIA NO SE HA VENDIDO') as 'GASTO TOTAL'
from PRODUCTO p 
LEFT join PEDIDO pe
on p.ID_PRODUCTO=pe.PRODUCTO
AND
P.ID_FAB=PE.FAB
group by P.ID_FAB,P.ID_PRODUCTO,P.DESCRIPCION
HAVING ISNULL(AVG(PE.IMPORTE),0)< 3000

--BD EMPLEADOS. Consulta que devuelva la lista de los pedidos que hace más de 24 años y menos
--de 28 años que se han realizado.
--IMPORTANTE: Para hacer la comprobación de los años que hace que se ha realizado el pedido no
--puedes usar ni la cláusula IN, ni OR ni tampoco los operadores >=, >, <=, !=, = <>.
--En el resultado deberá aparecer el número del pedido, en una segunda columna la fecha del
--pedido con formato dd-mm-aaaa (Fíjate que se separan con guiones y llámale FechaPed) y en una
--tercera columna de nombre Unidades aparecerá lo siguiente en función del número de unidades
--solicitadas en el pedido:
--- Si la cantidad de unidades del pedido es menor que 7 aparecerá el texto POCAS.
--- Si la cantidad de unidades del pedido es mayor o igual que 7 y menor que 30 aparecerá el
--texto NORMAL.
--- Si la cantidad de unidades del pedido es mayor o igual que 30 aparecerá el texto MUCHAS.
--Deben aparecer los pedidos más recientes primero. Asegúrate que aparecen bien ordenados.

SELECT P.NUM_PEDIDO, convert(char(10),P.FECHA_PEDIDO,103) as FechaPed, case
																		when p.CANT <7 then 'POCAS'
																		when p.CANT<30 then 'NORMAL'
																		when p.CANT>=30 then 'MUCHAS'
																		end as Unidades
FROM PEDIDO P
where DATEDIFF(YEAR,p.FECHA_PEDIDO,GETDATE()) between 30 and 34
order by p.FECHA_PEDIDO desc


--BD EMPLEADOS. Consulta que devuelva la ciudad de cada una de las oficinas de la BD, su región en
--minúsculas y en otra tercera columna el importe del pedido más barato de la oficina. Ten en cuenta
--que un pedido es de una oficina si ha sido realizado por un representante de ventas que trabaja en
--esa oficina.
--Sólo se mostrarán las oficinas con objetivo de ventas superior a 500000, y que además el pedido
--con mayor importe (pedido de importe máximo) no supera los 30000€.
--Si existiese alguna oficina que no ha vendido nada, no aparecerá en el resultado.
