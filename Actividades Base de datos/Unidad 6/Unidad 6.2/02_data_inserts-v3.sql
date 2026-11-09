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
