DROP DATABASE IF EXISTS edutask;
CREATE DATABASE IF NOT EXISTS edutask
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE edutask;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE preferencia_usuario (
    id_preferencia INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    recordatorio_default_min INT DEFAULT 15,
    notificaciones_activas BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE
);

CREATE TABLE materia (
    id_materia INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    profesor VARCHAR(150),
    color VARCHAR(30),
    descripcion TEXT,
    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE
);

CREATE TABLE horario_clase (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    id_materia INT NOT NULL,
    dia_semana ENUM(
        'lunes', 'martes', 'miercoles', 'jueves',
        'viernes', 'sabado', 'domingo'
    ) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    aula VARCHAR(100),
    FOREIGN KEY (id_materia)
        REFERENCES materia(id_materia)
        ON DELETE CASCADE
);

CREATE TABLE tarea (
    id_tarea INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_materia INT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    fecha_entrega DATE NOT NULL,
    hora_entrega TIME,
    prioridad ENUM('baja', 'media', 'alta', 'urgente') DEFAULT 'media',
    estado ENUM('pendiente', 'en_progreso', 'completada', 'cancelada')
        DEFAULT 'pendiente',
    es_importante BOOLEAN DEFAULT FALSE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_completada DATETIME NULL,
    INDEX idx_tarea_fecha_entrega (fecha_entrega),
    INDEX idx_tarea_estado (estado),
    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE,
    FOREIGN KEY (id_materia)
        REFERENCES materia(id_materia)
        ON DELETE CASCADE
);

CREATE TABLE recordatorio (
    id_recordatorio INT AUTO_INCREMENT PRIMARY KEY,
    id_tarea INT NOT NULL,
    anticipacion_minutos INT DEFAULT 15,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_tarea)
        REFERENCES tarea(id_tarea)
        ON DELETE CASCADE
);

-- Usuario de prueba 
INSERT INTO usuario (nombres, apellidos, email, contrasena, activo)
VALUES ('Jesus Alberto', 'Gonzalez Acevedo', 'jesus@gmail.com', '12345', TRUE);

SHOW TABLES;

SELECT * FROM usuario;
SELECT * FROM preferencia_usuario;
SELECT * FROM materia;
SELECT * FROM horario_clase;
SELECT * FROM tarea;
SELECT * FROM recordatorio;