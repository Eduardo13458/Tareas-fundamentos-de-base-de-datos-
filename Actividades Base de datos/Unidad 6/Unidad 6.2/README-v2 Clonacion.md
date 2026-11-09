# Práctica 6.2: Implementación de Script DDL, Carga de Datos y Consultas DML

**Asignatura:** Bases de Datos — Unidad 6  
**Motor de Base de Datos:** Microsoft SQL Server Express (T-SQL)  
**Herramienta de Administración:** SQL Server Management Studio (SSMS) / `sqlcmd`  
**Caso de Estudio:** Sistema Relacional de Comercio Electrónico (*TechStore DB*)  

---

## 📋 Descripción del Proyecto

Este repositorio contiene la solución técnica integral para la **Práctica 6.2**, estructurada en scripts SQL modulares (`T-SQL`) adaptados para **SQL Server Express**:
1. **Definición de Esquema LDD (`01_schema_ddl-v3.sql`)**: Creación de la base de datos, 5 tablas relacionales normalizadas en 3FN (`categorias`, `productos`, `clientes`, `pedidos`, `detalles_pedido`), claves primarias autoincrementables (`IDENTITY(1,1)`), claves foráneas y restricciones (`CHECK`, `UNIQUE`, `NOT NULL`, `DEFAULT`, `ON DELETE CASCADE / NO ACTION`).
2. **Poblado de Datos LMD (`02_data_inserts-v3.sql`)**: Inserción masiva de datos de prueba con control transaccional, directiva `SET IDENTITY_INSERT ON/OFF`, prefijo `N` para cadenas Unicode y fechas en formato ISO 8601.
3. **Consultas y Mantenimiento LMD (`03_queries_dml-v3.sql`)**: Consultas analíticas (`WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`, `INNER JOIN`, `LEFT JOIN`) y pruebas de mantenimiento e integridad referencial (`UPDATE` y `DELETE`).
4. **Script Consolidado (`script_completo_practica_6_2-v3.sql`)**: Ejecución unificada de todo el flujo en una sola sesión de SQL Server.

---

## 🛠️ Requisitos Previos

Antes de ejecutar los scripts, asegúrate de contar con:
- **Microsoft SQL Server Express** (edición 2017, 2019, 2022 o superior).
- **SQL Server Management Studio (SSMS)** o **Azure Data Studio**.
- **Git** instalado en tu sistema local.

---

## 📥 1. Instrucciones para Clonar el Repositorio

Abre tu terminal (Command Prompt, PowerShell o Git Bash) y ejecuta los siguientes comandos:

```bash
# 1. Clonar el repositorio público desde GitHub
git clone <URL_DE_TU_REPOSITORIO_GITHUB>

# 2. Entrar a la carpeta del proyecto
cd base-de-datos-unidad6-area6.2
```

---

## ⚙️ 2. Instrucciones de Ejecución en el SGBD (SQL Server Express)

Puedes ejecutar los scripts utilizando cualquiera de los dos métodos siguientes:

### Método 1: Desde SQL Server Management Studio (SSMS) — Gráfico (Recomendado)

1. Abre **SQL Server Management Studio (SSMS)** y conéctate a tu instancia de SQL Server Express (por ejemplo: `.\SQLEXPRESS` o `localhost`).
2. Abre la base de datos de destino (o utiliza `master` / crea una nueva base de datos llamada `TechStoreDB`).
3. Abre y ejecuta los scripts en el siguiente orden estricto (`Archivo > Abrir > Archivo...` o `Ctrl + O`):
   - **Paso 1:** Abre `01_schema_ddl-v3.sql` y presiona **F5** (o haz clic en **Ejecutar**). Esto creará las 5 tablas y sus restricciones.
   - **Paso 2:** Abre `02_data_inserts-v3.sql` y presiona **F5**. Esto poblará las tablas con los datos de prueba.
   - **Paso 3:** Abre `03_queries_dml-v3.sql` y presiona **F5**. Esto ejecutará las consultas de reporte y las pruebas de mantenimiento.
4. **Opción alternativa unificada:** También puedes abrir únicamente el archivo `script_completo_practica_6_2-v3.sql` y presionar **F5** para ejecutar la creación, inserción y consultas en una sola secuencia.

---

### Método 2: Desde Línea de Comandos (`sqlcmd`)

Si prefieres ejecutar los scripts directamente desde la consola de Windows:

```cmd
:: 1. Crear el esquema LDD
sqlcmd -S .\SQLEXPRESS -E -i 01_schema_ddl-v3.sql

:: 2. Cargar los datos LMD
sqlcmd -S .\SQLEXPRESS -E -i 02_data_inserts-v3.sql

:: 3. Ejecutar consultas y pruebas LMD
sqlcmd -S .\SQLEXPRESS -E -i 03_queries_dml-v3.sql
```

*(Nota: Sustituye `.\SQLEXPRESS` por el nombre específico de tu instancia local en caso de ser diferente).*

---

## 📁 Estructura del Repositorio

```text
├── 01_schema_ddl-v3.sql           # Definición de tablas, PK, FK y restricciones (T-SQL)
├── 02_data_inserts-v3.sql         # Carga de datos de prueba con IDENTITY_INSERT (T-SQL)
├── 03_queries_dml-v3.sql          # Consultas SELECT, JOINs, agregaciones y borrados
├── script_completo_practica_6_2-v3.sql # Script maestro de ejecución completa
└── README.md                       # Documentación y guía de despliegue
```
