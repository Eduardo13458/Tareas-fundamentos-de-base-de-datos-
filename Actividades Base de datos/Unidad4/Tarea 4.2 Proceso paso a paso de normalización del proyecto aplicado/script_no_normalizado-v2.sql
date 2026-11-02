-- ============================================================
-- SCRIPT NO NORMALIZADO (ESTADO 0) - T-SQL / SQL SERVER EXPRESS
-- ============================================================

-- Eliminar la tabla si existe previa ejecución
IF OBJECT_ID('dbo.REGISTRO_COMPRA_UNIFICADO', 'U') IS NOT NULL 
    DROP TABLE dbo.REGISTRO_COMPRA_UNIFICADO;
GO

-- Crear la tabla monolítica desnormalizada
CREATE TABLE dbo.REGISTRO_COMPRA_UNIFICADO (
    ID_Pedido INT NOT NULL,
    Fecha_Pedido VARCHAR(20) NOT NULL,
    ID_Cliente INT NOT NULL,
    Nombre_Cliente VARCHAR(100) NOT NULL,
    Email_Cliente VARCHAR(100) NOT NULL,
    Direccion_Cliente VARCHAR(150) NOT NULL,
    ID_Productos VARCHAR(255) NOT NULL,      -- Lista multivaluada (Ej: "101, 102")
    Nombres_Productos VARCHAR(255) NOT NULL, -- Lista multivaluada (Ej: "Laptop, Mouse")
    Precios_Unitarios VARCHAR(255) NOT NULL, -- Lista multivaluada (Ej: "1200.00, 25.00")
    Cantidades VARCHAR(255) NOT NULL,        -- Lista multivaluada (Ej: "1, 2")
    ID_Proveedor INT NOT NULL,
    Nombre_Proveedor VARCHAR(100) NOT NULL,
    Email_Proveedor VARCHAR(100) NOT NULL,
    Monto_Total_Pedido DECIMAL(10,2) NOT NULL
);
GO

-- Inserción de datos de prueba con grupos repetitivos (listas separadas por comas)
INSERT INTO dbo.REGISTRO_COMPRA_UNIFICADO (
    ID_Pedido, Fecha_Pedido, ID_Cliente, Nombre_Cliente, Email_Cliente, Direccion_Cliente,
    ID_Productos, Nombres_Productos, Precios_Unitarios, Cantidades,
    ID_Proveedor, Nombre_Proveedor, Email_Proveedor, Monto_Total_Pedido
) VALUES 
(1001, '2026-10-15', 501, 'Carlos Mendoza', 'carlos@email.com', 'Av. Reforma 123', '101, 102', 'Laptop Dell, Mouse Logitech', '1200.00, 25.00', '1, 2', 901, 'Tech Supplies SA', 'contacto@techsupplies.com', 1250.00),
(1002, '2026-10-16', 502, 'Ana Gómez', 'ana@email.com', 'Calle Juárez 456', '102, 103', 'Mouse Logitech, Teclado Redragon', '25.00, 75.00', '1, 1', 901, 'Tech Supplies SA', 'contacto@techsupplies.com', 100.00),
(1003, '2026-10-18', 501, 'Carlos Mendoza', 'carlos@email.com', 'Av. Reforma 123', '103', 'Teclado Redragon', '75.00', '2', 902, 'Componentes del Norte', 'ventas@compnorte.com', 150.00);
GO

-- Consultas de prueba que evidencian problemas de consulta y falta de atomicidad:
SELECT * FROM dbo.REGISTRO_COMPRA_UNIFICADO;
GO

-- Ejemplo de dificultad para consultar productos individuales (requiere LIKE o manipulación de cadenas):
SELECT ID_Pedido, Nombre_Cliente, Nombres_Productos 
FROM dbo.REGISTRO_COMPRA_UNIFICADO 
WHERE Nombres_Productos LIKE '%Mouse%';
GO
