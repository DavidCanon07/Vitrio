-- ============================================
-- BASE DE DATOS (opcional)
-- ============================================

-- CREATE DATABASE IF NOT EXISTS Vitrio;
-- USE Vitrio;

-- ============================================
-- TABLA CLIENTE
-- ============================================

CREATE TABLE IF NOT EXISTS cliente(
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    
    nombre VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- TABLA PROYECTO
-- ============================================

CREATE TABLE IF NOT EXISTS proyecto(

	id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_entrega DATE NOT NULL,
    estado ENUM(
        'PROPUESTO',
        'ANALISIS',
        'APROBADO',
        'PLANIFICACION',
        'EJECUCION',
        'SEGUIMIENTO',
        'PAUSADO',
        'CANCELADO',
        'COMPLETADO',
        'CERRADO'
    ) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_proyecto_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES cliente(id_cliente)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    INDEX idx_proyecto_cliente (id_cliente)

);


-- ============================================
-- TABLA ARCHIVO
-- ============================================

CREATE TABLE IF NOT EXISTS archivo(

	id_archivo INT AUTO_INCREMENT PRIMARY KEY,
    id_proyecto INT NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    ruta VARCHAR(500) NOT NULL,
    tipo ENUM(
        'VIDEO',
        'IMAGEN',
        'AUDIO',
		'PAQUETE',     -- zips o bundles con múltiples recursos
		'METADATO',    -- JSON/XML con programación, layout, playlists
		'DOCUMENTO'    -- guías, artes aprobados, brief en PDF, etc.
    ) NOT NULL,

    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_archivo_proyecto
    FOREIGN KEY (id_proyecto)
    REFERENCES proyecto(id_proyecto)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    INDEX idx_archivo_proyecto (id_proyecto)

);


-- ============================================
-- TABLA USUARIO
-- ============================================

CREATE TABLE IF NOT EXISTS usuario(

	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE,
    fecha_nacimiento DATE,
    rol VARCHAR(200),

    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

);


-- ============================================
-- TABLA PROYECTO_USUARIO
-- ============================================

CREATE TABLE IF NOT EXISTS proyecto_usuario(

	id_proyecto INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_proyecto, id_usuario),
    
    CONSTRAINT fk_pu_proyecto
    FOREIGN KEY (id_proyecto)
    REFERENCES proyecto(id_proyecto)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    CONSTRAINT fk_pu_usuario
    FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario)
    ON UPDATE CASCADE
    ON DELETE CASCADE

);
