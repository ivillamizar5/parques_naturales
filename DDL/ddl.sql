CREATE DATABASE parques_naturales;
USE parques_naturales;

CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE parques (
    id_parque INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_declaracion DATETIME
);


CREATE TABLE alojamiento (
    id_alojamiento INT PRIMARY KEY,
    descripcion TEXT,
    capacidad INT,
    id_categoria INT,
    id_parque INT,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
    FOREIGN KEY (id_parque) REFERENCES parques(id_parque)
);



CREATE TABLE profesion (
    id_profesion INT PRIMARY KEY,
    nombre VARCHAR(50)
);


CREATE TABLE visitantes (
    cedula INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(50),
    id_profesion INT,
    FOREIGN KEY (id_profesion) REFERENCES profesion(id_profesion)
);

CREATE TABLE tipo_personal (
    id_tipo_personal INT PRIMARY KEY,
    nombre VARCHAR(50)
);


CREATE TABLE personal (
    cedula INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(50),
    telefono VARCHAR(11),
    movil VARCHAR(10),
    sueldo FLOAT(10,2),
    id_tipo_personal INT,
    FOREIGN KEY (id_tipo_personal) REFERENCES tipo_personal(id_tipo_personal)
);



CREATE TABLE registro_parques (
    id_registro_parques INT PRIMARY KEY,
    id_visitante INT,
    id_parque INT,
    id_personal INT,
    fecha DATETIME,
    FOREIGN KEY (id_visitante) REFERENCES visitantes(cedula),
    FOREIGN KEY (id_parque) REFERENCES parques(id_parque),
    FOREIGN KEY (id_personal) REFERENCES personal(cedula)
);


CREATE TABLE visitante_alojamiento (
    id_visitante_alojamiento INT PRIMARY KEY,
    fecha_entrada DATETIME,
    fecha_salida DATETIME,
    id_alojamiento INT,
    id_registro_parques INT,
    FOREIGN KEY (id_alojamiento) REFERENCES alojamiento(id_alojamiento),
    FOREIGN KEY (id_registro_parques) REFERENCES registro_parques(id_registro_parques)
);


CREATE TABLE areas (
    id_area INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    extension DECIMAL(10,2),
    id_parques INT,
    FOREIGN KEY (id_parques) REFERENCES parques(id_parque)
);



CREATE TABLE especies (
    id_especie INT PRIMARY KEY,
    tipo ENUM('vegetales', 'animales', 'minerales'),
    denominacion_cientifica VARCHAR(50),
    denominacion_vulgar VARCHAR(50),
    numero_individuos INT
);


CREATE TABLE areas_especies (
    id_areas INT,
    id_especies INT,
    PRIMARY KEY (id_areas, id_especies),
    FOREIGN KEY (id_areas) REFERENCES areas(id_area),
    FOREIGN KEY (id_especies) REFERENCES especies(id_especie)
);


CREATE TABLE vehiculo (
    id_vehiculo INT PRIMARY KEY,
    tipo VARCHAR(50),
    marca VARCHAR(30)
);





CREATE TABLE personal_vehiculo (
    id_persona INT,
    id_vehiculo INT,
    PRIMARY KEY (id_persona, id_vehiculo),
    FOREIGN KEY (id_persona) REFERENCES personal(cedula),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo)
);


CREATE TABLE personal_areas (
    id_area INT,
    id_personal INT,
    PRIMARY KEY (id_area, id_personal),
    FOREIGN KEY (id_area) REFERENCES areas(id_area),
    FOREIGN KEY (id_personal) REFERENCES personal(cedula)
);

CREATE TABLE departamento (
    id_departamento INT PRIMARY KEY,
    nombre VARCHAR(50)
);


CREATE TABLE entidad_responsable (
    id_entidad INT PRIMARY KEY,
    nombre VARCHAR(50),
    id_parques INT,
    id_departamento INT,
    FOREIGN KEY (id_parques) REFERENCES parques(id_parque),
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
);


CREATE TABLE parques_departamento (
    id_entidad INT,
    id_parque INT,
    id_departamento INT,
    PRIMARY KEY (id_entidad, id_parque, id_departamento),
    FOREIGN KEY (id_entidad) REFERENCES entidad_responsable(id_entidad),
    FOREIGN KEY (id_parque) REFERENCES parques(id_parque),
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
);

CREATE TABLE proyectos_investigacion (
    id_proyecto_investigacion INT PRIMARY KEY,
    presupuesto FLOAT(10,2),
    periodo_realizacion DATETIME
);

CREATE TABLE personal_investigacion (
    id_personal INT,
    id_proyecto_investigacion INT,
    PRIMARY KEY (id_personal, id_proyecto_investigacion),
    FOREIGN KEY (id_personal) REFERENCES personal(cedula),
    FOREIGN KEY (id_proyecto_investigacion) REFERENCES proyectos_investigacion(id_proyecto_investigacion)
);

CREATE TABLE especies_investigacion (
    id_especie INT,
    id_proyecto_investigacion INT,
    PRIMARY KEY (id_especie, id_proyecto_investigacion),
    FOREIGN KEY (id_especie) REFERENCES especies(id_especie),
    FOREIGN KEY (id_proyecto_investigacion) REFERENCES proyectos_investigacion(id_proyecto_investigacion)
);

