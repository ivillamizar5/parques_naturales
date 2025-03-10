-- 1 Trigger para evitar que al insertar el personal tenga un salario menor a 1 millón
DELIMITER //
CREATE TRIGGER before_insert_personal_salario
BEFORE INSERT ON personal
FOR EACH ROW
BEGIN
    IF NEW.sueldo < 1000000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El salario no puede ser menor a 1 millón.';
    END IF;
END //

DELIMITER ;


-- 2 Trigger para evitar que un personal de vigilancia tenga más de 2 vehículos
DELIMITER //

CREATE TRIGGER before_personal_vehiculo_insert
BEFORE INSERT ON personal_vehiculo
FOR EACH ROW
BEGIN
    DECLARE num_vehiculos INT;

    -- Contar cuántos vehículos tiene asignados el personal de vigilancia
    SELECT COUNT(*) INTO num_vehiculos
    FROM personal_vehiculo
    WHERE id_persona = NEW.id_persona;

    -- Verificar si el personal es de vigilancia 
    IF (SELECT id_tipo_personal FROM personal WHERE cedula = NEW.id_persona) = 2 AND num_vehiculos >= 2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El personal de vigilancia no puede tener más de 2 vehículos asignados.';
    END IF;
END //

DELIMITER ;



-- 3 Trigger para evitar proyectos de investigación al insertar  su presupuestos sea menor a 10 millones

DELIMITER //

-- Trigger para INSERT
CREATE TRIGGER before_insert_proyectos_investigacion_presupuesto
BEFORE INSERT ON proyectos_investigacion
FOR EACH ROW
BEGIN
    IF NEW.presupuesto < 10000000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El presupuesto del proyecto no puede ser menor a 10 millones.';
    END IF;
END //
DELIMITER ;



-- 4 evitar más de 5 entidades responsables en la tabla responsabilidad
DELIMITER //

CREATE TRIGGER before_responsabilidad_insert
BEFORE INSERT ON responsabilidad
FOR EACH ROW
BEGIN
    DECLARE num_entidades INT;

    -- Contar cuantas entidades responsables hay
    SELECT COUNT(*) INTO num_entidades
    FROM responsabilidad;

    -- Verificar si se supera el límite de 5 entidades
    IF num_entidades >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No puede haber más de 5 entidades responsables.';
    END IF;
END //

DELIMITER ;


-- 5 Trigger para evitar que un proyecto de investigación tenga más de 5 investigadores asignados
DELIMITER //

CREATE TRIGGER before_personal_investigacion_insert
BEFORE INSERT ON personal_investigacion
FOR EACH ROW
BEGIN
    DECLARE num_investigadores INT;

    -- Contar cuántos investigadores están asignados al proyecto
    SELECT COUNT(*) INTO num_investigadores
    FROM personal_investigacion
    WHERE id_proyecto_investigacion = NEW.id_proyecto_investigacion;

    -- Verificar si el proyecto ya tiene 5 investigadores asignados
    IF num_investigadores >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Un proyecto de investigación no puede tener más de 5 investigadores asignados.';
    END IF;
END //

DELIMITER ;


-- 6 Trigger para evitar que un área al ser insertada tenga una extensión menor a 1 km²

DELIMITER //

-- Trigger para INSERT
CREATE TRIGGER before_insert_areas_extension
BEFORE INSERT ON areas
FOR EACH ROW
BEGIN
    IF NEW.extension < 1.00 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La extensión de un área no puede ser menor a 1 km².';
    END IF;
END //
DELIMITER ;


-- 7 Trigger para evitar que un vehículo sea asignado a un personal que no sea de vigilancia


DELIMITER //

CREATE TRIGGER before_personal_vehiculo_insert
BEFORE INSERT ON personal_vehiculo
FOR EACH ROW
BEGIN
    DECLARE tipo_personal INT;

    -- Obtener el tipo de personal
    SELECT id_tipo_personal INTO tipo_personal
    FROM personal
    WHERE cedula = NEW.id_persona;

    -- Verificar si el personal no es de vigilancia
    IF tipo_personal != 2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo el personal de vigilancia puede tener vehículos asignados.';
    END IF;
END //

DELIMITER ;

-- 8 Triger insertar un registro en la tabla registro_parques

DELIMITER //

CREATE TRIGGER after_registro_parques_insert
AFTER INSERT ON registro_parques
FOR EACH ROW
BEGIN
    -- Registrar la acción de inserción
    INSERT INTO auditoria_registro_parques (id_registro_parques, accion, usuario, fecha)
    VALUES (NEW.id_registro_parques, 'INSERT', CURRENT_USER(), NOW());
END //

DELIMITER ;




-- 9 Trigger activará después de actualizar un registro en la tabla registro_parques


DELIMITER //

CREATE TRIGGER after_registro_parques_update
AFTER UPDATE ON registro_parques
FOR EACH ROW
BEGIN
    -- Registrar la acción de actualización
    INSERT INTO auditoria_registro_parques (id_registro_parques, accion, usuario, fecha)
    VALUES (NEW.id_registro_parques, 'UPDATE', CURRENT_USER(), NOW());
END //

DELIMITER ;


-- 10 Trigger se activará después de eliminar un registro en la tabla

DELIMITER //

CREATE TRIGGER after_registro_parques_delete
AFTER DELETE ON registro_parques
FOR EACH ROW
BEGIN
    -- Registrar la acción de eliminación
    INSERT INTO auditoria_registro_parques (id_registro_parques, accion, usuario, fecha)
    VALUES (OLD.id_registro_parques, 'DELETE', CURRENT_USER(), NOW());
END //

DELIMITER ;



-- 11 Trigger para evitar que un visitante se registre en un parque si ya está alojado en otro
DELIMITER //

CREATE TRIGGER before_registro_parques_insert
BEFORE INSERT ON registro_parques
FOR EACH ROW
BEGIN
    DECLARE alojamiento_activo INT;

    -- Verificar si el visitante tiene un alojamiento activo
    SELECT COUNT(*) INTO alojamiento_activo
    FROM visitante_alojamiento
    WHERE id_visitante = NEW.id_visitante
    AND fecha_salida IS NULL;

    -- Si el visitante está alojado, evitar el registro
    IF alojamiento_activo > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El visitante no puede registrarse en un parque si ya está alojado en otro.';
    END IF;
END //

DELIMITER ;


-- 12 Trigger para evitar que un proyecto de investigación tenga más de 10 especies asignadas

DELIMITER //

CREATE TRIGGER before_especies_investigacion_insert
BEFORE INSERT ON especies_investigacion
FOR EACH ROW
BEGIN
    DECLARE num_especies INT;
    
    SELECT COUNT(*) INTO num_especies -- Contar cuántas especies están asignadas al proyecto
    FROM especies_investigacion
    WHERE id_proyecto_investigacion = NEW.id_proyecto_investigacion;

   
    IF num_especies >= 10 THEN  -- Verificar si el proyecto ya tiene 10 especies asignadas
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Un proyecto de investigación no puede tener más de 10 especies asignadas.';
    END IF;
END //

DELIMITER ;



-- 13 Trigger para evitar que un alojamiento exceda su capacidad máxima
DELIMITER //

CREATE TRIGGER before_visitante_alojamiento_insert
BEFORE INSERT ON visitante_alojamiento
FOR EACH ROW
BEGIN
    DECLARE capacidad_maxima INT;
    DECLARE ocupacion_actual INT;

    -- Obtener la capacidad máxima del alojamiento
    SELECT capacidad INTO capacidad_maxima
    FROM alojamiento
    WHERE id_alojamiento = NEW.id_alojamiento;

    -- Contar cuántos visitantes están actualmente en el alojamiento
    SELECT COUNT(*) INTO ocupacion_actual
    FROM visitante_alojamiento
    WHERE id_alojamiento = NEW.id_alojamiento
    AND fecha_salida IS NULL; -- Solo contar visitantes activos

    -- Verificar si el alojamiento está lleno
    IF ocupacion_actual >= capacidad_maxima THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El alojamiento ha alcanzado su capacidad máxima.';
    END IF;
END //

DELIMITER ;



-- 14 Trigger para evitar al actualizar el personal tenga un salario menor a 1 millón
DELIMITER //
CREATE TRIGGER before_update_personal_salario
BEFORE UPDATE ON personal
FOR EACH ROW
BEGIN
    IF NEW.sueldo < 1000000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El salario no puede ser menor a 1 millón.';
    END IF;
END //
DELIMITER ;


DELIMITER //
--  15 Trigger para evitar proyectos de investigación al actualizar  su presupuestos sea menor a 10 millones
CREATE TRIGGER before_update_proyectos_investigacion_presupuesto
BEFORE UPDATE ON proyectos_investigacion
FOR EACH ROW
BEGIN
    IF NEW.presupuesto < 10000000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El presupuesto del proyecto no puede ser menor a 10 millones.';
    END IF;
END //
DELIMITER ;


-- 16 Trigger para evitar que un área al ser actualizada tenga una extensión menor a 1 km²
DELIMITER //
-- Trigger para UPDATE
CREATE TRIGGER before_update_areas_extension
BEFORE UPDATE ON areas
FOR EACH ROW
BEGIN
    IF NEW.extension < 1.00 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La extensión de un área no puede ser menor a 1 km².';
    END IF;
END //
DELIMITER ;


-- 17 Trigger para evitar que un visitante se registre dos veces en el mismo parque el mismo día
DELIMITER //
CREATE TRIGGER before_registro_parques_duplicate
BEFORE INSERT ON registro_parques
FOR EACH ROW
BEGIN
    DECLARE existe INT;

    -- Verificar si ya hay un registro para el mismo visitante y parque en la misma fecha
    SELECT COUNT(*) INTO existe
    FROM registro_parques
    WHERE id_visitante = NEW.id_visitante 
    AND id_parque = NEW.id_parque
    AND DATE(fecha_ingreso) = DATE(NEW.fecha_ingreso);

    -- Si ya existe un registro, impedir la inserción
    IF existe > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El visitante ya está registrado en este parque el mismo día.';
    END IF;
END //
DELIMITER ;

-- 18 Trigger para evitar la eliminación de especies en investigación
DELIMITER //

CREATE TRIGGER tr_evitar_eliminar_especie
BEFORE DELETE ON especies
FOR EACH ROW
BEGIN
    DECLARE especie_en_proyecto INT;

    -- Verificar si la especie está en algún proyecto
    SELECT COUNT(*) INTO especie_en_proyecto
    FROM especies_investigacion
    WHERE id_especie = OLD.id_especie;

    -- Si está en un proyecto, lanzar un error
    IF especie_en_proyecto > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar la especie porque está asociada a un proyecto de investigación.';
    END IF;
END //

DELIMITER ;


-- 19 Trigger para evitar la eliminación de parques con áreas asociadas
DELIMITER //

CREATE TRIGGER tr_evitar_eliminar_parque
BEFORE DELETE ON parques
FOR EACH ROW
BEGIN
    DECLARE areas_asociadas INT;

    -- Verificar si el parque tiene áreas asociadas
    SELECT COUNT(*) INTO areas_asociadas
    FROM areas
    WHERE id_parques = OLD.id_parque;

    -- Si tiene áreas asociadas, lanzar un error
    IF areas_asociadas > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el parque porque tiene áreas asociadas.';
    END IF;
END //

DELIMITER ;

-- 20 trigger evitará la eliminación de un departamento si hay parques asociados a él en la tabla parques_departamento

DELIMITER //

CREATE TRIGGER tr_evitar_eliminar_departamento
BEFORE DELETE ON departamento
FOR EACH ROW
BEGIN
    DECLARE parques_asociados INT;

    -- Verificar si el departamento tiene parques asociados
    SELECT COUNT(*) INTO parques_asociados
    FROM parques_departamento
    WHERE id_departamento = OLD.id_departamento;

    -- Si tiene parques asociados, lanzar un error
    IF parques_asociados > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el departamento porque tiene parques asociados.';
    END IF;
END //

DELIMITER ;
