use parques_naturales;

INSERT INTO categoria (id_categoria, nombre) VALUES
(1, 'Ecológico'),
(2, 'Turístico'),
(3, 'Científico'),
(4, 'Recreativo'),
(5, 'Educativo');


INSERT INTO parques (id_parque, nombre, fecha_declaracion) VALUES
(1, 'Parque Nacional Natural Tayrona', '1964-04-24'),
(2, 'Parque Nacional Natural Los Nevados', '1974-04-30'),
(3, 'Parque Nacional Natural Amacayacu', '1975-09-29'),
(4, 'Parque Nacional Natural Sierra Nevada', '1964-05-04'),
(5, 'Parque Nacional Natural Chingaza', '1977-06-06'),
(6, 'Parque Nacional Natural El Cocuy', '1977-05-02'),
(7, 'Parque Nacional Natural Farallones de Cali', '1968-07-15'),
(8, 'Parque Nacional Natural Serranía de Chiribiquete', '1989-09-21'),
(9, 'Parque Nacional Natural Puracé', '1961-12-20'),
(10, 'Parque Nacional Natural Macuira', '1977-05-24'),
(11, 'Parque Nacional Natural Corales del Rosario', '1977-05-20'),
(12, 'Parque Nacional Natural Utría', '1987-10-20'),
(13, 'Parque Nacional Natural Cahuinarí', '1987-10-20'),
(14, 'Parque Nacional Natural La Paya', '1984-06-25'),
(15, 'Parque Nacional Natural Gorgona', '1984-07-26'),
(16, 'Parque Nacional Natural Katíos', '1973-08-06'),
(17, 'Parque Nacional Natural Las Orquídeas', '1973-08-06'),
(18, 'Parque Nacional Natural Los Katíos', '1973-08-06'),
(19, 'Parque Nacional Natural Paramillo', '1977-05-20'),
(20, 'Parque Nacional Natural Pisba', '1977-05-20'),
(21, 'Parque Nacional Natural Sumapaz', '1977-05-20'),
(22, 'Parque Nacional Natural Tatamá', '1987-10-20'),
(23, 'Parque Nacional Natural Selva de Florencia', '1984-06-25');


INSERT INTO alojamiento (id_alojamiento, descripcion, capacidad, id_categoria, id_parque) VALUES
(1, 'Cabañas ecológicas', 10, 1, 1),
(2, 'Hotel turístico', 50, 2, 2),
(3, 'Campamento científico', 20, 3, 3),
(4, 'Cabañas familiares', 15, 4, 4),
(5, 'Albergue educativo', 30, 5, 5),
(6, 'Cabañas ecológicas', 12, 1, 6),
(7, 'Hotel turístico', 40, 2, 7),
(8, 'Campamento científico', 25, 3, 8),
(9, 'Cabañas familiares', 18, 4, 9),
(10, 'Albergue educativo', 35, 5, 10),
(11, 'Cabañas ecológicas', 8, 1, 11),
(12, 'Hotel turístico', 60, 2, 12),
(13, 'Campamento científico', 22, 3, 13),
(14, 'Cabañas familiares', 20, 4, 14),
(15, 'Albergue educativo', 28, 5, 15),
(16, 'Cabañas ecológicas', 14, 1, 16),
(17, 'Hotel turístico', 45, 2, 17),
(18, 'Campamento científico', 30, 3, 18),
(19, 'Cabañas familiares', 16, 4, 19),
(20, 'Albergue educativo', 32, 5, 20)
(21, 'Cabañas ecológicas premium', 12, 1, 1),
(22, 'Hotel turístico premium', 55, 2, 2),
(23, 'Campamento científico avanzado', 30, 3, 3);


INSERT INTO profesion (id_profesion, nombre) VALUES
(1, 'Ingeniero Ambiental'),
(2, 'Biólogo'),
(3, 'Guía Turístico'),
(4, 'Geólogo'),
(5, 'Ecólogo'),
(6, 'Arqueólogo'),
(7, 'Antropólogo'),
(8, 'Médico Veterinario'),
(9, 'Educador Ambiental'),
(10, 'Fotógrafo'),
(11, 'Periodista'),
(12, 'Historiador'),
(13, 'Sociólogo'),
(14, 'Ingeniero Forestal'),
(15, 'Oceanógrafo'),
(16, 'Meteorólogo'),
(17, 'Químico'),
(18, 'Físico'),
(19, 'Matemático'),
(20, 'Economista');


INSERT INTO visitantes (cedula, nombre, apellido, direccion, id_profesion) VALUES
(1001, 'Juan', 'Pérez', 'Calle 123, Bogotá', 1),
(1002, 'María', 'Gómez', 'Carrera 45, Medellín', 2),
(1003, 'Carlos', 'López', 'Avenida 67, Cali', 3),
(1004, 'Ana', 'Martínez', 'Calle 89, Barranquilla', 4),
(1005, 'Luis', 'Rodríguez', 'Carrera 12, Cartagena', 5),
(1006, 'Laura', 'Hernández', 'Avenida 34, Bucaramanga', 6),
(1007, 'Pedro', 'Díaz', 'Calle 56, Pereira', 7),
(1008, 'Sofía', 'García', 'Carrera 78, Manizales', 8),
(1009, 'Jorge', 'Fernández', 'Avenida 90, Pasto', 9),
(1010, 'Carmen', 'Sánchez', 'Calle 11, Cúcuta', 10),
(1011, 'Diego', 'Ramírez', 'Carrera 22, Ibagué', 11),
(1012, 'Paula', 'Torres', 'Avenida 33, Neiva', 12),
(1013, 'Andrés', 'Jiménez', 'Calle 44, Villavicencio', 13),
(1014, 'Lucía', 'Ruiz', 'Carrera 55, Popayán', 14),
(1015, 'Gabriel', 'Vargas', 'Avenida 66, Montería', 15),
(1016, 'Valentina', 'Moreno', 'Calle 77, Valledupar', 16),
(1017, 'Felipe', 'Ortiz', 'Carrera 88, Santa Marta', 17),
(1018, 'Isabella', 'Gutiérrez', 'Avenida 99, Armenia', 18),
(1019, 'Daniel', 'Castro', 'Calle 10, Sincelejo', 19),
(1020, 'Camila', 'Rojas', 'Carrera 20, Tunja', 20),
(1021, 'Alejandro', 'Mendoza', 'Calle 21, Bogotá', 1),
(1022, 'Mariana', 'Castro', 'Carrera 32, Medellín', 2),
(1023, 'Roberto', 'Gómez', 'Avenida 43, Cali', 3),
(1024, 'Lucía', 'Hernández', 'Calle 54, Barranquilla', 4),
(1025, 'Felipe', 'Díaz', 'Carrera 65, Cartagena', 5),
(1026, 'Valeria', 'Torres', 'Avenida 76, Bucaramanga', 6),
(1027, 'Julián', 'Sánchez', 'Calle 87, Pereira', 7),
(1028, 'Camila', 'Ramírez', 'Carrera 98, Manizales', 8),
(1029, 'Mateo', 'Fernández', 'Avenida 109, Pasto', 9),
(1030, 'Isabella', 'Gutiérrez', 'Calle 120, Cúcuta', 10)
(1031, 'Carlos', 'Gómez', 'Calle 131, Bogotá', 1),
(1032, 'Ana', 'López', 'Carrera 232, Medellín', 2),
(1033, 'Pedro', 'Martínez', 'Avenida 333, Cali', 3),
(1034, 'Laura', 'Gómez', 'Calle 141, Bogotá', 1),
(1035, 'Diego', 'López', 'Carrera 242, Medellín', 2),
(1036, 'Sofía', 'Martínez', 'Avenida 343, Cali', 3);



INSERT INTO tipo_personal (id_tipo_personal, nombre) VALUES
(1, 'Gestión'),
(2, 'Vigilancia'),
(3, 'Conservación'),
(4, 'Investigador');


INSERT INTO personal (cedula, nombre, apellido, direccion, telefono, movil, sueldo, id_tipo_personal) VALUES
(2001, 'Alejandro', 'González', 'Calle 123, Bogotá', '6011234567', '3001234567', 2500000, 1),
(2002, 'Mónica', 'López', 'Carrera 45, Medellín', '6042345678', '3002345678', 2800000, 2),
(2003, 'Ricardo', 'Martínez', 'Avenida 67, Cali', '6023456789', '3003456789', 2300000, 3),
(2004, 'Patricia', 'Rodríguez', 'Calle 89, Barranquilla', '6054567890', '3004567890', 2600000, 4),
(2005, 'Fernando', 'Hernández', 'Carrera 12, Cartagena', '6035678901', '3005678901', 2700000, 1),
(2006, 'Diana', 'García', 'Avenida 34, Bucaramanga', '6076789012', '3006789012', 2400000, 2),
(2007, 'Javier', 'Fernández', 'Calle 56, Pereira', '6067890123', '3007890123', 2900000, 3),
(2008, 'Sandra', 'Sánchez', 'Carrera 78, Manizales', '6088901234', '3008901234', 2200000, 4),
(2009, 'Héctor', 'Ramírez', 'Avenida 90, Pasto', '6029012345', '3009012345', 2500000, 1),
(2010, 'Natalia', 'Torres', 'Calle 11, Cúcuta', '6070123456', '3010123456', 2600000, 2),
(2011, 'Oscar', 'Jiménez', 'Carrera 22, Ibagué', '6031234567', '3011234567', 2300000, 3),
(2012, 'Carolina', 'Ruiz', 'Avenida 33, Neiva', '6052345678', '3012345678', 2800000, 4),
(2013, 'Gustavo', 'Vargas', 'Calle 44, Villavicencio', '6013456789', '3013456789', 2400000, 1),
(2014, 'Adriana', 'Moreno', 'Carrera 55, Popayán', '6044567890', '3014567890', 2700000, 2),
(2015, 'Raúl', 'Ortiz', 'Avenida 66, Montería', '6025678901', '3015678901', 2500000, 3),
(2016, 'Verónica', 'Gutiérrez', 'Calle 77, Valledupar', '6076789012', '3016789012', 2600000, 4),
(2017, 'Arturo', 'Castro', 'Carrera 88, Santa Marta', '6067890123', '3017890123', 2200000, 1),
(2018, 'Lorena', 'Rojas', 'Avenida 99, Armenia', '6088901234', '3018901234', 2900000, 2),
(2019, 'Eduardo', 'Mendoza', 'Calle 10, Sincelejo', '6029012345', '3019012345', 2300000, 3),
(2020, 'Gabriela', 'Paredes', 'Carrera 20, Tunja', '6070123456', '3020123456', 2400000, 4),
(2021, 'Santiago', 'Molina', 'Calle 21, Bogotá', '6012345678', '3021234567', 2600000, 1),
(2022, 'Valentina', 'Rojas', 'Carrera 32, Medellín', '6043456789', '3022345678', 2700000, 2),
(2023, 'Daniel', 'Pérez', 'Avenida 43, Cali', '6024567890', '3023456789', 2400000, 3),
(2024, 'María', 'García', 'Calle 54, Barranquilla', '6055678901', '3024567890', 2500000, 4),
(2025, 'David', 'López', 'Carrera 65, Cartagena', '6036789012', '3025678901', 2800000, 1),
(2026, 'Sofía', 'Martínez', 'Avenida 76, Bucaramanga', '6077890123', '3026789012', 2300000, 2),
(2027, 'Juan', 'Rodríguez', 'Calle 87, Pereira', '6068901234', '3027890123', 2600000, 3),
(2028, 'Paula', 'Hernández', 'Carrera 98, Manizales', '6089012345', '3028901234', 2900000, 4),
(2029, 'Carlos', 'Díaz', 'Avenida 109, Pasto', '6020123456', '3029012345', 2200000, 1),
(2030, 'Laura', 'Sánchez', 'Calle 120, Cúcuta', '6071234567', '3030123456', 2400000, 2);



INSERT INTO registro_parques (id_registro_parques, id_visitante, id_parque, id_personal, fecha) VALUES
(1, 1001, 1, 2001, '2023-01-15'),
(2, 1002, 2, 2002, '2023-02-20'),
(3, 1003, 3, 2003, '2023-03-25'),
(4, 1004, 4, 2004, '2023-04-30'),
(5, 1005, 5, 2005, '2023-05-05'),
(6, 1006, 6, 2006, '2023-06-10'),
(7, 1007, 7, 2007, '2023-07-15'),
(8, 1008, 8, 2008, '2023-08-20'),
(9, 1009, 9, 2009, '2023-09-25'),
(10, 1010, 10, 2010, '2023-10-30'),
(11, 1011, 11, 2011, '2023-11-05'),
(12, 1012, 12, 2012, '2023-12-10'),
(13, 1013, 13, 2013, '2024-01-15'),
(14, 1014, 14, 2014, '2024-02-20'),
(15, 1015, 15, 2015, '2024-03-25'),
(16, 1016, 16, 2016, '2024-04-30'),
(17, 1017, 17, 2017, '2024-05-05'),
(18, 1018, 18, 2018, '2024-06-10'),
(19, 1019, 19, 2019, '2024-07-15'),
(20, 1020, 20, 2020, '2024-08-20'),
(21, 1021, 1, 2021, '2023-09-01'),
(22, 1022, 2, 2022, '2023-09-02'),
(23, 1023, 3, 2023, '2023-09-03'),
(24, 1024, 4, 2024, '2023-09-04'),
(25, 1025, 5, 2025, '2023-09-05'),
(26, 1026, 6, 2026, '2023-09-06'),
(27, 1027, 7, 2027, '2023-09-07'),
(28, 1028, 8, 2028, '2023-09-08'),
(29, 1029, 9, 2029, '2023-09-09'),
(30, 1030, 10, 2030, '2023-09-10'),
(31, 1031, 1, 2001, '2023-10-01'),  
(32, 1031, 2, 2002, '2023-10-02'),  
(33, 1032, 3, 2003, '2023-10-03'),  
(34, 1032, 4, 2004, '2023-10-04'),  
(35, 1033, 5, 2005, '2023-10-05'),  
(36, 1033, 6, 2006, '2023-10-06')
(37, 1034, 1, 2001, '2023-11-01'),  
(38, 1034, 2, 2002, '2023-11-02'), 
(39, 1035, 3, 2003, '2023-11-03'),  
(40, 1035, 4, 2004, '2023-11-04'),  
(41, 1036, 5, 2005, '2023-11-05'),  
(42, 1036, 6, 2006, '2023-11-06');  


INSERT INTO visitante_alojamiento (id_visitante_alojamiento, fecha_entrada, fecha_salida, id_alojamiento, id_registro_parques) VALUES
(1, '2023-01-15', '2023-01-20', 1, 1),
(2, '2023-02-20', '2023-02-25', 2, 2),
(3, '2023-03-25', '2023-03-30', 3, 3),
(4, '2023-04-30', '2023-05-05', 4, 4),
(5, '2023-05-05', '2023-05-10', 5, 5),
(6, '2023-06-10', '2023-06-15', 6, 6),
(7, '2023-07-15', '2023-07-20', 7, 7),
(8, '2023-08-20', '2023-08-25', 8, 8),
(9, '2023-09-25', '2023-09-30', 9, 9),
(10, '2023-10-30', '2023-11-04', 10, 10),
(11, '2023-11-05', '2023-11-10', 11, 11),
(12, '2023-12-10', '2023-12-15', 12, 12),
(13, '2024-01-15', '2024-01-20', 13, 13),
(14, '2024-02-20', '2024-02-25', 14, 14),
(15, '2024-03-25', '2024-03-30', 15, 15),
(16, '2024-04-30', '2024-05-05', 16, 16),
(17, '2024-05-05', '2024-05-10', 17, 17),
(18, '2024-06-10', '2024-06-15', 18, 18),
(19, '2024-07-15', '2024-07-20', 19, 19),
(20, '2024-08-20', '2024-08-25', 20, 20)
(21, '2025-03-03', NULL, 1, 21), 
(22, '2025-03-04', Null, 2, 22),
(23, '2025-03-05', NULL, 3, 23), 
(24, '2025-03-01', null, 4, 24),
(25, '2023-09-05', NULL, 5, 25),
(26, '2023-09-06', '2023-09-11', 6, 26),
(27, '2025-03-07', NULL, 7, 27), 
(28, '2023-09-08', '2023-09-13', 8, 28),
(29, '2023-09-09', NULL, 9, 29), 
(30, '2023-09-10', '2023-09-15', 10, 30),
(31, '2023-11-01', '2023-11-05', 1, 37), 
(32, '2023-11-02', '2023-11-06', 21, 38),  
(33, '2023-11-03', '2023-11-07', 3, 39),   
(34, '2023-11-04', '2023-11-08', 22, 40), 
(35, '2023-11-05', '2023-11-09', 5, 41),   
(36, '2023-11-06', '2023-11-10', 23, 42); 


INSERT INTO areas (id_area, nombre, extension, id_parques) VALUES
(1, 'Zona de camping', 500.50, 1),
(2, 'Zona de observación', 300.75, 2),
(3, 'Zona de investigación', 450.25, 3),
(4, 'Zona de senderismo', 600.00, 4),
(5, 'Zona de descanso', 200.30, 5),
(6, 'Zona de camping', 550.60, 6),
(7, 'Zona de observación', 350.80, 7),
(8, 'Zona de investigación', 480.90, 8),
(9, 'Zona de senderismo', 620.10, 9),
(10, 'Zona de descanso', 210.40, 10),
(11, 'Zona de camping', 510.70, 11),
(12, 'Zona de observación', 320.85, 12),
(13, 'Zona de investigación', 460.35, 13),
(14, 'Zona de senderismo', 610.20, 14),
(15, 'Zona de descanso', 220.50, 15),
(16, 'Zona de camping', 530.90, 16),
(17, 'Zona de observación', 330.95, 17),
(18, 'Zona de investigación', 470.45, 18),
(19, 'Zona de senderismo', 630.30, 19),
(20, 'Zona de descanso', 230.60, 20);




INSERT INTO especies (id_especie, tipo, denominacion_cientifica, denominacion_vulgar, numero_individuos) VALUES
(1, 'animales', 'Panthera onca', 'Jaguar', 50),
(2, 'vegetales', 'Ceiba pentandra', 'Ceiba', 200),
(3, 'minerales', 'Cuarzo', 'Cuarzo', 1000),
(4, 'animales', 'Tapirus terrestris', 'Tapir', 30),
(5, 'vegetales', 'Anacardium excelsum', 'Caracolí', 150),
(6, 'minerales', 'Oro', 'Oro', 500),
(7, 'animales', 'Ateles fusciceps', 'Mono araña', 40),
(8, 'vegetales', 'Mauritia flexuosa', 'Moriche', 180),
(9, 'minerales', 'Esmeralda', 'Esmeralda', 300),
(10, 'animales', 'Tayassu pecari', 'Pecarí', 60),
(11, 'vegetales', 'Cedrela odorata', 'Cedro', 170),
(12, 'minerales', 'Plata', 'Plata', 400),
(13, 'animales', 'Alouatta seniculus', 'Mono aullador', 35),
(14, 'vegetales', 'Swietenia macrophylla', 'Caoba', 160),
(15, 'minerales', 'Cobre', 'Cobre', 600),
(16, 'animales', 'Myrmecophaga tridactyla', 'Oso hormiguero', 25),
(17, 'vegetales', 'Hymenaea courbaril', 'Algarrobo', 140),
(18, 'minerales', 'Hierro', 'Hierro', 700),
(19, 'animales', 'Puma concolor', 'Puma', 20),
(20, 'vegetales', 'Ficus insipida', 'Higuerón', 130)
(21, 'animales', 'Canis lupus', 'Lobo gris', 15),
(22, 'vegetales', 'Quercus robur', 'Roble común', 120),
(23, 'minerales', 'Grafito', 'Grafito', 800);







INSERT INTO areas_especies (id_areas, id_especies) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);



INSERT INTO vehiculo (id_vehiculo, tipo, marca) VALUES
(1, 'Camioneta', 'Toyota'),
(2, 'Motocicleta', 'Yamaha'),
(3, 'Bicicleta', 'Trek'),
(4, 'Camión', 'Mercedes-Benz'),
(5, 'Cuatrimoto', 'Honda'),
(6, 'Camioneta', 'Ford'),
(7, 'Motocicleta', 'Kawasaki'),
(8, 'Bicicleta', 'Specialized'),
(9, 'Camión', 'Volvo'),
(10, 'Cuatrimoto', 'Suzuki'),
(11, 'Camioneta', 'Chevrolet'),
(12, 'Motocicleta', 'Harley-Davidson'),
(13, 'Bicicleta', 'Giant'),
(14, 'Camión', 'Scania'),
(15, 'Cuatrimoto', 'Polaris'),
(16, 'Camioneta', 'Nissan'),
(17, 'Motocicleta', 'Ducati'),
(18, 'Bicicleta', 'Cannondale'),
(19, 'Camión', 'MAN'),
(20, 'Cuatrimoto', 'KTM');



INSERT INTO personal_vehiculo (id_persona, id_vehiculo) VALUES
(2002, 1),
(2006, 2),
(2010, 3),
(2014, 4),
(2018, 5),
(2002, 6),
(2006, 7),
(2010, 8),
(2014, 9),
(2018, 10),
(2002, 11),
(2006, 12),
(2010, 13),
(2014, 14),
(2018, 15),
(2002, 16),
(2006, 17),
(2010, 18),
(2014, 19),
(2018, 20);



INSERT INTO personal_areas (id_area, id_personal) VALUES
(1, 2003),
(2, 2007),
(3, 2011),
(4, 2015),
(5, 2019),
(6, 2003),
(7, 2007),
(8, 2011),
(9, 2015),
(10, 2019),
(11, 2003),
(12, 2007),
(13, 2011),
(14, 2015),
(15, 2019),
(16, 2003),
(17, 2007),
(18, 2011),
(19, 2015),
(20, 2019);


INSERT INTO departamento (id_departamento, nombre) VALUES
(1, 'Amazonas'),
(2, 'Antioquia'),
(3, 'Arauca'),
(4, 'Atlántico'),
(5, 'Bolívar'),
(6, 'Boyacá'),
(7, 'Caldas'),
(8, 'Caquetá'),
(9, 'Casanare'),
(10, 'Cauca'),
(11, 'Cesar'),
(12, 'Chocó'),
(13, 'Córdoba'),
(14, 'Cundinamarca'),
(15, 'Guainía'),
(16, 'Guaviare'),
(17, 'Huila'),
(18, 'La Guajira'),
(19, 'Magdalena'),
(20, 'Meta');


INSERT INTO entidad_responsable (id_entidad, nombre, id_parques, id_departamento) VALUES
(1, 'Ministerio de Ambiente y Desarrollo Sostenible', 1, 1),
(2, 'Corporación Autónoma Regional del Centro', 2, 2),
(3, 'Parques Nacionales Naturales de Colombia', 3, 3),
(4, 'Secretaría de Ambiente y Desarrollo Sostenible', 4, 4),
(5, 'Gobernación de Bolívar', 5, 5),
(6, 'Corporación Ambiental del Centro', 6, 6),
(7, 'Alcaldía de Cali', 7, 7),
(8, 'Ministerio de Ambiente y Recursos Naturales', 8, 8),
(9, 'Corporación Autónoma Regional del Norte', 9, 9),
(10, 'Parques Nacionales Naturales del Caribe', 10, 10),
(11, 'Secretaría de Ambiente y Recursos Naturales', 11, 11),
(12, 'Gobernación de Chocó', 12, 12),
(13, 'Corporación Ambiental del Norte', 13, 13),
(14, 'Alcaldía de Bogotá', 14, 14),
(15, 'Ministerio de Ambiente y Cambio Climático', 15, 15),
(16, 'Corporación Autónoma Regional del Sur', 16, 16),
(17, 'Parques Nacionales Naturales del Pacífico', 17, 17),
(18, 'Secretaría de Ambiente y Cambio Climático', 18, 18),
(19, 'Gobernación de Magdalena', 19, 19),
(20, 'Corporación Ambiental del Sur', 20, 20),
(21, 'Ministerio de Cultura', 1, 1), 
(22, 'Gobernación de Magdalena', 1, 19),
(23, 'Corporación Autónoma Regional de Caldas', 2, 7),  
(24, 'Ministerio de Turismo', 2, 2),
(25, 'Ministerio de Ambiente y Biodiversidad', 3, 1),  
(26, 'Gobernación de Amazonas', 3, 1),
(27, 'Ministerio de Ambiente y Sostenibilidad', 4, 4), 
(28, 'Gobernación de La Guajira', 4, 18);





INSERT INTO parques_departamento (id_entidad, id_parque, id_departamento) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10),
(11, 11, 11),
(12, 12, 12),
(13, 13, 13),
(14, 14, 14),
(15, 15, 15),
(16, 16, 16),
(17, 17, 17),
(18, 18, 18),
(19, 19, 19),
(20, 20, 20);



INSERT INTO proyectos_investigacion (id_proyecto_investigacion, presupuesto, periodo_realizacion) VALUES
(1, 5000000, '2023-12-31'),
(2, 7500000, '2024-06-30'),
(3, 6000000, '2024-12-31'),
(4, 8000000, '2025-01-30'),
(5, 5500000, '1999-12-31'),
(6, 7000000, '2010-06-30'),
(7, 6500000, '2013-12-31'),
(8, 8500000, '2014-06-30'),
(9, 9000000, '2021-12-31'),
(10, 9500000, '2020-06-30'),
(11, 10000000, '2022-12-31'),
(12, 10500000, '2023-06-30'),
(13, 11000000, '2021-12-31'),
(14, 11500000, '2001-06-30'),
(15, 12000000, '2004-12-31'),
(16, 12500000, '2011-06-30'),
(17, 13000000, '2024-12-31'),
(18, 13500000, '2005-06-30'),
(19, 14000000, '2007-12-31'),
(20, 14500000, '2009-06-30'),
(21, 15000000, '2024-12-31'),
(22, 20000000, '2025-06-30'),
(23, 18000000, '2025-12-31');




INSERT INTO personal_investigacion (id_personal, id_proyecto_investigacion) VALUES
(2004, 1),
(2008, 2),
(2012, 3),
(2016, 4),
(2020, 5),
(2004, 6),
(2008, 7),
(2012, 8),
(2016, 9),
(2020, 10),
(2004, 11),
(2008, 12),
(2012, 13),
(2016, 14),
(2020, 15),
(2004, 16),
(2008, 17),
(2012, 18),
(2016, 19),
(2020, 20);



select * from personal;


INSERT INTO especies_investigacion (id_especie, id_proyecto_investigacion) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(1, 21),  
(2, 22),  
(3, 23); 




















