--Ejercicio 1 Obtener el nombre de todos los votantes cuyo segundo apellido acaba en “n”.

select NOMBRECOMPLETO
from VOTANTES
where NOMBRECOMPLETO like '%n';

--Ejercicio 2 Obtener el DNI de todos los votantes que tengan al menos tres 5s en su DNI.
select *
from votantes;

update votantes
set dni=51556778
where NOMBRECOMPLETO is null;

update votantes
set dni=51556775
where dni =51556778;

select DNI, NOMBRECOMPLETO
from VOTANTES
where DNI like '5%' and dni like '%55%' and DNI like '%5' ;

--Ejercicio 3 Obtener el nombre de aquellos votantes cuya fecha de nacimiento sea
--posterior al 1 de Enero de 1990.

select NOMBRECOMPLETO
from VOTANTES
where FECHANACIMIENTO>'1/1/1990';

--Ejercicio 4 Obtener el nombre del votante y el nombre de la localidad de aquellos
--votantes que han ejercido el voto en una localidad que tiene más de 300000
--habitantes.

select *
from localidades
where numerohabitantes>300000;

select v.nombrecompleto as nombre, l.nombre as localidad
from votantes v, localidades l
where v.localidad=l.idlocalidad and l.numerohabitantes>300000;

select *
from votantes;

--Ejercicio 5 Obtener el nombre del votante y el nombre de la comunidad de aquellos
--votantes que han ejercido el voto en una localidad que tiene más de 300000
--habitantes.

select v.nombrecompleto as nombre, p.comunidad as comunidad
from votantes v, localidades l, provincias p
where v.localidad=l.idlocalidad and l.provincia=p.idprovincia and l.numerohabitantes>300000;

--Ejercicio 6  Obtener el identificador del partido y el número de datos o consultas que se
--tiene para dicho partido de entre todos los partidos sobre los que se han
--realizado alguna consulta.

select *
from consultas_datos;

select *
from consultas;

select *
from partidos;

select cd.partido,count(cd.consulta) as conteo
from consultas_datos cd, partidos p
where p.idpartido=cd.partido
--having count(cd.consulta)>0
group by cd.partido;


--Ejercicio 7 Mostrar el identificador de partido y el número de consultas realizadas para
cada partido.

select p.nombrecompleto,count(cd.partido)
from consultas_datos cd, partidos p
where p.idpartido=cd.partido
group by p.nombrecompleto;

--Ejercicio 8 Mostrar el nombre del partido político sobre el que se han realizado más de 10
consultas.

select p.nombrecompleto
from consultas_datos cd, partidos p
where p.idpartido=cd.partido
having count(cd.consulta)>10
group by p.nombrecompleto;




--Ejercicio 9 Mostrar el nombre del partido y el número de consultas realizadas para
--aquellos partidos que aparecen en más de 10 consultas.

select p.nombrecompleto,count(cd.partido)
from consultas_datos cd, partidos p
where p.idpartido=cd.partido
having count(cd.partido)>10
group by p.nombrecompleto;


--Ejercicio 10  Mostrar el nombre de los partidos y el número de consultas realizadas para
--cada partido considerando sólo aquellas consultas en las que el encuestado ha
--contestado afirmativamente a votar a dicho partido y con una certidumbre por
--encima del 80%, es decir, 0.8.


select *
from consultas_datos;

select p.NOMBRECOMPLETO, count(cd.consulta) as conteo
from partidos p, consultas_datos cd
where p.idpartido=cd.partido and cd.respuesta like 'Si' and cd.certidumbre>0.8
group by p.NOMBRECOMPLETO;


