# Unidad 5: Álgebra Relacional
## Fundamentos de Bases de Datos — Índice y Portal General de la Unidad

---

### 📌 Información Institucional y del Estudiante

| Campo | Detalle |
| :--- | :--- |
| **Institución:** | Tecnológico Nacional de México |
| **Materia:** | Fundamentos de Bases de Datos |
| **Unidad:** | Unidad 5 – Lenguajes de Consulta Formales (Álgebra Relacional) |
| **Docente:** | Ruben Miguel Riojas Rodríguez |
| **Alumno:** | Eduardo Salazar Martínez |
| **Repositorio GitHub:** | [Eduardo13458 / Tareas-fundamentos-de-base-de-datos-](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-) |
| **Ubicación del Directorio:** | [`Actividades Base de datos/Unidad 5/`](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/tree/main/Actividades%20Base%20de%20datos/Unidad%205) |

---

## 🎯 1. Propósito y Alcance de la Unidad 5

La **Unidad 5** aborda los fundamentos matemáticos y procedimentales de los **Lenguajes de Consulta Formales**, centrando su estudio en el **Álgebra Relacional**. 

El álgebra relacional provee la base teórica formal mediante la cual se procesan, analizan y optimizan las consultas relacionales en los motores de bases de datos antes de ser ejecutadas mediante lenguajes declarativos como **SQL**.

Esta unidad se estructura en dos actividades clave:
1. **Actividad 5.1:** Dominio conceptual, notación formal matemática y modelado estructural de operadores fundamentales, derivados y extendidos mediante mapas conceptuales interactivos.
2. **Actividad 5.2:** Aplicación práctica y resolución formal de consultas sobre el esquema hospitalario normalizado en 3FN con su correspondiente traducción a SQL estandarizado.

---

## 🗂️ 2. Índice Principal de Actividades (Acceso a Carpetas y READMEs)

Utiliza la siguiente tabla para navegar directamente al `README.md` y a los recursos específicos de cada actividad dentro del repositorio:

| Carpeta de Actividad | Descripción y Contenido | Enlace Relativo Local (Recomendado sin 404) | Enlace Completo (GitHub) |
| :--- | :--- | :---: | :---: |
| **📁 Unidad 5.1** | **Operadores Fundamentales y Extendidos del Álgebra Relacional**<br>• Notación formal ($\sigma, \pi, \times, \cup, \cap, -, \div, \bowtie, \mathcal{G}$)<br>• Mapa conceptual vectorial en Mermaid<br>• Reportes en Word y PDF | [📂 Entrar a Carpeta Unidad 5.1](./Unidad%205.1/)<br><br>👉 [**Ver README de Unidad 5.1**](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/blob/main/Actividades%20Base%20de%20datos/Unidad%205/Unidad%205.1/README-v2%20(1).md) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/tree/main/Actividades%20Base%20de%20datos/Unidad%205/Unidad%205.1) |
| **📁 Unidad 5.2** | **Resolución de Consultas sobre el Esquema Relacional con Álgebra Formal**<br>• Esquema en 3FN de la Clínica Médica<br>• Catálogo de 10 consultas resueltas paso a paso<br>• Script `.sql` compatible con SQL Server / ANSI SQL | [📂 Entrar a Carpeta Unidad 5.2](./Unidad%205.2/)<br><br>👉 [**Ver README de Unidad 5.2**](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/blob/main/Actividades%20Base%20de%20datos/Unidad%205/Unidad%205.2/README_Unidad_5_2.md) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/tree/main/Actividades%20Base%20de%20datos/Unidad%205/Unidad%205.2) |

---

## 🌳 3. Estructura Jerárquica del Directorio de la Unidad

```text
📁 Actividades Base de datos/Unidad 5/
│
├── 📄 README.md                                          <- (Este archivo) Índice general y guía de navegación de la Unidad 5.
│
├── 📁 Unidad 5.1/                                        <- Carpeta de la Actividad 5.1
│   ├── 📄 README.md                                      <- Documentación detallada, marco teórico y mapa en Mermaid.
│   ├── 📑 reporte_tarea_5_1_algebra_relacional.docx      <- Reporte técnico en Word editable.
│   ├── 📑 reporte_tarea_5_1_algebra_relacional_v2.pdf    <- Reporte final en PDF con ejemplos prácticos.
│   ├── 📊 mapa_conceptual_mermaid.txt                   <- Código fuente en texto plano para diagramación Mermaid.
│   └── 🎥 Video en YouTube                              <- Exposición pública (notación formal y cámara en esquina inferior).
│
└── 📁 Unidad 5.2/                                        <- Carpeta de la Actividad 5.2
    ├── 📄 README.md                                      <- Documentación detallada y catálogo de las 10 consultas resueltas.
    ├── 📑 reporte_tarea_5_2_algebra_relacional.pdf       <- Reporte técnico en PDF con esquemas, pasos y tablas intermedias.
    ├── 📑 reporte_tarea_5_2_algebra_relacional (1).md    <- Catálogo de consultas en formato Markdown.
    ├── 💾 clinica_consultas_algebra_relacional (2).sql   <- Script de base de datos para SQL Server (DDL, DML y Consultas).
    └── 🎥 Video en YouTube                              <- Demostración en vivo en SSMS de consultas complejas.
```

---

## 📋 4. Resumen Ejecutivo de las Actividades

### 🔹 [Actividad 5.1: Operadores Fundamentales y Extendidos](./Unidad%205.1/README.md)
* **Objetivo:** Definir y comprender formalmente el catálogo de operaciones relacionales.
* **Aspectos Clave:**
  * **Operadores Unarios:** Selección ($\sigma$) como filtro horizontal de tuplas y Proyección ($\pi$) como filtro vertical de atributos.
  * **Operadores Binarios y Derivados:** Producto Cartesiano ($\times$), operaciones de conjuntos con compatibilidad de unión ($\cup, \cap, -$), Reunión o Join ($\bowtie$) y División relacional ($\div$).
  * **Álgebra Extendida:** Proyecciones generalizadas con cálculos aritméticos, Funciones de agregación ($\mathcal{G}$) y Reuniones externas (Outer Joins) para preservar tuplas mediante valores `NULL`.
* 🔗 [Consultar el README detallado de la Actividad 5.1](./Unidad%205.1/README.md)

---

### 🔹 [Actividad 5.2: Resolución de Consultas sobre Esquema Relacional](./Unidad%205.2/README.md)
* **Objetivo:** Plantear y resolver formalmente requerimientos de información sobre una base de datos normalizada.
* **Aspectos Clave:**
  * **Esquema Relacional en 3FN:** Caso de estudio de una Clínica Médica Hospitalaria (`PACIENTE`, `MEDICO`, `ESPECIALIDAD`, `CITA`, `HISTORIAL_CLINICO`, `TRATAMIENTO`).
  * **Catálogo de 10 Consultas:** Desglose paso a paso de tablas intermedias ($T_1, T_2, \dots, T_{\text{final}}$) abarcando desde consultas unarias simples hasta Joins de 4 relaciones, agrupamientos y división relacional mediante subconsultas anidadas correlacionadas (`NOT EXISTS`).
  * **Script SQL:** Código estructurado en T-SQL con separadores de lotes (`GO`) probado para SQL Server Management Studio (SSMS).
* 🔗 [Consultar el README detallado de la Actividad 5.2](./Unidad%205.2/README.md)

---

## 🎥 5. Videos Explicativos en YouTube

De acuerdo con los criterios oficiales de la rúbrica de evaluación (videos en modo público con captura de pantalla y cámara web del alumno en la esquina inferior derecha):

1. **Video Explicativo Actividad 5.1 (Sintaxis Formal y Operadores):**  
   🔗 `[Inserta aquí tu enlace público de YouTube para la Tarea 5.1]`
2. **Video Demostrativo Actividad 5.2 (Resolución de Consultas Complejas en SSMS):**  
   🔗 `[Inserta aquí tu enlace público de YouTube para la Tarea 5.2]`

---

## 📚 6. Referencias Bibliográficas (Formato APA 7.ª ed.)

* Codd, E. F. (1970). A relational model of data for large shared data banks. *Communications of the ACM*, 13(6), 377–387.
* Elmasri, R., & Navathe, S. B. (2017). *Fundamentos de sistemas de bases de datos* (7.ª ed.). Pearson Educación.
* Silberschatz, A., Korth, H. F., & Sudarshan, S. (2014). *Fundamentos de bases de datos* (6.ª ed.). McGraw-Hill Education.
