Tarea 4.1: Fundamentos de Normalización | Bases de Datos 



<!-- Start of picture text -->
=n<br>as<br><!-- End of picture text -->

TECNOLOGICO **Tarea 3.1 |** NACIONAL DE MEXICO 

# **Tarea 4.1: Fundamentos de Dependencias y Mapa Conceptual de Formas Normales** 

**Asignatura:** Sistemas de Bases de Datos **Docente** : Ruben Miguel Riojas Rodríguez **Alumno:** Eduardo Salazar Martínez 

Documento Técnico de Normalización de Bases de Datos Relacionales 

Tarea 4.1: Fundamentos de Normalización | Bases de Datos 

## **1. Introducción al Diseño Relacional y Normalización** 

La normalización de bases de datos relacionales es una disciplina formal introducida originalmente por Edgar F. Codd. Su objetivo primordial es estructurar los esquemas de tablas para eliminar la redundancia de información, evitar anomalías operacionales y asegurar que cada hecho de datos se almacene en un único lugar lógico. Este proceso garantiza la integridad referencial y optimiza el rendimiento general del sistema gestor de bases de datos (SGBD). 

## **2. Concepto Formal de Normalización** 

Formalmente, la normalización es una técnica de análisis relacional que aplica un conjunto de reglas (denominadas **Formas Normales** ) a un esquema de relación. El proceso descompone relaciones complejas o mal diseñadas en relaciones más pequeñas y bien estructuradas sin pérdida de información. Cumple con dos propiedades matemáticas fundamentales: 

- **Descomposición sin pérdida de unión (Lossless Join Decomposition):** Garantiza que al descomponer una tabla R en R1 y R2, la operación de natural join de R1 y R2 recupere exactamente el contenido original de R sin generar tuplas espurias. 

- **Preservación de dependencias (Dependency Preservation):** Asegura que todas las dependencias funcionales definidas sobre R puedan ser verificadas únicamente examinando las subrelaciones individuales, sin necesidad de realizar uniones costosas entre tablas. 

## **3. Clasificación de Dependencias Funcionales (DF)** 

Una dependencia funcional es una restricción entre dos conjuntos de atributos en una relación. Se denota como **X → Y** , lo cual significa que si dos tuplas coinciden en el valor del atributo X (determinante), obligatoriamente deben coincidir en el valor del atributo Y (dependiente). 

### **3.1 Dependencia Funcional Completa** 

Ocurre cuando un atributo no clave depende funcionalmente de la **totalidad** de una clave primaria compuesta, y no de ninguno de sus subconjuntos propios. Formalmente, dada la clave primaria X = {A, B}, la dependencia X → C es completa si ni A → C ni B → C son válidas por sí solas. 

### **3.2 Dependencia Funcional Parcial** 

Se presenta cuando un atributo no clave depende únicamente de un **subconjunto propio** de una clave primaria compuesta. Por ejemplo, en una clave compuesta {ID_Estudiante, ID_Curso}, si el atributo Nombre_Estudiante depende solo de ID_Estudiante, existe una dependencia parcial que viola la Segunda Forma Normal (2FN). 

Documento Técnico de Normalización de Bases de Datos Relacionales 

Tarea 4.1: Fundamentos de Normalización | Bases de Datos 

### **3.3 Dependencia Funcional Transitiva** 

Ocurre cuando un atributo no clave depende de otro atributo que tampoco es clave, formando una cadena de dependencias **X → Y → Z** , donde X es la clave primaria, Y no es superclave y Z es un atributo dependiente no clave. Esta dependencia viola la Tercera Forma Normal (3FN). 

## **4. Anomalías Clásicas en Esquemas No Normalizados** 

El diseño defectuoso de esquemas relacionales introduce anomalías que degradan la consistencia de los datos y complican el desarrollo de aplicaciones: 

### **4.1 Anomalía de Inserción** 

Se produce cuando no es posible registrar cierta información válida en la base de datos sin obligar a ingresar datos no disponibles o inventados en la clave primaria o en atributos requeridos. Ejemplo: No poder registrar un nuevo curso académico hasta que al menos un estudiante se inscriba en él. 

### **4.2 Anomalía de Borrado** 

Ocurre cuando la eliminación de una tupla provoca la pérdida involuntaria e irreversible de otra información esencial. Ejemplo: Al dar de baja al único estudiante inscrito en un curso, se elimina automáticamente toda la existencia del curso en el sistema. 

### **4.3 Anomalía de Modificación (Actualización)** 

Se genera cuando la actualización de un dato duplicado en una fila no se propaga a todas las demás filas donde se repite. Esto ocasiona inconsistencia en la base de datos, donde la misma entidad muestra valores contradictorios (por ejemplo, dos direcciones distintas para el mismo proveedor). 

## **5. Desarrollo Teórico de las Formas Normales con Ejemplos Prácticos** 

### **5.1 Primera Forma Normal (1FN)** 

**Reglas:** Todos los atributos de la tabla deben contener únicamente valores atómicos (indivisibles). Se deben eliminar grupos de valores repetidos y definir una clave primaria única. 

**Ejemplo 1FN:** Tabla Incompleta: Estudiante(ID, Nombre, Teléfonos ['555-1234', '555-5678']) Tabla 1FN: Estudiante_Teléfono(ID_Estudiante, Teléfono) con clave primaria compuesta {ID_Estudiante, Teléfono}. 

Documento Técnico de Normalización de Bases de Datos Relacionales 

Tarea 4.1: Fundamentos de Normalización | Bases de Datos 

### **5.2 Segunda Forma Normal (2FN)** 

**Reglas:** Estar en 1FN y garantizar que todos los atributos no clave dependan funcionalmente de la clave primaria completa, eliminando todas las dependencias parciales. 

**Ejemplo 2FN:** Tabla Incompleta: Inscripción(ID_Alumno, ID_Curso, Nombre_Alumno, Calificación) donde Nombre_Alumno depende solo de ID_Alumno. 

Solución 2FN: Separar en Alumno(ID_Alumno, Nombre_Alumno) e Inscripción(ID_Alumno, ID_Curso, Calificación). 

### **5.3 Tercera Forma Normal (3FN)** 

**Reglas:** Estar en 2FN y eliminar las dependencias transitivas. Ningún atributo no clave debe depender de otro atributo no clave. 

**Ejemplo 3FN:** Tabla Incompleta: Empleado(ID_Emp, Nombre, ID_Depto, Nombre_Depto) donde Nombre_Depto depende de ID_Depto (no clave). 

Solución 3FN: Separar en Departamento(ID_Depto, Nombre_Depto) y Empleado(ID_Emp, Nombre, ID_Depto). 

### **5.4 Forma Normal de Boyce-Codd (FNBC)** 

**Reglas:** Es una extensión más estricta de la 3FN. Requiere que para toda dependencia funcional X → Y no trivial, X debe ser una superclave. 

**Ejemplo FNBC:** Caso de estudio: Asignación(Alumno, Asignatura, Profesor) donde Profesor → Asignatura pero {Alumno, Asignatura} es clave. Como Profesor no es superclave, viola FNBC. Solución: Profesor_Asignatura(Profesor, Asignatura) y Alumno_Profesor(Alumno, Profesor). 

### **5.5 Cuarta Forma Normal (4FN)** 

**Reglas:** Estar en FNBC y eliminar las dependencias multivaluadas (DMV, X →→ Y) independientes, descomponiendo tablas donde un atributo determina múltiples valores independientes de otros atributos. 

Documento Técnico de Normalización de Bases de Datos Relacionales 

Tarea 4.1: Fundamentos de Normalización | Bases de Datos 

**Ejemplo 4FN:** Tabla Incompleta: Profesor(ID_Prof, Libro_Texto, Deporte) donde un profesor usa varios libros y practica varios deportes de forma independiente. 

Solución 4FN: Profesor_Libros(ID_Prof, Libro) y Profesor_Deportes(ID_Prof, Deporte). 

### **5.6 Quinta Forma Normal (5FN / PJ/NF)** 

**Reglas:** Estar en 4FN y eliminar dependencias de unión (Join Dependencies). Asegura que la relación no pueda ser reconstruida a partir de proyecciones más pequeñas a menos que sus claves lo permitan sin generar combinaciones irreales. 

**Ejemplo 5FN:** Solución 5FN: Descomposición en tres relaciones n-arias donde la combinación ProveedorPieza-Proyecto solo se reconstruye correctamente si se imponen restricciones de proyección cruzada triples. 

## **6. Matriz Sintética de Reglas de Transición y Mapa Conceptual en Mermaid** 

La siguiente matriz resume los requisitos de entrada y la condición de eliminación de dependencias para cada etapa de normalización: 

|**Forma Normal**|**Requisito Previo**|**Dependencia / Anomalia Eliminada**|**Criterio de Validación**|
|---|---|---|---|
|**1FN**|Esquema relacional|Valores no atómicos y grupos repetidos|Cada celda contiene un único valor<br>escalar.|
|**2FN**|Estar en 1FN|Dependencias parciales|Todos los atributos dependen de la<br>clave primaria completa.|
|**3FN**|Estar en 2FN|Dependencias transitivas (X → Y → Z)|Atributos no clave dependen<br>únicamente de la clave primaria.|
|**FNBC**|Estar en 3FN|Determinantes no clave (X → Y)|Todo determinante X es<br>necesariamente superclave.|
|**4FN**|Estar en FNBC|Dependencias multivaluadas (X →→ Y)|Elimina combinaciones<br>multivaluadas independientes.|
|**5FN**|Estar en 4FN|Dependencias de unión (Join<br>Dependencies)|Garantiza<br>descomposición/reconstrucción sin<br>pérdida.|



Documento Técnico de Normalización de Bases de Datos Relacionales 

Tarea 4.1: Fundamentos de Normalización | Bases de Datos 

### **6.1 Mapa Conceptual** 

```mermaid
graph TD
    %% Nodos Principales
    A[Normalización de Bases de Datos Relacionales]

    %% Fundamentos
    B[Conceptos Fundamentales]
    B1[Objetivo: Eliminar Redundancia e Inconsistencia]
    B2[Dependencias Funcionales - DF]
    B3[Anomalías Clásicas]

    %% Dependencias
    D1[DF Completa: Atributo depende de TODA la clave primaria compuesta]
    D2[DF Parcial: Atributo depende de una parte de la clave compuesta]
    D3[DF Transitiva: Atributo no clave depende de otro no clave X -> Y -> Z]

    %% Anomalías
    AN1[Inserción: Imposible añadir registros sin clave requerida]
    AN2[Borrado: Pérdida involuntaria de datos no relacionados]
    AN3[Modificación: Datos inconsistentes por actualización parcial]

    %% Formas Normales
    C[Formas Normales - Reglas de Transición]

    F1[1FN: Primera Forma Normal]
    R1[Valores atómicos por celda]
    R2[Eliminar grupos repetidos]
    R3[Definir Clave Primaria única]

    F2[2FN: Segunda Forma Normal]
    R4[Estar en 1FN]
    R5[Eliminar Dependencias Parciales]
    R6[Atributos no clave dependen de la clave primaria completa]

    F3[3FN: Tercera Forma Normal]
    R7[Estar en 2FN]
    R8[Eliminar Dependencias Transitivas]
    R9[Ningún atributo no clave depende de otro atributo no clave]

    FBC[FNBC: Boyce-Codd Normal Form]
    R10[Versión más estricta de 3FN]
    R11[Toda determinante X -> Y debe ser Superclave]

    F4[Cuarta Forma Normal - 4FN]
    R12[Estar en FNBC / 3FN]
    R13[Eliminar Dependencias Multivaluadas Independientes X ->-> Y]

    F5[Quinta Forma Normal - 5FN / PJ-NF]
    R14[Estar en 4FN]
    R15[Eliminar Dependencias de Unión Join Dependencies]
    R16[Garantizar descomposición/reconstrucción sin pérdida]

    %% Relaciones
    A --> B
    B --> B1
    B --> B2
    B --> B3

    B2 --> D1
    B2 --> D2
    B2 --> D3

    B3 --> AN1
    B3 --> AN2
    B3 --> AN3

    A --> C

    C --> F1
    F1 --> R1
    F1 --> R2
    F1 --> R3

    F1 --> F2
    F2 --> R4
    F2 --> R5
    F2 --> R6

    F2 --> F3
    F3 --> R7
    F3 --> R8
    F3 --> R9

    F3 --> FBC
    FBC --> R10
    FBC --> R11

    FBC --> F4
    F4 --> R12
    F4 --> R13

    F4 --> F5
    F5 --> R14
    F5 --> R15
    F5 --> R16

    %% Definición de Estilos (ClassDef)
    classDef root fill:#1f77b4,stroke:#0f3854,stroke-width:2px,color:#fff,font-weight:bold;
    classDef section fill:#2ca02c,stroke:#155015,stroke-width:2px,color:#fff,font-weight:bold;
    classDef fn fill:#ff7f0e,stroke:#994c08,stroke-width:2px,color:#fff,font-weight:bold;
    classDef rule fill:#f7f7f7,stroke:#cccccc,stroke-width:1px,color:#333;
    classDef anomaly fill:#d62728,stroke:#6b1314,stroke-width:1px,color:#fff;

    %% Asignación explícita de Clases
    class A root;
    class B,C section;
    class F1,F2,F3,FBC,F4,F5 fn;
    class B1,B2,D1,D2,D3,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,R16 rule;
    class B3,AN1,AN2,AN3 anomaly;

```


Documento Técnico de Normalización de Bases de Datos Relacionales 

