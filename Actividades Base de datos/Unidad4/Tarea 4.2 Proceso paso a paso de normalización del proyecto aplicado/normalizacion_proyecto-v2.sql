-- ============================================================
-- PROYECTO: NORMALIZACIÓN DE BASE DE DATOS (T-SQL / SQL SERVER)
-- ============================================================

-- ============================================================
-- PARTE 1: ESTRUCTURA DESNORMALIZADA (ESTADO 0)
-- ============================================================

IF OBJECT_ID('dbo.REGISTRO_COMPRA_UNIFICADO', 'U') IS NOT NULL 
    DROP TABLE dbo.REGISTRO_COMPRA_UNIFICADO;
GO

CREATE TABLE dbo.REGISTRO_COMPRA_UNIFICADO (
    ID_Pedido INT,
    Fecha_Pedido VARCHAR(20),
    ID_Cliente INT,
    Nombre_Cliente VARCHAR(100),
    Email_Cliente VARCHAR(100),
    Direccion_Cliente VARCHAR(150),
    ID_Productos VARCHAR(255),      -- Lista multivaluada
    Nombres_Productos VARCHAR(255), -- Lista multivaluada
    Precios_Unitarios VARCHAR(255), -- Lista multivaluada
    Cantidades VARCHAR(255),        -- Lista multivaluada
    ID_Proveedor INT,
    Nombre_Proveedor VARCHAR(100),
    Email_Proveedor VARCHAR(100),
    Monto_Total_Pedido DECIMAL(10,2)
);
GO

INSERT INTO dbo.REGISTRO_COMPRA_UNIFICADO VALUES
(1001, '2026-10-15', 501, 'Carlos Mendoza', 'carlos@email.com', 'Av. Reforma 123', '101, 102', 'Laptop Dell, Mouse Logitech', '1200.00, 25.00', '1, 2', 901, 'Tech Supplies SA', 'contacto@techsupplies.com', 1250.00),
(1002, '2026-10-16', 502, 'Ana Gómez', 'ana@email.com', 'Calle Juárez 456', '102, 103', 'Mouse Logitech, Teclado Redragon', '25.00, 75.00', '1, 1', 901, 'Tech Supplies SA', 'contacto@techsupplies.com', 100.00);
GO

-- ============================================================
-- PARTE 2: ESQUEMA TOTALMENTE NORMALIZADO (3FN / FNBC) - SQL SERVER
-- ============================================================

-- Eliminar tablas si existen en orden inverso por FKs
IF OBJECT_ID('dbo.DETALLE_PEDIDO', 'U') IS NOT NULL DROP TABLE dbo.DETALLE_PEDIDO;
IF OBJECT_ID('dbo.PEDIDO', 'U') IS NOT NULL DROP TABLE dbo.PEDIDO;
IF OBJECT_ID('dbo.PRODUCTO', 'U') IS NOT NULL DROP TABLE dbo.PRODUCTO;
IF OBJECT_ID('dbo.CLIENTE', 'U') IS NOT NULL DROP TABLE dbo.CLIENTE;
IF OBJECT_ID('dbo.PROVEEDOR', 'U') IS NOT NULL DROP TABLE dbo.PROVEEDOR;
GO

-- 1. TABLA PROVEEDOR
CREATE TABLE dbo.PROVEEDOR (
    ID_Proveedor INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Proveedor VARCHAR(100) NOT NULL,
    Email_Proveedor VARCHAR(100) NOT NULL UNIQUE,
    Telefono VARCHAR(20)
);
GO

-- 2. TABLA CLIENTE
CREATE TABLE dbo.CLIENTE (
    ID_Cliente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Cliente VARCHAR(100) NOT NULL,
    Email_Cliente VARCHAR(100) NOT NULL UNIQUE,
    Direccion_Cliente VARCHAR(150) NOT NULL
);
GO

-- 3. TABLA PRODUCTO
CREATE TABLE dbo.PRODUCTO (
    ID_Producto INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Producto VARCHAR(100) NOT NULL,
    Precio_Unitario DECIMAL(10,2) NOT NULL CHECK (Precio_Unitario >= 0),
    ID_Proveedor INT NOT NULL,
    CONSTRAINT FK_Producto_Proveedor FOREIGN KEY (ID_Proveedor) 
        REFERENCES dbo.PROVEEDOR(ID_Proveedor)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

-- 4. TABLA PEDIDO
CREATE TABLE dbo.PEDIDO (
    ID_Pedido INT IDENTITY(1,1) PRIMARY KEY,
    Fecha_Pedido DATE NOT NULL,
    ID_Cliente INT NOT NULL,
    CONSTRAINT FK_Pedido_Cliente FOREIGN KEY (ID_Cliente) 
        REFERENCES dbo.CLIENTE(ID_Cliente)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

-- 5. TABLA DETALLE_PEDIDO (Relación M:N)
CREATE TABLE dbo.DETALLE_PEDIDO (
    ID_Pedido INT NOT NULL,
    ID_Producto INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    Precio_Venta DECIMAL(10,2) NOT NULL CHECK (Precio_Venta >= 0),
    CONSTRAINT PK_DetallePedido PRIMARY KEY (ID_Pedido, ID_Producto),
    CONSTRAINT FK_Detalle_Pedido FOREIGN KEY (ID_Pedido) 
        REFERENCES dbo.PEDIDO(ID_Pedido)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Detalle_Producto FOREIGN KEY (ID_Producto) 
        REFERENCES dbo.PRODUCTO(ID_Producto)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
GO

-- ============================================================
-- PARTE 3: CARGA DE DATOS DE PRUEBA
-- ============================================================

INSERT INTO dbo.PROVEEDOR (Nombre_Proveedor, Email_Proveedor, Telefono)
VALUES ('Tech Supplies SA', 'contacto@techsupplies.com', '555-0192');

INSERT INTO dbo.CLIENTE (Nombre_Cliente, Email_Cliente, Direccion_Cliente)
VALUES 
('Carlos Mendoza', 'carlos@email.com', 'Av. Reforma 123'),
('Ana Gómez', 'ana@email.com', 'Calle Juárez 456');

INSERT INTO dbo.PRODUCTO (Nombre_Producto, Precio_Unitario, ID_Proveedor)
VALUES 
('Laptop Dell', 1200.00, 1),
('Mouse Logitech', 25.00, 1),
('Teclado Redragon', 75.00, 1);

INSERT INTO dbo.PEDIDO (Fecha_Pedido, ID_Cliente)
VALUES 
('2026-10-15', 1),
('2026-10-16', 2);

INSERT INTO dbo.DETALLE_PEDIDO (ID_Pedido, ID_Producto, Cantidad, Precio_Venta)
VALUES 
(1, 1, 1, 1200.00),
(1, 2, 2, 25.00),
(2, 2, 1, 25.00),
(2, 3, 1, 75.00);
GO

-- ============================================================
-- PARTE 4: CONSULTA DE VERIFICACIÓN (RECONSTRUCCIÓN DE VISTA)
-- ============================================================

SELECT 
    p.ID_Pedido,
    p.Fecha_Pedido,
    c.Nombre_Cliente,
    c.Email_Cliente,
    pr.Nombre_Producto,
    dp.Cantidad,
    dp.Precio_Venta,
    (dp.Cantidad * dp.Precio_Venta) AS Subtotal,
    prov.Nombre_Proveedor
FROM dbo.PEDIDO p
INNER JOIN dbo.CLIENTE c ON p.ID_Cliente = c.ID_Cliente
INNER JOIN dbo.DETALLE_PEDIDO dp ON p.ID_Pedido = dp.ID_Pedido
INNER JOIN dbo.PRODUCTO pr ON dp.ID_Producto = pr.ID_Producto
INNER JOIN dbo.PROVEEDOR prov ON pr.ID_Proveedor = prov.ID_Proveedor;
GO
