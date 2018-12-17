--ejercicio 1

select nombrecompleto 
from votantes 
where localidad +1 = substr(dni, 8, 9);

--ejercicio 2

select a.nombrecompleto, decode(b.nombre, 'Cordoba','Madrid','Montilla','Madrid','Baena','Madrid',b.nombre) as nombre
from votantes a join localidades b 
on a.localidad=b.idlocalidad;

--ejercicio 3

select b.siglas
from eventos_resultados a join partidos b on a.partido=b.idpartido
having count(a.partido) = all (select max(count(partido)) from eventos_resultados group by partido)
group by b.siglas;

--ejercicio 4

select dni
from (select fechanacimiento, dni from votantes where fechanacimiento > any (select min(fechanacimiento) from votantes) order by fechanacimiento asc)
where rownum <= 1;

--ejercicio 5

select votante, count(votante) as numeroconsultas
from consultas
group by votante
order by count(votante) desc;

--ejercicio 6

select votante, count(votante) as numeroconsultas
from consultas
having count(votante) > all (select avg(count(votante)) from consultas group by votante)
group by votante
order by count(votante) desc;

--ejercicio 7

select b.nombrecompleto
from consultas a
join votantes b
on a.votante = b.dni
having count(votante) > all (select avg(count(votante)) from consultas group by votante)
group by b.nombrecompleto;

--ejercicio 8

select votante, count(votante) as numerovotos
from consultas
where votante != any ( select dni from (select fechanacimiento, dni from votantes where fechanacimiento > any (select min(fechanacimiento) from votantes) order by fechanacimiento asc) where rownum <= 1 )
group by votante
order by count(votante) desc;

-------------
