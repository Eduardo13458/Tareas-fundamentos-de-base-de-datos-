Tarea 5.2: Álgebra Relacional Aplicada — Sistema de Clínica 



<!-- Start of picture text -->
=o<br>as<br>TECNOLOGICO<br>NACIONAL DE MEXICO<br><!-- End of picture text -->

# **TAREA 5.2: CATÁLOGO DE CONSULTAS EN ÁLGEBRA RELACIONAL FORMAL** 

**Asignatura:** Sistemas de Bases de Datos **Docente** : Ruben Miguel Riojas Rodríguez **Alumno:** Eduardo Salazar Martínez 

Base de Datos | Reporte Técnico Académico — Tarea 5.2 

Tarea 5.2: Álgebra Relacional Aplicada — Sistema de Clínica 

## **1. Contextualización y Esquema Relacional de la Clínica** 

Para la realización de esta actividad, se toma como referencia el proyecto del Sistema de Gestión de Clínica Médica. El esquema relacional está diseñado bajo la Tercera Forma Normal (3FN), garantizando la integridad de entidad, referencial y de dominio. A continuación se presentan las 6 tablas relacionales fundamentales que componen el catálogo de datos del sistema: 

|**Relación (Tabla)**|**Llave Primaria**<br>**(PK)**|**Llaves Foráneas**<br>**(FK)**|**Atributos Adicionales (Dominio)**|
|---|---|---|---|
|PACIENTE|id_paciente|Ninguna|nombre, apellido, fecha_nacimiento,<br>genero, telefono, ciudad|
|MEDICO|id_medico|id_especialidad →<br>ESPECIALIDAD|nombre, apellido, telefono, salario|
|ESPECIALIDAD|id_especialidad|Ninguna|nombre_especialidad, area_hospital|
|CITA|id_cita|id_paciente →<br>PACIENTE<br>id_medico → MEDICO|fecha, hora, estado, costo|
|HISTORIAL_CLINICO|id_historial|id_paciente →<br>PACIENTE<br>id_medico → MEDICO<br>id_tratamiento →<br>TRATAMIENTO|fecha_diagnostico, diagnostico|
|TRATAMIENTO|id_tratamiento|Ninguna|nombre_tratamiento,<br>costo_tratamiento, duracion_dias|



Base de Datos | Reporte Técnico Académico — Tarea 5.2 

Tarea 5.2: Álgebra Relacional Aplicada — Sistema de Clínica 

## **2. Catálogo Formal de 10 Consultas Relacionales (Diferente Complejidad)** 

A continuación se desglosa el catálogo exigido de 10 consultas formales, estructuradas desde complejidad básica (operadores unarios) hasta avanzada (reuniones complejas, agregaciones, outer joins y división relacional). Cada consulta incluye: 

1. Equivalencia estricta en Lenguaje Natural del requerimiento de información. 

2. Expresión matemática formal en Álgebra Relacional. 

3. Desglose detallado paso a paso de las tablas relacionales intermedias ($T_1, T_2, \dots, 

- T_{\text{final}}$). 

4. Ejemplo representativo con tuplas relacionales de entrada y resultado. 

**Consulta 1: Filtro de Pacientes por Ciudad (Complejidad Básica — Selección σ)** 

**Lenguaje Natural:** Obtener todos los datos de los pacientes que residen en la ciudad de 'Monterrey'. 

**Expresión Formal:** σ_{ciudad = 'Monterrey'}(PACIENTE) 

#### **Desglose de Tablas Intermedias:** 

• Paso 1 (Tabla Final T_1): Se aplica el operador unario de Selección σ sobre la relación PACIENTE con el predicado θ = (ciudad = 'Monterrey'). El resultado conserva todos los atributos del esquema original de PACIENTE filtrando únicamente las filas que cumplen la condición de igualdad en el dominio de la ciudad. 

|**id_pacien**<br>**te**|**nombre**|**apellido**|**fecha_nac**|**genero**|**ciudad**|
|---|---|---|---|---|---|
|101|Carlos|Mendoza|1985-04-12|M|Monterrey|
|104|Mariana|Salinas|1992-09-25|F|Monterrey|



Base de Datos | Reporte Técnico Académico — Tarea 5.2 

Tarea 5.2: Álgebra Relacional Aplicada — Sistema de Clínica 

**Consulta 2: Proyección de Directorio de Médicos (Complejidad Básica — Proyección π)** 

**Lenguaje Natural:** Obtener únicamente el código (ID), nombre, apellido y salario de todos los médicos registrados en la clínica. 

**Expresión Formal:** π_{id_medico, nombre, apellido, salario}(MEDICO) 

#### **Desglose de Tablas Intermedias:** 

• Paso 1 (Tabla Final T_1): Se aplica el operador unario de Proyección π sobre la relación MEDICO restringiendo el esquema a los 4 atributos especificados. La operación elimina de manera implícita cualquier tupla duplicada en caso de existir. 

|**id_medico**|**nombre**|**apellido**|**salario ($)**|
|---|---|---|---|
|201|Roberto|Gómez|45,000.00|
|202|Ana|Martínez|52,000.00|
|203|Luis|Hernández|38,500.00|



Base de Datos | Reporte Técnico Académico — Tarea 5.2 

Tarea 5.2: Álgebra Relacional Aplicada — Sistema de Clínica 

**Consulta 3: Pacientes con Citas Completadas (Complejidad Intermedia — Selección + Join + Proyección)** 

**Lenguaje Natural:** Obtener el nombre y apellido de los pacientes que tienen al menos una cita médica registrada en estado 'Completada'. 

**Expresión Formal:** π_{nombre, apellido}( σ_{estado = 'Completada'}(CITA) ⋈ _{CITA.id_paciente = PACIENTE.id_paciente} PACIENTE ) 

#### **Desglose de Tablas Intermedias:** 

- Paso 1 (T_1): T_1 = σ_{estado = 'Completada'}(CITA) → Se filtran las tuplas de la relación CITA cuyo atributo estado es 'Completada'. 

- Paso 2 (T_2): T_2 = T_1 ⋈ PACIENTE → Se realiza una reunión natural/theta join entre T_1 y la relación PACIENTE vinculando la llave foránea id_paciente. 

- Paso 3 (Tabla Final T_final): T_final = π_{nombre, apellido}(T_2) → Se proyectan exclusivamente las columnas de nombre y apellido eliminando duplicados de pacientes con múltiples citas completadas. 

||**nombre**||**apellido**|
|---|---|---|---|
|Carlos||Mendoza||
|Lucía||Fernández||
|Mariana||Salinas||



Base de Datos | Reporte Técnico Académico — Tarea 5.2 

Tarea 5.2: Álgebra Relacional Aplicada — Sistema de Clínica 

### **Consulta 4: Detalle Multitabla de Citas Agendadas (Complejidad Intermedia — Join Multitabla)** 

**Lenguaje Natural:** Obtener la fecha, hora, nombre del paciente, nombre del médico y especialidad médica para todas las citas registradas en la clínica. **Expresión Formal:** π_{CITA.fecha, CITA.hora, PACIENTE.nombre, PACIENTE.apellido, MEDICO.nombre, MEDICO.apellido, ESPECIALIDAD.nombre_especialidad}( ( (CITA ⋈ PACIENTE) ⋈ MEDICO ) ⋈ ESPECIALIDAD ) 

#### **Desglose de Tablas Intermedias:** 

- Paso 1 (T_1): T_1 = CITA ⋈ PACIENTE → Une la información de citas con los datos personales del paciente mediante id_paciente. 

- Paso 2 (T_2): T_2 = T_1 ⋈ MEDICO → Agrega la información del médico asignado a cada cita combinando id_medico. 

- Paso 3 (T_3): T_3 = T_2 ⋈ ESPECIALIDAD → Incorpora la descripción del área médica uniendo id_especialidad. 

- Paso 4 (Tabla Final T_final): Proyección de las columnas requeridas para el reporte administrativo. 

|**Fecha**|**Paciente**|**Médico**|**Especialidad**|**Hora**|
|---|---|---|---|---|
|2026-11-10|Carlos Mendoza|Dr. Roberto Gómez|Cardiología|09:00 AM|
|2026-11-11|Lucía Fernández|Dra. Ana Martínez|Pediatría|11:30 AM|



Base de Datos | Reporte Técnico Académico — Tarea 5.2 

Tarea 5.2: Álgebra Relacional Aplicada — Sistema de Clínica 

**Consulta 5: Pacientes Inactivos sin Citas Registradas (Complejidad Intermedia — Diferencia -)** 

**Lenguaje Natural:** Obtener el código (ID), nombre y apellido de los pacientes que están registrados en el sistema de la clínica pero NUNCA han agendado una cita médica. **Expresión Formal:** π_{id_paciente, nombre, apellido}(PACIENTE) - π_{PACIENTE.id_paciente, PACIENTE.nombre, PACIENTE.apellido}(PACIENTE ⋈ _{PACIENTE.id_paciente = CITA.id_paciente} CITA) 

#### **Desglose de Tablas Intermedias:** 

• Paso 1 (T_1): T_1 = π_{id_paciente, nombre, apellido}(PACIENTE) → Conjunto total de todos los pacientes registrados en la base de datos. 

- Paso 2 (T_2): T_2 = π_{id_paciente, nombre, apellido}(PACIENTE ⋈ CITA) → Conjunto de pacientes que tienen al menos una cita agendada. 

• Paso 3 (Tabla Final T_final): T_final = T_1 - T_2 → Operación de diferencia relacional de conjuntos que retorna únicamente las tuplas presentes en T_1 que no existen en T_2 (pacientes inactivos). 

|**id_paciente**||**nombre**||**apellido**|
|---|---|---|---|---|
|108|Fernando||Torres||
|112|Sofia||Vargas||



Base de Datos | Reporte Técnico Académico — Tarea 5.2 

Tarea 5.2: Álgebra Relacional Aplicada — Sistema de Clínica 

**Consulta 6: Directorio Unificado de Contactos (Complejidad Intermedia — Unión** ∪ **)** 

**Lenguaje Natural:** Generar una lista unificada de contactos de emergencia que incluya nombres, apellidos y números de teléfono tanto de médicos como de pacientes. **Expresión Formal:** π_{nombre, apellido, telefono}(PACIENTE) ∪ π_{nombre, apellido, telefono}(MEDICO) 

#### **Desglose de Tablas Intermedias:** 

- Paso 1 (T_1): T_1 = π_{nombre, apellido, telefono}(PACIENTE) → Proyección del directorio de pacientes (3 atributos). 

- Paso 2 (T_2): T_2 = π_{nombre, apellido, telefono}(MEDICO) → Proyección del directorio de médicos (3 atributos). 

- Paso 3 (Tabla Final T_final): T_final = T_1 ∪ T_2 → Se verifica la compatibilidad de unión (ambos esquemas tienen el mismo grado 3 y dominios compatibles). Combina ambos conjuntos eliminando contactos duplicados. 

||**nombre**|**apellido**||**telefono**|
|---|---|---|---|---|
|Carlos||Mendoza|811-555-0192||
|Roberto||Gómez|811-555-9821||
|Ana||Martínez|811-555-3411||



Base de Datos | Reporte Técnico Académico — Tarea 5.2 

Tarea 5.2: Álgebra Relacional Aplicada — Sistema de Clínica 

**Consulta 7: Cálculo de Costos con Seguro Médico (Álgebra Extendida — Proyección Generalizada)** 

**Lenguaje Natural:** Obtener el código de la cita, el costo original y el costo neto con un descuento del 15% por concepto de seguro de gastos médicos para aquellas citas de especialidad con costo superior a $500. 

**Expresión Formal:** π_{id_cita, costo, costo * 0.85 → costo_seguro}( σ_{costo > 500}(CITA) ) 

#### **Desglose de Tablas Intermedias:** 

• Paso 1 (T_1): T_1 = σ_{costo > 500}(CITA) → Se seleccionan las citas cuyo monto excede el umbral de $500.00. 

• Paso 2 (Tabla Final T_final): T_final = π_{id_cita, costo, costo * 0.85 → costo_seguro}(T_1) → Aplica la proyección generalizada calculando una expresión aritmética en el tercer atributo para generar dinámicamente la columna costo_seguro. 

||**id_cita**|**costo_original ($)**|**costo_seguro (85%) ($)**|
|---|---|---|---|
|501||800.00|680.00|
|504||1,200.00|1,020.00|
|507||650.00|552.50|



Base de Datos | Reporte Técnico Académico — Tarea 5.2 

Tarea 5.2: Álgebra Relacional Aplicada — Sistema de Clínica 

### **Consulta 8: Resumen Estadístico por Médico (Álgebra Extendida — Agregación y Agrupamiento G)** 

**Lenguaje Natural:** Calcular por cada médico el total de ingresos recaudados por sus citas, el costo promedio por consulta y el total de citas atendidas. **Expresión Formal:** _{id_medico} G _{SUM(costo) → total_ingresos, AVG(costo) → promedio_consulta, COUNT(id_cita) → total_citas}(CITA) 

#### **Desglose de Tablas Intermedias:** 

• Paso 1 (T_1): Agrupamiento particionado de la relación CITA utilizando como llave de grupo el atributo id_medico. 

• Paso 2 (Tabla Final T_final): Se aplican simultáneamente sobre cada partición las funciones estadísticas de suma SUM(), promedio AVG() y conteo COUNT(), retornando una fila agregada por cada grupo de médico. 

|**id_medico**|**total_ingresos ($)**|**promedio_consulta ($)**||**total_citas**|
|---|---|---|---|---|
|201|4,500.00|750.00|6||
|202|6,200.00|885.71|7||
|203|2,100.00|525.00|4||



Base de Datos | Reporte Técnico Académico — Tarea 5.2 

Tarea 5.2: Álgebra Relacional Aplicada — Sistema de Clínica 

### **Consulta 9: Auditoría de Médicos sin Citas Asignadas (Álgebra Extendida — Left Outer Join** ⟕ **)** 

**Lenguaje Natural:** Obtener el listado completo de todos los médicos de la plantilla hospitalaria con sus correspondientes citas agendadas, garantizando que aquellos médicos sin citas agendadas aparezcan registrados en la tabla con valores nulos (NULL). **Expresión Formal:** π_{MEDICO.id_medico, MEDICO.nombre, MEDICO.apellido, CITA.id_cita, CITA.fecha}( MEDICO ⟕ _{MEDICO.id_medico = CITA.id_medico} CITA ) 

#### **Desglose de Tablas Intermedias:** 

- Paso 1 (T_1): T_1 = MEDICO ⋈ CITA → Coincidencias exactas entre médicos y citas agendadas. 

- Paso 2 (T_2): T_2 = MEDICO - π_{esquema(MEDICO)}(T_1) → Identificación de las tuplas de la relación izquierda (MEDICO) que no tuvieron match. 

- Paso 3 (T_3): T_3 = T_2 × {(NULL, NULL, ...)} → Relleno con valores nulos para los atributos faltantes de CITA. 

- Paso 4 (Tabla Final T_final): T_final = T_1 ∪ T_3 → Conserva la totalidad de tuplas de la relación izquierda. 

|**id_medico**|**nombre**|**apellido**|**id_cita**|**fecha**|
|---|---|---|---|---|
|201|Roberto|Gómez|501|2026-11-10|
|202|Ana|Martínez|502|2026-11-11|
|205|Javier|Ríos|NULL|NULL|



Base de Datos | Reporte Técnico Académico — Tarea 5.2 

Tarea 5.2: Álgebra Relacional Aplicada — Sistema de Clínica 

### **Consulta 10: Pacientes Frecuentes Universales por Especialidad (Complejidad Avanzada — División ÷)** 

**Lenguaje Natural:** Obtener el nombre y apellido de los pacientes que se han atendido en citas médicas con TODOS los médicos pertenecientes a la especialidad de 'Cardiología'. **Expresión Formal:** S = π_{id_medico}( MEDICO ⋈ σ_{nombre_especialidad = 'Cardiología'}(ESPECIALIDAD) ) R = π_{id_paciente, id_medico}( CITA ) T_div = R ÷ S T_final = π_{nombre, apellido}( T_div ⋈ PACIENTE ) 

#### **Desglose de Tablas Intermedias:** 

• Paso 1 (Conjunto Divisor S): S = π_{id_medico}(MEDICO ⋈ σ_{nombre_especialidad = 'Cardiología'}(ESPECIALIDAD)) → Obtiene los IDs de todos los cardiólogos registrados (ejemplo: {201, 204}). 

• Paso 2 (Relación Dividendo R): R = π_{id_paciente, id_medico}(CITA) → Par ordenado de atención (paciente, médico). 

• Paso 3 (Resultado División T_div): T_div = R ÷ S = π_{id_paciente}(R) - π_{id_paciente}( (π_{id_paciente}(R) × S) - R ) → Filtra y selecciona únicamente los id_paciente que están asociados con TODAS las tuplas del conjunto S. 

• Paso 4 (Tabla Final T_final): T_final = π_{nombre, apellido}(T_div ⋈ PACIENTE) → Proyección final del nombre y apellido de los pacientes universales. 

**nombre apellido** 

Carlos Mendoza 

Base de Datos | Reporte Técnico Académico — Tarea 5.2 

Tarea 5.2: Álgebra Relacional Aplicada — Sistema de Clínica 

## **3. Referencias Bibliográficas (Formato APA 7.ª ed.)** 

- Codd, E. F. (1970). A relational model of data for large shared data banks. Communications of the ACM, 13(6), 377–387. 

- Elmasri, R., & Navathe, S. B. (2017). Fundamentos de sistemas de bases de datos (7.ª ed.). Pearson Educación. 

- Silberschatz, A., Korth, H. F., & Sudarshan, S. (2014). Fundamentos de bases de datos (6.ª ed.). McGraw-Hill Education. 

Base de Datos | Reporte Técnico Académico — Tarea 5.2 

