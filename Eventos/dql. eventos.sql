


-- 1 Ajusta aleatoriamente el numero de individuos en la tabla especies, aumentando o disminuyendo hasta en 5 unidades.
DELIMITER $$

CREATE EVENT actualizar_inventario_especies
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    UPDATE especies
    SET numero_individuos = numero_individuos + FLOOR(RAND() * 10) - 5
    WHERE numero_individuos > 0;
END $$




-- 2 Inserta un registro en reportes_visitantes, con la cantidad de visitantes registrados en la última semana.

create table if not exists reportes_visitantes(
	id int auto_increment primary key,
	fecha_declaracion dateTime,
	total_visitantes int
);

CREATE EVENT generar_reporte_semanal_visitantes
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    INSERT INTO reportes_visitantes (fecha_generacion, total_visitantes)
    SELECT NOW(), COUNT(*) FROM registro_parques WHERE fecha >= NOW() - INTERVAL 1 WEEK;
END $$



-- 3 Aumenta en un 5% los sueldos de los empleados en la tabla personal.
CREATE EVENT actualizar_sueldos_personal
ON SCHEDULE EVERY 1 YEAR
DO
BEGIN
    UPDATE personal SET sueldo = sueldo * 1.05;
END $$


-- 4 Elimina registros de visitante_alojamiento cuando la fecha de salida ya pasó.
CREATE EVENT cerrar_alojamientos_vencidos
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    DELETE FROM visitante_alojamiento WHERE fecha_salida < NOW();
END $$


-- 5 Inserta en reportes_proyectos el total de proyectos de investigación registrados.



CREATE EVENT generar_reporte_proyectos
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    INSERT INTO reportes_proyectos (fecha_generacion, total_proyectos)
    SELECT NOW(), COUNT(*) FROM Proyectos_de_Investigacion;
END $$


-- 6 Si un número de teléfono tiene menos de 7 dígitos, lo borra de la base de datos.
CREATE EVENT revisar_telefonos_personal
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    UPDATE personal SET telefono = NULL WHERE LENGTH(telefono) < 7;
END $$

DELIMITER ;


-- 7 borre los números de celular (móvil) con menos de 10 dígitos:
DELIMITER $$

CREATE EVENT revisar_movil_personal
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    UPDATE personal 
    SET movil = NULL 
    WHERE LENGTH(movil) < 10;
END $$

DELIMITER ;


-- 8 actualizar numero_individuos en la tabla especies incrementándolo en 1 cada semana

DELIMITER $$

CREATE EVENT actualizar_numero_individuos
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
    UPDATE especies 
    SET numero_individuos = numero_individuos + 1;
END $$

DELIMITER ;


-- 9 Aumentar sueldo del Personal de Conservación en 4% cada seis meses
CREATE EVENT actualizar_sueldo_conservacion
ON SCHEDULE EVERY 6 MONTH
DO
UPDATE personal
SET sueldo = sueldo * 1.04
WHERE id_tipo_personal = (SELECT id_tipo_personal FROM tipo_personal WHERE nombre = 'Personal de Conservación');


-- 10 Eliminar vehículos sin uso en los últimos 2 años

CREATE EVENT eliminar_vehiculos_antiguos
ON SCHEDULE EVERY 6 MONTH
DO
DELETE FROM vehiculo 
WHERE id_vehiculo NOT IN (SELECT id_vehiculo FROM personal_vehiculo WHERE id_vehiculo IS NOT NULL);


-- 11 Ajustar presupuesto de proyectos de investigación anualmente

CREATE EVENT actualizar_presupuesto_proyectos
ON SCHEDULE EVERY 1 YEAR
DO
UPDATE proyectos_investigacion 
SET presupuesto = presupuesto * 1.10;


-- 12 Actualizar información de áreas según nuevas especies registradas

CREATE EVENT actualizar_areas_especies
ON SCHEDULE EVERY 1 MONTH
DO
UPDATE areas 
SET extension = extension + 0.5 
WHERE id_area IN (SELECT id_areas FROM areas_especies);



-- 13 Aumentar el presupuesto de investigación si hay más de 5 especies en estudio
CREATE EVENT aumentar_presupuesto_si_muchas_especies
ON SCHEDULE EVERY 6 MONTH
DO
UPDATE proyectos_investigacion 
SET presupuesto = presupuesto * 1.15 
WHERE id_proyecto_investigacion IN (SELECT id_proyecto_investigacion FROM especies_investigacion GROUP BY id_proyecto_investigacion HAVING COUNT(id_especie) > 5);




-- 14 Eliminar visitantes que no han ingresado en 3 años
CREATE EVENT eliminar_visitantes_antiguos
ON SCHEDULE EVERY 1 MONTH
DO
DELETE FROM visitantes 
WHERE cedula NOT IN (SELECT id_visitante FROM registro_parques WHERE fecha >= DATE_SUB(NOW(), INTERVAL 3 YEAR));



-- 15 Eliminar personal sin asignación a ninguna área
CREATE EVENT eliminar_personal_sin_area
ON SCHEDULE EVERY 6 MONTH
DO
DELETE FROM personal 
WHERE cédula NOT IN (SELECT id_personal FROM personal_areas);


-- 16 Eliminar responsabilidades si la entidad responsable ya no existe
CREATE EVENT limpiar_responsabilidades
ON SCHEDULE EVERY 1 MONTH
DO
DELETE FROM responsabilidad 
WHERE id_entidad_responsable NOT IN (SELECT id_entidad_responsable FROM nombre_entidad_responsable);


-- 17 Eliminar proyectos de investigación finalizados hace más de 20 años
CREATE EVENT eliminar_proyectos_viejos
ON SCHEDULE EVERY 6 MONTH
DO
DELETE FROM Proyectos_de_Investigación 
WHERE periodo_realizacion < NOW() - INTERVAL 20 YEAR;


-- 18 Eliminar alojamiento sin uso 4 años
CREATE EVENT eliminar_alojamientos_viejos
ON SCHEDULE EVERY 6 MONTH
DO
DELETE FROM alojamiento 
WHERE id_alojamiento NOT IN (SELECT id_alojamiento FROM visitante_alojamiento WHERE fecha_salida > NOW() - INTERVAL 4 YEAR);



-- 19 Actualizar denominaciones de especies en peligro
CREATE EVENT actualizar_denominacion_especies
ON SCHEDULE EVERY 1 month
DO
UPDATE especies 
SET denominacion_vulgar = CONCAT(denominacion_vulgar, ' (En peligro)') 
WHERE numero_individuos < 100;


-- 20 Eliminar personal sin asignaciones
CREATE EVENT eliminar_personal_sin_asignacion
ON SCHEDULE EVERY 1 YEAR
DO
DELETE FROM personal 
WHERE id_personal NOT IN (SELECT id_personal FROM personal_areas)
AND id_personal NOT IN (SELECT id_personal FROM personal_investigacion);

