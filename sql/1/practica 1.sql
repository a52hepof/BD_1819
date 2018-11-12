--Ejercicio 2- Mostrar todas las tablas 

SELECT table_name FROM user_tables;

--Ejercicio 3- Descripciones de tablas

DESCRIBE LOCALIDADES, PROVINCIAS;

--Ejercicio 4- Borrado tablas con PRIMARY_KEY

DROP TABLE VOTANTES CASCADE CONSTRAINTS;

--Ejercicio 5- Inserción votantes

INSERT INTO VOTANTES

  VALUES (3065384, 'María González Ramírez' , 'Doctorado' , 'Activo', 'goram@telefonica.es', 1, '21/8/1989', 677544822);
  
INSERT INTO VOTANTES

  VALUES (30945741, 'Fernando Herrera Poch' , 'Superiores' , 'Estudiante', 'a52hepof@uco.es', 1, '07/02/1977', 630460774);

INSERT INTO VOTANTES
  (DNI, ESTUDIOSSUPERIORES, SITUACIONLABORAL, EMAIL, LOCALIDAD, FECHANACIMIENTO)
  VALUES (44361343, 'Superiores' , 'Activo', 'm92rorum@uco.es', 1, '12/12/1977');


--Ejercicio 6- Comprobar inserción datos

SELECT DNI, NOMBRECOMPLETO
  FROM VOTANTES
  ORDER BY DNI ASC;
  
--Ejercicio 7- Borrado de inserción

DELETE
  FROM VOTANTES
  WHERE DNI = 30945741;
  
--Ejercicio 8- Realizar distintas inserciones y comprobarlas

SELECT IDPARTIDO, NOMBRECOMPLETO AS"NOMBRE", SIGLAS
  FROM PARTIDOS
  ORDER BY NOMBRE ASC;

INSERT INTO PARTIDOS
  (IDPARTIDO, NOMBRECOMPLETO, PRESIDENTE, FECHACREACION, DIRECCION, CIUDAD)
  VALUES (6, 'VOX', 'SANTIAGO ABASCAL', '03/12/2013', 'Diego de Leon, 6', 'Madrid');
  
SELECT *
  FROM EVENTOS;

INSERT INTO EVENTOS
  (IDEVENTO, NOMBRE, FECHA, TIPO)
  VALUES (12, 'Punta Umbria', '22/01/2018', 'Locales');
  
  
  
--Ejercicio 9- el nombre de los eventos que tienen lugar y que se encuentran en la tabla eventos,así como su tipo

SELECT NOMBRE, TIPO, FECHA
  FROM EVENTOS;
  
--Ejercicio 10- Concatenación nombre evento y su tipo en una única columna CONVOVATORIA

SELECT NOMBRE ||' ' || 'DE TIPO' ||' ' ||TIPO AS CONVOCATORIA
  FROM EVENTOS;
  
--Ejercicio 11- Concatenación columnas y renombrado en otras tablas

SELECT NOMBRECOMPLETO || ' '|| ' - PRESIDENTE : ' || ' '||PRESIDENTE AS "PARTIDO POLÍTICO"
  FROM PARTIDOS;
  
  
SELECT LOCALIDADES.NOMBRE || ' - '||  PROVINCIAS.NOMBRE as "Municipio-Provincia", LOCALIDADES.NUMEROHABITANTES || ' - '||  PROVINCIAS.NUMEROHABITANTES as "Hab Localidad-Hab Provincia"
 FROM PROVINCIAS INNER JOIN LOCALIDADES ON LOCALIDADES.PROVINCIA=PROVINCIAS.IDPROVINCIA;
 
 SELECT LOCALIDADES.NOMBRE || ' - '||  PROVINCIAS.NOMBRE as "Municipio-Provincia", LOCALIDADES.NUMEROHABITANTES || ' - '||  PROVINCIAS.NUMEROHABITANTES as "Hab Localidad-Hab Provincia"
 FROM PROVINCIAS, LOCALIDADES
 WHERE LOCALIDADES.PROVINCIA=PROVINCIAS.IDPROVINCIA;
  
  
--Otros 

SELECT *
  FROM PARTIDOS;
  

SELECT *
  FROM PARTIDOS 
  WHERE NOMBRECOMPLETO LIKE '%Partido%';
  
  
UPDATE PARTIDOS
	SET NOMBRECOMPLETO='Partido Socialista Obrero Español'
	WHERE NOMBRECOMPLETO like '%Obrero%';
  
UPDATE PARTIDOS
	SET DIRECCION='Alcalá, 253'
	WHERE SIGLAS like 'Cs';
  
UPDATE PARTIDOS
	SET PRESIDENTE='Pablo Iglesias Turrión'
	WHERE NOMBRECOMPLETO like 'Podemos';

UPDATE PARTIDOS
	SET PRESIDENTE='Alberto Garzón Espinosa'
	WHERE NOMBRECOMPLETO like 'Izquierda Unida';





--uso de alias

SELECT IDPARTIDO "numero partido", NOMBRECOMPLETO "nombre"
  FROM partidos;
   
--selección de datos de varias tablas  
  
SELECT LOCALIDADES.NOMBRE "NOMBRE LOCALIDAD", PROVINCIAS.NOMBRE "NOMBRE PROVINCIA", LOCALIDADES.NUMEROHABITANTES, PROVINCIAS.NUMEROHABITANTES "HABITANTES PROVICIA"

  FROM LOCALIDADES INNER JOIN PROVINCIAS ON LOCALIDADES.PROVINCIA=PROVINCIAS.IDPROVINCIA;
  
SELECT *
  FROM VOTANTES;