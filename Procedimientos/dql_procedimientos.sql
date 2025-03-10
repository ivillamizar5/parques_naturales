
-- 1 Actualizar información de una especie
DELIMITER //
CREATE PROCEDURE actualizar_especie (
    IN p_id_especie INT,
    IN p_id_tipo_especie INT,
    IN p_denominacion_cientifica VARCHAR(50),
    IN p_denominacion_vulgar VARCHAR(50),
    IN p_numero_individuos INT
)
BEGIN
    UPDATE especies
    SET id_tipo_especie = p_id_tipo_especie, 
        denominacion_cientifica = p_denominacion_cientifica, 
        denominacion_vulgar = p_denominacion_vulgar, 
        numero_individuos = p_numero_individuos
    WHERE id_especie = p_id_especie;
END //
DELIMITER ;

-- 2 Registrar un visitante
DELIMITER //
CREATE PROCEDURE registrar_visitante (
    IN p_cedula INT,
    IN p_nombre VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_direccion VARCHAR(50),
    IN p_id_profesion INT
)
BEGIN
    INSERT INTO visitantes (cedula, nombre, apellido, direccion, id_profesion)
    VALUES (p_cedula, p_nombre, p_apellido, p_direccion, p_id_profesion);
END //
DELIMITER ;

-- 3 Registrar una nueva especie
DELIMITER //
CREATE PROCEDURE registrar_especie (
    IN p_id_tipo_especie INT,
    IN p_denominacion_cientifica VARCHAR(50),
    IN p_denominacion_vulgar VARCHAR(50),
    IN p_numero_individuos INT
)
BEGIN
    INSERT INTO especies (id_tipo_especie, denominacion_cientifica, denominacion_vulgar, numero_individuos)
    VALUES (p_id_tipo_especie, p_denominacion_cientifica, p_denominacion_vulgar, p_numero_individuos);
END //
DELIMITER ;


-- 4 Asignar un alojamiento a un visitante
DELIMITER //
CREATE PROCEDURE asignar_alojamiento (
    IN p_id_alojamiento INT,
    IN p_id_registro_parques INT,
    IN p_fecha_entrada DATETIME,
    IN p_fecha_salida DATETIME
)
BEGIN
    INSERT INTO visitante_alojamiento (id_alojamiento, id_registro_parques, fecha_entrada, fecha_salida)
    VALUES (p_id_alojamiento, p_id_registro_parques, p_fecha_entrada, p_fecha_salida);
END //
DELIMITER ;

-- 5 Registrar personal en una área específica
DELIMITER //
CREATE PROCEDURE registrar_personal_area (
    IN p_id_area INT,
    IN p_id_personal INT
)
BEGIN
    INSERT INTO personal_areas (id_area, id_personal)
    VALUES (p_id_area, p_id_personal);
END //
DELIMITER ;


-- 6 Asignar especie a un área
DELIMITER //
CREATE PROCEDURE asignar_especie_area (
    IN p_id_area INT,
    IN p_id_especies INT
)
BEGIN
    INSERT INTO areas_especies (id_areas, id_especies)
    VALUES (p_id_area, p_id_especies);
END //
DELIMITER ;


-- 7 Registrar un vehiculo para el personal
DELIMITER //
CREATE PROCEDURE registrar_vehiculo_personal (
    IN p_id_persona INT,
    IN p_id_vehiculo INT
)
BEGIN
    INSERT INTO personal_vehiculo (id_persona, id_vehiculo)
    VALUES (p_id_persona, p_id_vehiculo);
END //
DELIMITER ;

-- 8 Registrar un nuevo proyecto de investigación
DELIMITER //
CREATE PROCEDURE registrar_proyecto_investigacion (
    IN p_nombre VARCHAR(100),
    IN p_presupuesto FLOAT(10,2),
    IN p_periodo_realizacion DATETIME
)
BEGIN
    INSERT INTO proyectos_investigacion (nombre, presupuesto, periodo_realizacion)
    VALUES (p_nombre, p_presupuesto, p_periodo_realizacion);
END //
DELIMITER ;

-- 9 Actualizar presupuesto de un proyecto de investigación
DELIMITER //
CREATE PROCEDURE actualizar_presupuesto_proyecto (
    IN p_id_proyecto_investigacion INT,
    IN p_presupuesto FLOAT(10,2)
)
BEGIN
    UPDATE proyectos_investigacion
    SET presupuesto = p_presupuesto
    WHERE id_proyecto_investigacion = p_id_proyecto_investigacion;
END //
DELIMITER ;


-- 10 Registrar responsabilidad de una entidad
DELIMITER //
CREATE PROCEDURE registrar_responsabilidad (
    IN p_id_entidad_responsable INT,
    IN p_id_departamento INT,
    IN p_id_parques INT
)
BEGIN
    INSERT INTO responsabilidad (id_entidad_responsable, id_departamento, id_parques)
    VALUES (p_id_entidad_responsable, p_id_departamento, p_id_parques);
END //
DELIMITER ;


-- 11 Asignar un personal a un proyecto de investigación
DELIMITER //
CREATE PROCEDURE asignar_personal_proyecto (
    IN p_id_personal INT,
    IN p_id_proyecto_investigacion INT
)
BEGIN
    INSERT INTO personal_investigacion (id_personal, id_proyecto_investigacion)
    VALUES (p_id_personal, p_id_proyecto_investigacion);
END //
DELIMITER ;


-- 12 Relacionar un parque con un departamento
DELIMITER //
CREATE PROCEDURE asociar_parque_departamento (
    IN p_id_parque INT,
    IN p_id_departamento INT
)
BEGIN
    INSERT INTO parques_departamento (id_parque, id_departamento)
    VALUES (p_id_parque, p_id_departamento);
END //
DELIMITER ;

-- 13 Registrar una nueva categoría de alojamiento
DELIMITER //
CREATE PROCEDURE registrar_categoria (
    IN p_nombre VARCHAR(50)
)
BEGIN
    INSERT INTO categoria (nombre)
    VALUES (p_nombre);
END //
DELIMITER ;


-- 14 Actualizar información de un alojamiento
DELIMITER //
CREATE PROCEDURE actualizar_alojamiento (
    IN p_id_alojamiento INT,
    IN p_descripcion TEXT,
    IN p_capacidad INT,
    IN p_id_categoria INT,
    IN p_id_parque INT
)
BEGIN
    UPDATE alojamiento
    SET descripcion = p_descripcion, capacidad = p_capacidad, 
        id_categoria = p_id_categoria, id_parque = p_id_parque
    WHERE id_alojamiento = p_id_alojamiento;
END //
DELIMITER ;


-- 15 Asociar un proyecto de investigación a una especie
DELIMITER //
CREATE PROCEDURE asociar_proyecto_especie (
    IN p_id_especie INT,
    IN p_id_proyecto_investigacion INT
)
BEGIN
    INSERT INTO especies_investigacion (id_especie, id_proyecto_investigacion)
    VALUES (p_id_especie, p_id_proyecto_investigacion);
END //
DELIMITER ;


-- 16 Registrar un nuevo tipo de personal
DELIMITER //
CREATE PROCEDURE registrar_tipo_personal (
    IN p_nombre VARCHAR(50)
)
BEGIN
    INSERT INTO tipo_personal (nombre)
    VALUES (p_nombre);
END //
DELIMITER ;


-- 17 Registrar un nuevo parque
DELIMITER //
CREATE PROCEDURE registrar_parque (
    IN p_nombre VARCHAR(50), 
    IN p_fecha_declaracion DATETIME
)
BEGIN
    INSERT INTO parques (nombre, fecha_declaracion)
    VALUES (p_nombre, p_fecha_declaracion);
END //
DELIMITER ;


-- 18 Actualizar información de un parque
DELIMITER //
CREATE PROCEDURE actualizar_parque (
    IN p_id_parque INT,
    IN p_nombre VARCHAR(50),
    IN p_fecha_declaracion DATETIME
)
BEGIN
    UPDATE parques
    SET nombre = p_nombre, fecha_declaracion = p_fecha_declaracion
    WHERE id_parque = p_id_parque;
END //
DELIMITER ;


-- 19 Registrar una nueva área en un parque
DELIMITER //
CREATE PROCEDURE registrar_area (
    IN p_nombre VARCHAR(50),
    IN p_extension DECIMAL(10,2),
    IN p_id_parque INT
)
BEGIN
    INSERT INTO areas (nombre, extension, id_parques)
    VALUES (p_nombre, p_extension, p_id_parque);
END //
DELIMITER ;


-- 20 Actualizar información de un área
DELIMITER //
CREATE PROCEDURE actualizar_area (
    IN p_id_area INT,
    IN p_nombre VARCHAR(50),
    IN p_extension DECIMAL(10,2)
)
BEGIN
    UPDATE areas
    SET nombre = p_nombre, extension = p_extension
    WHERE id_area = p_id_area;
END //
DELIMITER ;
