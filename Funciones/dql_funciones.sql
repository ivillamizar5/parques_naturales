DELIMITER //
-- 1 Superficie total de parques por departamento id
CREATE FUNCTION superficie_total_por_departamento(id_dep INT) 
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(a.extension) INTO total
    FROM areas a
    JOIN parques_departamento pd ON a.id_parques = pd.id_parque
    WHERE pd.id_departamento =  id_dep;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

DELIMITER //
-- 2 Inventario de especies por área id y tipo id
CREATE FUNCTION inventario_especies_por_area(id_area INT, id_tipo INT) 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(e.id_especie) INTO total
    FROM especies e
    JOIN areas_especies ae ON e.id_especie = ae.id_especies
    WHERE ae.id_areas = id_area AND e.id_tipo_especie = id_tipo;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

DELIMITER //
-- 3 Calcular  costos  de proyectos
CREATE FUNCTION costo_total_proyectos() RETURNS 
DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(p.presupuesto)  INTO total 
    FROM proyectos_investigacion p;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

DELIMITER //
-- 4 numero de visitantes por parque en un rango de fechas
CREATE FUNCTION visitantes_por_parque(id_parque INT, fecha_inicio DATETIME, fecha_fin DATETIME) 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT id_visitante) INTO total
    FROM registro_parques
    WHERE id_parque = id_parque AND fecha BETWEEN fecha_inicio AND fecha_fin;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

DELIMITER //
-- 5 Capacidad total de alojamiento en un parque especifico id
CREATE FUNCTION capacidad_total_alojamiento(id_parque INT) 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(capacidad)  INTO total
    FROM alojamiento WHERE id_parque = id_parque;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

DELIMITER //
-- 6 calcular ala cantidad de empleados por parque id
CREATE FUNCTION empleados_por_parque(id_parque INT) 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT p.cedula)  INTO total
    FROM personal p
    JOIN personal_areas pa ON p.cedula = pa.id_personal
    JOIN areas a ON pa.id_area = a.id_area
    WHERE a.id_parques = id_parque;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

DELIMITER //
-- 7 calcular la cantidad de especies protegidas en un parque id
CREATE FUNCTION especies_en_parque(id_parque INT) 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT e.id_especie) INTO total
    FROM especies e
    JOIN areas_especies ae ON e.id_especie = ae.id_especies
    JOIN areas a ON ae.id_areas = a.id_area
    WHERE a.id_parques = id_parque;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

DELIMITER //
-- 8 Calcular el total de proyectos de investigación  en un periodo
CREATE FUNCTION proyectos_activos(fecha_inicio DATETIME, fecha_fin DATETIME) 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(id_proyecto_investigacion) INTO total
    FROM proyectos_investigacion
    WHERE periodo_realizacion BETWEEN fecha_inicio AND fecha_fin;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

DELIMITER //
-- 9 Calcular el promedio de sueldo del personal por tipo de empleado id
CREATE FUNCTION promedio_sueldo_por_tipo(id_tipo INT) 
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(sueldo) INTO promedio 
    FROM personal WHERE id_tipo_personal = id_tipo;
    RETURN COALESCE(promedio, 0);
END //
DELIMITER ;

DELIMITER //
-- 10 El numero total de vehiculos registrados para el personal
CREATE FUNCTION total_vehiculos_personal() 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT id_vehiculo) INTO total 
    FROM personal_vehiculo;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

DELIMITER //
-- 11 Cantidad total de especies en un parque específico
CREATE FUNCTION cantidad_especies_por_parque(id_parque_param INT) 
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE total_especies INT;
    SELECT COUNT(DISTINCT e.id_especie) INTO total_especies
    FROM especies e
    JOIN areas_especies ae ON e.id_especie = ae.id_especies
    JOIN areas a ON ae.id_areas = a.id_area
    WHERE a.id_parques = id_parque_param;
    RETURN total_especies;
END //
DELIMITER ;

DELIMITER //
-- 12 calcular el numero total de proyectos de investigación en un parque específico id
CREATE FUNCTION total_proyectos_en_parque(id_parque_param INT) 
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE total_proyectos INT;
    SELECT COUNT(DISTINCT pi.id_proyecto_investigacion)  INTO total_proyectos
    FROM proyectos_investigacion pi
    JOIN especies_investigacion ei ON pi.id_proyecto_investigacion = ei.id_proyecto_investigacion
    JOIN especies e ON ei.id_especie = e.id_especie
    JOIN areas_especies ae ON e.id_especie = ae.id_especies
    JOIN areas a ON ae.id_areas = a.id_area
    WHERE a.id_parques = 1;
    RETURN total_proyectos;
END //
DELIMITER ;

DELIMITER //
-- 13 calcular cantidad de areas por parque id  y su extensión total
CREATE FUNCTION extension_total_areas(id_parque_param INT) 
RETURNS DECIMAL(10,2) 
DETERMINISTIC
BEGIN
    DECLARE total_extension DECIMAL(10,2);
    SELECT SUM(a.extension)  INTO total_extension
    FROM areas a
    WHERE a.id_parques = id_parque_param;
    RETURN total_extension;
END //
DELIMITER ;

DELIMITER //
-- 14. Número total de proyectos de investigación en un departamento específico
CREATE FUNCTION total_proyectos_en_departamento(id_departamento_param INT) 
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE total_proyectos INT;
    SELECT COUNT(DISTINCT pi.id_proyecto_investigacion)  INTO total_proyectos
    FROM proyectos_investigacion pi
    JOIN especies_investigacion ei ON pi.id_proyecto_investigacion = ei.id_proyecto_investigacion
    JOIN especies e ON ei.id_especie = e.id_especie
    JOIN areas_especies ae ON e.id_especie = ae.id_especies
    JOIN areas a ON ae.id_areas = a.id_area
    JOIN parques p ON a.id_parques = p.id_parque
    JOIN parques_departamento pd ON p.id_parque = pd.id_parque
    WHERE pd.id_departamento = id_departamento_param;
    RETURN total_proyectos;
END //

DELIMITER ;



DELIMITER //
-- 15. Presupuesto total de proyectos de investigación en un parque específico id
CREATE FUNCTION presupuesto_total_proyectos(id_parque_param INT) 
RETURNS DECIMAL(10,2) 
DETERMINISTIC
BEGIN
    DECLARE total_presupuesto DECIMAL(10,2);
    SELECT SUM(pi.presupuesto)  INTO total_presupuesto
    FROM proyectos_investigacion pi
    JOIN especies_investigacion ei ON pi.id_proyecto_investigacion = ei.id_proyecto_investigacion
    JOIN especies e ON ei.id_especie = e.id_especie
    JOIN areas_especies ae ON e.id_especie = ae.id_especies
    JOIN areas a ON ae.id_areas = a.id_area
    WHERE a.id_parques = id_parque_param;
    RETURN IFNULL(total_presupuesto, 0);
END //
DELIMITER ;

DELIMITER //
-- 16. Cantidad de especies en peligro de extinción en un parque id (menos de 50 individuos)
CREATE FUNCTION especies_en_peligro(id_parque_param INT) 
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE total_peligro INT;
    SELECT COUNT(DISTINCT e.id_especie) -- INTO total_peligro
    FROM especies e
    JOIN areas_especies ae ON e.id_especie = ae.id_especies
    JOIN areas a ON ae.id_areas = a.id_area
    WHERE a.id_parques = id_parque_param
    AND e.numero_individuos < 50; 
    RETURN total_peligro;
END //
DELIMITER ;

DELIMITER //
-- 17 Calcular el total de personal asignado a proyectos de investigación
CREATE FUNCTION total_personal_proyectos() 
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE total_personal INT;
    SELECT COUNT(DISTINCT id_personal)  INTO total_personal
    FROM personal_investigacion;
    RETURN total_personal;
END //
DELIMITER ;

DELIMITER //
-- 18  Cantidad de parques que estan en un departamento id
CREATE FUNCTION parques_por_departamento(id_departamento_param INT) 
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE total_parques INT;
    SELECT COUNT(DISTINCT pd.id_parque)  INTO total_parques
    FROM parques_departamento pd
    WHERE pd.id_departamento = id_departamento_param;
    RETURN total_parques;
END //
DELIMITER ;


DELIMITER //
-- 19 Calcular el numero de visitantes que han utilizado alojamiento en un parque id
CREATE FUNCTION visitantes_con_alojamiento(id_parque_param INT) 
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE total_visitantes INT;
    SELECT COUNT(DISTINCT va.id_visitante_alojamiento) INTO total_visitantes
    FROM visitante_alojamiento va
    JOIN alojamiento a ON va.id_alojamiento = a.id_alojamiento
    WHERE a.id_parque = id_parque_param;
    RETURN total_visitantes;
END //
DELIMITER ;


DELIMITER //
-- 20 Calcular la cantidad de personal (según tipo_personal) id
CREATE FUNCTION personal_por_tipo(id_tipo_personal_param INT) 
RETURNS INT 
DETERMINISTIC
BEGIN
    DECLARE total_personal INT;
    SELECT COUNT(*)  INTO total_personal
    FROM personal
    WHERE id_tipo_personal = id_tipo_personal_param;
    RETURN total_personal;
END //
DELIMITER ;



