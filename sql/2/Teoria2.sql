DESCRIBE consultas;

SELECT *
FROM consultas;

SELECT *
FROM localidades, votantes
WHERE localidades.IDLOCALIDAD=votantes.LOCALIDAD AND votantes.LOCALIDAD=1;

SELECT * FROM votantes a, localidades b, provincias c
WHERE a.localidad=b.idlocalidad AND b.provincia=c.idprovincia AND a.localidad=1;

SELECT AVG(presupuesto) FROM partidos;

SELECT COUNT(presupuesto) FROM partidos WHERE presupuesto>100000;

SELECT presupuesto FROM partidos WHERE presupuesto>100000;

SELECT MAX(presupuesto) FROM partidos;

SELECT nombrecompleto, avg(presupuesto)
FROM partidos GROUP BY nombrecompleto
HAVING AVG(presupuesto)>100000;

SELECT *
FROM partidos;

SELECT provincia, SUM(numerohabitantes)
FROM localidades GROUP BY
provincia;
