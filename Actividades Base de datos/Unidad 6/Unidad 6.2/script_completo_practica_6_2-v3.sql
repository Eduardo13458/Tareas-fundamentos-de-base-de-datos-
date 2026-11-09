-- ============================================================
-- SCRIPT 01: DEFINICIÓN DE ESQUEMA LDD (SQL SERVER EXPRESS / T-SQL)
-- ============================================================
USE [master];
GO

-- Asegurar que los mensajes de conteo no interfieran
SET NOCOUNT ON;
GO

-- Eliminación de tablas si existen (en orden inverso por dependencias)
IF OBJECT_ID('dbo.detalles_pedido', 'U') IS NOT NULL DROP TABLE dbo.detalles_pedido;
IF OBJECT_ID('dbo.pedidos', 'U') IS NOT NULL DROP TABLE dbo.pedidos;
IF OBJECT_ID('dbo.productos', 'U') IS NOT NULL DROP TABLE dbo.productos;
IF OBJECT_ID('dbo.clientes', 'U') IS NOT NULL DROP TABLE dbo.clientes;
IF OBJECT_ID('dbo.categorias', 'U') IS NOT NULL DROP TABLE dbo.categorias;
GO

-- 1. Tabla: categorias
CREATE TABLE dbo.categorias (
    categoria_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nombre NVARCHAR(50) NOT NULL UNIQUE,
    descripcion NVARCHAR(MAX) NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- 2. Tabla: productos
CREATE TABLE dbo.productos (
    producto_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    categoria_id INT NOT NULL,
    nombre NVARCHAR(100) NOT NULL UNIQUE,
    precio DECIMAL(10, 2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    estado NVARCHAR(20) NOT NULL DEFAULT N'ACTIVO' CHECK (estado IN (N'ACTIVO', N'INACTIVO', N'DESCONTINUADO')),
    CONSTRAINT fk_productos_categorias 
        FOREIGN KEY (categoria_id) REFERENCES dbo.categorias(categoria_id) 
        ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

-- 3. Tabla: clientes
CREATE TABLE dbo.clientes (
    cliente_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nombre NVARCHAR(50) NOT NULL,
    apellido NVARCHAR(50) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    telefono NVARCHAR(20) NULL,
    fecha_registro DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- 4. Tabla: pedidos
CREATE TABLE dbo.pedidos (
    pedido_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha_pedido DATETIME NOT NULL DEFAULT GETDATE(),
    monto_total DECIMAL(10, 2) NOT NULL DEFAULT 0.00 CHECK (monto_total >= 0),
    estado NVARCHAR(20) NOT NULL DEFAULT N'PENDIENTE' CHECK (estado IN (N'PENDIENTE', N'PROCESANDO', N'ENVIADO', N'ENTREGADO', N'CANCELADO')),
    CONSTRAINT fk_pedidos_clientes 
        FOREIGN KEY (cliente_id) REFERENCES dbo.clientes(cliente_id) 
        ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

-- 5. Tabla: detalles_pedido
CREATE TABLE dbo.detalles_pedido (
    detalle_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL CHECK (precio_unitario > 0),
    subtotal AS (cantidad * precio_unitario) PERSISTED,
    CONSTRAINT fk_detalles_pedidos 
        FOREIGN KEY (pedido_id) REFERENCES dbo.pedidos(pedido_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_detalles_productos 
        FOREIGN KEY (producto_id) REFERENCES dbo.productos(producto_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT uq_pedido_producto UNIQUE (pedido_id, producto_id)
);
GO

-- ============================================================
-- SCRIPT 02: POBLADO DE DATOS LMD (SQL SERVER EXPRESS / T-SQL)
-- ============================================================
SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

BEGIN TRANSACTION;

-- 1. Insertar Categorías (Con IDENTITY_INSERT para asegurar IDs exactos)
SET IDENTITY_INSERT dbo.categorias ON;

INSERT INTO dbo.categorias (categoria_id, nombre, descripcion) VALUES
(1, N'Laptops y Gaming', N'Equipos portatiles de alto rendimiento'),
(2, N'Componentes de PC', N'Tarjetas graficas, procesadores y memorias'),
(3, N'Perifericos y Accesorios', N'Teclados mecano-opticos y ratones'),
(4, N'Monitores y Pantallas', N'Monitores gamer 4K y OLED'),
(5, N'Redes y Conectividad', N'Routers Wi-Fi 6 y switches');

SET IDENTITY_INSERT dbo.categorias OFF;
GO

-- 2. Insertar Productos
SET IDENTITY_INSERT dbo.productos ON;

INSERT INTO dbo.productos (producto_id, categoria_id, nombre, precio, stock, estado) VALUES
(1, 1, N'Laptop Gaming Asus ROG Strix 16', 1499.99, 15, N'ACTIVO'),
(2, 1, N'MacBook Pro 14 M3 Pro', 1999.00, 10, N'ACTIVO'),
(3, 2, N'Procesador AMD Ryzen 7 7800X3D', 389.50, 25, N'ACTIVO'),
(4, 2, N'Tarjeta de Video NVIDIA RTX 4070 Super', 599.99, 12, N'ACTIVO'),
(5, 2, N'Memoria RAM Corsair Vengeance 32GB DDR5', 115.00, 40, N'ACTIVO'),
(6, 3, N'Teclado Mecanico Logitech G Pro X', 129.99, 30, N'ACTIVO'),
(7, 3, N'Mouse Inalambrico Razer DeathAdder V3', 89.90, 50, N'ACTIVO'),
(8, 4, N'Monitor LG UltraGear 27 IPS 165Hz', 279.00, 20, N'ACTIVO'),
(9, 4, N'Monitor Samsung Odyssey G9 49 Curved', 1199.99, 5, N'ACTIVO'),
(10, 5, N'Router Asus RT-AX88U Wi-Fi 6', 229.50, 0, N'INACTIVO');

SET IDENTITY_INSERT dbo.productos OFF;
GO

-- 3. Insertar Clientes
SET IDENTITY_INSERT dbo.clientes ON;

INSERT INTO dbo.clientes (cliente_id, nombre, apellido, email, telefono) VALUES
(1, N'Carlos', N'Mendoza', N'carlos.mendoza@tienda.com', N'555-1010'),
(2, N'Ana', N'Garcia', N'ana.garcia@tienda.com', N'555-2020'),
(3, N'Roberto', N'Sanchez', N'roberto.sanchez@tienda.com', N'555-3030'),
(4, N'Laura', N'Torres', N'laura.torres@tienda.com', N'555-4040'),
(5, N'Fernando', N'Lopez', N'fernando.lopez@tienda.com', N'555-5050'),
(6, N'Elena', N'Vargas', N'elena.vargas@tienda.com', N'555-6060');

SET IDENTITY_INSERT dbo.clientes OFF;
GO

-- 4. Insertar Pedidos
SET IDENTITY_INSERT dbo.pedidos ON;

INSERT INTO dbo.pedidos (pedido_id, cliente_id, fecha_pedido, monto_total, estado) VALUES
(1, 1, '2026-10-01T10:30:00', 1629.98, N'ENTREGADO'),
(2, 1, '2026-10-15T14:20:00', 389.50, N'ENTREGADO'),
(3, 2, '2026-10-18T11:15:00', 2114.00, N'ENVIADO'),
(4, 3, '2026-10-20T16:45:00', 729.98, N'PROCESANDO'),
(5, 4, '2026-10-22T09:00:00', 279.00, N'PENDIENTE'),
(6, 4, '2026-11-01T18:30:00', 204.90, N'PENDIENTE'),
(7, 5, '2026-11-03T12:10:00', 1199.99, N'PROCESANDO'),
(8, 1, '2026-11-05T15:00:00', 129.99, N'PENDIENTE');

SET IDENTITY_INSERT dbo.pedidos OFF;
GO

-- 5. Insertar Detalles de Pedido
SET IDENTITY_INSERT dbo.detalles_pedido ON;

INSERT INTO dbo.detalles_pedido (detalle_id, pedido_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 1, 1499.99),
(2, 1, 6, 1, 129.99),
(3, 2, 3, 1, 389.50),
(4, 3, 2, 1, 1999.00),
(5, 3, 5, 1, 115.00),
(6, 4, 4, 1, 599.99),
(7, 4, 6, 1, 129.99),
(8, 5, 8, 1, 279.00),
(9, 6, 5, 1, 115.00),
(10, 6, 7, 1, 89.90),
(11, 7, 9, 1, 1199.99),
(12, 8, 6, 1, 129.99);

SET IDENTITY_INSERT dbo.detalles_pedido OFF;
GO

COMMIT TRANSACTION;
GO

-- ============================================================
-- SCRIPT 03: CONSULTAS Y MANTENIMIENTO LMD (SQL SERVER EXPRESS / T-SQL)
-- ============================================================
SET NOCOUNT ON;
GO

-- Consulta 1: Filtros condicionales (WHERE) y Ordenamiento (ORDER BY)
SELECT producto_id, nombre AS producto, precio, stock, estado
FROM dbo.productos
WHERE precio > 200.00 AND estado = N'ACTIVO'
ORDER BY precio DESC;
GO

-- Consulta 2: Agregaciones (COUNT, MIN, MAX, AVG, SUM) y Agrupaciones (GROUP BY)
SELECT c.nombre AS categoria,
       COUNT(p.producto_id) AS total_productos,
       MIN(p.precio) AS min_precio,
       MAX(p.precio) AS max_precio,
       ROUND(AVG(p.precio), 2) AS avg_precio,
       SUM(p.stock) AS total_stock
FROM dbo.categorias c
JOIN dbo.productos p ON c.categoria_id = p.categoria_id
GROUP BY c.categoria_id, c.nombre
ORDER BY total_productos DESC;
GO

-- Consulta 3: Agrupación con Filtro de Grupo (GROUP BY y HAVING)
SELECT cl.cliente_id,
       CONCAT(cl.nombre, N' ', cl.apellido) AS cliente,
       COUNT(p.pedido_id) AS total_pedidos,
       SUM(p.monto_total) AS monto_acumulado
FROM dbo.clientes cl
JOIN dbo.pedidos p ON cl.cliente_id = p.cliente_id
GROUP BY cl.cliente_id, cl.nombre, cl.apellido
HAVING SUM(p.monto_total) > 500.00
ORDER BY monto_acumulado DESC;
GO

-- Consulta 4: Reunión Interna entre múltiples tablas (INNER JOIN)
SELECT p.pedido_id,
       CONCAT(c.nombre, N' ', c.apellido) AS cliente,
       pr.nombre AS producto,
       dp.cantidad,
       dp.precio_unitario,
       dp.subtotal,
       p.estado AS estado_pedido
FROM dbo.pedidos p
INNER JOIN dbo.clientes c ON p.cliente_id = c.cliente_id
INNER JOIN dbo.detalles_pedido dp ON p.pedido_id = dp.pedido_id
INNER JOIN dbo.productos pr ON dp.producto_id = pr.producto_id
ORDER BY p.pedido_id ASC, pr.nombre ASC;
GO

-- Consulta 5: Reunión Externa (LEFT JOIN) para identificar clientes sin pedidos
SELECT c.cliente_id, c.nombre, c.apellido, c.email,
       ISNULL(CAST(p.pedido_id AS VARCHAR), N'NINGUNO') AS pedido_id,
       ISNULL(p.estado, N'SIN PEDIDOS') AS estado_pedido
FROM dbo.clientes c
LEFT JOIN dbo.pedidos p ON c.cliente_id = p.cliente_id
WHERE p.pedido_id IS NULL;
GO

-- ------------------------------------------------------------
-- OPERACIONES DE MANTENIMIENTO E INTEGRIDAD REFERENCIAL
-- ------------------------------------------------------------

-- Mantenimiento 1: Actualización con UPDATE
UPDATE dbo.productos 
SET precio = ROUND(precio * 1.10, 2), 
    stock = stock + 5 
WHERE producto_id = 3;
GO

-- Mantenimiento 2: Borrado Exitoso en Cascada (DELETE)
-- Al eliminar el pedido 8, sus detalles se eliminan automáticamente por ON DELETE CASCADE
DELETE FROM dbo.pedidos WHERE pedido_id = 8;
GO

-- Mantenimiento 3: Prueba de Violación de Integridad Referencial
-- Intentar borrar una categoría con productos asociados (Generará el error de restricción FK)
-- DELETE FROM dbo.categorias WHERE categoria_id = 1;
-- GO
