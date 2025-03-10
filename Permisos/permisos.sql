-- usuarios con sus respectivos roles

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin_password_123';
CREATE USER 'gestor_parques'@'localhost' IDENTIFIED BY 'gestor_password_123';
CREATE USER 'investigador'@'localhost' IDENTIFIED BY 'investigador_password_123';
CREATE USER 'auditor'@'localhost' IDENTIFIED BY 'auditor_password_123';
CREATE USER 'encargado_visitantes'@'localhost' IDENTIFIED BY 'encargado_password_123';



-- permisos a cada usuario según su rol
	-- Administrador: Acceso total.
	GRANT ALL PRIVILEGES ON parques_naturales.* TO 'admin'@'localhost';

    
	-- Gestor de parques: Gestión de parques, áreas y especies.
    GRANT SELECT, INSERT, UPDATE, DELETE ON parques_naturales.parques TO 'gestor_parques'@'localhost';
	GRANT SELECT, INSERT, UPDATE, DELETE ON parques_naturales.areas TO 'gestor_parques'@'localhost';
	GRANT SELECT, INSERT, UPDATE, DELETE ON parques_naturales.especies TO 'gestor_parques'@'localhost';
    GRANT SELECT, INSERT, UPDATE, DELETE ON parques_naturales.areas_especies TO 'gestor_parques'@'localhost';
	GRANT SELECT, INSERT, UPDATE, DELETE ON parques_naturales.personal_areas TO 'gestor_parques'@'localhost';


	-- Investigador: Acceso a datos de proyectos y especies.
	GRANT SELECT ON parques_naturales.proyectos_investigacion TO 'investigador'@'localhost';
	GRANT SELECT ON parques_naturales.especies TO 'investigador'@'localhost';
	GRANT SELECT ON parques_naturales.especies_investigacion TO 'investigador'@'localhost';
	GRANT SELECT ON parques_naturales.personal_investigacion TO 'investigador'@'localhost';

    
    -- Auditor: Acceso a reportes financieros.
    GRANT SELECT ON parques_naturales.proyectos_investigacion TO 'auditor'@'localhost';

    
    -- Encargado de visitantes: Gestión de visitantes y alojamientos.
    GRANT SELECT, INSERT, UPDATE, DELETE ON parques_naturales.visitantes TO 'encargado_visitantes'@'localhost';
	GRANT SELECT, INSERT, UPDATE, DELETE ON parques_naturales.alojamiento TO 'encargado_visitantes'@'localhost';
	GRANT SELECT, INSERT, UPDATE, DELETE ON parques_naturales.registro_parques TO 'encargado_visitantes'@'localhost';
	GRANT SELECT, INSERT, UPDATE, DELETE ON parques_naturales.visitante_alojamiento TO 'encargado_visitantes'@'localhost';

FLUSH PRIVILEGES;