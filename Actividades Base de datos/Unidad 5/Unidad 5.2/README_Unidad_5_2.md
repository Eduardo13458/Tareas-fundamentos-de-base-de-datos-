# Unidad 5: Álgebra Relacional
## Actividad 5.2: Resolución de Consultas sobre el Esquema Relacional con Álgebra Formal

---

### 📌 Información Institucional y del Alumno

| Campo | Detalle |
| :--- | :--- |
| **Institución:** | Tecnológico Nacional de México |
| **Materia:** | Fundamentos de Bases de Datos |
| **Unidad:** | Unidad 5 – Lenguajes de Consulta Formales (Álgebra Relacional) |
| **Docente:** | Ruben Miguel Riojas Rodríguez |
| **Alumno:** | Eduardo Salazar Martínez |
| **Repositorio GitHub:** | [Eduardo13458 / Tareas-fundamentos-de-base-de-datos-](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-) |
| **Directorio de la Actividad:** | [`Actividades Base de datos/Unidad 5/Unidad 5.2/`](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/tree/main/Actividades%20Base%20de%20datos/Unidad%205/Unidad%205.2) |
| **Video en YouTube:** | `[https://youtu.be/KH9KWQ0N_2Q]` 
---

## 🗂️ 1. Índice de Archivos de la Actividad 5.2

Los archivos que conforman esta entrega dentro del directorio `Unidad 5.2/` son accesibles mediante enlaces relativos directos y enlaces absolutos a GitHub:

| Archivo | Descripción | Enlace Relativo (Directo) | Enlace Absoluto (GitHub) |
| :--- | :--- | :---: | :---: |
| **`reporte_tarea_5_2_algebra_relacional.pdf`** | Reporte técnico formal en PDF con las 10 consultas, esquemas y tablas intermedias. | [Abrir PDF](./reporte_tarea_5_2_algebra_relacional.pdf) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/blob/main/Actividades%20Base%20de%20datos/Unidad%205/Unidad%205.2/reporte_tarea_5_2_algebra_relacional.pdf) |
| **`reporte_tarea_5_2_algebra_relacional (1).md`** | Reporte técnico en formato Markdown con el catálogo completo de consultas. | [Abrir Markdown](./reporte_tarea_5_2_algebra_relacional%20(1).md) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/blob/main/Actividades%20Base%20de%20datos/Unidad%205/Unidad%205.2/reporte_tarea_5_2_algebra_relacional%20(1).md) |
| **`clinica_consultas_algebra_relacional (2).sql`** | Script SQL compatible con SQL Server (T-SQL) con DDL, DML y las 10 consultas. | [Abrir Script SQL](./clinica_consultas_algebra_relacional%20(2).sql) | [Ver en GitHub](https://github.com/Eduardo13458/Tareas-fundamentos-de-base-de-datos-/blob/main/Actividades%20Base%20de%20datos/Unidad%205/Unidad%205.2/clinica_consultas_algebra_relacional%20(2).sql) |

---

## 🏥 2. Esquema Relacional de Referencia (Clínica Médica Hospitalaria en 3FN)

El diseño del esquema relacional se encuentra normalizado hasta la **Tercera Forma Normal (3FN)**:

```text
PACIENTE (id_paciente [PK], nombre, apellido, fecha_nacimiento, genero, telefono, ciudad)
ESPECIALIDAD (id_especialidad [PK], nombre_especialidad, area_hospital)
MEDICO (id_medico [PK], nombre, apellido, id_especialidad [FK -> ESPECIALIDAD], telefono, salario)
CITA (id_cita [PK], id_paciente [FK -> PACIENTE], id_medico [FK -> MEDICO], fecha, hora, estado, costo)
TRATAMIENTO (id_tratamiento [PK], nombre_tratamiento, costo_tratamiento, duracion_dias)
HISTORIAL_CLINICO (id_historial [PK], id_paciente [FK -> PACIENTE], id_medico [FK -> MEDICO], fecha_diagnostico, diagnostico, id_tratamiento [FK -> TRATAMIENTO])
```

---

## 📋 3. Catálogo de las 10 Consultas Resueltas en Álgebra Relacional y SQL

A continuación se presenta el catálogo formal resuelto, estructurado de menor a mayor complejidad:

### Consulta 1: Selección (Operador Unario $\sigma$)
* **Requerimiento (Lenguaje Natural):** Obtener todos los datos de los pacientes que residen en la ciudad de 'Monterrey'.
* **Álgebra Relacional:**
  $$\sigma_{\text{ciudad} = '\text{Monterrey}'}(\text{PACIENTE})$$
* **Equivalencia en SQL:**
  ```sql
  SELECT * FROM PACIENTE WHERE ciudad = 'Monterrey';
  ```

---

### Consulta 2: Proyección (Operador Unario $\pi$)
* **Requerimiento (Lenguaje Natural):** Obtener el código, nombre, apellido y salario de todos los médicos registrados.
* **Álgebra Relacional:**
  $$\pi_{\text{id\_medico}, \text{nombre}, \text{apellido}, \text{salario}}(\text{MEDICO})$$
* **Equivalencia en SQL:**
  ```sql
  SELECT id_medico, nombre, apellido, salario FROM MEDICO;
  ```

---

### Consulta 3: Selección + Natural Join + Proyección
* **Requerimiento (Lenguaje Natural):** Obtener el nombre y apellido de los pacientes que tienen al menos una cita registrada en estado 'Completada'.
* **Álgebra Relacional:**
  $$\pi_{\text{nombre}, \text{apellido}}\left( \sigma_{\text{estado} = '\text{Completada}'}(\text{CITA}) \bowtie_{\text{CITA.id\_paciente} = \text{PACIENTE.id\_paciente}} \text{PACIENTE} \right)$$
* **Equivalencia en SQL:**
  ```sql
  SELECT DISTINCT p.nombre, p.apellido
  FROM PACIENTE p
  INNER JOIN CITA c ON p.id_paciente = c.id_paciente
  WHERE c.estado = 'Completada';
  ```

---

### Consulta 4: Join Multitabla (4 Relaciones Encadenadas)
* **Requerimiento (Lenguaje Natural):** Obtener la fecha, hora, nombre del paciente, nombre del médico y la especialidad de todas las citas agendadas.
* **Álgebra Relacional:**
  $$\pi_{\text{CITA.fecha}, \text{CITA.hora}, \text{PACIENTE.nombre}, \text{MEDICO.nombre}, \text{ESPECIALIDAD.nombre\_especialidad}}\left( ( (\text{CITA} \bowtie \text{PACIENTE}) \bowtie \text{MEDICO} ) \bowtie \text{ESPECIALIDAD} \right)$$
* **Equivalencia en SQL:**
  ```sql
  SELECT c.fecha, c.hora, 
         p.nombre AS nombre_paciente, 
         m.nombre AS nombre_medico, 
         e.nombre_especialidad
  FROM CITA c
  INNER JOIN PACIENTE p ON c.id_paciente = p.id_paciente
  INNER JOIN MEDICO m ON c.id_medico = m.id_medico
  INNER JOIN ESPECIALIDAD e ON m.id_especialidad = e.id_especialidad;
  ```

---

### Consulta 5: Diferencia Relacional ($-$) con Subconsulta
* **Requerimiento (Lenguaje Natural):** Obtener los pacientes registrados en la clínica que nunca han agendado una cita médica.
* **Álgebra Relacional:**
  $$\pi_{\text{id\_paciente}, \text{nombre}, \text{apellido}}(\text{PACIENTE}) - \pi_{\text{PACIENTE.id\_paciente}, \text{PACIENTE.nombre}, \text{PACIENTE.apellido}}(\text{PACIENTE} \bowtie \text{CITA})$$
* **Equivalencia en SQL:**
  ```sql
  SELECT id_paciente, nombre, apellido
  FROM PACIENTE
  WHERE id_paciente NOT IN (
      SELECT id_paciente 
      FROM CITA
  );
  ```

---

### Consulta 6: Unión Relacional ($\cup$)
* **Requerimiento (Lenguaje Natural):** Generar un directorio unificado de contactos (nombre, apellido y teléfono) de médicos y pacientes.
* **Álgebra Relacional:**
  $$\pi_{\text{nombre}, \text{apellido}, \text{telefono}}(\text{PACIENTE}) \cup \pi_{\text{nombre}, \text{apellido}, \text{telefono}}(\text{MEDICO})$$
* **Equivalencia en SQL:**
  ```sql
  SELECT nombre, apellido, telefono FROM PACIENTE
  UNION
  SELECT nombre, apellido, telefono FROM MEDICO;
  ```

---

### Consulta 7: Proyección Generalizada (Expresiones Aritméticas)
* **Requerimiento (Lenguaje Natural):** Obtener las citas con costo superior a $500 y calcular el costo con 15% de descuento por seguro médico.
* **Álgebra Relacional:**
  $$\pi_{\text{id\_cita}, \text{costo}, \text{costo} \times 0.85 \rightarrow \text{costo\_seguro}}\left( \sigma_{\text{costo} > 500}(\text{CITA}) \right)$$
* **Equivalencia en SQL:**
  ```sql
  SELECT id_cita, costo, (costo * 0.85) AS costo_seguro
  FROM CITA
  WHERE costo > 500;
  ```

---

### Consulta 8: Funciones de Agregación y Agrupamiento ($\mathcal{G}$)
* **Requerimiento (Lenguaje Natural):** Calcular por cada médico el total de ingresos recaudados, el costo promedio por consulta y el total de citas atendidas.
* **Álgebra Relacional:**
  $$_{\text{id\_medico}}\mathcal{G}_{\text{SUM}(\text{costo}) \rightarrow \text{total\_ingresos}, \text{AVG}(\text{costo}) \rightarrow \text{promedio\_consulta}, \text{COUNT}(\text{id\_cita}) \rightarrow \text{total\_citas}}(\text{CITA})$$
* **Equivalencia en SQL:**
  ```sql
  SELECT id_medico,
         SUM(costo) AS total_ingresos,
         AVG(costo) AS promedio_consulta,
         COUNT(id_cita) AS total_citas
  FROM CITA
  GROUP BY id_medico;
  ```

---

### Consulta 9: Left Outer Join ($	ext{ }⟕	ext{ }$)
* **Requerimiento (Lenguaje Natural):** Obtener el listado de todos los médicos y sus citas agendadas, incluyendo aquellos médicos que aún no tienen citas asignadas (`NULL`).
* **Álgebra Relacional:**
  $$\pi_{\text{MEDICO.id\_medico}, \text{MEDICO.nombre}, \text{MEDICO.apellido}, \text{CITA.id\_cita}, \text{CITA.fecha}}\left( \text{MEDICO} \text{ }⟕\text{ }_{\text{MEDICO.id\_medico} = \text{CITA.id\_medico}} \text{CITA} \right)$$
* **Equivalencia en SQL:**
  ```sql
  SELECT m.id_medico, m.nombre, m.apellido, c.id_cita, c.fecha
  FROM MEDICO m
  LEFT OUTER JOIN CITA c ON m.id_medico = c.id_medico;
  ```

---

### Consulta 10: División Relacional ($\div$) con Doble Subconsulta Anidada
* **Requerimiento (Lenguaje Natural):** Obtener el nombre y apellido de los pacientes que se han atendido con **todos** los médicos pertenecientes a la especialidad de 'Cardiología'.
* **Álgebra Relacional:**
  $$S = \pi_{\text{id\_medico}}\left( \text{MEDICO} \bowtie \sigma_{\text{nombre\_especialidad} = '\text{Cardiología}'}(\text{ESPECIALIDAD}) \right)$$
  $$R = \pi_{\text{id\_paciente}, \text{id\_medico}}(\text{CITA})$$
  $$T_{\text{div}} = R \div S$$
  $$T_{\text{final}} = \pi_{\text{nombre}, \text{apellido}}(T_{\text{div}} \bowtie \text{PACIENTE})$$
* **Equivalencia en SQL:**
  ```sql
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
  ```

---

## 🎥 4. Video Explicativo en YouTube (Tarea 5.2)

* **Enlace del Video:** `[Inserta aquí tu enlace público de YouTube]`
* **Requerimientos de la Rúbrica cumplidos:**
  * Grabación pública en el canal oficial del estudiante.
  * Captura de pantalla nítida del entorno de base de datos (SSMS).
  * Exposición y resolución en vivo de al menos tres consultas complejas (**Consulta 4, Consulta 5 y Consulta 10**).
  * Recuadro visible del rostro del estudiante en la esquina inferior derecha durante toda la duración del video.

---

## 📚 5. Referencias Bibliográficas (Formato APA 7.ª ed.)

* Codd, E. F. (1970). A relational model of data for large shared data banks. *Communications of the ACM*, 13(6), 377–387.
* Elmasri, R., & Navathe, S. B. (2017). *Fundamentos de sistemas de bases de datos* (7.ª ed.). Pearson Educación.
* Silberschatz, A., Korth, H. F., & Sudarshan, S. (2014). *Fundamentos de bases de datos* (6.ª ed.). McGraw-Hill Education.
