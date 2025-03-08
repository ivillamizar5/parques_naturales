

use parques_naturales;

-- 1. cantidad de parques por entidad responsable
select er.nombre , COUNT(er.id_parques) as "cantidad Parques" 
from departamento d join entidad_responsable er on d.id_departamento = er.id_parques 
	GROUP by er.nombre;


-- 2. cantidad de parques
SELECT count(id_parque)
	from parques p ;


-- 3. muestre las especies que habitan en el Zona de camping
SELECT e.denominacion_vulgar  as "Especie"
FROM areas a join areas_especies ae on a.id_area = ae.id_areas  
	join especies e on ae.id_especies=e.id_especie  
	WHERE LOWER(a.nombre) = LOWER("Zona de camping");

select * from especies e  ;

-- 4. muestre las especies que habitan en el Zona de observación
SELECT e.denominacion_vulgar  as "Especie"
FROM areas a join areas_especies ae on a.id_area = ae.id_areas  
	join especies e on ae.id_especies=e.id_especie  
	WHERE LOWER(a.nombre) = LOWER("Zona de observación");


-- 5. cuantas especies hay en el area Zona de investigación
SELECT e.denominacion_vulgar as "Especie", COUNT(ae.id_especies) as cantidad 
FROM areas a join areas_especies ae on a.id_area = ae.id_areas  
	join especies e on ae.id_especies=e.id_especie  
	WHERE LOWER(a.nombre) = LOWER("Zona de investigación") 
	group by e.denominacion_vulgar;

-- 6. especies que habitan en mas de dos areas
	SELECT e.denominacion_vulgar as "Especie", COUNT(ae.id_areas) as "Cantidad_areas"
	FROM areas a join areas_especies ae on a.id_area = ae.id_areas  
	join especies e on ae.id_especies=e.id_especie
	GROUP by e.denominacion_vulgar 
	HAVING COUNT(ae.id_areas) > 1;


-- 7. Area con mayor extension 
select  nombre, extension  
	from areas a 
	order by extension desc limit 1;

-- 8. cantidad de especies por tipo
SELECT tipo, SUM(numero_individuos)  
	FROM especies e 
	group by tipo;


-- 9. mostrar el visitante registrado recientemente
SELECT CONCAT(v.nombre, " ", v.apellido) as "Nombre", rp.fecha 
	from visitantes v join registro_parques rp on v.cedula = rp.id_visitante 
	ORDER by fecha DESC limit 1;

-- 10. Muestre el personal de vigilancia que mas registros de visitantes ha hecho.
SELECT CONCAT(p.nombre, " ", p.apellido) ,  COUNT(rp.id_visitante) as "Cantidad"  
	from personal p join registro_parques rp on p.cedula = rp.id_personal 
	group by CONCAT(p.nombre, " ", p.apellido)
	order by COUNT(rp.id_visitante) desc LIMIT 1;

-- 11. Mostrar los visitantes que aun estan  alojados
SELECT CONCAT(v.nombre, " ", v.apellido) as visitante
from visitantes v join registro_parques rp on v.cedula = rp.id_visitante 
	join visitante_alojamiento va on rp.id_registro_parques = va.id_registro_parques 
	where va.fecha_salida is null;



-- 12. Visitantes que han visitado más de un parque
SELECT CONCAT(v.nombre, ' ', v.apellido) AS Visitante, COUNT(rp.id_parque) AS Cantidad_Parques
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
GROUP BY v.cedula
HAVING COUNT(rp.id_parque) > 1;

-- 13. Áreas con más de una especie registrada
SELECT a.nombre AS Area, COUNT(ae.id_especies) AS Cantidad_Especies
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
GROUP BY a.nombre
HAVING COUNT(ae.id_especies) > 1;


-- 14. Personal que trabaja en más de un área
SELECT CONCAT(p.nombre, ' ', p.apellido) AS Personal, COUNT(pa.id_area) AS Cantidad_Areas
FROM personal p
JOIN personal_areas pa ON p.cedula = pa.id_personal
GROUP BY p.cedula
HAVING COUNT(pa.id_area) > 1;

-- 15. Proyectos de investigación con un presupuesto superior a 10,000,000
SELECT id_proyecto_investigacion AS Proyecto, presupuesto
FROM proyectos_investigacion
WHERE presupuesto > 10000000
ORDER BY presupuesto DESC;	

-- 16.  Especies que no están asociadas a ningún proyecto de investigación
SELECT e.denominacion_vulgar AS Especie
FROM especies e
LEFT JOIN especies_investigacion ei ON e.id_especie = ei.id_especie
WHERE ei.id_proyecto_investigacion IS NULL;


-- 17. Visitantes que han estado en más de un alojamiento
SELECT CONCAT(v.nombre, ' ', v.apellido) AS Visitante, COUNT(va.id_alojamiento) AS Cantidad_Alojamientos
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
JOIN visitante_alojamiento va ON rp.id_registro_parques = va.id_registro_parques
GROUP BY v.cedula
HAVING COUNT(va.id_alojamiento) > 1;


-- 18. Personal que ha utilizado más de un vehículo
SELECT CONCAT(p.nombre, ' ', p.apellido) AS Personal, COUNT(pv.id_vehiculo) AS Cantidad_Vehiculos
FROM personal p
JOIN personal_vehiculo pv ON p.cedula = pv.id_persona
GROUP BY p.cedula
HAVING COUNT(pv.id_vehiculo) > 1;


--- 19. Proyectos de investigación que involucran más de una especie *****
SELECT pi.id_proyecto_investigacion AS Proyecto, COUNT(ei.id_especie) AS Cantidad_Especies
FROM proyectos_investigacion pi
JOIN especies_investigacion ei ON pi.id_proyecto_investigacion = ei.id_proyecto_investigacion
GROUP BY pi.id_proyecto_investigacion
HAVING COUNT(ei.id_especie) > 1;


-- 20. Áreas con la mayor extensión por parque
SELECT p.nombre AS Parque, a.nombre AS Area, MAX(a.extension) AS Extension
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
GROUP BY p.nombre, a.nombre
ORDER BY Extension DESC;


--- 21. Especies que no están registrados en ninguna área
SELECT e.denominacion_vulgar AS Especie
FROM especies e
LEFT JOIN areas_especies ae ON e.id_especie = ae.id_especies
WHERE ae.id_areas IS NULL;


-- 22. Personal que no está asignado a ningún proyecto de investigación
SELECT CONCAT(p.nombre, ' ', p.apellido) AS Personal, p.cedula  
FROM personal p
LEFT JOIN personal_investigacion pi ON p.cedula = pi.id_personal
WHERE pi.id_proyecto_investigacion IS NULL;


-- 23. Parques con más de una entidad responsable

SELECT p.nombre AS Parque, COUNT(er.id_entidad) AS Cantidad_Entidades
FROM parques p
JOIN entidad_responsable er ON p.id_parque = er.id_parques
GROUP BY p.nombre
HAVING COUNT(er.id_entidad) > 1;




-- 24. Obtener el nombre de los parques que tienen alojamientos de categoría "Ecológico".

SELECT p.nombre
FROM parques p
WHERE p.id_parque IN (
    SELECT a.id_parque
    FROM alojamiento a
    JOIN categoria c ON a.id_categoria = c.id_categoria
    WHERE c.nombre = 'Ecológico'
);


-- 25. Listar los nombres de los visitantes que se alojaron en el parque "Parque Nacional Natural Tayrona".
SELECT CONCAT(v.nombre , " " ,v.apellido )  as visitantes
FROM visitantes v
WHERE v.cedula IN (
    SELECT r.id_visitante
    FROM registro_parques r
    JOIN parques p ON r.id_parque = p.id_parque
    WHERE p.nombre = 'Parque Nacional Natural Tayrona'
);



-- 26. Mostrar el nombre y sueldo del personal que trabaja en el área "Zona de camping"
SELECT pe.nombre, pe.sueldo
FROM personal pe
WHERE pe.cedula IN (
    SELECT pa.id_personal
    FROM personal_areas pa
    JOIN areas a ON pa.id_area = a.id_area
    WHERE a.nombre = "Zona de camping"
);


-- 27. Obtener el nombre de las especies que su periodo de investigacion es mayor al año 2000  con un presupuesto mayor a $70,000.
SELECT e.denominacion_vulgar
FROM especies e
WHERE e.id_especie IN (
    SELECT ei.id_especie
    FROM especies_investigacion ei
    JOIN proyectos_investigacion pi ON ei.id_proyecto_investigacion = pi.id_proyecto_investigacion
    WHERE pi.presupuesto > 70000 and YEAR(pi.periodo_realizacion) > 2000
);


--  28. Listar los nombres de los parques que tienen áreas con una extensión mayor a 500 km²

SELECT p.nombre
FROM parques p
WHERE p.id_parque IN (
    SELECT a.id_parques
    FROM areas a
    WHERE a.extension > 500
);

-- 29. Obtener el nombre de los departamentos que tienen parques declarados antes del año 2000.
SELECT d.nombre
FROM departamento d
WHERE d.id_departamento IN (
    SELECT pd.id_departamento
    FROM parques_departamento pd
    JOIN parques p ON pd.id_parque = p.id_parque
    WHERE YEAR(p.fecha_declaracion) < 2000
);


-- 30. Mostrar el nombre de los parques que tienen áreas con más de 100 individuos de especies "minerales".
SELECT p.nombre
FROM parques p
WHERE p.id_parque IN (
    SELECT a.id_parques
    FROM areas a
    JOIN areas_especies ae ON a.id_area = ae.id_areas
    JOIN especies e ON ae.id_especies = e.id_especie
    WHERE e.tipo = 'minerales' AND e.numero_individuos > 100
);


-- 31. Calcular el número total de visitantes por parque.
SELECT p.nombre, COUNT(r.id_visitante) AS total_visitantes
FROM parques p
LEFT JOIN registro_parques r ON p.id_parque = r.id_parque
GROUP BY p.nombre;


--  32. Obtener el nombre del parque con la mayor extensión total de áreas.
SELECT p.nombre, a.extension 
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
GROUP BY p.nombre, a.extension 
ORDER BY SUM(a.extension) DESC
LIMIT 1;

-- 33. Listar los nombres de los visitantes que no se han alojado en ningún alojamiento.
SELECT v.cedula , CONCAT(v.nombre," ",v.apellido) 
FROM visitantes v
WHERE v.cedula NOT IN (
    SELECT va.id_registro_parques
    FROM visitante_alojamiento va
);

-- 34. Mostrar el nombre y sueldo promedio del personal por tipo de personal
SELECT tp.nombre, AVG(pe.sueldo) AS sueldo_promedio
FROM personal pe
JOIN tipo_personal tp ON pe.id_tipo_personal = tp.id_tipo_personal
GROUP BY tp.nombre;


-- 35. Listar los nombres de los parques que no tienen áreas asignadas.

SELECT p.nombre
FROM parques p
WHERE p.id_parque NOT IN (
    SELECT a.id_parques
    FROM areas a
);


-- 36. Mostrar el nombre de los visitantes que han visitado más de un parque.
SELECT CONCAT(v.nombre," ",v.apellido) 
FROM visitantes v
WHERE v.cedula IN (
    SELECT r.id_visitante
    FROM registro_parques r
    GROUP BY r.id_visitante
    HAVING COUNT(DISTINCT r.id_parque) > 1
);

-- 37. Obtener el nombre de los alojamientos que no han sido ocupados.
SELECT a.descripcion
FROM alojamiento a
WHERE a.id_alojamiento NOT IN (
    SELECT va.id_alojamiento
    FROM visitante_alojamiento va
);


-- 38. Calcular el número total de especies por tipo en cada área.
SELECT a.nombre AS area, e.tipo, COUNT(e.id_especie) AS total_especies
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
GROUP BY a.nombre, e.tipo;



-- 39. Obtener el nombre de los parques que tienen alojamientos con capacidad mayor a 10 personas.
SELECT p.nombre
FROM parques p
WHERE p.id_parque IN (
    SELECT a.id_parque
    FROM alojamiento a
    WHERE a.capacidad > 10
);


-- 40. Obtener el nombre de los vehículos utilizados por el personal de Vigilancia.
SELECT v.tipo, v.marca
FROM vehiculo v
WHERE v.id_vehiculo IN (
    SELECT pv.id_vehiculo
    FROM personal_vehiculo pv
    JOIN personal pe ON pv.id_persona = pe.cedula
    JOIN tipo_personal tp ON pe.id_tipo_personal = tp.id_tipo_personal
    WHERE tp.nombre = 'Vigilancia'
);




-- 41. Calcular el número total de visitantes por profesión.
SELECT pr.nombre, COUNT(v.cedula) AS total_visitantes
FROM visitantes v
JOIN profesion pr ON v.id_profesion = pr.id_profesion
GROUP BY pr.nombre;

-- 42. Obtener el nombre del parque con la menor extensión total de áreas.
SELECT p.nombre, a.extension 
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
GROUP BY p.nombre, a.extension 
ORDER BY SUM(a.extension) ASC
LIMIT 1;


-- 43. Mostrar el nombre y sueldo máximo por tipo de personal.
SELECT tp.nombre, MAX(pe.sueldo) AS sueldo_maximo
FROM personal pe
JOIN tipo_personal tp ON pe.id_tipo_personal = tp.id_tipo_personal
GROUP BY tp.nombre;



-- 44. Obtener el nombre de los alojamientos que han sido ocupados más de 2 veces.
SELECT a.descripcion
FROM alojamiento a
WHERE a.id_alojamiento IN (
    SELECT va.id_alojamiento
    FROM visitante_alojamiento va
    GROUP BY va.id_alojamiento
    HAVING COUNT(va.id_visitante_alojamiento) > 2
);

-- 45. Calcular el número total de especies por tipo en cada parque
SELECT p.nombre AS parque, e.tipo, COUNT(e.id_especie) AS total_especies
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
GROUP BY p.nombre, e.tipo;


-- 46  Obtener el nombre de los parques que tienen alojamientos con capacidad mayor a 15 personas

SELECT p.nombre
FROM parques p
WHERE p.id_parque IN (
    SELECT a.id_parque
    FROM alojamiento a
    WHERE a.capacidad > 15
);

-- 47 Listar los nombres de los visitantes y la cantidad de veces que han visitado parques.
SELECT CONCAT(v.nombre," ",v.apellido), COUNT(r.id_visitante) AS visitas
FROM visitantes v
LEFT JOIN registro_parques r ON v.cedula = r.id_visitante
GROUP BY CONCAT(v.nombre," ",v.apellido);

-- 48 Mostrar el nombre del personal y el tipo de vehículo que utilizan.
SELECT CONCAT(pe.nombre," ",pe.apellido) as Nombre, v.tipo
FROM personal pe
JOIN personal_vehiculo pv ON pe.cedula = pv.id_persona
JOIN vehiculo v ON pv.id_vehiculo = v.id_vehiculo;


-- 50. Obtener el nombre de los alojamientos y la categoría a la que pertenecen.
SELECT DISTINCT c.nombre,  a.descripcion 
FROM alojamiento a
JOIN categoria c ON a.id_categoria = c.id_categoria;




-- 51 Clasificar los parques según su antigüedad (antes o después del año 2000).
SELECT nombre, fecha_declaracion,
    CASE
        WHEN YEAR(fecha_declaracion) < 2000 THEN 'Antiguo'
        ELSE 'Reciente'
    END AS clasificacion
FROM parques;

-- 52. Mostrar el estado de los alojamientos (disponible o no disponible) basado en su capacidad.

SELECT descripcion, capacidad,
    IF(capacidad > 0, 'Disponible', 'No Disponible') AS estado
FROM alojamiento;


-- 53. Clasificar las especies según su número de individuos (abundante, moderado, escaso).

SELECT denominacion_vulgar, numero_individuos,
    CASE
        WHEN numero_individuos > 100 THEN 'Abundante'
        WHEN numero_individuos BETWEEN 50 AND 100 THEN 'Moderado'
        ELSE 'Escaso'
    END AS clasificacion
FROM especies;

-- 54. Clasificar los proyectos de investigación según su presupuesto (bajo, medio, alto).
SELECT id_proyecto_investigacion, presupuesto,
    CASE
        WHEN presupuesto < 5000000 THEN 'Bajo'
        WHEN presupuesto BETWEEN 5000000 AND 10000000 THEN 'Medio'
        ELSE 'Alto'
    END AS clasificacion_presupuesto
FROM proyectos_investigacion;


-- 55. Clasificar los parques según su número de visitantes (popular, moderado, poco visitado). *********************** 
SELECT p.nombre, COUNT(r.id_visitante) AS visitantes,
    CASE
        WHEN COUNT(r.id_visitante) > 100 THEN 'Popular'
        WHEN COUNT(r.id_visitante) BETWEEN 20 AND 100 THEN 'Moderado'
        ELSE 'Poco Visitado'
    END AS clasificacion
FROM parques p
LEFT JOIN registro_parques r ON p.id_parque = r.id_parque
GROUP BY p.nombre;


-- 56. Clasificar las especies según su número de individuos (crítico, vulnerable, estable).
SELECT denominacion_vulgar, numero_individuos,
    CASE
        WHEN numero_individuos < 20 THEN 'Crítico'
        WHEN numero_individuos BETWEEN 20 AND 50 THEN 'Vulnerable'
        ELSE 'Estable'
    END AS estado_conservacion
FROM especies;



-- 57. Mostrar el estado de los alojamientos (disponible, ocupado, en mantenimiento) basado en su capacidad y fecha de salida.
SELECT a.descripcion, a.capacidad, va.fecha_salida,
    CASE
        WHEN va.fecha_salida IS NULL THEN 'Ocupado'
        ELSE 'Disponible'
    END AS estado
FROM alojamiento a
LEFT JOIN visitante_alojamiento va ON a.id_alojamiento = va.id_alojamiento;

-- 58. Clasificar los parques según su extensión total de áreas (grande, mediano, pequeño).

SELECT p.nombre, SUM(a.extension) AS extension_total,
    CASE
        WHEN SUM(a.extension) > 1000 THEN 'Grande'
        WHEN SUM(a.extension) BETWEEN 500 AND 1000 THEN 'Mediano'
        ELSE 'Pequeño'
    END AS clasificacion
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
GROUP BY p.nombre;


-- 59. Clasificar los proyectos de investigación según su presupuesto (bajo, medio, alto).
SELECT id_proyecto_investigacion, presupuesto,
    CASE
        WHEN presupuesto < 5000000 THEN 'Bajo'
        WHEN presupuesto BETWEEN 5000000 AND 10000000 THEN 'Medio'
        ELSE 'Alto'
    END AS clasificacion_presupuesto
FROM proyectos_investigacion;


-- 60. Mostrar el estado de los visitantes (activo, inactivo) basado en su última visita. *******************************************
SELECT CONCAT(v.nombre, ' ', v.apellido) AS visitante, MAX(r.fecha) AS ultima_visita,
    IF(MAX(r.fecha) >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR), 'Activo', 'Inactivo') AS estado
FROM visitantes v
JOIN registro_parques r ON v.cedula = r.id_visitante
GROUP BY v.cedula;


-- 61. Clasificar las áreas según su extensión (grande, mediana, pequeña).
SELECT nombre, extension,
    CASE
        WHEN extension > 500 THEN 'Grande'
        WHEN extension BETWEEN 200 AND 500 THEN 'Mediana'
        ELSE 'Pequeña'
    END AS clasificacion
FROM areas;


-- 62. Mostrar todos los visitantes
SELECT CONCAT(nombre, ' ', apellido) AS visitante
FROM visitantes;


-- 63. Mostrar los nombres de los visitantes y sus profesiones.
SELECT CONCAT(v.nombre, ' ', v.apellido) AS visitante, p.nombre AS profesion
FROM visitantes v
JOIN profesion p ON v.id_profesion = p.id_profesion;



-- 64. Mostrar los nombres de los departamentos y su entidad responsable.
SELECT d.nombre AS departamento, er.nombre AS entidad_responsable
FROM departamento d
JOIN entidad_responsable er ON d.id_departamento = er.id_departamento;

-- 65. Mostrar los nombres de los parques y su número de áreas.
SELECT p.nombre, COUNT(a.id_area) AS cantidad_areas
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
GROUP BY p.nombre;



-- 66. Mostrar los nombres de los visitantes y el último parque que visitaron ordenados por fecha de mayor a menor.
SELECT CONCAT(v.nombre, ' ', v.apellido) AS visitante, MAX(r.fecha) AS ultima_visita, p.nombre as "Parque"
FROM visitantes v
JOIN registro_parques r ON v.cedula = r.id_visitante join parques p ON p.id_parque = r.id_registro_parques 
GROUP BY v.cedula, p.id_parque 
order by r.fecha desc;


-- 67. Mostrar los nombres de los alojamientos, su categoría y capacidad. ********************* cambiar descripcion de los alojamientos *********************************
SELECT a.descripcion, c.nombre AS categoria, a.capacidad 
FROM alojamiento a
JOIN categoria c ON a.id_categoria = c.id_categoria;


-- 68. Mostrar los nombres de los departamentos y su número de parques.

SELECT d.nombre, COUNT(p.id_parque) AS cantidad_parques
FROM departamento d
JOIN parques_departamento pd ON d.id_departamento = pd.id_departamento
JOIN parques p ON pd.id_parque = p.id_parque
GROUP BY d.nombre;



-- 69. Mostrar los nombres de los tipos de personal y su número de empleados.

SELECT tp.nombre, COUNT(p.cedula) AS cantidad_empleados
FROM tipo_personal tp
JOIN personal p ON tp.id_tipo_personal = p.id_tipo_personal
GROUP BY tp.nombre;


-- 70. Mostrar los nombres de los alojamientos y su  número de ocupaciones.

SELECT a.descripcion, COUNT(va.id_visitante_alojamiento) AS ocupaciones
FROM alojamiento a
JOIN visitante_alojamiento va ON a.id_alojamiento = va.id_alojamiento
GROUP BY a.descripcion;

-- 71 Promedio de sueldo del personal por tipo de personal y departamento
SELECT tp.nombre AS Tipo_Personal, d.nombre AS Departamento, AVG(p.sueldo) AS Sueldo_Promedio
FROM personal p
JOIN tipo_personal tp ON p.id_tipo_personal = tp.id_tipo_personal
JOIN registro_parques rp ON p.cedula = rp.id_personal
JOIN parques pa ON rp.id_parque = pa.id_parque
JOIN parques_departamento pd ON pa.id_parque = pd.id_parque
JOIN departamento d ON pd.id_departamento = d.id_departamento
GROUP BY tp.nombre, d.nombre;


-- 72 Cantidad de especies por tipo en cada parque, ordenado por la cantidad de especies descendente
SELECT p.nombre AS Parque, e.tipo AS Tipo_Especie, COUNT(e.id_especie) AS Cantidad_Especies
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
GROUP BY p.nombre, e.tipo
ORDER BY Cantidad_Especies DESC;


-- 73  Parques con más de una entidad responsable y su presupuesto total de proyectos de investigación
SELECT p.nombre AS Parque, COUNT(er.id_entidad) AS Cantidad_Entidades, SUM(pi.presupuesto) AS Presupuesto_Total
FROM parques p
JOIN entidad_responsable er ON p.id_parque = er.id_parques
JOIN proyectos_investigacion pi ON p.id_parque = pi.id_proyecto_investigacion
GROUP BY p.nombre
HAVING COUNT(er.id_entidad) > 1;


-- 74. Visitantes que han visitado más de un parque y han estado en alojamientos de categoría "Ecológico"
SELECT CONCAT(v.nombre, ' ', v.apellido) AS Visitante, COUNT(DISTINCT rp.id_parque) AS Cantidad_Parques
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
JOIN visitante_alojamiento va ON rp.id_registro_parques = va.id_registro_parques
JOIN alojamiento a ON va.id_alojamiento = a.id_alojamiento
JOIN categoria c ON a.id_categoria = c.id_categoria
WHERE c.nombre = 'Ecológico'
GROUP BY v.cedula
HAVING COUNT(DISTINCT rp.id_parque) > 1;


-- 75 Proyectos de investigación que involucran más de una especie y tienen un presupuesto superior a 10,000,000 *******************************

SELECT pi.id_proyecto_investigacion AS Proyecto, COUNT(ei.id_especie) AS Cantidad_Especies, pi.presupuesto
FROM proyectos_investigacion pi
JOIN especies_investigacion ei ON pi.id_proyecto_investigacion = ei.id_proyecto_investigacion
GROUP BY pi.id_proyecto_investigacion
HAVING COUNT(ei.id_especie) > 1 AND pi.presupuesto > 1000;


-- 76 Áreas con más de una especie registrada y que tienen una extensión mayor a 500 km² ************************** 
SELECT a.nombre AS Area, COUNT(ae.id_especies) AS Cantidad_Especies, a.extension
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
GROUP BY a.nombre, a.extension
HAVING COUNT(ae.id_especies) > 1 AND a.extension > 500;


-- 77 Visitantes que han estado en más de un alojamiento y han visitado más de un parque
SELECT CONCAT(v.nombre, ' ', v.apellido) AS Visitante, COUNT(DISTINCT va.id_alojamiento) AS Cantidad_Alojamientos, COUNT(DISTINCT rp.id_parque) AS Cantidad_Parques
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
JOIN visitante_alojamiento va ON rp.id_registro_parques = va.id_registro_parques
GROUP BY v.cedula
HAVING COUNT(DISTINCT va.id_alojamiento) > 1 AND COUNT(DISTINCT rp.id_parque) > 1;


-- 78. Parques con más de una entidad responsable y que tienen alojamientos de categoría "Turístico"
SELECT p.nombre AS Parque, COUNT(er.id_entidad) AS Cantidad_Entidades
FROM parques p
JOIN entidad_responsable er ON p.id_parque = er.id_parques
JOIN alojamiento a ON p.id_parque = a.id_parque
JOIN categoria c ON a.id_categoria = c.id_categoria
WHERE c.nombre = 'Turístico'
GROUP BY p.nombre
HAVING COUNT(er.id_entidad) > 1;


-- 79. Visitantes que han visitado parques en más de un departamento
SELECT CONCAT(v.nombre, ' ', v.apellido) AS Visitante, COUNT(DISTINCT d.id_departamento) AS Cantidad_Departamentos
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
JOIN parques p ON rp.id_parque = p.id_parque
JOIN parques_departamento pd ON p.id_parque = pd.id_parque
JOIN departamento d ON pd.id_departamento = d.id_departamento
GROUP BY v.cedula
HAVING COUNT(DISTINCT d.id_departamento) > 1;


-- 80. Áreas que tienen especies de más de un tipo (animales, vegetales, minerales)
SELECT a.nombre AS Area, COUNT(DISTINCT e.tipo) AS Cantidad_Tipos_Especies
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
GROUP BY a.nombre
HAVING COUNT(DISTINCT e.tipo) > 1;

--  81 Visitantes que han estado en alojamientos de más de una categoría
SELECT CONCAT(v.nombre, ' ', v.apellido) AS Visitante, COUNT(DISTINCT c.nombre) AS Cantidad_Categorias
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
JOIN visitante_alojamiento va ON rp.id_registro_parques = va.id_registro_parques
JOIN alojamiento a ON va.id_alojamiento = a.id_alojamiento
JOIN categoria c ON a.id_categoria = c.id_categoria
GROUP BY v.cedula
HAVING COUNT(DISTINCT c.nombre) > 1;


-- 82 Especies que están en más de un proyecto de investigación y que habitan en más de un área ***************************
SELECT e.denominacion_vulgar AS Especie, COUNT(DISTINCT ei.id_proyecto_investigacion) AS Cantidad_Proyectos, COUNT(DISTINCT ae.id_areas) AS Cantidad_Areas
FROM especies e
JOIN especies_investigacion ei ON e.id_especie = ei.id_especie
JOIN areas_especies ae ON e.id_especie = ae.id_especies
GROUP BY e.denominacion_vulgar
HAVING COUNT(DISTINCT ei.id_proyecto_investigacion) > 1 AND COUNT(DISTINCT ae.id_areas) > 1;

-- 83  Promedio de presupuesto de proyectos de investigación por tipo de especie
SELECT e.tipo AS Tipo_Especie, AVG(pi.presupuesto) AS Presupuesto_Promedio
FROM especies e
JOIN especies_investigacion ei ON e.id_especie = ei.id_especie
JOIN proyectos_investigacion pi ON ei.id_proyecto_investigacion = pi.id_proyecto_investigacion
GROUP BY e.tipo;


-- 84 Cantidad de visitantes por profesión que han visitado más de un parque
SELECT pr.nombre AS Profesion, COUNT(DISTINCT v.cedula) AS Cantidad_Visitantes
FROM visitantes v
JOIN profesion pr ON v.id_profesion = pr.id_profesion
JOIN registro_parques rp ON v.cedula = rp.id_visitante
GROUP BY pr.nombre
HAVING COUNT(DISTINCT rp.id_parque) > 1;




