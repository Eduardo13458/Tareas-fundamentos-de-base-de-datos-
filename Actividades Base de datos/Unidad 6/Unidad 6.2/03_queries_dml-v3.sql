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
