--BD EMPLEADOS. Consulta que devuelve en una primera columna la descripci�n y el precio de
--todos los productos, separados por una barra invertida (por ejemplo ARTICULO TIPO2 \ 76), y en
--una segunda columna el gasto total en pedidos de ese producto. Entre la descripci�n y la barra
--invertida s�lo puede existir un espacio en blanco y entre la barra invertida y el precio otro espacio
--en blanco.
--En el resultado s�lo podr�n aparecer aquellos productos cuyo gasto medio es menor de 3000�.
--La primera columna se llamar� Producto y la segunda Gasto total.
--Si de alg�n producto no se han realizado pedidos en la columna del Gasto total deber� aparecer la
--frase PRODUCTO QUE TODAVIA NO SE HA VENDIDO.
--La columna del gasto total deber� mostrar los importes con 6 d�gitos como m�ximo en la parte
--entera y 2 decimales.
--Deber�n aparecer primero en el resultado los productos con mayor gasto total.


select TRIM(p.DESCRIPCION) +' \ '+ (CONVERT(varchar(5),COUNT(p.PRECIO))) AS PRODUCTO,ISNULL(CAST(CAST(sum(pe.IMPORTE)AS numeric(8,2)) AS CHAR),'PRODUCTO QUE TODAVIA NO SE HA VENDIDO') as 'GASTO TOTAL'
from PRODUCTO p 
LEFT join PEDIDO pe
on p.ID_PRODUCTO=pe.PRODUCTO
AND
P.ID_FAB=PE.FAB
group by P.ID_FAB,P.ID_PRODUCTO,P.DESCRIPCION
HAVING ISNULL(AVG(PE.IMPORTE),0)< 3000

--BD EMPLEADOS. Consulta que devuelva la lista de los pedidos que hace m�s de 24 a�os y menos
--de 28 a�os que se han realizado.
--IMPORTANTE: Para hacer la comprobaci�n de los a�os que hace que se ha realizado el pedido no
--puedes usar ni la cl�usula IN, ni OR ni tampoco los operadores >=, >, <=, !=, = <>.
--En el resultado deber� aparecer el n�mero del pedido, en una segunda columna la fecha del
--pedido con formato dd-mm-aaaa (F�jate que se separan con guiones y ll�male FechaPed) y en una
--tercera columna de nombre Unidades aparecer� lo siguiente en funci�n del n�mero de unidades
--solicitadas en el pedido:
--- Si la cantidad de unidades del pedido es menor que 7 aparecer� el texto POCAS.
--- Si la cantidad de unidades del pedido es mayor o igual que 7 y menor que 30 aparecer� el
--texto NORMAL.
--- Si la cantidad de unidades del pedido es mayor o igual que 30 aparecer� el texto MUCHAS.
--Deben aparecer los pedidos m�s recientes primero. Aseg�rate que aparecen bien ordenados.

SELECT P.NUM_PEDIDO, convert(char(10),P.FECHA_PEDIDO,103) as FechaPed, case
																		when p.CANT <7 then 'POCAS'
																		when p.CANT<30 then 'NORMAL'
																		when p.CANT>=30 then 'MUCHAS'
																		end as Unidades
FROM PEDIDO P
where DATEDIFF(YEAR,p.FECHA_PEDIDO,GETDATE()) between 30 and 34
order by p.FECHA_PEDIDO desc


--BD EMPLEADOS. Consulta que devuelva la ciudad de cada una de las oficinas de la BD, su regi�n en
--min�sculas y en otra tercera columna el importe del pedido m�s barato de la oficina. Ten en cuenta
--que un pedido es de una oficina si ha sido realizado por un representante de ventas que trabaja en
--esa oficina.
--S�lo se mostrar�n las oficinas con objetivo de ventas superior a 500000, y que adem�s el pedido
--con mayor importe (pedido de importe m�ximo) no supera los 30000�.
--Si existiese alguna oficina que no ha vendido nada, no aparecer� en el resultado.
