# Sistema de Gestión de Parques Naturales

## Descripción del Proyecto

El proyecto **"Sistema de Gestión de Parques Naturales"** tiene como objetivo diseñar y desarrollar una base de datos  para administrar  las operaciones relacionadas con los parques naturales bajo la supervisión del Ministerio del Medio Ambiente. Este sistema permite gestionar departamentos, parques, áreas, especies, personal, proyectos de investigación, visitantes y alojamientos, facilitando la toma de decisiones y la optimización de recursos.

### Propósito de la Base de Datos
La base de datos centraliza la información relacionada con los parques naturales, permitiendo:
- Registrar y gestionar parques, áreas y especies.
- Controlar el personal y sus asignaciones.
- Administrar proyectos de investigación y su financiamiento.
- Gestionar visitantes y alojamientos.
- Generar consultas para la toma de decisiones.

### Funcionalidades Implementadas
1. **Gestión de Parques y Áreas**: Registro y clasificación de parques según su extensión.
2. **Control de Especies**: Registro de especies y su distribución en áreas específicas.
3. **Gestión de Personal**: Asignación de personal a áreas y proyectos.
4. **Proyectos de Investigación**: Registro  de proyectos, incluyendo presupuestos y asignación de investigadores.
5. **Gestión de Visitantes**: Registro de visitantes, alojamientos y control de capacidad.
6. **Automatización**: Uso de triggers, procedimientos almacenados, funciones y eventos para garantizar la integridad de los datos y automatizar tareas repetitivas.

---

## Instalación y Configuración

### Paso 1: Configuración del Entorno
1. **Requisitos**:
   - MySQL Server instalado.
   - Acceso a una terminal o interfaz gráfica para ejecutar scripts SQL.

2. **Ejecución del Archivo DDL**:
   - El archivo `ddl.sql` contiene la estructura de la base de datos (tablas, relaciones, claves primarias y foráneas).

3. **Carga de Datos Iniciales**:
   - El archivo `dml.sql` contiene los datos iniciales para poblar las tablas.

4. **Ejecución de Consultas, Procedimientos y Triggers**:
   - Para ejecutar consultas, procedimientos almacenados, funciones, eventos y triggers, utiliza una interfaz gráfica como MySQL Workbench o ejecuta los scripts directamente en la terminal.

---

## Estructura de la Base de Datos

### Resumen de Tablas
1. **Parques**: Almacena información sobre los parques naturales.
2. **Áreas**: Registra las áreas dentro de los parques, con su extensión.
3. **Especies**: Contiene datos sobre las especies presentes en los parques.
4. **Personal**: Gestiona la información del personal, incluyendo su tipo y asignaciones.
5. **Proyectos de Investigación**: Registra los proyectos, su presupuesto y período de realización.
6. **Visitantes**: Almacena datos de los visitantes y su registro en los parques.
7. **Alojamientos**: Gestiona la capacidad y disponibilidad de alojamientos.

### Relaciones
- **Áreas-Especies**: Relación entre áreas y especies.
- **Personal-Áreas**: Asignación de personal a áreas.
- **Proyectos-Especies**: Asignación de especies a proyectos de investigación.
- **Visitantes-Alojamientos**: Registro de visitantes en alojamientos.

---

## Ejemplos de Consultas

### 1. Clasificación de Parques por Extensión
```sql
SELECT p.nombre, SUM(a.extension) AS extension_total,
    CASE
        WHEN SUM(a.extension) > 1000 THEN 'Grande'
        WHEN SUM(a.extension) BETWEEN 500 AND 1000 THEN 'Mediano'
        ELSE 'Pequeño'
    END AS clasificacion
FROM parques p
JOIN areas a ON p.id_parque = a.id_parques
GROUP BY p.nombre;
```

## Descripción
Clasifica los parques según su extensión total en grandes, medianos y pequeños.

## Número de Especies por Tipo en Cada Área

```sql
SELECT a.nombre AS area, te.nombre, COUNT(e.id_especie) AS total_especies
FROM areas a
JOIN areas_especies ae ON a.id_area = ae.id_areas
JOIN especies e ON ae.id_especies = e.id_especie
JOIN tipo_especie te ON te.id_tipo_especie = e.id_tipo_especie
GROUP BY a.nombre, te.nombre;
```

**Descripción:** Muestra el número de especies por tipo en cada área.

## Proyectos con Presupuesto Superior a 10 Millones

```sql
SELECT id_proyecto_investigacion AS "Proyecto", presupuesto
FROM proyectos_investigacion
WHERE presupuesto > 10000000
ORDER BY presupuesto DESC;
```

**Descripción:** Lista los proyectos con un presupuesto superior a 10 millones.

# Procedimientos, Funciones, Triggers y Eventos

## Funciones

### Costo Total de Proyectos
Calcula el costo total de todos los proyectos de investigación.

```sql
SELECT costo_total_proyectos();
```

### Visitantes por Parque en un Rango de Fechas
Devuelve el número de visitantes en un parque específico dentro de un rango de fechas.

```sql
SELECT visitantes_por_parque(1, '2023-01-01', '2023-12-31');
```

## Procedimientos Almacenados

### Asignar Personal a un Proyecto
Asigna un miembro del personal a un proyecto de investigación.

```sql
CALL asignar_personal_proyecto(123, 456);
```

### Registrar un Nuevo Parque
Registra un nuevo parque en la base de datos.

```sql
CALL registrar_parque('Parque Nacional XYZ', '2023-10-10');
```

## Eventos

### Eliminar Proyectos Finalizados Hace Más de 20 Años
Elimina automáticamente los proyectos finalizados hace más de 20 años.

```sql
CREATE EVENT eliminar_proyectos_viejos
ON SCHEDULE EVERY 6 MONTH
DO
DELETE FROM Proyectos_de_Investigación 
WHERE periodo_realizacion < NOW() - INTERVAL 20 YEAR;
-- 3 Aumenta en un 5% los sueldos de los empleados en la tabla personal.
CREATE EVENT actualizar_sueldos_personal
ON SCHEDULE EVERY 1 YEAR
DO
BEGIN
    UPDATE personal SET sueldo = sueldo * 1.05;
END $$
```

### Aumentar Sueldos en un 5%
Aumenta los sueldos del personal en un 5% anualmente.

```sql
CREATE EVENT actualizar_sueldos_personal
ON SCHEDULE EVERY 1 YEAR
DO
BEGIN
    UPDATE personal SET sueldo = sueldo * 1.05;
END $$
```

## Triggers

### Evitar Exceso de Capacidad en Alojamientos
Impide que un alojamiento exceda su capacidad máxima.

```sql
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
```

# Roles de Usuario y Permisos

## Roles Creados

- **Admin:** Acceso total a la base de datos.
- **Gestor de Parques:** Gestiona parques, áreas y especies.
- **Investigador:** Accede a datos de proyectos y especies.
- **Auditor:** Genera reportes financieros.
- **Encargado de Visitantes:** Gestiona visitantes y alojamientos.

## Asignación de Permisos

```sql
-- Admin
GRANT ALL PRIVILEGES ON parques_naturales.* TO 'admin'@'localhost';

-- Gestor de Parques
GRANT SELECT, INSERT, UPDATE, DELETE ON parques_naturales.parques TO 'gestor_parques'@'localhost';

-- Investigador
GRANT SELECT ON parques_naturales.proyectos_investigacion TO 'investigador'@'localhost';

-- Auditor
GRANT SELECT ON parques_naturales.proyectos_investigacion TO 'auditor'@'localhost';

-- Encargado de Visitantes
GRANT SELECT, INSERT, UPDATE, DELETE ON parques_naturales.visitantes TO 'encargado_visitantes'@'localhost';
```

## Creación de Usuarios y Asignación de Roles

```sql
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin_password_123';
CREATE USER 'gestor_parques'@'localhost' IDENTIFIED BY 'gestor_password_123';
-- Repite para otros usuarios...

