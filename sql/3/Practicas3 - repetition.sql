
--1- Obtener el nombre de todos los votantes cuyo DNI acaba igual que el
--identificador de su localidad más 1. Es decir, el votante con DNI 30948214 debe
--mostrarse si pertenece a la localidad número 3.

SELECT V.NOMBRECOMPLETO,DNI,  LOCALIDAD+1, SUBSTR(DNI, 8)
FROM VOTANTES V
WHERE LOCALIDAD+1=SUBSTR(DNI, 8);


--2- Obtener el nombre de todos los votantes así como el nombre de la localidad en
--la que viven teniendo en cuenta que todos los que sean de la provincia de
--Córdoba (identificador de localidad 1, 2 y 3) se han mudado a Madrid.

select idlocalidad, nombre
from localidades;

select v.nombrecompleto, l.nombre, decode(l.nombre, 'Cordoba', 'Madrid',
                                                    'Montilla', 'Madrid',
                                                    'Baena', 'Madrid',l.nombre)
                                                    
from votantes v, localidades l
where v.localidad=l.idlocalidad;


--3- Mostrar las siglas de aquellos partidos que han participado un mayor
--número de veces en eventos.

SELECT P.SIGLAS
FROM PARTIDOS P, EVENTOS_RESULTADOS E
WHERE P.IDPARTIDO=E.PARTIDO
HAVING (COUNT(E.PARTIDO))=(SELECT MAX(COUNT(E.EVENTO)) FROM EVENTOS_RESULTADOS E GROUP BY E.PARTIDO)
GROUP BY SIGLAS;
--WHERE;

SELECT MAX(COUNT(E.EVENTO))
FROM EVENTOS_RESULTADOS E
GROUP BY E.PARTIDO;
           

--4 Obtener el DNI del segundo votante de más edad de entre todos los votantes
--existentes en la base de datos.

SELECT DNI
FROM (SELECT V.FECHANACIMIENTO, V.DNI
FROM VOTANTES V
WHERE V.FECHANACIMIENTO>(SELECT MIN(V.FECHANACIMIENTO)FROM VOTANTES V) ORDER BY FECHANACIMIENTO ASC)
WHERE FECHANACIMIENTO=(SELECT MIN(FECHANACIMIENTO)
FROM(SELECT V.FECHANACIMIENTO, V.DNI
FROM VOTANTES V
WHERE V.FECHANACIMIENTO>(SELECT MIN(V.FECHANACIMIENTO)FROM VOTANTES V) ORDER BY FECHANACIMIENTO ASC))
;

SELECT MIN(V.FECHANACIMIENTO)
FROM VOTANTES V;

SELECT V.FECHANACIMIENTO, V.DNI
FROM VOTANTES V
WHERE V.FECHANACIMIENTO>(SELECT MIN(V.FECHANACIMIENTO)FROM VOTANTES V) ORDER BY FECHANACIMIENTO ASC;

SELECT MIN(FECHANACIMIENTO)
FROM(SELECT V.FECHANACIMIENTO, V.DNI
FROM VOTANTES V
WHERE V.FECHANACIMIENTO>(SELECT MIN(V.FECHANACIMIENTO)FROM VOTANTES V) ORDER BY FECHANACIMIENTO ASC);



--5 Obtener el DNI del votante y el numero de veces que dicho votante ha
--participado en una consulta, mostrando el resultado de manera descendente
--en cuanto a número de participaciones.

SELECT VOTANTE, COUNT(EVENTO) AS PARTICIPACIONES
FROM CONSULTAS
WHERE COUNT (EVENTO)=5
GROUP BY VOTANTE
ORDER BY PARTICIPACIONES DESC;


--6- Obtener el DNI del votante y el numero de veces que dicho votante ha
--participado en una consulta, mostrando el resultado de manera descendente
--en cuanto a número de participaciones. Sólo se mostrarán aquellos votantes
--cuya participación ha sido mayor que la media de participaciones de todos los
--votantes.

SELECT AVG(COUNT(EVENTO)) AS MEDIA
FROM CONSULTAS
GROUP BY VOTANTE;

SELECT VOTANTE, COUNT(EVENTO) AS PARTICIPACIONES
FROM CONSULTAS
HAVING COUNT(EVENTO)>(SELECT AVG(COUNT(EVENTO)) AS MEDIA FROM CONSULTAS GROUP BY VOTANTE)
GROUP BY VOTANTE
ORDER BY PARTICIPACIONES DESC
;



--7- Obtener el nombre de los votantes cuya participación ha sido mayor que la
--media de participaciones de todos los votantes.


--8- Obtener el DNI del votante y el numero de veces que dicho votante ha
--participado en una consulta, mostrando el resultado de manera descendente
--en cuanto a número de participaciones y no mostrando los resultados del
--segundo votante de más edad.





