# Unidad 6: Lenguaje de Consulta Estructurado (SQL)
## Actividad 6.2: Implementación de Script DDL, Carga de Datos y Consultas DML

---

### 📌 Información Institucional y del Estudiante

| Campo | Detalle |
| :--- | :--- |
| **Institución:** | Tecnológico Nacional de México |
| **Materia:** | Sistemas de Bases de Datos / Fundamentos de Bases de Datos |
| **Unidad:** | Unidad 6 – Lenguaje de Definición y Manipulación de Datos (SQL) |
| **Docente:** | Ruben Miguel Riojas Rodríguez |
| **Alumno:** | Eduardo Salazar Martínez |
| **Caso de Estudio:** | Sistema Relacional de Comercio Electrónico (*TechStore DB*) |
| **Motor de Base de Datos:** | Microsoft SQL Server Express (T-SQL) |
| **Herramienta:** | SQL Server Management Studio (SSMS) / sqlcmd |
| **Repositorio GitHub:** | [Eduardo13458 / Tareas-fundamentos-de-base-de-datos-](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-) |
| **Directorio de la Actividad:** | [`Actividades Base de datos/Unidad 6/Unidad 6.2/`](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/tree/main/Actividades%20Base%20de%20datos/Unidad%206/Unidad%206.2) |
| **Video en YouTube:** | `[Inserta aquí tu enlace público de YouTube]` *(Demostración en vivo en SSMS de la ejecución de DDL, carga de datos, consultas analíticas y pruebas de integridad)* |

---

## 🗂️ 1. Índice de Archivos de la Actividad 6.2

A continuación se presentan los enlaces locales directos y absolutos verificados a partir de los archivos existentes en tu rama `main` en GitHub (garantizados sin errores 404):

| Archivo | Tipo de Recurso | Enlace Local  | Enlace Completo (GitHub) |
| :--- | :--- | :---: | :---: |
| **`Reporte_Tecnico_SQL_Area_6.2-v2.pdf`** | Reporte Técnico Formal en PDF | [📑 Abrir Reporte PDF](./Reporte_Tecnico_SQL_Area_6.2-v2.pdf) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/blob/main/Actividades%20Base%20de%20datos/Unidad%206/Unidad%206.2/Reporte_Tecnico_SQL_Area_6.2-v2.pdf) |
| **`Reporte_Tecnico_SQL_Area_6.2-v2.md`** | Reporte Técnico en Markdown | [📄 Abrir Reporte Markdown](./Reporte_Tecnico_SQL_Area_6.2-v2.md) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/blob/main/Actividades%20Base%20de%20datos/Unidad%206/Unidad%206.2/Reporte_Tecnico_SQL_Area_6.2-v2.md) |
| **`01_schema_ddl.sql`** | Script DDL: Definición de Esquema | [💾 Abrir Script DDL](./01_schema_ddl.sql) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/blob/main/Actividades%20Base%20de%20datos/Unidad%206/Unidad%206.2/01_schema_ddl.sql) |
| **`02_data_inserts-v3.sql`** | Script DML: Poblado de Datos Transaccional | [💾 Abrir Script Datos](./02_data_inserts-v3.sql) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/blob/main/Actividades%20Base%20de%20datos/Unidad%206/Unidad%206.2/02_data_inserts-v3.sql) |
| **`03_queries_dml-v3.sql`** | Script DML: Consultas y Mantenimiento | [💾 Abrir Script Consultas](./03_queries_dml-v3.sql) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/blob/main/Actividades%20Base%20de%20datos/Unidad%206/Unidad%206.2/03_queries_dml-v3.sql) |
| **`script_completo_practica_6_2-v3.sql`** | Script Consolidado Maestro | [💾 Abrir Script Maestro](./script_completo_practica_6_2-v3.sql) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/blob/main/Actividades%20Base%20de%20datos/Unidad%206/Unidad%206.2/script_completo_practica_6_2-v3.sql) |
| **`README-v2 Clonacion.md`** | Guía de Despliegue y Clonación | [📖 Abrir Guía Clonación](./README-v2%20Clonacion.md) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/blob/main/Actividades%20Base%20de%20datos/Unidad%206/Unidad%206.2/README-v2%20Clonacion.md) |

---

## 🏬 2. Arquitectura del Modelo Relacional y Diccionario de Datos (*TechStore DB*)

El caso de estudio corresponde a una tienda de comercio electrónico de tecnología, estructurada en **Tercera Forma Normal (3FN)** con 5 entidades:

```text
categorias (categoria_id [PK], nombre, descripcion, fecha_creacion)
productos (producto_id [PK], categoria_id [FK -> categorias], nombre, precio, stock, estado)
clientes (cliente_id [PK], nombre, apellido, email, telefono, fecha_registro)
pedidos (pedido_id [PK], cliente_id [FK -> clientes], fecha_pedido, monto_total, estado)
detalles_pedido (detalle_id [PK], pedido_id [FK -> pedidos], producto_id [FK -> productos], cantidad, precio_unitario, subtotal)
```

### Diccionario de Datos (T-SQL):
* **`categorias`**: Identificador autoincrementable `IDENTITY(1,1)`, nombre de categoría único y descripción.
* **`productos`**: Control de inventario con restricciones `CHECK (precio > 0)`, `CHECK (stock >= 0)` y regla de estado `CHECK (estado IN ('ACTIVO', 'INACTIVO', 'DESCONTINUADO'))`.
* **`clientes`**: Validación única de correo electrónico (`UNIQUE NOT NULL`).
* **`pedidos`**: Estados controlados (`PENDIENTE`, `PROCESANDO`, `ENVIADO`, `ENTREGADO`, `CANCELADO`) y relación con clientes.
* **`detalles_pedido`**: Clave foránea hacia `pedidos` con eliminación en cascada (`ON DELETE CASCADE`), clave única compuesta `UNIQUE (pedido_id, producto_id)` y columna calculada persistente `subtotal AS (cantidad * precio_unitario) PERSISTED`.

---

## 🛠️ 3. Guía de Ejecución y Flujo de Despliegue en SQL Server Express

### Opción A: Ejecución Modular (Paso a Paso en SSMS)
1. Abrir **SQL Server Management Studio (SSMS)** y conectarse a la instancia local (`.\SQLEXPRESS` o `localhost`).
2. Abrir la base de datos de trabajo o crear una nueva (`CREATE DATABASE TechStoreDB; USE TechStoreDB;`).
3. Ejecutar los scripts en el siguiente orden secuencial estricto:
   * **Paso 1 (DDL):** Abrir [`01_schema_ddl.sql`](./01_schema_ddl.sql) y presionar **F5**. Crea las 5 tablas, contadores `IDENTITY` y restricciones `CHECK`/`FOREIGN KEY`.
   * **Paso 2 (DML Inserts):** Abrir [`02_data_inserts-v3.sql`](./02_data_inserts-v3.sql) y presionar **F5**. Activa `SET IDENTITY_INSERT` e inserta los registros con control transaccional (`BEGIN TRANSACTION / COMMIT`).
   * **Paso 3 (DML Queries):** Abrir [`03_queries_dml-v3.sql`](./03_queries_dml-v3.sql) y presionar **F5**. Ejecuta las 5 consultas de reporte y las operaciones de mantenimiento.

### Opción B: Ejecución Unificada
Abrir y ejecutar directamente el script maestro consolidado [`script_completo_practica_6_2-v3.sql`](./script_completo_practica_6_2-v3.sql) con **F5** para recrear toda la base de datos en una sola operación.

---

## 📊 4. Catálogo de Consultas LMD y Pruebas de Integridad

El script [`03_queries_dml-v3.sql`](./03_queries_dml-v3.sql) contiene la resolución analítica y pruebas de consola:

1. **Consulta 1 (Filtros y Ordenamiento):** Productos activos con precio superior a $200.00 ordenados descendentemente (`WHERE precio > 200.00 AND estado = 'ACTIVO' ORDER BY precio DESC`).
2. **Consulta 2 (Funciones de Agregación y Agrupación):** Resumen de inventario por categoría calculando `COUNT(producto_id)`, `MIN(precio)`, `MAX(precio)`, `AVG(precio)` y `SUM(stock)` con `GROUP BY`.
3. **Consulta 3 (Filtro sobre Grupos):** Clientes con facturación acumulada superior a $500.00 mediante `GROUP BY` y cláusula `HAVING SUM(monto_total) > 500.00`.
4. **Consulta 4 (Reunión Multitabla - INNER JOIN):** Cruce relacional de 4 tablas (`pedidos`, `clientes`, `detalles_pedido`, `productos`) para reconstruir el detalle completo de ventas.
5. **Consulta 5 (Reunión Externa - LEFT JOIN):** Detección de clientes inactivos sin compras mediante `LEFT JOIN pedidos ON clientes.cliente_id = pedidos.cliente_id WHERE pedidos.pedido_id IS NULL`.

### Pruebas de Integridad Referencial:
* **Mantenimiento 1 (UPDATE):** Aumento del 10% en precio y 5 unidades en stock para el producto ID 3.
* **Mantenimiento 2 (DELETE CASCADE):** Eliminación del pedido ID 8 verificando la supresión automática de sus tuplas dependientes en `detalles_pedido`.
* **Mantenimiento 3 (Violación FK):** Demostración del error **Msg 547** al intentar eliminar una categoría (`categoria_id = 1`) que cuenta con productos activos asociados (bloqueo por `ON DELETE NO ACTION`).

---

## 🎥 5. Video Explicativo en YouTube

* **URL del Video:** `[Inserta aquí tu enlace público de YouTube]`
* **Contenido de la Demostración:**
  * Conexión a SQL Server Management Studio (SSMS).
  * Ejecución secuencial de los scripts DDL y DML.
  * Análisis de los resultados en pantalla de las 5 consultas analíticas.
  * Demostración en vivo del borrado en cascada (`ON DELETE CASCADE`) y del error de restricción referencial.
  * Cámara web activa mostrando el rostro del estudiante en la esquina inferior derecha durante toda la exposición.

---

## 📚 6. Referencias Bibliográficas (Formato APA 7.ª ed.)

* Elmasri, R., & Navathe, S. B. (2021). *Fundamentals of database systems* (7.ª ed.). Pearson.
* Microsoft Learn. (2026). *Transact-SQL statements overview - SQL Server*. Microsoft Technical Documentation.
* Silberschatz, A., Korth, H. F., & Sudarshan, S. (2020). *Database system concepts* (7.ª ed.). McGraw-Hill Education.
