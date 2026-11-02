**CLÍNICA SALUD TOTAL - REPORTE TÉCNICO E-R / EER** 

**PÁGINA 1** 

### **LICENCIATURA EN INFORMÁTICA** 

NACIONAL DE MEXICO 

# **REPORTE TÉCNICO: MODELADO CONCEPTUAL E-R Y E-R EXTENDIDO** 

**Asignatura:** Sistemas de Bases de Datos **Docente** : Ruben Miguel Riojas Rodríguez **Alumno:** Eduardo Salazar Martínez 

Materia: Bases de Datos | Unidad 2 

Documentación Técnica de Ingeniería 

**CLÍNICA SALUD TOTAL - REPORTE TÉCNICO E-R / EER** 

**PÁGINA 2** 

# **REPORTE TÉCNICO: MODELADO CONCEPTUAL** 

## **1. Planteamiento del Problema y Descripción Contextual** 

La institución médica **'Salud Total'** es un centro de atención ambulatoria y especializada que enfrenta ineficiencias operativas debido a la fragmentación de sus registros clínicos y administrativos. La coexistencia de expedientes físicos y hojas de cálculo independientes genera duplicidad de registros, dificultad para rastrear el historial de consultas de los pacientes, traslape en la agenda de citas de los médicos y falta de control estricto sobre los medicamentos prescritos. 

Para resolver esta problemática, se diseñó un modelo de base de datos relacional centralizado fundamentado en el **Modelo Entidad-Relación Extendido (EER)** . Este diseño permite consolidar la información de pacientes, personal médico, departamentos, agendas de citas, diagnósticos de consulta y emisión de recetas en un esquema estructurado que garantiza la integridad referencial, elimina redundancias y optimiza la toma de decisiones operativas. 

## **2. Reglas de Negocio Formales (RN)** 

- **RN-01 (Jerarquía de Personas):** Toda persona registrada en el sistema es clasificada de forma obligatoria y disjunta como Paciente o Médico. Cada persona posee un identificador único (ID_Persona), nombre completo, dirección de residencia, fecha de nacimiento y uno o más teléfonos de contacto. 

- **RN-02 (Expedientes de Pacientes):** Cada paciente cuenta con un número de expediente único y su tipo de sangre. La edad del paciente se calcula dinámicamente a partir de su fecha de nacimiento. 

- **RN-03 (Acreditación Médica):** Cada médico posee una cédula profesional única, fecha de contratación y puede acreditar una o varias especialidades médicas. 

- **RN-04 (Estructura Departamental):** La clínica se organiza en departamentos médicos. Un departamento alberga uno o varios médicos; cada médico pertenece obligatoriamente a un único departamento. 

- **RN-05 (Programación de Citas):** Un paciente puede solicitar múltiples citas a lo largo del tiempo, y un médico atiende múltiples citas. Cada cita almacena un folio único, fecha, hora y estado (Programada, Completada, Cancelada). 

- **RN-06 (Agregación - Consulta Médica):** La atención efectiva derivada de una cita entre un paciente y un médico constituye la Consulta Médica, de la cual se registra el diagnóstico y costo base. 

- **RN-07 (Emisión de Recetas):** A partir de una consulta médica se emite una o más recetas médicas identificadas por folio de receta y fecha de emisión. 

- **RN-08 (Prescripción de Medicamentos):** Una receta incluye uno o varios medicamentos. Para cada medicamento recetado se especifican dosis, frecuencia y duración en días del tratamiento. 

Materia: Bases de Datos | Unidad 2 

Documentación Técnica de Ingeniería 

**CLÍNICA SALUD TOTAL - REPORTE TÉCNICO E-R / EER** 

**PÁGINA 3** 

## **3. Identificación de Componentes del Modelo E-R** 

|**Entidad**|**Clave Primaria**<br>**(PK)**|**Atributos Simples**|**Atributo Compuesto**|**Atributo**<br>**Derivado**|**Atributo**<br>**Multivalorado**|
|---|---|---|---|---|---|
|Persona (Super)|ID_Persona|Fecha_Nacimiento|Nombre_Completo,<br>Dirección|Edad (calculado)|Teléfono|
|Paciente (Sub)|Num_Expediente|Tipo_Sangre|Heredados de Persona|Heredados de<br>Persona|Heredados de<br>Persona|
|Médico (Sub)|Num_Cédula|Fecha_Contratación|Heredados de Persona|Heredados de<br>Persona|Especialidad|
|Departamento|ID_Depto|Nombre_Depto, Ubicación|N/A|N/A|N/A|
|Cita|Folio_Cita|Fecha, Hora, Estado|N/A|N/A|N/A|
|Consulta|ID_Consulta|Diagnóstico, Costo_Base|N/A|N/A|N/A|
|Receta|Folio_Receta|Fecha_Emisión|N/A|N/A|N/A|
|Medicamento|Código_Med|Nombre_Comercial, Fórmula|N/A|N/A|N/A|



## **4. Aplicación del Modelo E-R Extendido (EER)** 

**A. Jerarquía de Especialización / Generalización:** Se definió la superclase PERSONA y las subclases PACIENTE y MÉDICO. Se aplica una restricción de **Disyunción (d)** porque una instancia no puede ser médico y paciente al mismo tiempo, y una restricción de **Completitud Total (t)** ya que toda persona debe pertenecer obligatoriamente a una de las dos subclases. 

**B. Abstracción por Agregación:** La relación entre PACIENTE, MÉDICO y CITA genera el hecho abstracto CONSULTA MÉDICA, conectando directamente la atención con la emisión de RECETAS mediante la relación (1:N) Prescribe, evitando relaciones ternarias complejas. 

Materia: Bases de Datos | Unidad 2 

Documentación Técnica de Ingeniería 

**CLÍNICA SALUD TOTAL - REPORTE TÉCNICO E-R / EER** 

**PÁGINA 4** 

## **5. Diagramas Formales del Modelo E-R y EER** 

**Figura 1.** Diagrama Entidad-Relación Completo del Sistema Clínica Salud Total. 
```mermaid
---
config:
  layout: dagre
---
flowchart TB
    E_PERSONA["PERSONA"] --- A_ID_PERS(["ID_Persona (PK)"])
    E_PACIENTE["PACIENTE"] --- A_EXP(["Num_Expediente (PK)"])
    E_MEDICO["MÉDICO"] --- A_CEDULA(["Num_Cédula (PK)"])
    E_DEPTO["DEPARTAMENTO"] --- A_ID_DEPTO(["ID_Depto (PK)"])
    E_CITA["CITA"] --- A_FOLIO_CITA(["Folio_Cita (PK)"])
    E_CONSULTA["CONSULTA"] --- A_ID_CONSULTA(["ID_Consulta (PK)"])
    E_RECETA["RECETA"] --- A_FOLIO_RECETA(["Folio_Receta (PK)"])
    E_MEDICAMENTO["MEDICAMENTO"] --- A_COD_MED(["Código_Med (PK)"])
    R_CONTIENE{"Contiene"} --- A_DOSIS(["Dosis"]) & A_FREC(["Frecuencia"]) & A_DURACION(["Duración_Días"])
    E_PERSONA -- 1 --- R_ES1{"Es"} & R_ES2{"Es"}
    R_ES1 -- 1 --- E_PACIENTE
    R_ES2 -- 1 --- E_MEDICO
    E_DEPTO -- 1 --- R_ALBERGA{"Alberga"}
    R_ALBERGA -- N --- E_MEDICO
    E_PACIENTE -- 1 --- R_SOLICITA{"Solicita"}
    R_SOLICITA -- N --- E_CITA
    E_MEDICO -- 1 --- R_ATIENDE{"Atiende"}
    R_ATIENDE -- N --- E_CITA
    E_CITA -- 1 --- R_ORIGINA{"Origina"}
    R_ORIGINA -- 1 --- E_CONSULTA
    E_CONSULTA -- 1 --- R_PRESCRIBE{"Prescribe"}
    R_PRESCRIBE -- N --- E_RECETA
    E_RECETA -- M --- R_CONTIENE
    R_CONTIENE -- N --- E_MEDICAMENTO
```




**CLÍNICA SALUD TOTAL - REPORTE TÉCNICO E-R / EER** 

**PÁGINA 5** 

**Figura 2.** Detalle del Modelo E-R Extendido: Jerarquía Persona y Agregación Consulta. 
```mermaid
erDiagram
    %% SUPERCLASE Y SUBCLASES (Especialización Disjunta y Total (d, t))
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
        string Telefono_Multivalorado
    }

    PACIENTE {
        string Num_Expediente PK
        int ID_Persona FK
        string Tipo_Sangre
    }

    MEDICO {
        string Num_Cedula PK
        int ID_Persona FK
        date Fecha_Contratacion
        string Especialidad_Multivalorado
        int ID_Depto FK
    }

    DEPARTAMENTO {
        int ID_Depto PK
        string Nombre_Depto
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
        int Folio_Cita FK
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
        int Folio_Receta PK_FK
        int Codigo_Med PK_FK
        string Dosis
        string Frecuencia
        int Duracion_Dias
    }

    %% JERARQUÍA EER: ESPECIALIZACIÓN DISJUNTA Y TOTAL (d, t)
    PERSONA ||--o| PACIENTE : "es_subclase (d, t)"
    PERSONA ||--o| MEDICO : "es_subclase (d, t)"

    %% RELACIONES DEL MODELO EER
    DEPARTAMENTO ||--|{ MEDICO : "alberga (1:N)"
    PACIENTE ||--|{ CITA : "solicita (1:N)"
    MEDICO ||--|{ CITA : "atiende (1:N)"

    %% ABSTRACCIÓN POR AGREGACIÓN (CONSULTA = CITA entre PACIENTE y MÉDICO)
    CITA ||--|| CONSULTA : "origina_agregacion (1:1)"
    CONSULTA ||--|{ RECETA : "prescribe (1:N)"
    
    %% RELACIÓN M:N RESOLVIENDO ATRIBUTOS DE PRESCRIPCIÓN
    RECETA ||--|{ RECETA_MEDICAMENTO : "incluye"
    MEDICAMENTO ||--|{ RECETA_MEDICAMENTO : "prescrito_en"

```





Materia: Bases de Datos | Unidad 2 

Documentación Técnica de Ingeniería 

**CLÍNICA SALUD TOTAL - REPORTE TÉCNICO E-R / EER** 

**PÁGINA 6** 

## **6. Diccionario de Datos Completo del Sistema** 

El diccionario de datos especifica la estructura física, tipos de datos, longitudes, restricciones de integridad y descripción semántica de las tablas derivadas del modelo relacional: 

**Tabla 1: PERSONA (Superclase de Entidad)** 

|**Nombre Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|ID_Persona|INT|4 bytes|NO|PK|AUTO_INCREMENT > 0|Identificador único de la<br>persona.|
|Primer_Nombre|VARCHAR|50|NO|Ninguna|Sin números ni símbolos|Primer nombre de la<br>persona.|
|Apellido_Paterno|VARCHAR|50|NO|Ninguna|Texto alfabético|Primer apellido de la<br>persona.|
|Apellido_Materno|VARCHAR|50|SÍ|Ninguna|Texto alfabético|Segundo apellido de la<br>persona.|
|Calle|VARCHAR|100|NO|Ninguna|Dirección física|Nombre de la calle de<br>residencia.|
|Numero|VARCHAR|20|NO|Ninguna|Alfanumérico|Número exterior e interior.|
|Colonia|VARCHAR|100|NO|Ninguna|Texto|Colonia o fraccionamiento.|
|Codigo_Postal|VARCHAR|10|NO|Ninguna|Formato postal local|Código postal de<br>residencia.|
|Fecha_Nacimiento|DATE|3 bytes|NO|Ninguna|CHECK (Fecha < Actual)|Fecha de nacimiento.|
|Edad_Derivado|INT|4 bytes|SÍ|Derivado|Calculado dinámicamente|Edad en años a la fecha<br>actual.|



**Tabla 2: PERSONA_TELEFONO (Atributo Multivalorado)** 

|**Nombre Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|ID_Persona|INT|4 bytes|NO|PK / FK|FK -><br>PERSONA(ID_Persona)|Identificador de la<br>persona.|
|Telefono|VARCHAR|15|NO|PK|Dígitos de contacto|Número telefónico de<br>contacto.|
|**Tabla 3: PACIE**<br>**Nombre Campo**|**NTE (Subcla**<br>**Tipo Dato**|**se de PER**<br>**Longitud**|**SONA)**<br>**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|Num_Expediente|VARCHAR|20|NO|PK|Formato 'EXP-YYYY-XXXX'|Número único de<br>expediente clínico.|
|ID_Persona|INT|4 bytes|NO|FK / UNQ|FK -><br>PERSONA(ID_Persona)|Vínculo con la superclase<br>persona.|
|Tipo_Sangre|VARCHAR|5|NO|Ninguna|CHECK in<br>('A+','A-','O+','O-',...)|Grupo sanguíneo y factor<br>Rh.|



**Tabla 3: PACIENTE (Subclase de PERSONA)** 

Materia: Bases de Datos | Unidad 2 

Documentación Técnica de Ingeniería 

**CLÍNICA SALUD TOTAL - REPORTE TÉCNICO E-R / EER** 

**PÁGINA 7** 

**Tabla 4: MEDICO (Subclase de PERSONA)** 

|**Nombre Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|Num_Cedula|VARCHAR|20|NO|PK|Cédula profesional|Cédula profesional del<br>médico.|
|**Nombre Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|ID_Persona|INT|4 bytes|NO|FK / UNQ|FK -><br>PERSONA(ID_Persona)|Vínculo con la superclase<br>persona.|
|Fecha_Contratacion|DATE|3 bytes|NO|Ninguna|CHECK (Fecha <= Actual)|Fecha de ingreso a la<br>clínica.|
|ID_Depto|INT|4 bytes|NO|FK|FK -> DEPARTAMENTO(ID_<br>Depto)|Departamento al que<br>pertenece.|



**Tabla 5: MEDICO_ESPECIALIDAD (Atributo Multivalorado)** 

|**Nombre Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|Num_Cedula|VARCHAR|20|NO|PK / FK|FK -><br>MEDICO(Num_Cedula)|Cédula profesional del<br>médico.|
|Especialidad|VARCHAR|50|NO|PK|Texto académico|Nombre de la especialidad<br>acreditada.|



**Tabla 6: DEPARTAMENTO** 

|**Nombre Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|ID_Depto|INT|4 bytes|NO|PK|AUTO_INCREMENT|Identificador del<br>departamento.|
|Nombre_Depto|VARCHAR|100|NO|UNIQUE|Texto único|Nombre del departamento<br>clínico.|
|Ubicacion|VARCHAR|100|SÍ|Ninguna|Texto libre|Piso o ala dentro de la<br>clínica.|



**Tabla 7: CITA** 

|**Nombre Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|Folio_Cita|INT|4 bytes|NO|PK|AUTO_INCREMENT|Folio único de la cita<br>médica.|
|Fecha|DATE|3 bytes|NO|Ninguna|Fecha programada|Día asignado para la<br>consulta.|
|Hora|TIME|3 bytes|NO|Ninguna|Horario laboral|Hora programada para la<br>cita.|
|Estado|VARCHAR|20|NO|Ninguna|DEFAULT 'Programada'|Estado (Programada/Com<br>pletada/Cancelada).|
|Num_Expediente|VARCHAR|20|NO|FK|FK -> PACIENTE(Num_Expe<br>diente)|Paciente que solicita la<br>cita.|
|Num_Cedula|VARCHAR|20|NO|FK|FK -><br>MEDICO(Num_Cedula)|Médico asignado para la<br>cita.|



Materia: Bases de Datos | Unidad 2 

Documentación Técnica de Ingeniería 

**CLÍNICA SALUD TOTAL - REPORTE TÉCNICO E-R / EER** 

**PÁGINA 8** 

**Tabla 8: CONSULTA (Agregación)** 

|**Nombre Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|ID_Consulta|INT|4 bytes|NO|PK|AUTO_INCREMENT|Identificador de la<br>consulta médica.|
|Folio_Cita|INT|4 bytes|NO|FK / UNQ|FK -> CITA(Folio_Cita)|Cita que origina la<br>consulta.|
|Diagnostico|TEXT|Variable|NO|Ninguna|Min. 10 caracteres|Diagnóstico clínico<br>detallado.|
|**Nombre Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|Costo_Base|DECIMAL|10,2|NO|Ninguna|CHECK (Costo_Base >= 0)|Costo financiero de la<br>consulta.|



#### **Tabla 9: RECETA** 

|**Nombre Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|Folio_Receta|INT|4 bytes|NO|PK|AUTO_INCREMENT|Folio único de la receta<br>médica.|
|ID_Consulta|INT|4 bytes|NO|FK|FK -><br>CONSULTA(ID_Consulta)|Consulta donde se emite<br>la receta.|
|Fecha_Emision|DATE|3 bytes|NO|Ninguna|DEFAULT CURRENT_DATE|Fecha de emisión de la<br>receta.|



#### **Tabla 10: MEDICAMENTO** 

|**Nombre Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|Codigo_Med|INT|4 bytes|NO|PK|AUTO_INCREMENT|Código interno del<br>medicamento.|
|Nombre_Comercial|VARCHAR|100|NO|Ninguna|Texto comercial|Nombre de marca del<br>medicamento.|
|Formula|VARCHAR|200|NO|Ninguna|Sustancia activa|Composición química o<br>fórmula.|



**Tabla 11: RECETA_MEDICAMENTO (Relación M:N)** 

|**Nombre Campo**|**Tipo Dato**|**Longitud**|**Nulo**|**Clave**|**Restricciones / Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|Folio_Receta|INT|4 bytes|NO|PK / FK|FK -><br>RECETA(Folio_Receta)|Receta que incluye el<br>medicamento.|
|Codigo_Med|INT|4 bytes|NO|PK / FK|FK -> MEDICAMENTO(Codi<br>go_Med)|Medicamento prescrito.|
|Dosis|VARCHAR|100|NO|Ninguna|Ej. '500 mg'|Cantidad por toma<br>prescrita.|
|Frecuencia|VARCHAR|100|NO|Ninguna|Ej. 'Cada 8 horas'|Intervalo de<br>administración.|
|Duracion_Dias|INT|4 bytes|NO|Ninguna|CHECK (Duracion_Dias > 0)|Días totales del<br>tratamiento.|



Materia: Bases de Datos | Unidad 2 

Documentación Técnica de Ingeniería 

**CLÍNICA SALUD TOTAL - REPORTE TÉCNICO E-R / EER** 

**PÁGINA 9** 

## **7. Justificación Técnica del Diseño** 

El diseño del modelo conceptual y diccionario de datos responde a criterios estrictos de ingeniería de bases de datos: 1. **Normalización Inicial (1FN):** Los atributos multivalorados (Teléfonos y Especialidades) se descompusieron en tablas satélite subordinadas, eliminando grupos repetitivos dentro de las entidades principales. 2. **Mantenibilidad de la Jerarquía:** La especialización de Persona consolida atributos comunes en una sola entidad, evitando duplicar nombres y direcciones en tablas independientes para médicos y pacientes. 

3. **Integridad de Prescripción:** La abstracción de Consulta mediante agregación garantiza que las recetas se emitan únicamente en el marco de una atención médica confirmada, asegurando trazabilidad legal y clínica. 

Materia: Bases de Datos | Unidad 2 

Documentación Técnica de Ingeniería 

**CLÍNICA SALUD TOTAL - REPORTE TÉCNICO E-R / EER** 

**PÁGINA 10** 

## **8. Referencias Bibliográficas (Formato APA 7.ª Edición)** 

- **Coronel, C., & Morris, S.** (2019). _Database Systems: Design, Implementation, & Management_ (13th ed.). Cengage Learning. 

- **Date, C. J.** (2004). _An Introduction to Database Systems_ (8th ed.). Pearson Addison-Wesley. 

- **Elmasri, R., & Navathe, S. B.** (2017). _Fundamentos de sistemas de bases de datos_ (7.ª ed.). Pearson Educación. 

- **Object Management Group.** (2017). _Unified Modeling Language (UML) Specification_ (Version 2.5.1). OMG. 

- **Silberschatz, A., Korth, H. F., & Sudarshan, S.** (2014). _Fundamentos de bases de datos_ (6.ª ed.). McGraw-Hill Education. 

Materia: Bases de Datos | Unidad 2 

Documentación Técnica de Ingeniería 

