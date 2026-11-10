# Unidad 6: Lenguaje de Consulta Estructurado (SQL)
## Fundamentos de Bases de Datos — Índice y Portal General de la Unidad 6

---

### 📌 Información Institucional y del Estudiante

| Campo | Detalle |
| :--- | :--- |
| **Institución:** | Tecnológico Nacional de México |
| **Materia:** | Fundamentos de Bases de Datos / Sistemas de Bases de Datos |
| **Unidad:** | Unidad 6 – Lenguaje de Definición y Manipulación de Datos (SQL) |
| **Docente:** | Ruben Miguel Riojas Rodríguez |
| **Alumno:** | Eduardo Salazar Martínez |
| **Repositorio GitHub:** | [Eduardo13458 / Tareas-fundamentos-de-base-de-datos-](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-) |
| **Ubicación del Directorio:** | [`Actividades Base de datos/Unidad 6/`](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/tree/main/Actividades%20Base%20de%20datos/Unidad%206) |

---

## 🎯 1. Propósito y Alcance de la Unidad 6

La **Unidad 6** tiene como propósito el dominio integral del **Lenguaje de Consulta Estructurado (SQL - Structured Query Language)** bajo el estándar ANSI/ISO, abarcando tanto el diseño e implementación de objetos de base de datos como la manipulación, consulta analítica y mantenimiento transaccional de los datos.

La unidad se divide en dos fases progresivas:
1. **Actividad 6.1 (Marco Teórico y Taxonómico):** Clasificación formal, sintaxis, características y diferencias operativas entre los sublenguajes **LDD (Lenguaje de Definición de Datos)** y **LMD (Lenguaje de Manipulación de Datos)**.
2. **Actividad 6.2 (Implementación Práctica en SGBD):** Creación del esquema relacional en 3FN para un comercio electrónico (*TechStore DB*), carga masiva de datos con control de identidad y transacciones, ejecución de consultas analíticas multitabla (JOINs, agrupamientos, agregaciones) y pruebas de integridad referencial en **Microsoft SQL Server Express (T-SQL)**.

---

## 🗂️ 2. Índice Principal de Actividades (Acceso a Carpetas y READMEs)

Utiliza la siguiente tabla para navegar directamente al `README.md` y a los recursos específicos de cada actividad dentro del repositorio (enlaces relativos locales garantizados sin error 404):

| Subunidad / Actividad | Descripción y Contenido | Enlace Relativo Local (Recomendado sin 404) | Enlace Completo (GitHub) |
| :--- | :--- | :---: | :---: |
| **📁 Unidad 6.1** | **Sintaxis y Clasificación de Sentencias SQL (LDD y LMD)**<br>• Taxonomía comparativa LDD vs. LMD<br>• Matriz de diferencias `DROP` vs. `TRUNCATE` vs. `DELETE`<br>• Diagrama taxonómico en Mermaid<br>• Reportes formales en Word y PDF | [📂 Entrar a Carpeta Unidad 6.1](./Unidad%206.1/)<br><br>👉 [**Ver README de Unidad 6.1**](./Unidad%206.1/README_Unidad_6_1.md) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/tree/main/Actividades%20Base%20de%20datos/Unidad%206/Unidad%206.1) |
| **📁 Unidad 6.2** | **Implementación de Script DDL, Carga de Datos y Consultas DML**<br>• Esquema en 3FN de *TechStore DB* (5 tablas)<br>• Scripts modulares DDL, carga DML y consultas en T-SQL<br>• Pruebas de mantenimiento y reglas referenciales (CASCADE/RESTRICT)<br>• Guía de clonación y ejecución en SSMS | [📂 Entrar a Carpeta Unidad 6.2](./Unidad%206.2/)<br><br>👉 [**Ver README de Unidad 6.2**](./Unidad%206.2/README_Unidad_6_2.md) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/tree/main/Actividades%20Base%20de%20datos/Unidad%206/Unidad%206.2) |

---

## 🌳 3. Estructura Jerárquica del Directorio de la Unidad 6

```text
📁 Actividades Base de datos/Unidad 6/
│
├── 📄 README.md                                          <- (Este archivo) Índice general y portal de la Unidad 6.
│
├── 📁 Unidad 6.1/                                        <- Actividad 6.1: Sintaxis y Clasificación LDD y LMD
│   ├── 📄 README_Unidad_6_1.md                           <- Documentación teórica, taxonomía y matriz comparativa.
│   ├── 📑 tarea 6.1Sintaxis y Clasificación de Sentencias SQL (LDD y LMD).pdf  <- Reporte en formato PDF.
│   ├── 📄 tarea 6.1Sintaxis y Clasificación de Sentencias SQL (LDD y LMD) (1).md <- Reporte en Markdown.
│   └── 🎥 Video Explicativo en YouTube                  <- Exposición de sintaxis y comportamiento formal.
│
└── 📁 Unidad 6.2/                                        <- Actividad 6.2: Implementación Práctica en SQL Server
    ├── 📄 README_Unidad_6_2.md                           <- Documentación técnica y catálogo de consultas.
    ├── 📖 README-v2 Clonacion.md                         <- Guía de despliegue y clonación paso a paso.
    ├── 📑 Reporte_Tecnico_SQL_Area_6.2-v2.pdf            <- Reporte técnico formal con capturas y resultados.
    ├── 📄 Reporte_Tecnico_SQL_Area_6.2-v2.md             <- Reporte técnico en formato Markdown.
    ├── 💾 01_schema_ddl.sql                             <- Script LDD: Definición de tablas y restricciones FK.
    ├── 💾 02_data_inserts-v3.sql                         <- Script LMD: Carga transaccional con IDENTITY_INSERT.
    ├── 💾 03_queries_dml-v3.sql                          <- Script LMD: Consultas analíticas y mantenimiento.
    ├── 💾 script_completo_practica_6_2-v3.sql            <- Script consolidado maestro de ejecución unificada.
    └── 🎥 Video Demostrativo en YouTube                 <- Ejecución en vivo en SSMS de consultas y pruebas.
```

---

## 📋 4. Resumen Ejecutivo de las Subunidades

### 🔹 [Actividad 6.1: Sintaxis y Clasificación de Sentencias SQL (LDD y LMD)](./Unidad%206.1/README_Unidad_6_1.md)
* **Objetivo:** Comprender la estructura funcional del lenguaje SQL y clasificar con precisión matemática y operativa los comandos de definición frente a los de manipulación.
* **Aspectos Clave:**
  * **Naturaleza Declarativa y Reglas de Integridad:** Entidad (`PRIMARY KEY`), Dominio (`CHECK`, `NOT NULL`) y Referencial (`FOREIGN KEY`).
  * **Diferenciación Operativa:** LDD actúa sobre la estructura/metadatos con *auto-commit*, mientras que LMD opera sobre las tuplas de contenido con control transaccional (`COMMIT` / `ROLLBACK`).
  * **Análisis Crítico:** Matriz comparativa de desasignación de páginas entre `DROP TABLE`, `TRUNCATE TABLE` y `DELETE FROM`.
* 🔗 [Consultar el README detallado de la Actividad 6.1](./Unidad%206.1/README_Unidad_6_1.md)

---

### 🔹 [Actividad 6.2: Implementación de Script DDL, Carga de Datos y Consultas DML](./Unidad%206.2/README_Unidad_6_2.md)
* **Objetivo:** Desplegar una base de datos relacional funcional en un entorno real de SGBD (**Microsoft SQL Server Express**) con normalización en 3FN.
* **Aspectos Clave:**
  * **Esquema Relacional (*TechStore DB*):** 5 tablas vinculadas (`categorias`, `productos`, `clientes`, `pedidos`, `detalles_pedido`) con columnas calculadas persistentes (`PERSISTED`).
  * **Carga Transaccional:** Control de claves artificiales mediante directivas `SET IDENTITY_INSERT` y cadenas Unicode (`N'...'`).
  * **Consultas Avanzadas:** Filtros condicionales con ordenamiento (`WHERE`, `ORDER BY`), agregaciones agrupadas (`COUNT`, `SUM`, `AVG`, `GROUP BY`), condiciones de grupo (`HAVING`) y reuniones (`INNER JOIN` de 4 tablas y `LEFT JOIN` para clientes sin pedidos).
  * **Reglas de Integridad:** Comprobación práctica de eliminación en cascada (`ON DELETE CASCADE`) y bloqueo de borrado de huérfanos (`ON DELETE NO ACTION / Msg 547`).
* 🔗 [Consultar el README detallado de la Actividad 6.2](./Unidad%206.2/README_Unidad_6_2.md)

---

## 🎥 5. Videos Explicativos en YouTube

De acuerdo con los criterios de evaluación de la rúbrica oficial (videos públicos con captura de pantalla y webcam visible del estudiante en la esquina inferior derecha):

1. **Video Explicativo Actividad 6.1 (Sintaxis y Taxonomía LDD/LMD):**  
   🔗 `[Inserta aquí tu enlace público de YouTube para la Actividad 6.1]`
2. **Video Demostrativo Actividad 6.2 (Despliegue y Ejecución en SSMS):**  
   🔗 `[Inserta aquí tu enlace público de YouTube para la Actividad 6.2]`

---

## 📚 6. Referencias Bibliográficas (Formato APA 7.ª ed.)

* Date, C. J. (2019). *An introduction to database systems* (8.ª ed.). Pearson Education.
* Elmasri, R., & Navathe, S. B. (2021). *Fundamentals of database systems* (7.ª ed.). Pearson.
* ISO/IEC. (2023). *Information technology — Database languages — SQL* (ISO/IEC Standard No. 9075:2023). International Organization for Standardization.
* Microsoft Learn. (2026). *Transact-SQL statements overview - SQL Server*. Microsoft Technical Documentation.
* Silberschatz, A., Korth, H. F., & Sudarshan, S. (2020). *Database system concepts* (7.ª ed.). McGraw-Hill Education.
