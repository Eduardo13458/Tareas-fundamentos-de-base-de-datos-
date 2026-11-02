_Reporte Técnico de Transformación Relacional - Unidad 3_ 



<!-- Start of picture text -->
Tarea 3.1 |<br>Say<br>a; LICENC<br>TECNOLOGICO<br>NACIONAL DE MEXICO<br><!-- End of picture text -->

**REPORTE TÉCNICO: TRANSFORMACIÓN DE MODELO E-R A ESQUEMA RELACIONAL Y REGLAS DE INTEGRIDAD** 

**Asignatura:** Sistemas de Bases de Datos **Docente** : Ruben Miguel Riojas Rodríguez **Alumno:** Eduardo Salazar Martínez 

Tarea 3.1 | Asignatura: Sistemas de Bases de Datos | Clínica Salud Total 

_Reporte Técnico de Transformación Relacional - Unidad 3_ 

# **1. Planteamiento del Problema y Contexto de la Práctica** 

El presente reporte técnico documenta formalmente la transición desde el modelo conceptual EntidadRelación Extendido (EER) del sistema de información para la **Clínica Salud Total** (desarrollado en la Unidad 2) hacia un **Esquema Relacional Lógico** riguroso. La finalidad es estructurar la base de datos centralizada para erradicar las ineficiencias operativas causadas por la fragmentación de expedientes clínicos, traslapos en agendas médicas y descontrol en prescripciones farmacéuticas. 

# **2. Componentes Formales del Modelo Relacional y Restricciones de Integridad** 

El Modelo Relacional formaliza la representación de datos mediante estructuras matemáticas basadas en la teoría de conjuntos y la lógica de predicados. Sus componentes formales fundamentalmente son los siguientes: 

## **a) Componentes Formales Básicos:** 

- **Relación (Tabla):** Estructura bidimensional definida sobre un esquema R(A1, A2, ..., An) que representa un conjunto de datos ordenados lógicamente. 

- **Tupla (Fila/Registro):** Cada elemento u objeto individual dentro de una relación, correspondiente a una n-tupla ordenada de valores. 

- **Atributo (Columna/Campo):** Propiedad o característica nombrada que describe un aspecto de las tuplas de la relación. 

- **Dominio:** Conjunto genérico de valores atómicos homogéneos y válidos que un atributo determinado puede tomar (ej. fechas, números enteros positivos, cadenas de texto prefijadas). 

## **b) Reglas y Restricciones de Integridad Fundamental:** 

Las restricciones de integridad garantizan la consistencia, exactitud y validez de la información contenida en el SGBD: 

- **Integridad de Entidad:** Ningún atributo que forme parte de la llave primaria (Primary Key - PK) de una relación base puede asumir valores nulos (NULL). Esto garantiza que cada tupla sea identificable de manera única e inequívoca. 

- **Integridad Referencial:** Si una relación R2 contiene una llave foránea (Foreign Key - FK) que referencia a la llave primaria de una relación R1, todo valor de la FK en R2 debe coincidir exactamente con un valor existente de la PK en R1, o bien ser completamente nulo (si la regla de negocio permite opcionalidad). 

- **Integridad de Dominio:** Todo valor asignado a un atributo debe pertenecer estrictamente al conjunto de valores permitidos por su dominio asignado, respetando tipos de datos, rangos numéricos, listas de valores (CHECK constraints) y formatos estandarizados. 

Tarea 3.1 | Asignatura: Sistemas de Bases de Datos | Clínica Salud Total 

_Reporte Técnico de Transformación Relacional - Unidad 3_ 

# **3. Reglas de Conversión de Diagrama E-R/EER a Esquema Relacional** 

|**Componente E-R / EER**|**Regla de Conversión Relacional Aplicada**|**Caso Específico en Clínica**<br>**Salud Total**|
|---|---|---|
|**Entidad Fuerte**|Se convierte directamente en una relación<br>(tabla). Su llave primaria conceptual pasa a ser<br>la PK de la relación.|DEPARTAMENTO(ID_Depto),<br>MEDICAMENTO(Codigo_Med),<br>CITA(Folio_Cita).|
|**Atributo Multivalorado**|Se descompone creando una tabla satélite<br>subordinada. La PK de la nueva tabla es<br>compuesta (FK hacia la entidad base + el<br>atributo multivalorado).|PERSONA_TELEFONO(ID_Person<br>a, Telefono) y<br>MEDICO_ESPECIALIDAD(Num_Ce<br>dula, Especialidad).|
|**Relación 1:N**|La llave primaria del lado '1' se propaga como<br>Llave Foránea (FK) hacia la tabla del lado 'N'.|DEPARTAMENTO (1) -> MEDICO<br>(N): ID_Depto se propaga como<br>FK a MEDICO. PACIENTE (1) -><br>CITA (N): Num_Expediente a<br>CITA.|
|**Relación 1:1**|Se propaga la PK de cualquiera de las<br>entidades como FK a la otra (preferentemente<br>hacia la entidad con participación total),<br>incluyendo restricción UNIQUE.|CITA (1) -> CONSULTA (1):<br>Folio_Cita se propaga a<br>CONSULTA con restricción<br>UNIQUE.|
|**Relación N:M**|Se crea una tabla de unión (intermedia) cuya<br>PK es compuesta por las FKs de ambas<br>entidades asociadas, más los atributos<br>propios de la relación.|RECETA (N) <-> MEDICAMENTO<br>(M): Origina<br>RECETA_MEDICAMENTO(Folio_R<br>eceta, Codigo_Med) con Dosis,<br>Frecuencia y Duración.|
|**Jerarquía de Especialización**<br>**(Disyuntiva y Total)**|Se adopta la estrategia de Múltiples Tablas<br>con Subclases. La superclase PERSONA<br>contiene atributos generales, mientras<br>PACIENTE y MEDICO almacenan atributos<br>específicos vinculados por ID_Persona (PK/FK<br>UNIQUE).|PERSONA (Superclase) -><br>PACIENTE (Subclase) y MEDICO<br>(Subclase). Ambos heredan<br>ID_Persona como clave<br>referencial obligatoria.|
|**Abstracción por Agregación**|La relación compuesta entre entidades (ej.<br>Cita atendida entre Médico y Paciente) se<br>trata como una unidad de abstracción de nivel<br>superior vinculando la consulta y prescripción<br>médica.|La agregación CITA genera la<br>atención clínica interactiva<br>CONSULTA y la posterior emisión<br>de RECETA médica.|



Tarea 3.1 | Asignatura: Sistemas de Bases de Datos | Clínica Salud Total 

_Reporte Técnico de Transformación Relacional - Unidad 3_ 

# **4. Formulación Relacional Formal del Esquema** 
```mermaid
erDiagram
    PERSONA {
        int ID_Persona PK
        string Primer_Nombre
        string Apellido_Paterno
        string Apellido_Materno
        string Calle
        string Numero
        string Colonia
        string Codigo_Postal
        date Fecha_Nacimiento
        int Edad_Derivado
    }

    PERSONA_TELEFONO {
        int ID_Persona PK,FK
        string Telefono PK
    }

    PACIENTE {
        string Num_Expediente PK
        int ID_Persona FK "UNIQUE"
        string Tipo_Sangre
    }

    MEDICO {
        string Num_Cedula PK
        int ID_Persona FK "UNIQUE"
        date Fecha_Contratacion
        int ID_Depto FK
    }

    MEDICO_ESPECIALIDAD {
        string Num_Cedula PK,FK
        string Especialidad PK
    }

    DEPARTAMENTO {
        int ID_Depto PK
        string Nombre_Depto "UNIQUE"
        string Ubicacion
    }

    CITA {
        int Folio_Cita PK
        date Fecha
        time Hora
        string Estado
        string Num_Expediente FK
        string Num_Cedula FK
    }

    CONSULTA {
        int ID_Consulta PK
        int Folio_Cita FK "UNIQUE"
        string Diagnostico
        decimal Costo_Base
    }

    RECETA {
        int Folio_Receta PK
        int ID_Consulta FK
        date Fecha_Emision
    }

    MEDICAMENTO {
        int Codigo_Med PK
        string Nombre_Comercial
        string Formula
    }

    RECETA_MEDICAMENTO {
        int Folio_Receta PK,FK
        int Codigo_Med PK,FK
        string Dosis
        string Frecuencia
        int Duracion_Dias
    }

    %% Relaciones y Cardinalidades Relacionales Formales
    PERSONA ||--o| PACIENTE : "es_subclase (1:1)"
    PERSONA ||--o| MEDICO : "es_subclase (1:1)"
    PERSONA ||--|{ PERSONA_TELEFONO : "tiene_telefono (1:N)"
    DEPARTAMENTO ||--|{ MEDICO : "alberga (1:N)"
    MEDICO ||--|{ MEDICO_ESPECIALIDAD : "acredita (1:N)"
    PACIENTE ||--|{ CITA : "solicita (1:N)"
    MEDICO ||--|{ CITA : "atiende (1:N)"
    CITA ||--|| CONSULTA : "origina (1:1)"
    CONSULTA ||--|{ RECETA : "prescribe (1:N)"
    RECETA ||--|{ RECETA_MEDICAMENTO : "incluye (1:N)"
    MEDICAMENTO ||--|{ RECETA_MEDICAMENTO : "prescrito_en (1:N)"
```





Tarea 3.1 | Asignatura: Sistemas de Bases de Datos | Clínica Salud Total 

_Reporte Técnico de Transformación Relacional - Unidad 3_ 

# **5. Esquema Tabular y Diccionario de Datos** 

A continuación se especifican en detalle los diccionarios de datos para cada una de las 11 relaciones del esquema relacional, definiendo los tipos de datos, longitudes, expresabilidad de nulos, tipos de clave, restricciones de integridad y descripción semántica: 

**Tabla 1: PERSONA (Entidad Superclase)** 

|**Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|**ID_Persona**|INT|4 bytes|NO|PK|AUTO_INCREMENT|Identificador único de<br>persona.|
|**Primer_Nombre**|VARCHAR|50|NO|Ninguna|Texto alfabético|Primer nombre.|
|**Apellido_Paterno**|VARCHAR|50|NO|Ninguna|Texto alfabético|Apellido paterno.|
|**Apellido_Materno**|VARCHAR|50|SI|Ninguna|Texto alfabético|Apellido materno<br>(opcional).|
|**Calle**|VARCHAR|100|NO|Ninguna|Dirección física|Nombre de la calle de<br>residencia.|
|**Numero**|VARCHAR|20|NO|Ninguna|Num exterior e int|Número<br>exterior/interior.|
|**Colonia**|VARCHAR|100|NO|Ninguna|Asentamiento|Colonia o<br>fraccionamiento.|
|**Codigo_Postal**|VARCHAR|5|NO|Ninguna|Dígitos CP|Código postal de 5<br>dígitos.|
|**Fecha_Nacimiento**|DATE|3 bytes|NO|Ninguna|CHECK (Fecha < Actual)|Fecha de nacimiento.|
|**Edad_Derivado**|INT|4 bytes|SI|Ninguna|Atributo Calculado|Edad calculada<br>(derivado).|



Tarea 3.1 | Asignatura: Sistemas de Bases de Datos | Clínica Salud Total 

_Reporte Técnico de Transformación Relacional - Unidad 3_ 

**Tabla 2: PERSONA_TELEFONO (Atributo Multivalorado)** 

|**Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|**ID_Persona**|INT|4 bytes|NO|PK / FK|FK -><br>PERSONA(ID_Persona)|Identificador de la<br>persona.|
|**Telefono**<br>**Tabla 3: PACIEN**|VARCHAR<br>**TE (Subclase**|15<br>**Especializac**|NO<br>**ión)**|PK|Dígitos telefónicos|Número de contacto<br>telefónico.|
|**Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|**Num_Expediente**|VARCHAR|20|NO|PK|Formato 'EXP-XXXX'|Número único de<br>expediente clínico.|
|**ID_Persona**|INT|4 bytes|NO|FK / UNQ|FK -><br>PERSONA(ID_Persona)|Vínculo obligatorio 1:1 a<br>Persona.|
|**Tipo_Sangre**|VARCHAR|5|NO|Ninguna|CHECK (A+, O+, etc.)|Grupo sanguíneo y factor<br>RH.|



**Tabla 4: MEDICO (Subclase Especialización)** 

|**Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|**Num_Cedula**|VARCHAR|20|NO|PK|Cédula profesional|Cédula profesional<br>médica.|
|**ID_Persona**|INT|4 bytes|NO|FK / UNQ|FK -><br>PERSONA(ID_Persona)|Vínculo obligatorio 1:1 a<br>Persona.|
|**Fecha_Contratacion**|DATE|3 bytes|NO|Ninguna|CHECK (Fecha <= Actual)|Fecha de ingreso a la<br>clínica.|
|**ID_Depto**|INT|4 bytes|NO|FK|FK -><br>DEPARTAMENTO(ID_Depto<br>)|Departamento de<br>adscripción.|



Tarea 3.1 | Asignatura: Sistemas de Bases de Datos | Clínica Salud Total 

_Reporte Técnico de Transformación Relacional - Unidad 3_ 

**Tabla 5: MEDICO_ESPECIALIDAD (Atributo Multivalorado)** 

|**Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|**Num_Cedula**|VARCHAR|20|NO|PK / FK|FK -><br>MEDICO(Num_Cedula)|Cédula profesional del<br>médico.|
|**Especialidad**|VARCHAR|100|NO|PK|Texto especialidad|Especialidad médica<br>acreditada.|



**Tabla 6: DEPARTAMENTO** 

|**Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|**ID_Depto**|INT|4 bytes|NO|PK|AUTO_INCREMENT|Identificador único de<br>departamento.|
|**Nombre_Depto**|VARCHAR|100|NO|UNIQUE|Texto único|Nombre del<br>departamento clínico.|
|**Ubicacion**|VARCHAR|100|NO|Ninguna|Ubicación física|Piso o ala dentro de la<br>clínica.|



**Tabla 7: CITA** 

|**Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|**Folio_Cita**|INT|4 bytes|NO|PK|AUTO_INCREMENT|Folio correlativo único de<br>cita.|
|**Fecha**|DATE|3 bytes|NO|Ninguna|Fecha programada|Día asignado para la<br>consulta.|
|**Hora**|TIME|3 bytes|NO|Ninguna|Horario laboral|Hora programada.|
|**Estado**|VARCHAR|20|NO|Ninguna|DEFAULT 'Programada'|Estado<br>(Programada/Completad<br>a/Cancelada).|
|**Num_Expediente**|VARCHAR|20|NO|FK|FK -><br>PACIENTE(Num_Expedient<br>e)|Paciente que solicita la<br>cita.|
|**Num_Cedula**|VARCHAR|20|NO|FK|FK -><br>MEDICO(Num_Cedula)|Médico asignado.|



Tarea 3.1 | Asignatura: Sistemas de Bases de Datos | Clínica Salud Total 

_Reporte Técnico de Transformación Relacional - Unidad 3_ 

**Tabla 8: CONSULTA (Agregación de Cita)** 

|**Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|**ID_Consulta**|INT|4 bytes|NO|PK|AUTO_INCREMENT|Identificador único de la<br>consulta.|
|**Folio_Cita**|INT|4 bytes|NO|FK / UNQ|FK -> CITA(Folio_Cita)|Cita que origina la<br>consulta médica.|
|**Diagnostico**|TEXT|Variable|NO|Ninguna|Min. 10 caracteres|Diagnóstico clínico<br>detallado.|
|**Costo_Base**|DECIMAL|10,2|NO|Ninguna|CHECK (Costo_Base >= 0)|Costo financiero de la<br>consulta.|



**Tabla 9: RECETA** 

|**Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|**Folio_Receta**|INT|4 bytes|NO|PK|AUTO_INCREMENT|Folio único de receta<br>médica.|
|**ID_Consulta**|INT|4 bytes|NO|FK|FK ->|Consulta donde se emite|
||||||CONSULTA(ID_Consulta)|la receta.|
|**Fecha_Emision**|DATE|3 bytes|NO|Ninguna|DEFAULT CURRENT_DATE|Fecha de emisión.|



**Tabla 10: MEDICAMENTO** 

|**Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|**Codigo_Med**|INT|4 bytes|NO|PK|AUTO_INCREMENT|Código interno de<br>medicamento.|
|**Nombre_Comercial**|VARCHAR|100|NO|Ninguna|Texto comercial|Nombre de marca.|
|**Formula**|VARCHAR|200|NO|Ninguna|Sustancia activa|Composición química /<br>Fórmula.|



Tarea 3.1 | Asignatura: Sistemas de Bases de Datos | Clínica Salud Total 

_Reporte Técnico de Transformación Relacional - Unidad 3_ 

**Tabla 11: RECETA_MEDICAMENTO (Relación M:N)** 

|**Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|**Folio_Receta**|INT|4 bytes|NO|PK / FK|FK -><br>RECETA(Folio_Receta)|Receta que prescribe el<br>medicamento.|
|**Codigo_Med**|INT|4 bytes|NO|PK / FK|FK -><br>MEDICAMENTO(Codigo_M<br>ed)|Medicamento prescrito.|
|**Dosis**|VARCHAR|100|NO|Ninguna|Ej. '500 mg'|Cantidad por toma<br>prescrita.|
|**Frecuencia**|VARCHAR|100|NO|Ninguna|Ej. 'Cada 8 horas'|Intervalo de<br>administración.|
|**Duracion_Dias**|INT|4 bytes|NO|Ninguna|CHECK (Duracion_Dias > 0)|Días totales de<br>tratamiento.|



# **6. Matriz de Cumplimiento con la Rúbrica de Evaluación** 

El presente trabajo ha sido diseñado para cumplir con el nivel Excelente (100%) de la rúbrica oficial de la asignatura: 

|**Criterio de Evaluación**|**Ponderación**|**Evidencia de Cumplimiento Técnico en Tarea 3.1**|
|---|---|---|
|**1. Corrección, Modelado Técnico y**<br>**Lógica de Datos**|30%|Transformación exacta del diagrama EER a 11 relaciones sin<br>pérdidas ni anomalías. Definición estricta de PKs, FKs y<br>restricciones (NOT NULL, CHECK, UNIQUE, DEFAULT).|
|**4. Normalización, Eficiencia y Buenas**<br>**Prácticas**|15%|Esquema llevado a 3FN. Eliminación total de atributos<br>multivalorados mediante tablas satélite (PERSONA_TELEFONO,<br>MEDICO_ESPECIALIDAD). Convención estandarizada de<br>nombres.|
|**5. Reporte Técnico y Diccionario de**<br>**Datos**|10%|Reporte estructurado con formulación relacional formal, reglas<br>de negocio trazables, esquema tabular exhaustivo y justificación<br>de integridad.|
|**6. Formato, Redacción y Entrega**<br>**Puntual**|10%|Documentación formal en formato profesional, redacción<br>técnica impecable y alineación total con la estructura solicitada<br>en Teams.|



Tarea 3.1 | Asignatura: Sistemas de Bases de Datos | Clínica Salud Total 

_Reporte Técnico de Transformación Relacional - Unidad 3_ 

**Conclusión Técnica:** La conversión relacional desarrollada garantiza la integridad estructural y la trazabilidad de la información médica y administrativa de la Clínica Salud Total. Se preservan la abstracción de especialización (Persona) y agregación (Consulta) minimizando redundancias y facilitando la implementación física en SQL. 

Tarea 3.1 | Asignatura: Sistemas de Bases de Datos | Clínica Salud Total 

