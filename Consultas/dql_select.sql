
use parques_naturales;

-- 1 Clasificar los parques según su extensión total de áreas (grande, mediano, pequeño).

SELECT p.nombre, SUM(a.extension) AS extension_total,
    CASE
        WHEN SUM(a.extension) > 1000 THEN 'Grande'
        WHEN SUM(a.extension) BETWEEN 500 AND 1000 THEN 'Mediano'
        ELSE 'Pequeño'
    END AS clasificacion
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
GROUP BY p.nombre;



-- 2. Clasificar los parques según su número de visitantes (popular, moderado, poco visitado). 
SELECT p.nombre, COUNT(r.id_visitante) AS visitantes,
    CASE
        WHEN COUNT(r.id_visitante) > 100 THEN 'Popular'
        WHEN COUNT(r.id_visitante) BETWEEN 20 AND 100 THEN 'Moderado'
        ELSE 'Poco Visitado'
    END AS clasificacion
FROM parques p
LEFT JOIN registro_parques r ON p.id_parque = r.id_parque
GROUP BY p.nombre;


-- 3 Calcular el número total de especies por tipo en cada parque
SELECT p.nombre AS parque, te.nombre AS tipo_especie, COUNT(e.id_especie) AS total_especies
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
JOIN tipo_especie te ON e.id_tipo_especie = te.id_tipo_especie
GROUP BY p.nombre, te.nombre;


-- 4  Obtener el nombre de los parques que tienen alojamientos con capacidad mayor a 15 personas

SELECT p.nombre
FROM parques p
WHERE p.id_parque IN (
    SELECT a.id_parque
    FROM alojamiento a
    WHERE a.capacidad > 15
);

-- 5 Listar los nombres de los visitantes y la cantidad de veces que han visitado parques.
SELECT CONCAT(v.nombre, ' ', v.apellido) AS visitante, COUNT(r.id_visitante) AS visitas
FROM visitantes v
LEFT JOIN registro_parques r ON v.cedula = r.id_visitante
GROUP BY v.cedula;


-- 6 Mostrar el nombre y sueldo promedio del personal por tipo de personal
SELECT tp.nombre, AVG(pe.sueldo) AS sueldo_promedio
FROM personal pe
JOIN tipo_personal tp ON pe.id_tipo_personal = tp.id_tipo_personal
GROUP BY tp.nombre;


-- 7 Visitantes que no se han alojado en ningún alojamiento

SELECT CONCAT(v.nombre, ' ', v.apellido) AS visitante
FROM visitantes v
WHERE v.cedula NOT IN (
    SELECT rp.id_visitante
    FROM registro_parques rp
    JOIN visitante_alojamiento va ON rp.id_registro_parques = va.id_registro_parques
);

-- 8 Mostrar el nombre de los visitantes que han visitado más de un parque.
SELECT CONCAT(v.nombre, ' ', v.apellido) AS "Visitante"
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
GROUP BY rp.id_visitante
HAVING COUNT(rp.id_parque) > 1;

-- 9 Obtener el nombre de los alojamientos que no han sido ocupados.
SELECT a.descripcion
FROM alojamiento a
WHERE a.id_alojamiento NOT IN (
    SELECT va.id_alojamiento
    FROM visitante_alojamiento va
);


-- 10 Calcular el número total de especies por tipo en cada área.
SELECT a.nombre AS area, te.nombre, COUNT(e.id_especie) AS total_especies
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
JOIN tipo_especie te on te.id_tipo_especie=e.id_tipo_especie
GROUP BY a.nombre, te.nombre;



-- 11 Obtener el nombre de los parques que tienen alojamientos con capacidad mayor a 10 personas.
SELECT p.nombre
FROM parques p
WHERE p.id_parque IN (
    SELECT a.id_parque
    FROM alojamiento a
    WHERE a.capacidad > 10
);


-- 12 Obtener el nombre de los vehículos utilizados por el personal de Vigilancia.
SELECT distinct v.tipo, v.marca
FROM vehiculo v
WHERE v.id_vehiculo IN (
    SELECT pv.id_vehiculo
    FROM personal_vehiculo pv
    JOIN personal pe ON pv.id_persona = pe.cedula
    JOIN tipo_personal tp ON pe.id_tipo_personal = tp.id_tipo_personal
    WHERE tp.nombre = 'Personal de Vigilancia'
);






-- 13 Calcular el número total de visitantes por profesión.
SELECT pr.nombre, COUNT(v.cedula) AS total_visitantes
FROM visitantes v
JOIN profesion pr ON v.id_profesion = pr.id_profesion
GROUP BY pr.nombre;

-- 14 Obtener el nombre del parque con la menor extensión total de áreas.
SELECT p.nombre, SUM(a.extension) AS extension_total
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
GROUP BY p.nombre
ORDER BY extension_total ASC
LIMIT 1;


-- 15 Mostrar el nombre y sueldo máximo por tipo de personal.
SELECT tp.nombre, MAX(pe.sueldo) AS sueldo_maximo
FROM personal pe
JOIN tipo_personal tp ON pe.id_tipo_personal = tp.id_tipo_personal
GROUP BY tp.nombre;



-- 16 Calcular el número total de visitantes por parque.
SELECT p.nombre, COUNT(r.id_visitante) AS total_visitantes
FROM parques p
LEFT JOIN registro_parques r ON p.id_parque = r.id_parque
GROUP BY p.nombre;


-- 17 Obtener el nombre del parque con la mayor extensión total de áreas.
SELECT p.nombre, a.extension 
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
GROUP BY p.nombre, a.extension 
ORDER BY SUM(a.extension) DESC
LIMIT 1;


-- 18 Número de áreas por tipo de especie en cada entidad responsable
SELECT er.nombre AS entidad_responsable, te.nombre AS tipo_especie, COUNT(DISTINCT a.id_area) AS cantidad_areas
FROM nombre_entidad_responsable er
JOIN responsabilidad r ON er.id_entidad_responsable = r.id_entidad_responsable
JOIN parques p ON r.id_parques = p.id_parque
JOIN areas a ON p.id_parque = a.id_parques
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
JOIN tipo_especie te ON e.id_tipo_especie = te.id_tipo_especie
GROUP BY er.nombre, te.nombre;



-- 19 cuantas especies hay en el area Zona de observación Utría
SELECT e.denominacion_vulgar AS "Especie", COUNT(ae.id_especies) AS cantidad
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
WHERE LOWER(a.nombre) = LOWER('Zona de observación Utría')
GROUP BY e.denominacion_vulgar;



-- 20 especies que habitan en dos areas
SELECT e.denominacion_vulgar AS "Especie", COUNT(ae.id_areas) AS "Cantidad_areas"
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
GROUP BY e.denominacion_vulgar
HAVING COUNT(ae.id_areas) = 2;


-- 21 cantidad de especies por tipo
SELECT te.nombre AS "Tipo", COUNT(e.id_especie) AS "Cantidad"
FROM especies e
JOIN tipo_especie te ON e.id_tipo_especie = te.id_tipo_especie
GROUP BY te.nombre;


-- 22 Visitantes que han visitado más de un parque
SELECT CONCAT(v.nombre, ' ', v.apellido) AS Visitante, COUNT(rp.id_parque) AS Cantidad_Parques
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
GROUP BY v.cedula
HAVING COUNT(rp.id_parque) > 1;

-- 23 Áreas con más de una especie registrada 
SELECT a.nombre AS Area, COUNT(ae.id_especies) AS Cantidad_Especies
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
GROUP BY a.nombre
HAVING COUNT(ae.id_especies) > 1;


-- 24 Personal que trabaja en más de un área
SELECT CONCAT(p.nombre, ' ', p.apellido) AS "Personal", COUNT(pa.id_area) AS "Cantidad_Areas"
FROM personal p
JOIN personal_areas pa ON p.cedula = pa.id_personal
GROUP BY p.cedula
HAVING COUNT(pa.id_area) > 1;



-- 25 Proyectos de investigación que involucran más de una especie *****
SELECT pi.nombre AS "Proyecto", COUNT(ei.id_especie) AS "Cantidad_Especies"
FROM proyectos_investigacion pi
JOIN especies_investigacion ei ON pi.id_proyecto_investigacion = ei.id_proyecto_investigacion
GROUP BY pi.id_proyecto_investigacion
HAVING COUNT(ei.id_especie) > 1;


-- 26 Áreas con la mayor extensión por parque
SELECT p.nombre AS "Parque", a.nombre AS "Area", MAX(a.extension) AS "Extension"
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
GROUP BY p.nombre, a.nombre
ORDER BY MAX(a.extension) DESC;


-- 27 Parques con más de una entidad responsable
SELECT p.nombre AS "Parque", COUNT(r.id_entidad_responsable) AS "Cantidad_Entidades"
FROM parques p
JOIN responsabilidad r ON p.id_parque = r.id_parques
join nombre_entidad_responsable ne on ne.id_entidad_responsable=r.id_entidad_responsable
GROUP BY ne.nombre
HAVING COUNT(r.id_entidad_responsable) > 1;



-- 28 Muestre el Personal de Gestión que mas registros de visitantes ha hecho.
SELECT CONCAT(p.nombre, ' ', p.apellido) AS "Personal", COUNT(rp.id_visitante) AS "Cantidad"
FROM personal p
JOIN registro_parques rp ON p.cedula = rp.id_personal
WHERE p.id_tipo_personal = (SELECT id_tipo_personal FROM tipo_personal WHERE nombre = 'Personal de Gestión')
GROUP BY p.cedula
ORDER BY COUNT(rp.id_visitante) DESC
LIMIT 1;





-- 29 Obtener el nombre de los parques que tienen alojamientos de categoría "Camping".

SELECT p.nombre
FROM parques p
WHERE p.id_parque IN (
    SELECT a.id_parque
    FROM alojamiento a
    JOIN categoria c ON a.id_categoria = c.id_categoria
    WHERE c.nombre = 'Camping'
);



-- 30 Listar los nombres de los visitantes que se alojaron en el parque "Parque Nacional Natural Tayrona".
SELECT CONCAT(v.nombre , " " ,v.apellido )  as visitantes
FROM visitantes v
WHERE v.cedula IN (
    SELECT r.id_visitante
    FROM registro_parques r
    JOIN parques p ON r.id_parque = p.id_parque
    WHERE p.nombre = 'Parque Nacional Natural Tayrona'
);





-- 31 Mostrar el nombre y sueldo del personal que trabaja en la Zona de investigación Sierra Nevada"
SELECT pe.nombre, pe.sueldo
FROM personal pe
WHERE pe.cedula IN (
    SELECT pa.id_personal
    FROM personal_areas pa
    JOIN areas a ON pa.id_area = a.id_area
    WHERE a.nombre = "Zona de investigación Sierra Nevada"
);


-- 32 Obtener el nombre de las especies que su periodo de investigacion es mayor al año 2000  con un presupuesto mayor a $70,000.
SELECT e.denominacion_vulgar
FROM especies e
WHERE e.id_especie IN (
    SELECT ei.id_especie
    FROM especies_investigacion ei
    JOIN proyectos_investigacion pi ON ei.id_proyecto_investigacion = pi.id_proyecto_investigacion
    WHERE pi.presupuesto > 70000 and YEAR(pi.periodo_realizacion) > 2000
);


-- 33 Listar los nombres de los parques que tienen áreas con una extensión mayor a 500 km²

SELECT p.nombre
FROM parques p
WHERE p.id_parque IN (
    SELECT a.id_parques
    FROM areas a
    WHERE a.extension > 500
);

-- 34 Obtener el nombre de los departamentos que tienen parques declarados antes del año 2000.
SELECT d.nombre
FROM departamento d
WHERE d.id_departamento IN (
    SELECT pd.id_departamento
    FROM parques_departamento pd
    JOIN parques p ON pd.id_parque = p.id_parque
    WHERE YEAR(p.fecha_declaracion) < 2000



-- 35 Visitantes que han estado en más de un alojamiento
SELECT CONCAT(v.nombre, ' ', v.apellido) AS "Visitante", COUNT(DISTINCT va.id_alojamiento) AS "Cantidad_Alojamientos"
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
JOIN visitante_alojamiento va ON rp.id_registro_parques = va.id_registro_parques
GROUP BY v.cedula
HAVING COUNT(DISTINCT va.id_alojamiento) > 1;



-- 36 Personal que ha utilizado más de un vehículo
SELECT CONCAT(p.nombre, ' ', p.apellido) AS "Personal", COUNT(pv.id_vehiculo) AS "Cantidad_Vehiculos"
FROM personal p
JOIN personal_vehiculo pv ON p.cedula = pv.id_persona
GROUP BY p.cedula
HAVING COUNT(pv.id_vehiculo) > 1;



-- 37 cantidad de parques por entidad responsable
SELECT er.nombre, COUNT(r.id_parques) AS "cantidad Parques"
FROM nombre_entidad_responsable er
JOIN responsabilidad r ON er.id_entidad_responsable = r.id_entidad_responsable
GROUP BY er.nombre;


-- 38 muestre las especies que habitan en el Zona de camping Amacayacu
SELECT e.denominacion_vulgar AS "Especie"
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
WHERE LOWER(a.nombre) = LOWER('Zona de camping Amacayacu');


-- 39 muestre las especies que habitan en Zona de descanso El Cocuy
SELECT e.denominacion_vulgar AS "Especie"
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
WHERE LOWER(a.nombre) = LOWER('Zona de descanso El Cocuy');


-- 40 Area con mayor extension 
SELECT nombre, extension
FROM areas
ORDER BY extension DESC
LIMIT 1;


-- 41 mostrar el visitante registrado recientemente
SELECT CONCAT(v.nombre, ' ', v.apellido) AS "Nombre", rp.fecha
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
ORDER BY rp.fecha DESC
LIMIT 1;



-- 42 Mostrar los visitantes que aun estan  alojados
SELECT CONCAT(v.nombre, ' ', v.apellido) AS "Visitante"
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
JOIN visitante_alojamiento va ON rp.id_registro_parques = va.id_registro_parques
WHERE va.fecha_salida IS NULL;


-- 43 Proyectos de investigación con un presupuesto superior a 10,000,000
SELECT id_proyecto_investigacion AS "Proyecto", presupuesto
FROM proyectos_investigacion
WHERE presupuesto > 10000000
ORDER BY presupuesto DESC;

-- 44  Especies que no están asociadas a ningún proyecto de investigación
SELECT e.denominacion_vulgar AS Especie
FROM especies e
LEFT JOIN especies_investigacion ei ON e.id_especie = ei.id_especie
WHERE ei.id_proyecto_investigacion IS NULL;

-- 45. Especies que no están registrados en ninguna área
SELECT e.denominacion_vulgar AS "Especie"
FROM especies e
LEFT JOIN areas_especies ae ON e.id_especie = ae.id_especies
WHERE ae.id_areas IS NULL;


-- 46 Personal que no está asignado a ningún proyecto de investigación
SELECT CONCAT(p.nombre, ' ', p.apellido) AS "Personal", p.cedula
FROM personal p
LEFT JOIN personal_investigacion pi ON p.cedula = pi.id_personal
	join tipo_personal t on t.id_tipo_personal=p.id_tipo_personal
WHERE pi.id_proyecto_investigacion IS NULL and lower(t.nombre) = lower("Personal de Investigación");



-- 47 Mostrar el nombre de los parques que tienen áreas con más de 100 individuos de especies "minerales".
SELECT p.nombre
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
JOIN tipo_especie te ON e.id_tipo_especie = te.id_tipo_especie
WHERE te.nombre = 'minerales' AND e.numero_individuos > 100;


-- 48 Listar los nombres de los visitantes que no se han alojado en ningún alojamiento.
SELECT CONCAT(v.nombre, ' ', v.apellido) AS "Visitante"
FROM visitantes v
LEFT JOIN registro_parques rp ON v.cedula = rp.id_visitante
LEFT JOIN visitante_alojamiento va ON rp.id_registro_parques = va.id_registro_parques
WHERE va.id_alojamiento IS NULL;



-- 49. Obtener el nombre de los alojamientos que aun estan ocupados.
SELECT a.descripcion
FROM alojamiento a
JOIN visitante_alojamiento va ON a.id_alojamiento = va.id_alojamiento
where va.fecha_salida is null;



-- 50 Mostrar el nombre del personal y el tipo de vehículo que utilizan.
SELECT CONCAT(pe.nombre," ",pe.apellido) as Nombre, v.tipo
FROM personal pe
JOIN personal_vehiculo pv ON pe.cedula = pv.id_persona
JOIN vehiculo v ON pv.id_vehiculo = v.id_vehiculo;


-- 51. Obtener el nombre de los alojamientos y la categoría a la que pertenecen.
SELECT DISTINCT c.nombre,  a.descripcion 
FROM alojamiento a
JOIN categoria c ON a.id_categoria = c.id_categoria;




-- 52 Clasificar los parques según su antigüedad (antes o después del año 2000).
SELECT nombre, fecha_declaracion,
    CASE
        WHEN YEAR(fecha_declaracion) < 2000 THEN 'Antiguo'
        ELSE 'Reciente'
    END AS clasificacion
FROM parques;

-- 53. Mostrar el estado de los alojamientos (disponible o no disponible) basado en su capacidad.

SELECT descripcion, capacidad,
    IF(capacidad > 0, 'Disponible', 'No Disponible') AS estado
FROM alojamiento;


-- 54. Clasificar las especies según su número de individuos (abundante, moderado, escaso).

SELECT denominacion_vulgar, numero_individuos,
    CASE
        WHEN numero_individuos > 100 THEN 'Abundante'
        WHEN numero_individuos BETWEEN 50 AND 100 THEN 'Moderado'
        ELSE 'Escaso'
    END AS clasificacion
FROM especies;

-- 55. Clasificar los proyectos de investigación según su presupuesto (bajo, medio, alto).
SELECT nombre, presupuesto,
    CASE
        WHEN presupuesto < 5000000 THEN 'Bajo'
        WHEN presupuesto BETWEEN 5000000 AND 10000000 THEN 'Medio'
        ELSE 'Alto'
    END AS clasificacion_presupuesto
FROM proyectos_investigacion;





-- 56. Clasificar las especies según su número de individuos (crítico, vulnerable, estable).
SELECT denominacion_vulgar, numero_individuos,
    CASE
        WHEN numero_individuos < 50 THEN 'Crítico'
        WHEN numero_individuos BETWEEN 50 AND 100 THEN 'Vulnerable'
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



-- 58. Clasificar los proyectos de investigación según su presupuesto (bajo, medio, alto).
SELECT nombre, presupuesto,
    CASE
        WHEN presupuesto < 5000000 THEN 'Bajo'
        WHEN presupuesto BETWEEN 5000000 AND 10000000 THEN 'Medio'
        ELSE 'Alto'
    END AS clasificacion_presupuesto
FROM proyectos_investigacion;














-- 59. Mostrar el estado de los visitantes (activo, inactivo) basado en su última visita. 
SELECT CONCAT(v.nombre, ' ', v.apellido) AS visitante, MAX(r.fecha) AS ultima_visita,
    IF(MAX(r.fecha) >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR), 'Activo', 'Inactivo') AS estado
FROM visitantes v
JOIN registro_parques r ON v.cedula = r.id_visitante
GROUP BY v.cedula;


-- 60. Clasificar las áreas según su extensión (grande, mediana, pequeña).
SELECT nombre, extension,
    CASE
        WHEN extension > 500 THEN 'Grande'
        WHEN extension BETWEEN 200 AND 500 THEN 'Mediana'
        ELSE 'Pequeña'
    END AS clasificacion
FROM areas;


-- 61. Mostrar todos los visitantes
SELECT CONCAT(nombre, ' ', apellido) AS visitante
FROM visitantes;


-- 62. Mostrar los nombres de los visitantes y sus profesiones.
SELECT CONCAT(v.nombre, ' ', v.apellido) AS visitante, p.nombre AS profesion
FROM visitantes v
JOIN profesion p ON v.id_profesion = p.id_profesion;



-- 63. Mostrar los nombres de los departamentos y su entidad responsable.
SELECT d.nombre AS departamento, er.nombre AS entidad_responsable
FROM departamento d
JOIN responsabilidad r ON d.id_departamento = r.id_departamento
JOIN nombre_entidad_responsable er ON r.id_entidad_responsable = er.id_entidad_responsable;

-- 64. Mostrar los nombres de los parques y su número de áreas.
SELECT p.nombre, COUNT(a.id_area) AS cantidad_areas
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
GROUP BY p.nombre;



-- 65. Mostrar los nombres de los visitantes y el último parque que visitaron ordenados por fecha de mayor a menor.
SELECT CONCAT(v.nombre, ' ', v.apellido) AS visitante, 
       MAX(r.fecha) AS ultima_visita, 
       p.nombre AS parque
FROM visitantes v
JOIN registro_parques r ON v.cedula = r.id_visitante 
JOIN parques p ON p.id_parque = r.id_parque 
GROUP BY v.cedula, p.nombre
ORDER BY ultima_visita DESC;

-- 66. Mostrar los nombres de los alojamientos, su categoría y capacidad
SELECT a.descripcion, c.nombre AS categoria, a.capacidad 
FROM alojamiento a
JOIN categoria c ON a.id_categoria = c.id_categoria;


-- 67. Mostrar los nombres de los departamentos y su número de parques.

SELECT d.nombre, COUNT(p.id_parque) AS cantidad_parques
FROM departamento d
JOIN parques_departamento pd ON d.id_departamento = pd.id_departamento
JOIN parques p ON pd.id_parque = p.id_parque
GROUP BY d.nombre;



-- 68. Mostrar los nombres de los tipos de personal y su número de empleados.

SELECT tp.nombre, COUNT(p.cedula) AS cantidad_empleados
FROM tipo_personal tp
JOIN personal p ON tp.id_tipo_personal = p.id_tipo_personal
GROUP BY tp.nombre;


-- 69. Mostrar los nombres de los alojamientos y su  número de ocupaciones.

SELECT a.descripcion, COUNT(va.id_visitante_alojamiento) AS ocupaciones
FROM alojamiento a
JOIN visitante_alojamiento va ON a.id_alojamiento = va.id_alojamiento
GROUP BY a.descripcion;

-- 70 Promedio de sueldo del personal por tipo de personal y departamento
SELECT tp.nombre AS Tipo_Personal, d.nombre AS Departamento, AVG(p.sueldo) AS Sueldo_Promedio
FROM personal p
JOIN tipo_personal tp ON p.id_tipo_personal = tp.id_tipo_personal
JOIN registro_parques rp ON p.cedula = rp.id_personal
JOIN parques pa ON rp.id_parque = pa.id_parque
JOIN parques_departamento pd ON pa.id_parque = pd.id_parque
JOIN departamento d ON pd.id_departamento = d.id_departamento
GROUP BY tp.nombre, d.nombre;


-- 71 Cantidad de especies por tipo en cada parque, ordenado por la cantidad de especies descendente
SELECT p.nombre AS parque, te.nombre AS tipo_especie, COUNT(e.id_especie) AS cantidad_especies
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
JOIN tipo_especie te ON e.id_tipo_especie = te.id_tipo_especie
GROUP BY p.nombre, te.nombre
ORDER BY cantidad_especies DESC;


-- 72  contar la cantidad de vehiculos de tipo "Automovil" asociado a un personal de Vigilancia;
select count(v.id_vehiculo)
from vehiculo v join personal_vehiculo pv on pv.id_vehiculo=v.id_vehiculo
join personal p on p.cedula = pv.id_persona
join tipo_personal tp on tp.id_tipo_personal = p.id_tipo_personal
where v.tipo = "Automovil" and tp.nombre = "Personal de Vigilancia";



-- 73. Número de proyectos de investigación por tipo de especie y categoría de alojamiento
SELECT c.nombre AS categoria, te.nombre AS tipo_especie, COUNT(pi.id_proyecto_investigacion) AS cantidad_proyectos
FROM categoria c
JOIN alojamiento a ON c.id_categoria = a.id_categoria
JOIN parques p ON a.id_parque = p.id_parque
JOIN proyectos_investigacion pi ON p.id_parque = pi.id_proyecto_investigacion
JOIN especies_investigacion ei ON pi.id_proyecto_investigacion = ei.id_proyecto_investigacion
JOIN especies e ON ei.id_especie = e.id_especie
JOIN tipo_especie te ON e.id_tipo_especie = te.id_tipo_especie
GROUP BY c.nombre, te.nombre;


-- 74 Proyectos de investigación que involucran más de una especie y tienen un presupuesto superior a 7500000

SELECT pi.nombre AS Proyecto, COUNT(ei.id_especie) AS Cantidad_Especies, pi.presupuesto
FROM proyectos_investigacion pi
JOIN especies_investigacion ei ON pi.id_proyecto_investigacion = ei.id_proyecto_investigacion
GROUP BY pi.id_proyecto_investigacion
HAVING COUNT(ei.id_especie) > 1 AND pi.presupuesto > 7500000;


-- 75 Áreas con más de una especie registrada y que tienen una extensión mayor a 500 km²
SELECT a.nombre AS area, COUNT(ae.id_especies) AS cantidad_especies, a.extension
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
GROUP BY a.nombre, a.extension
HAVING COUNT(ae.id_especies) > 1 AND a.extension > 500;



-- 76. Parques con más de una entidad responsable y que tienen alojamientos de categoría "Ecolodge"
SELECT p.nombre AS parque, COUNT(r.id_entidad_responsable) AS cantidad_entidades
FROM parques p
JOIN responsabilidad r ON p.id_parque = r.id_parques
JOIN alojamiento a ON p.id_parque = a.id_parque
JOIN categoria c ON a.id_categoria = c.id_categoria
WHERE c.nombre = 'Ecolodge'
GROUP BY p.nombre
HAVING COUNT(r.id_entidad_responsable) > 1;

-- 77. Visitantes que han visitado parques en más de un departamento
SELECT CONCAT(v.nombre, ' ', v.apellido) AS Visitante, COUNT(DISTINCT d.id_departamento) AS Cantidad_Departamentos
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
JOIN parques p ON rp.id_parque = p.id_parque
JOIN parques_departamento pd ON p.id_parque = pd.id_parque
JOIN departamento d ON pd.id_departamento = d.id_departamento
GROUP BY v.cedula
HAVING COUNT(DISTINCT d.id_departamento) > 1;


--  78 Visitantes que han estado en alojamientos de más de una categoría
SELECT CONCAT(v.nombre, ' ', v.apellido) AS Visitante, COUNT(DISTINCT c.nombre) AS Cantidad_Categorias
FROM visitantes v
JOIN registro_parques rp ON v.cedula = rp.id_visitante
JOIN visitante_alojamiento va ON rp.id_registro_parques = va.id_registro_parques
JOIN alojamiento a ON va.id_alojamiento = a.id_alojamiento
JOIN categoria c ON a.id_categoria = c.id_categoria
GROUP BY v.cedula
HAVING COUNT(DISTINCT c.nombre) > 1;


-- 79 Especies que están en más de un proyecto de investigación y que habitan en más de un área 
SELECT e.denominacion_vulgar AS Especie, COUNT(DISTINCT ei.id_proyecto_investigacion) AS Cantidad_Proyectos, COUNT(DISTINCT ae.id_areas) AS Cantidad_Areas
FROM especies e
JOIN especies_investigacion ei ON e.id_especie = ei.id_especie
JOIN areas_especies ae ON e.id_especie = ae.id_especies
GROUP BY e.denominacion_vulgar
HAVING COUNT(DISTINCT ei.id_proyecto_investigacion) > 1 AND COUNT(DISTINCT ae.id_areas) > 1;

-- 80  Promedio de presupuesto de proyectos de investigación por tipo de especie
SELECT te.nombre AS tipo_especie, AVG(pi.presupuesto) AS presupuesto_promedio
FROM especies e
JOIN tipo_especie te ON e.id_tipo_especie = te.id_tipo_especie
JOIN especies_investigacion ei ON e.id_especie = ei.id_especie
JOIN proyectos_investigacion pi ON ei.id_proyecto_investigacion = pi.id_proyecto_investigacion
GROUP BY te.nombre;

-- 81 Cantidad de visitantes por profesión que han visitado más de un parque
SELECT pr.nombre AS Profesion, COUNT( v.cedula) AS Cantidad_Visitantes
FROM visitantes v
JOIN profesion pr ON v.id_profesion = pr.id_profesion
JOIN registro_parques rp ON v.cedula = rp.id_visitante
GROUP BY pr.nombre
HAVING COUNT( rp.id_parque) > 1;

-- 82: Número de proyectos de investigación por tipo de especie
SELECT te.nombre AS tipo_especie, COUNT(pi.id_proyecto_investigacion) AS cantidad_proyectos
FROM especies e
JOIN tipo_especie te ON e.id_tipo_especie = te.id_tipo_especie
JOIN especies_investigacion ei ON e.id_especie = ei.id_especie
JOIN proyectos_investigacion pi ON ei.id_proyecto_investigacion = pi.id_proyecto_investigacion
GROUP BY te.nombre;

-- 83: Áreas con más de una especie y más de un proyecto de investigación
SELECT a.nombre AS area, COUNT(DISTINCT ae.id_especies) AS cantidad_especies, COUNT(DISTINCT pi.id_proyecto_investigacion) AS cantidad_proyectos
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
JOIN especies_investigacion ei ON e.id_especie = ei.id_especie
JOIN proyectos_investigacion pi ON ei.id_proyecto_investigacion = pi.id_proyecto_investigacion
GROUP BY a.nombre
HAVING COUNT(DISTINCT ae.id_especies) > 1 AND COUNT(DISTINCT pi.id_proyecto_investigacion) > 1;

-- 84 Personal que trabaja en más de un área y está asignado a más de un proyecto de investigación
SELECT CONCAT(p.nombre, ' ', p.apellido) AS personal, COUNT(DISTINCT pa.id_area) AS cantidad_areas, COUNT(DISTINCT pi.id_proyecto_investigacion) AS cantidad_proyectos
FROM personal p
JOIN personal_areas pa ON p.cedula = pa.id_personal
JOIN personal_investigacion pi ON p.cedula = pi.id_personal
JOIN tipo_personal tp on tp.id_tipo_personal=p.id_tipo_personal
where tp.nombre = "Personal de Investigación"
GROUP BY p.cedula
HAVING COUNT(DISTINCT pa.id_area) > 1 AND COUNT(DISTINCT pi.id_proyecto_investigacion) > 1;


-- 85  Especies que están en más de un proyecto de investigación y tienen más de 100 individuos
SELECT e.denominacion_vulgar AS especie, COUNT(DISTINCT ei.id_proyecto_investigacion) AS cantidad_proyectos, e.numero_individuos
FROM especies e
JOIN especies_investigacion ei ON e.id_especie = ei.id_especie
GROUP BY e.denominacion_vulgar, e.numero_individuos
HAVING COUNT(DISTINCT ei.id_proyecto_investigacion) > 1 AND e.numero_individuos > 100;

-- 86 Especies que están en más de un área y tienen más de un proyecto de investigación
SELECT e.denominacion_vulgar AS especie, COUNT(DISTINCT ae.id_areas) AS cantidad_areas, COUNT(DISTINCT ei.id_proyecto_investigacion) AS cantidad_proyectos
FROM especies e
JOIN areas_especies ae ON e.id_especie = ae.id_especies
JOIN especies_investigacion ei ON e.id_especie = ei.id_especie
GROUP BY e.denominacion_vulgar
HAVING COUNT(DISTINCT ae.id_areas) > 1 AND COUNT(DISTINCT ei.id_proyecto_investigacion) > 1;

-- 87 Personal que ha utilizado más de un vehículo y trabaja en más de un área
SELECT CONCAT(p.nombre, ' ', p.apellido) AS personal, COUNT(DISTINCT pv.id_vehiculo) AS cantidad_vehiculos, COUNT(DISTINCT pa.id_area) AS cantidad_areas
FROM personal p
JOIN personal_vehiculo pv ON p.cedula = pv.id_persona
JOIN personal_areas pa ON p.cedula = pa.id_personal
GROUP BY p.cedula
HAVING COUNT(DISTINCT pv.id_vehiculo) > 1 AND COUNT(DISTINCT pa.id_area) > 1;


-- 88 Número de especies por tipo de especie en cada departamento
SELECT d.nombre AS departamento, te.nombre AS tipo_especie, COUNT(e.id_especie) AS cantidad_especies
FROM departamento d
JOIN parques_departamento pd ON d.id_departamento = pd.id_departamento
JOIN parques p ON pd.id_parque = p.id_parque
JOIN areas a ON p.id_parque = a.id_parques
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
JOIN tipo_especie te ON e.id_tipo_especie = te.id_tipo_especie
GROUP BY d.nombre, te.nombre;

-- 89 Número de proyectos de investigación por entidad responsable

SELECT ner.nombre AS entidad_responsable, 
       COUNT(DISTINCT pi.id_proyecto_investigacion) AS total_proyectos
FROM responsabilidad r
JOIN nombre_entidad_responsable ner ON r.id_entidad_responsable = ner.id_entidad_responsable
JOIN parques p ON r.id_parques = p.id_parque
JOIN areas a ON a.id_parques = p.id_parque
JOIN personal_areas pa ON pa.id_area = a.id_area
JOIN personal_investigacion pi_inv ON pa.id_personal = pi_inv.id_personal
JOIN Proyectos_de_Investigación pi ON pi_inv.id_proyecto_investigacion = pi.id_proyecto_investigacion
GROUP BY ner.nombre;






-- 90 Número de alojamientos por categoría en cada parque
SELECT p.nombre AS parque, c.nombre AS categoria, COUNT(a.id_alojamiento) AS cantidad_alojamientos
FROM parques p
JOIN alojamiento a ON p.id_parque = a.id_parque
JOIN categoria c ON a.id_categoria = c.id_categoria
GROUP BY p.nombre, c.nombre;


-- 91 Número de visitantes por profesión en cada parque
SELECT p.nombre AS parque, pr.nombre AS profesion, COUNT(v.cedula) AS cantidad_visitantes
FROM parques p
JOIN registro_parques rp ON p.id_parque = rp.id_parque
JOIN visitantes v ON rp.id_visitante = v.cedula
JOIN profesion pr ON v.id_profesion = pr.id_profesion
GROUP BY p.nombre, pr.nombre;

-- 92 Número de vehículos por tipo de personal
SELECT tp.nombre AS tipo_personal, COUNT(DISTINCT v.id_vehiculo) AS cantidad_vehiculos
FROM tipo_personal tp
JOIN personal p ON tp.id_tipo_personal = p.id_tipo_personal
JOIN personal_vehiculo pv ON p.cedula = pv.id_persona
JOIN vehiculo v ON pv.id_vehiculo = v.id_vehiculo
GROUP BY tp.nombre;

-- 93  Número de especies por tipo en cada área

SELECT a.nombre AS area, te.nombre AS tipo_especie, COUNT(e.id_especie) AS cantidad_especies
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
JOIN tipo_especie te ON e.id_tipo_especie = te.id_tipo_especie
GROUP BY a.nombre, te.nombre;


--  94 Número de proyectos de investigación por tipo de especie
SELECT te.nombre AS tipo_especie, COUNT(pi.id_proyecto_investigacion) AS cantidad_proyectos
FROM tipo_especie te
JOIN especies e ON te.id_tipo_especie = e.id_tipo_especie
JOIN especies_investigacion ei ON e.id_especie = ei.id_especie
JOIN proyectos_investigacion pi ON ei.id_proyecto_investigacion = pi.id_proyecto_investigacion
GROUP BY te.nombre;

-- 95 Número de visitantes por tipo de personal que los registró
SELECT tp.nombre AS tipo_personal, COUNT(DISTINCT v.cedula) AS cantidad_visitantes
FROM tipo_personal tp
JOIN personal p ON tp.id_tipo_personal = p.id_tipo_personal
JOIN registro_parques rp ON p.cedula = rp.id_personal
JOIN visitantes v ON rp.id_visitante = v.cedula
GROUP BY tp.nombre;

-- 96 Número de especies por tipo en cada departamento
SELECT d.nombre AS departamento, te.nombre AS tipo_especie, COUNT(e.id_especie) AS cantidad_especies
FROM departamento d
JOIN parques_departamento pd ON d.id_departamento = pd.id_departamento
JOIN parques p ON pd.id_parque = p.id_parque
JOIN areas a ON p.id_parque = a.id_parques
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
JOIN tipo_especie te ON e.id_tipo_especie = te.id_tipo_especie
GROUP BY d.nombre, te.nombre;

-- 97  Número de proyectos de investigación por entidad responsable y departamento
SELECT er.nombre AS entidad_responsable, d.nombre AS departamento, COUNT(pi.id_proyecto_investigacion) AS cantidad_proyectos
FROM nombre_entidad_responsable er
JOIN responsabilidad r ON er.id_entidad_responsable = r.id_entidad_responsable
JOIN departamento d ON r.id_departamento = d.id_departamento
JOIN proyectos_investigacion pi ON r.id_parques = pi.id_proyecto_investigacion
GROUP BY er.nombre, d.nombre;


-- 98 Número de visitantes por tipo de alojamiento en cada parque
SELECT p.nombre AS parque, a.nombre AS area, te.nombre AS tipo_especie, COUNT(e.id_especie) AS cantidad_especies
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
JOIN tipo_especie te ON e.id_tipo_especie = te.id_tipo_especie
GROUP BY p.nombre, a.nombre, te.nombre;


-- 99 Número de proyectos de investigación por tipo de especie y entidad responsable 
SELECT er.nombre AS entidad_responsable, te.nombre AS tipo_especie, COUNT(pi.id_proyecto_investigacion) AS cantidad_proyectos
FROM nombre_entidad_responsable er
JOIN responsabilidad r ON er.id_entidad_responsable = r.id_entidad_responsable
JOIN proyectos_investigacion pi ON r.id_parques = pi.id_proyecto_investigacion
JOIN especies_investigacion ei ON pi.id_proyecto_investigacion = ei.id_proyecto_investigacion
JOIN especies e ON ei.id_especie = e.id_especie
JOIN tipo_especie te ON e.id_tipo_especie = te.id_tipo_especie
GROUP BY er.nombre, te.nombre;

-- 100 Mostrar la profesion que tiene el visitante con cedula 10234567

select p.nombre as "Profesion"
from profesion p join visitantes v on p.id_profesion = v.id_profesion
where v.cedula = 10234567;

