select tipo ,
(max(count(tipo)))
from eventos
group by tipo;

select Min(fechanacimiento)
from votantes;


create table prueba
  (edad number(20), nombre varchar(50));
  
drop table prueba;



SELECT * FROM votantes WHERE estudiossuperiores IN ('Basicos',
'Superiores', 'Doctorado');

SELECT * FROM votantes WHERE estudiossuperiores NOT IN ('Ninguno');
SELECT * FROM votantes WHERE estudiossuperiores IN ('Ninguno');
SELECT * FROM eventos_resultados;

update votantes
set ESTUDIOSSUPERIORES='Ninguno'
where nombrecompleto='Rosario Ruiz Olivares';

SELECT CONCAT(CONCAT(a.nombrecompleto,' es de '),b.nombre) AS "nombre y dirección del elector"  FROM votantes a,
localidades b WHERE a.localidad=b.idlocalidad;

SELECT a.nombrecompleto||' es de '||b.nombre AS "nombre y dirección del elector"  
FROM votantes a,localidades b 
WHERE a.localidad=b.idlocalidad;

SELECT SUBSTR(nombrecompleto,1,INSTR(nombrecompleto,' ')) FROM votantes;
SELECT SUBSTR(nombrecompleto,1,INSTR(nombrecompleto,' ')-1) as nombre
FROM votantes
WHERE length(SUBSTR(nombrecompleto,1,INSTR(nombrecompleto,' ')-1))<=5;

SELECT nombre FROM (SELECT * FROM localidades WHERE provincia=1)
WHERE numerohabitantes>20000;

SELECT
numerohabitantes, nombre
FROM localidades WHERE provincia=1;

SELECT nombre FROM localidades WHERE numerohabitantes > any (SELECT
numerohabitantes FROM localidades WHERE provincia=1);


--1- Obtener el nombre de todos los votantes cuyo DNI acaba igual que el
--identificador de su localidad más 1. Es decir, el votante con DNI 30948214 debe
--mostrarse si pertenece a la localidad número 3.

select nombrecompleto, dni, localidad+1, SUBSTR(dni, LENGTH(dni))
from votantes
where localidad +1 = SUBSTR(dni, LENGTH(dni));

--2- Obtener el nombre de todos los votantes así como el nombre de la localidad en
--la que viven teniendo en cuenta que todos los que sean de la provincia de
--Córdoba (identificador de localidad 1, 2 y 3) se han mudado a Madrid.

select v.nombrecompleto, DECODE(l.nombre,'Cordoba', 'Madrid', 'Baena', 'Madrid', 'Montilla', 'Madrid', l.nombre) AS NOMBRE
from votantes v,localidades l
where v.localidad=l.idlocalidad
ORDER BY v.nombrecompleto;

--3- Mostrar las siglas de aquellos partidos que han participado un mayor
--número de veces en eventos.


select p.siglas
from partidos p, eventos_resultados e
where p.idpartido=e.partido
having count(partido)= (select max(count(partido))
                from EVENTOS_RESULTADOS
                group by partido)
group by p.siglas;
            

select max(count(partido))as num_veces_max
from EVENTOS_RESULTADOS
group by partido;

select (count(partido))as num_veces_max
from EVENTOS_RESULTADOS
group by partido;

--4 Obtener el DNI del segundo votante de más edad de entre todos los votantes
--existentes en la base de datos.


SELECT DNI
FROM 
  (SELECT DNI, FECHANACIMIENTO
    FROM VOTANTES
    WHERE FECHANACIMIENTO>(SELECT MIN(FECHANACIMIENTO)
                    FROM VOTANTES)
    ORDER BY FECHANACIMIENTO)
WHERE ROWNUM<3;


SELECT DNI, FECHANACIMIENTO
FROM VOTANTES
WHERE FECHANACIMIENTO>=(SELECT MIN(FECHANACIMIENTO)
                    FROM VOTANTES)
ORDER BY FECHANACIMIENTO;



SELECT MIN(FECHANACIMIENTO)
FROM VOTANTES;



--5 Obtener el DNI del votante y el numero de veces que dicho votante ha
--participado en una consulta, mostrando el resultado de manera descendente
--en cuanto a número de participaciones.

select votante, count(votante) as participaciones
from consultas
group by votante
order by participaciones desc;


--6- Obtener el DNI del votante y el numero de veces que dicho votante ha
--participado en una consulta, mostrando el resultado de manera descendente
--en cuanto a número de participaciones. Sólo se mostrarán aquellos votantes
--cuya participación ha sido mayor que la media de participaciones de todos los
--votantes.

select  votante, count(votante)as participaciones
from  consultas
having count(votante)>(select avg(count(votante))
                      from consultas
                      group by votante)
group by votante
order by participaciones desc;

select count(avg(votante))
from consultas
group by votante;

--7- Obtener el nombre de los votantes cuya participación ha sido mayor que la
--media de participaciones de todos los votantes.


(SELECT V.NOMBRECOMPLETO, COUNT(C.VOTANTE) AS PARTICIPACIONES
FROM VOTANTES V, CONSULTAS C
WHERE V.DNI=C.VOTANTE
GROUP BY V.NOMBRECOMPLETO);

(SELECT AVG(COUNT(VOTANTE)) AS MEDIA
FROM CONSULTAS 
GROUP BY VOTANTE);

SELECT V.NOMBRECOMPLETO, COUNT (C.VOTANTE) AS PARTICIPACIONES
FROM VOTANTES V, CONSULTAS C
WHERE V.DNI=C.VOTANTE
HAVING COUNT(C.VOTANTE)>(SELECT AVG(COUNT(VOTANTE)) AS MEDIA
                      FROM CONSULTAS 
                      GROUP BY VOTANTE)
GROUP BY V.NOMBRECOMPLETO
ORDER BY PARTICIPACIONES DESC;


--8- Obtener el DNI del votante y el numero de veces que dicho votante ha
--participado en una consulta, mostrando el resultado de manera descendente
--en cuanto a número de participaciones y no mostrando los resultados del
--segundo votante de más edad.

select votante, count(votante) as participaciones
from consultas
where votante NOT IN ( select dni from (select fechanacimiento, dni from votantes where fechanacimiento > any (select min(fechanacimiento) from votantes) order by fechanacimiento asc) where rownum <= 1 )
group by votante
order by participaciones desc;

