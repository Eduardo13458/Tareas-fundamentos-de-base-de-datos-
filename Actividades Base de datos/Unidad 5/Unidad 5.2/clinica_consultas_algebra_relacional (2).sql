-- =============================================================================
-- SISTEMA DE GESTIÓN DE CLÍNICA MÉDICA HOSPITALARIA
-- SCRIPT SQL COMPATIBLE CON MICROSOFT SQL SERVER (T-SQL / SSMS)
-- Incluye comandos GO para separar lotes (batches) de compilación.
-- =============================================================================

USE [Unidad 5.2];
GO

-- -----------------------------------------------------------------------------
-- 1. ELIMINACIÓN DE TABLAS EXISTENTES (Respetando Llaves Foráneas)
-- -----------------------------------------------------------------------------

IF OBJECT_ID('dbo.HISTORIAL_CLINICO', 'U') IS NOT NULL DROP TABLE dbo.HISTORIAL_CLINICO;
IF OBJECT_ID('dbo.CITA', 'U') IS NOT NULL DROP TABLE dbo.CITA;
IF OBJECT_ID('dbo.TRATAMIENTO', 'U') IS NOT NULL DROP TABLE dbo.TRATAMIENTO;
IF OBJECT_ID('dbo.MEDICO', 'U') IS NOT NULL DROP TABLE dbo.MEDICO;
IF OBJECT_ID('dbo.ESPECIALIDAD', 'U') IS NOT NULL DROP TABLE dbo.ESPECIALIDAD;
IF OBJECT_ID('dbo.PACIENTE', 'U') IS NOT NULL DROP TABLE dbo.PACIENTE;
GO

-- -----------------------------------------------------------------------------
-- 2. CREACIÓN DE TABLAS (DDL)
-- -----------------------------------------------------------------------------

CREATE TABLE PACIENTE (
    id_paciente INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero CHAR(1) CHECK (genero IN ('M', 'F')),
    telefono VARCHAR(15),
    ciudad VARCHAR(50) NOT NULL
);
GO

CREATE TABLE ESPECIALIDAD (
    id_especialidad INT PRIMARY KEY,
    nombre_especialidad VARCHAR(50) NOT NULL,
    area_hospital VARCHAR(50) NOT NULL
);
GO

CREATE TABLE MEDICO (
    id_medico INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    id_especialidad INT NOT NULL,
    telefono VARCHAR(15),
    salario DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_MEDICO_ESPECIALIDAD FOREIGN KEY (id_especialidad) REFERENCES ESPECIALIDAD(id_especialidad)
);
GO

CREATE TABLE CITA (
    id_cita INT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME(0) NOT NULL,
    estado VARCHAR(20) CHECK (estado IN ('Programada', 'Completada', 'Cancelada')),
    costo DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_CITA_PACIENTE FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente),
    CONSTRAINT FK_CITA_MEDICO FOREIGN KEY (id_medico) REFERENCES MEDICO(id_medico)
);
GO

CREATE TABLE TRATAMIENTO (
    id_tratamiento INT PRIMARY KEY,
    nombre_tratamiento VARCHAR(100) NOT NULL,
    costo_tratamiento DECIMAL(10, 2) NOT NULL,
    duracion_dias INT NOT NULL
);
GO

CREATE TABLE HISTORIAL_CLINICO (
    id_historial INT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    fecha_diagnostico DATE NOT NULL,
    diagnostico VARCHAR(MAX) NOT NULL,
    id_tratamiento INT NULL,
    CONSTRAINT FK_HISTORIAL_PACIENTE FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente),
    CONSTRAINT FK_HISTORIAL_MEDICO FOREIGN KEY (id_medico) REFERENCES MEDICO(id_medico),
    CONSTRAINT FK_HISTORIAL_TRATAMIENTO FOREIGN KEY (id_tratamiento) REFERENCES TRATAMIENTO(id_tratamiento)
);
GO

-- -----------------------------------------------------------------------------
-- 3. INSERCIÓN DE DATOS DE PRUEBA (DML)
-- -----------------------------------------------------------------------------

INSERT INTO PACIENTE (id_paciente, nombre, apellido, fecha_nacimiento, genero, telefono, ciudad) VALUES
(1, 'Carlos', 'González', '1985-03-15', 'M', '8112345678', 'Monterrey'),
(2, 'Ana', 'Martínez', '1992-07-22', 'F', '8187654321', 'Monterrey'),
(3, 'Luis', 'Rodríguez', '1978-11-05', 'M', '5551234567', 'Guadalajara'),
(4, 'María', 'López', '2000-01-30', 'F', '5559876543', 'CDMX'),
(5, 'Jorge', 'Sánchez', '1965-09-12', 'M', '8119998877', 'Monterrey'),
(6, 'Sofia', 'Hernández', '1995-04-18', 'F', '8180001122', 'San Pedro');
GO

INSERT INTO ESPECIALIDAD (id_especialidad, nombre_especialidad, area_hospital) VALUES
(101, 'Cardiología', 'Piso 3 - Torre Médica A'),
(102, 'Pediatría', 'Piso 1 - Edificio Materno Infant'),
(103, 'Neurología', 'Piso 4 - Torre Médica B'),
(104, 'Dermatología', 'Piso 2 - Consulta Externa');
GO

INSERT INTO MEDICO (id_medico, nombre, apellido, id_especialidad, telefono, salario) VALUES
(201, 'Dr. Roberto', 'Garza', 101, '8111112233', 45000.00),
(202, 'Dra. Elena', 'Torres', 101, '8114445566', 48000.00),
(203, 'Dr. Fernando', 'Ríos', 102, '8117778899', 38000.00),
(204, 'Dra. Carmen', 'Villarreal', 103, '8110003344', 52000.00),
(205, 'Dr. Hugo', 'Navarro', 104, '8115552211', 35000.00);
GO

INSERT INTO CITA (id_cita, id_paciente, id_medico, fecha, hora, estado, costo) VALUES
(301, 1, 201, '2026-10-01', '09:00:00', 'Completada', 600.00),
(302, 1, 202, '2026-10-15', '11:30:00', 'Completada', 650.00),
(303, 2, 201, '2026-10-05', '10:00:00', 'Completada', 600.00),
(304, 2, 203, '2026-10-10', '16:00:00', 'Cancelada', 400.00),
(305, 3, 204, '2026-10-12', '12:00:00', 'Completada', 800.00),
(306, 4, 201, '2026-10-20', '13:00:00', 'Programada', 600.00),
(307, 5, 205, '2026-10-22', '15:30:00', 'Programada', 350.00);
GO

INSERT INTO TRATAMIENTO (id_tratamiento, nombre_tratamiento, costo_tratamiento, duracion_dias) VALUES
(401, 'Electrocardiograma y Monitoreo', 1200.00, 1),
(402, 'Rehabilitación Cardíaca', 3500.00, 30),
(403, 'Terapia Dermatológica Láser', 2200.00, 7);
GO

INSERT INTO HISTORIAL_CLINICO (id_historial, id_paciente, id_medico, fecha_diagnostico, diagnostico, id_tratamiento) VALUES
(501, 1, 201, '2026-10-01', 'Hipertensión Arterial Leve', 401),
(502, 2, 201, '2026-10-05', 'Arritmia Sinusal', 402),
(503, 3, 204, '2026-10-12', 'Migraña Crónica', NULL);
GO


-- -----------------------------------------------------------------------------
-- 4. CATÁLOGO DE CONSULTAS DE ÁLGEBRA RELACIONAL EN SQL (TAREA 5.2)
-- -----------------------------------------------------------------------------

-- CONSULTA 1: Selección (sigma)
SELECT *
FROM PACIENTE
WHERE ciudad = 'Monterrey';
GO

-- CONSULTA 2: Proyección (pi)
SELECT id_medico, nombre, apellido, salario
FROM MEDICO;
GO

-- CONSULTA 3: Selección + Join + Proyección
SELECT DISTINCT p.nombre, p.apellido
FROM PACIENTE p
INNER JOIN CITA c ON p.id_paciente = c.id_paciente
WHERE c.estado = 'Completada';
GO

-- CONSULTA 4: Join Multitabla (3 Relaciones)
SELECT c.fecha, c.hora, 
       p.nombre AS nombre_paciente, 
       m.nombre AS nombre_medico, 
       e.nombre_especialidad
FROM CITA c
INNER JOIN PACIENTE p ON c.id_paciente = p.id_paciente
INNER JOIN MEDICO m ON c.id_medico = m.id_medico
INNER JOIN ESPECIALIDAD e ON m.id_especialidad = e.id_especialidad;
GO

-- CONSULTA 5: Diferencia Relacional (-)
SELECT id_paciente, nombre, apellido
FROM PACIENTE
WHERE id_paciente NOT IN (
    SELECT id_paciente 
    FROM CITA
);
GO

-- CONSULTA 6: Unión Relacional (∪)
SELECT nombre, apellido, telefono FROM PACIENTE
UNION
SELECT nombre, apellido, telefono FROM MEDICO;
GO

-- CONSULTA 7: Proyección Generalizada
SELECT id_cita, costo, (costo * 0.85) AS costo_seguro
FROM CITA
WHERE costo > 500;
GO

-- CONSULTA 8: Funciones de Agregación y Agrupamiento (G)
SELECT id_medico,
       SUM(costo) AS total_ingresos,
       AVG(costo) AS promedio_consulta,
       COUNT(id_cita) AS total_citas
FROM CITA
GROUP BY id_medico;
GO

-- CONSULTA 9: Left Outer Join
SELECT m.id_medico, m.nombre, m.apellido, c.id_cita, c.fecha
FROM MEDICO m
LEFT OUTER JOIN CITA c ON m.id_medico = c.id_medico;
GO

-- CONSULTA 10: División Relacional (÷)
SELECT p.id_paciente, p.nombre, p.apellido
FROM PACIENTE p
WHERE NOT EXISTS (
    SELECT m.id_medico
    FROM MEDICO m
    INNER JOIN ESPECIALIDAD e ON m.id_especialidad = e.id_especialidad
    WHERE e.nombre_especialidad = 'Cardiología'
    AND NOT EXISTS (
        SELECT c.id_cita
        FROM CITA c
        WHERE c.id_paciente = p.id_paciente
        AND c.id_medico = m.id_medico
    )
);
GO
