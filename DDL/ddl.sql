CREATE DATABASE IF NOT EXISTS parques_naturales;
USE parques_naturales;

-- Tabla categoria
CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY auto_increment,
    nombre VARCHAR(50)
);

-- Tabla tipo_especie
CREATE TABLE tipo_especie (
    id_tipo_especie INT PRIMARY KEY auto_increment,
    nombre VARCHAR(50)
);

-- Tabla tipo_personal
CREATE TABLE tipo_personal (
    id_tipo_personal INT PRIMARY KEY auto_increment,
    nombre VARCHAR(50)
);

-- Tabla profesion
CREATE TABLE profesion (
    id_profesion INT PRIMARY KEY auto_increment,
    nombre VARCHAR(50)
);

-- Tabla vehiculo
CREATE TABLE vehiculo (
    id_vehiculo INT PRIMARY KEY auto_increment,
    tipo VARCHAR(50),
    marca VARCHAR(30)
);

-- Tabla departamento
CREATE TABLE departamento (
    id_departamento INT PRIMARY KEY auto_increment,
    nombre VARCHAR(50)
);

-- Tabla nombre_entidad_responsable
CREATE TABLE nombre_entidad_responsable (
    id_entidad_responsable INT PRIMARY KEY auto_increment,
    nombre VARCHAR(50)
);

-- Tabla parques
CREATE TABLE parques (
    id_parque INT PRIMARY KEY auto_increment,
    nombre VARCHAR(50),
    fecha_declaracion DATETIME
);

-- Tabla alojamiento
CREATE TABLE alojamiento (
    id_alojamiento INT PRIMARY KEY auto_increment,
    descripcion TEXT,
    capacidad INT,
    id_categoria INT,
    id_parque INT,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria) ON DELETE CASCADE,
    FOREIGN KEY (id_parque) REFERENCES parques(id_parque) ON DELETE CASCADE
);

-- Tabla especies
CREATE TABLE especies (
    id_especie INT PRIMARY KEY auto_increment,
    id_tipo_especie INT,
    denominacion_cientifica VARCHAR(50),
    denominacion_vulgar VARCHAR(50),
    numero_individuos INT,
    FOREIGN KEY (id_tipo_especie) REFERENCES tipo_especie(id_tipo_especie) ON DELETE CASCADE
);

-- Tabla visitantes
CREATE TABLE visitantes (
    cedula INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(50),
    id_profesion INT,
    FOREIGN KEY (id_profesion) REFERENCES profesion(id_profesion) ON DELETE CASCADE
);

-- Tabla personal
CREATE TABLE personal (
    cedula INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(50),
    telefono VARCHAR(11),
    movil VARCHAR(10),
    sueldo FLOAT(10,2),
    id_tipo_personal INT,
    FOREIGN KEY (id_tipo_personal) REFERENCES tipo_personal(id_tipo_personal) ON DELETE CASCADE
);

-- Tabla areas
CREATE TABLE areas (
    id_area INT PRIMARY KEY auto_increment,
    nombre VARCHAR(50),
    extension DECIMAL(10,2),
    id_parques INT,
    FOREIGN KEY (id_parques) REFERENCES parques(id_parque) ON DELETE CASCADE
);

-- Tabla proyectos_investigacion
CREATE TABLE proyectos_investigacion (
    id_proyecto_investigacion INT PRIMARY KEY auto_increment,
    presupuesto FLOAT(10,2),
    nombre VARCHAR(100),
    periodo_realizacion DATETIME
);

-- Tabla registro_parques
CREATE TABLE registro_parques (
    id_registro_parques INT PRIMARY KEY auto_increment,
    id_visitante INT,
    id_parque INT,
    id_personal INT,
    fecha DATETIME,
    FOREIGN KEY (id_visitante) REFERENCES visitantes(cedula) ON DELETE CASCADE,
    FOREIGN KEY (id_parque) REFERENCES parques(id_parque) ON DELETE CASCADE,
    FOREIGN KEY (id_personal) REFERENCES personal(cedula) ON DELETE CASCADE
);

-- Tabla visitante_alojamiento
CREATE TABLE visitante_alojamiento (
    id_visitante_alojamiento INT PRIMARY KEY auto_increment,
    fecha_entrada DATETIME,
    fecha_salida DATETIME,
    id_alojamiento INT,
    id_registro_parques INT,
    FOREIGN KEY (id_alojamiento) REFERENCES alojamiento(id_alojamiento) ON DELETE CASCADE,
    FOREIGN KEY (id_registro_parques) REFERENCES registro_parques(id_registro_parques) ON DELETE CASCADE
);

-- Tabla personal_areas
CREATE TABLE personal_areas (
    id_area INT,
    id_personal INT,
    PRIMARY KEY (id_area, id_personal),
    FOREIGN KEY (id_area) REFERENCES areas(id_area) ON DELETE CASCADE,
    FOREIGN KEY (id_personal) REFERENCES personal(cedula) ON DELETE CASCADE
);

-- Tabla areas_especies
CREATE TABLE areas_especies (
    id_areas INT,
    id_especies INT,
    PRIMARY KEY (id_areas, id_especies),
    FOREIGN KEY (id_areas) REFERENCES areas(id_area) ON DELETE CASCADE,
    FOREIGN KEY (id_especies) REFERENCES especies(id_especie) ON DELETE CASCADE
);

-- Tabla especies_investigacion
CREATE TABLE especies_investigacion (
    id_especie INT,
    id_proyecto_investigacion INT,
    PRIMARY KEY (id_especie, id_proyecto_investigacion),
    FOREIGN KEY (id_especie) REFERENCES especies(id_especie) ON DELETE CASCADE,
    FOREIGN KEY (id_proyecto_investigacion) REFERENCES proyectos_investigacion(id_proyecto_investigacion) ON DELETE CASCADE
);

-- Tabla personal_investigacion
CREATE TABLE personal_investigacion (
    id_personal INT,
    id_proyecto_investigacion INT,
    PRIMARY KEY (id_personal, id_proyecto_investigacion),
    FOREIGN KEY (id_personal) REFERENCES personal(cedula) ON DELETE CASCADE,
    FOREIGN KEY (id_proyecto_investigacion) REFERENCES proyectos_investigacion(id_proyecto_investigacion) ON DELETE CASCADE
);

-- Tabla personal_vehiculo
CREATE TABLE personal_vehiculo (
    id_persona INT,
    id_vehiculo INT,
    PRIMARY KEY (id_persona, id_vehiculo),
    FOREIGN KEY (id_persona) REFERENCES personal(cedula) ON DELETE CASCADE,
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo) ON DELETE CASCADE
);

-- Tabla responsabilidad
CREATE TABLE responsabilidad (
    id_entidad INT auto_increment,
    id_entidad_responsable INT,
    id_departamento INT,
    id_parques INT,
    PRIMARY KEY (id_entidad),
    FOREIGN KEY (id_entidad_responsable) REFERENCES nombre_entidad_responsable(id_entidad_responsable) ON DELETE CASCADE,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento) ON DELETE CASCADE,
    FOREIGN KEY (id_parques) REFERENCES parques(id_parque) ON DELETE CASCADE
);

-- Tabla parques_departamento
CREATE TABLE parques_departamento (
    id_parque INT,
    id_departamento INT,
    PRIMARY KEY (id_parque, id_departamento),
    FOREIGN KEY (id_parque) REFERENCES parques(id_parque) ON DELETE CASCADE,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento) ON DELETE CASCADE
);

-- Tabla auditoria_registro_parques
CREATE TABLE auditoria_registro_parques (
    id_auditoria INT PRIMARY KEY AUTO_INCREMENT, 
    id_registro_parques INT,                   
    accion ENUM('INSERT', 'UPDATE', 'DELETE'),  
    usuario VARCHAR(50),                       
    fecha DATETIME                              
);

-- Tabla reportes_proyectos
CREATE TABLE IF NOT EXISTS reportes_proyectos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_generacion DATETIME,
    total_proyectos INT
);