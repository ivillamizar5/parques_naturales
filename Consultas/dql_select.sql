-- cantidad de parques por entidad responsable

use parques_naturales;

select er.nombre , COUNT(er.id_parques) as "cantidad Parques" 
from departamento d join entidad_responsable er on d.id_departamento = er.id_parques 
	GROUP by er.nombre;


-- cantidad de parques
SELECT count(id_parque)
	from parques p ;


-- muestre las especies que habitan en el Zona de camping
SELECT e.denominacion_vulgar  as "Especie"
FROM areas a join areas_especies ae on a.id_area = ae.id_areas  
	join especies e on ae.id_especies=e.id_especie  
	WHERE LOWER(a.nombre) = LOWER("Zona de camping");

select * from especies e  ;

-- muestre las especies que habitan en el Zona de observación
SELECT e.denominacion_vulgar  as "Especie"
FROM areas a join areas_especies ae on a.id_area = ae.id_areas  
	join especies e on ae.id_especies=e.id_especie  
	WHERE LOWER(a.nombre) = LOWER("Zona de observación");


-- cuantas especies hay en el area Zona de investigación
SELECT e.denominacion_vulgar as "Especie", COUNT(ae.id_especies) as cantidad 
FROM areas a join areas_especies ae on a.id_area = ae.id_areas  
	join especies e on ae.id_especies=e.id_especie  
	WHERE LOWER(a.nombre) = LOWER("Zona de investigación") 
	group by e.denominacion_vulgar;

-- especies que habitan en mas de dos areas
	SELECT e.denominacion_vulgar as "Especie", COUNT(ae.id_areas) as "Cantidad_areas"
	FROM areas a join areas_especies ae on a.id_area = ae.id_areas  
	join especies e on ae.id_especies=e.id_especie
	GROUP by e.denominacion_vulgar 
	HAVING COUNT(ae.id_areas) > 1;


-- Area con mayor extension 
select  nombre, extension  
	from areas a 
	order by extension desc limit 1;

-- cantidad de especies por tipo
SELECT tipo, SUM(numero_individuos)  
	FROM especies e 
	group by tipo;


-- mostrar el visitante registrado recientemente
SELECT CONCAT(v.nombre, " ", v.apellido) as "Nombre", rp.fecha 
	from visitantes v join registro_parques rp on v.cedula = rp.id_visitante 
	ORDER by fecha DESC limit 1;

-- Muestre el personal de vigilancia que mas registros de visitantes ha hecho.
SELECT CONCAT(p.nombre, " ", p.apellido) ,  COUNT(rp.id_visitante) as "Cantidad"  
	from personal p join registro_parques rp on p.cedula = rp.id_personal 
	group by CONCAT(p.nombre, " ", p.apellido)
	order by COUNT(rp.id_visitante) desc LIMIT 1;

-- Mostrar los visitantes que aun estan  alojados
SELECT CONCAT(v.nombre, " ", v.apellido) as visitante
from visitantes v join registro_parques rp on v.cedula = rp.id_visitante 
	join visitante_alojamiento va on rp.id_registro_parques = va.id_registro_parques 
	where va.fecha_salida is null;



-- Visitantes que han visitado más de un parque
SELECT CONCAT(v.nombre, ' ', v.apellido) AS Visitante, COUNT(rp.id_parque) AS Cantidad_Parques
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
GROUP BY v.cedula
HAVING COUNT(rp.id_parque) > 1;

-- Áreas con más de una especie registrada
SELECT a.nombre AS Area, COUNT(ae.id_especies) AS Cantidad_Especies
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
GROUP BY a.nombre
HAVING COUNT(ae.id_especies) > 1;


--  Personal que trabaja en más de un área
SELECT CONCAT(p.nombre, ' ', p.apellido) AS Personal, COUNT(pa.id_area) AS Cantidad_Areas
FROM personal p
JOIN personal_areas pa ON p.cedula = pa.id_personal
GROUP BY p.cedula
HAVING COUNT(pa.id_area) > 1;

-- Proyectos de investigación con un presupuesto superior a 10,000,000
SELECT id_proyecto_investigacion AS Proyecto, presupuesto
FROM proyectos_investigacion
WHERE presupuesto > 10000000
ORDER BY presupuesto DESC;	

--  Especies que no están asociadas a ningún proyecto de investigación
SELECT e.denominacion_vulgar AS Especie
FROM especies e
LEFT JOIN especies_investigacion ei ON e.id_especie = ei.id_especie
WHERE ei.id_proyecto_investigacion IS NULL;


-- Visitantes que han estado en más de un alojamiento
SELECT CONCAT(v.nombre, ' ', v.apellido) AS Visitante, COUNT(va.id_alojamiento) AS Cantidad_Alojamientos
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
JOIN visitante_alojamiento va ON rp.id_registro_parques = va.id_registro_parques
GROUP BY v.cedula
HAVING COUNT(va.id_alojamiento) > 1;


-- Personal que ha utilizado más de un vehículo
SELECT CONCAT(p.nombre, ' ', p.apellido) AS Personal, COUNT(pv.id_vehiculo) AS Cantidad_Vehiculos
FROM personal p
JOIN personal_vehiculo pv ON p.cedula = pv.id_persona
GROUP BY p.cedula
HAVING COUNT(pv.id_vehiculo) > 1;


---  Proyectos de investigación que involucran más de una especie *****
SELECT pi.id_proyecto_investigacion AS Proyecto, COUNT(ei.id_especie) AS Cantidad_Especies
FROM proyectos_investigacion pi
JOIN especies_investigacion ei ON pi.id_proyecto_investigacion = ei.id_proyecto_investigacion
GROUP BY pi.id_proyecto_investigacion
HAVING COUNT(ei.id_especie) > 1;


-- Áreas con la mayor extensión por parque
SELECT p.nombre AS Parque, a.nombre AS Area, MAX(a.extension) AS Extension
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
GROUP BY p.nombre, a.nombre
ORDER BY Extension DESC;


--- Especies que no están registrados en ninguna área
SELECT e.denominacion_vulgar AS Especie
FROM especies e
LEFT JOIN areas_especies ae ON e.id_especie = ae.id_especies
WHERE ae.id_areas IS NULL;


-- Personal que no está asignado a ningún proyecto de investigación
SELECT CONCAT(p.nombre, ' ', p.apellido) AS Personal, p.cedula  
FROM personal p
LEFT JOIN personal_investigacion pi ON p.cedula = pi.id_personal
WHERE pi.id_proyecto_investigacion IS NULL;


-- Parques con más de una entidad responsable

SELECT p.nombre AS Parque, COUNT(er.id_entidad) AS Cantidad_Entidades
FROM parques p
JOIN entidad_responsable er ON p.id_parque = er.id_parques
GROUP BY p.nombre
HAVING COUNT(er.id_entidad) > 1;





-- Obtener el nombre de los parques que tienen alojamientos de categoría "Ecológico".

SELECT p.nombre
FROM parques p
WHERE p.id_parque IN (
    SELECT a.id_parque
    FROM alojamiento a
    JOIN categoria c ON a.id_categoria = c.id_categoria
    WHERE c.nombre = 'Ecológico'
);


-- Listar los nombres de los visitantes que se alojaron en el parque "Parque Nacional Natural Tayrona".

SELECT v.nombre , v.apellido 
FROM visitantes v
WHERE v.cedula IN (
    SELECT r.id_visitante
    FROM registro_parques r
    JOIN parques p ON r.id_parque = p.id_parque
    WHERE p.nombre = 'Parque Nacional Natural Tayrona'
);









