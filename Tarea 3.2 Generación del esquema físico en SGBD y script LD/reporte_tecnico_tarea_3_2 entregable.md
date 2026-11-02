Sistemas de Bases de Datos — Tarea 3.2 | Clínica Salud Total 



<!-- Start of picture text -->
=n<br>as<br><!-- End of picture text -->

NACIONAL DE MEXICO. **Tarea 3.1 |** 

# **REPORTE TÉCNICO: GENERACIÓN DEL ESQUEMA FÍSICO EN SGBD Y SCRIPT LDD (SQL)** 

**Asignatura:** Sistemas de Bases de Datos **Docente** : Ruben Miguel Riojas Rodríguez **Alumno:** Eduardo Salazar Martínez 

Página 1 

Sistemas de Bases de Datos — Tarea 3.2 | Clínica Salud Total 

## **1. Planteamiento del Problema y Objetivos de la Práctica 3.2** 

El presente reporte técnico documenta formalmente el desarrollo, la construcción e implementación física del esquema de base de datos relacional para el sistema de información de la **Clínica Salud Total** . La práctica se enfoca en traducir el modelo relacional lógico previamente diseñado en la Tarea 3.1 a un esquema físico completamente operativo en el Sistema Gestor de Bases de Datos (SGBD) **Microsoft SQL Server Express (T-SQL)** , mediante la extracción y validación de un script formal de Lenguaje de Definición de Datos (LDD/DDL). 

Los objetivos específicos alcanzados en esta actividad comprenden: 

- Traducción rigurosa de los tipos de datos lógicos a tipos de datos físicos nativos de SQL Server (INT IDENTITY, VARCHAR, DATE, TIME, DECIMAL, VARCHAR(MAX)). 

- Codificación explícita de restricciones de integridad de entidad (PRIMARY KEY), integridad referencial (FOREIGN KEY) y de dominio (CHECK, NOT NULL, UNIQUE, DEFAULT). 

- Resolución de conflictos de arquitectura T-SQL en SQL Server, específicamente el Error 1785 (Multiple Cascade Paths) mediante la configuración de cláusulas de acción referencial ON DELETE NO ACTION. 

- Poblado masivo con más de 300 registros de prueba y ejecución de pruebas de esfuerzo para validar la integridad referencial y el bloqueo de borrados en cascada no autorizados. 

Página 2 

Sistemas de Bases de Datos — Tarea 3.2 | Clínica Salud Total 

## **2. Especificación del Script LDD (SQL) y Reglas de Acción Referencial** 

La implementación física en Microsoft SQL Server Express requirió definir reglas explícitas de acción referencial (ON DELETE / ON UPDATE) para mantener la consistencia del expediente médico y evitar anomalías de huérfanos o ciclos de cascada. A continuación se resumen los patrones aplicados: 

|**Patrón de Relación**|**Cláusula Referencial en SQL**<br>**Server**|**Justificación Semántica en Clínica Salud Total**|
|---|---|---|
|Superclase -> Subclase<br>(PERSONA -> PACIENTE / MEDICO)|ON DELETE CASCADE<br>ON UPDATE CASCADE|Al dar de baja el registro base de una persona, sus<br>perfiles especializados se eliminan<br>automáticamente para mantener sincronizado el<br>expediente.|
|Entidad Base -> Multivalorado<br>(PERSONA -> PERSONA_TELEFONO)|ON DELETE CASCADE<br>ON UPDATE CASCADE|Los teléfonos pertenecen a la persona. La baja de<br>la persona elimina automáticamente sus números<br>de contacto en cascada.|
|Entidad -> Transaccional<br>(PACIENTE / MEDICO -> CITA)|ON DELETE NO ACTION<br>ON UPDATE NO ACTION|Protección de Historial: Impide la baja de un<br>paciente o médico con citas registradas. Resuelve<br>el Error 1785 (Multiple Cascade Paths) en T-SQL.|
|Agregación 1:1<br>(CITA -> CONSULTA)|ON DELETE CASCADE<br>ON UPDATE NO ACTION|La atención médica de consulta y sus<br>prescripciones dependen directamente de la<br>existencia de la cita previa programada.|
|Relación N:M<br>(RECETA <-> MEDICAMENTO)|ON DELETE NO ACTION<br>ON UPDATE NO ACTION|Protección de Catálogo: Se prohíbe eliminar un<br>medicamento del catálogo si ya ha sido prescrito<br>en recetas médicas emitidas.|



Página 3 

Sistemas de Bases de Datos — Tarea 3.2 | Clínica Salud Total 

## **3. Diccionario de Datos del Esquema Físico (11 Tablas Relacionales)** 

A continuación se especifican en detalle las 11 tablas relacionales del esquema físico de la base de datos implementada en Microsoft SQL Server Express, incluyendo campos, tipos de datos físicos, longitudes, aceptabilidad de nulos, restricciones de clave y reglas de validación (CHECK / DEFAULT): 

**Tabla 1: PERSONA (Entidad Superclase Base)** 

|**Campo**|**Tipo Dato**<br>**Físico**|**Longitu**<br>**d**|**Nul**<br>**o**|**Clave**|**Restricciones /**<br>**Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|ID_Persona|INT|4 bytes|NO|PK|IDENTITY(1,1)|Identificador único<br>correlativo de la persona.|
|Primer_Nombre|VARCHAR|50|NO|Ninguna|Texto obligatorio|Primer nombre de la<br>persona.|
|Apellido_Patern<br>o|VARCHAR|50|NO|Ninguna|Texto obligatorio|Primer apellido de la<br>persona.|
|Apellido_Matern<br>o|VARCHAR|50|SI|Ninguna|Opcional|Segundo apellido de la<br>persona.|
|Calle|VARCHAR|100|NO|Ninguna|Texto obligatorio|Nombre de la calle del<br>domicilio.|
|Numero|VARCHAR|20|NO|Ninguna|Texto obligatorio|Número exterior e<br>interior.|
|Colonia|VARCHAR|100|NO|Ninguna|Texto obligatorio|Colonia o asentamiento<br>urbano.|
|Codigo_Postal|VARCHAR|5|NO|Ninguna|Formato 5 dígitos|Código postal del<br>domicilio.|
|Fecha_Nacimien<br>to|DATE|3 bytes|NO|Ninguna|Formato YYYY-MM-DD|Fecha de nacimiento de la<br>persona.|
|Edad_Derivado|INT|4 bytes|SI|Ninguna|Campo calculado|Edad calculada en años.|



Página 4 

Sistemas de Bases de Datos — Tarea 3.2 | Clínica Salud Total 

### **Tabla 2: PERSONA_TELEFONO (Atributo Multivalorado)** 

|**Campo**|**Tipo Dato**|**Longitu**|**Nul**|**Clave**|**Restricciones /**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
||**Físico**|**d**|**o**||**Default**||
|ID_Persona|INT|4 bytes|NO|PK / FK|FK -><br>PERSONA(ID_Persona)|Identificador de la<br>persona titular.|
|Telefono|VARCHAR|15|NO|PK|Dígitos telefónicos|Número de contacto<br>telefónico.|



**Tabla 3: PACIENTE (Subclase de Especialización 1:1)** 

|**Campo**|**Tipo Dato**|**Longitu**|**Nul**|**Clave**|**Restricciones /**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
||**Físico**|**d**|**o**||**Default**||
|Num_Expedient<br>e|VARCHAR|20|NO|PK|Formato EXP-YYYY-XXX|Número único de<br>expediente clínico.|
|ID_Persona|INT|4 bytes|NO|FK / UNQ|FK -><br>PERSONA(ID_Persona)|Persona vinculada al<br>expediente.|
|Tipo_Sangre|VARCHAR|5|NO|Ninguna|CHECK (A+, A-, B+, B-,<br>AB+, AB-, O+, O-)|Grupo sanguíneo y factor<br>RH.|



**Tabla 4: DEPARTAMENTO (Catálogo / Entidad Fuerte)** 

|**Campo**|**Tipo Dato**<br>**Físico**|**Longitu**<br>**d**|**Nul**<br>**o**|**Clave**|**Restricciones /**<br>**Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|ID_Depto|INT|4 bytes|NO|PK|IDENTITY(1,1)|Identificador único del<br>departamento.|
|Nombre_Depto|VARCHAR|100|NO|UNIQUE|Texto único|Nombre del<br>departamento clínico.|
|Ubicacion|VARCHAR|100|NO|Ninguna|Piso / Edificio|Ubicación física en la<br>clínica.|



Página 5 

Sistemas de Bases de Datos — Tarea 3.2 | Clínica Salud Total 

### **Tabla 5: MEDICO (Subclase de Especialización 1:1)** 

|**Campo**|**Tipo Dato**<br>**Físico**|**Longitu**<br>**d**|**Nul**<br>**o**|**Clave**|**Restricciones /**<br>**Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|Num_Cedula|VARCHAR|20|NO|PK|Formato CED-XXXXXX|Cédula profesional del<br>médico.|
|ID_Persona|INT|4 bytes|NO|FK / UNQ|FK -><br>PERSONA(ID_Persona)|Persona asociada al perfil<br>médico.|
|Fecha_Contratac<br>ion|DATE|3 bytes|NO|Ninguna|Formato YYYY-MM-DD|Fecha de ingreso laboral a<br>la clínica.|
|ID_Depto|INT|4 bytes|NO|FK|FK -><br>DEPARTAMENTO(ID_De<br>pto)|Departamento clínico de<br>adscripción.|



**Tabla 6: MEDICO_ESPECIALIDAD (Atributo Multivalorado)** 

|**Campo**|**Tipo Dato**|**Longitu**|**Nul**|**Clave**|**Restricciones /**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
||**Físico**|**d**|**o**||**Default**||
|Num_Cedula|VARCHAR|20|NO|PK / FK|FK -><br>MEDICO(Num_Cedula)|Cédula del médico<br>especialista.|
|Especialidad|VARCHAR|100|NO|PK|Texto especializado|Nombre de la especialidad<br>acreditada.|



**Tabla 7: CITA (Entidad Transaccional 1:N)** 

|**Campo**|**Tipo Dato**|**Longitu**|**Nul**|**Clave**|**Restricciones /**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
||**Físico**|**d**|**o**||**Default**||
|Folio_Cita|INT|4 bytes|NO|PK|IDENTITY(1,1)|Folio correlativo único de<br>la cita.|
|Fecha|DATE|3 bytes|NO|Ninguna|Formato YYYY-MM-DD|Fecha programada para la<br>cita.|



Página 6 

Sistemas de Bases de Datos — Tarea 3.2 | Clínica Salud Total 

|**Campo**|**Tipo Dato**|**Longitu**|**Nul**|**Clave**|**Restricciones /**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
||**Físico**|**d**|**o**||**Default**||
|Hora|TIME|3 bytes|NO|Ninguna|Formato HH:MM:SS|Hora programada para la<br>cita.|
|Estado|VARCHAR|20|NO|Ninguna|DEFAULT 'Programada',<br>CHECK|Estado<br>(Programada/Completada<br>/Cancelada).|
|Num_Expedient<br>e|VARCHAR|20|NO|FK|FK -><br>PACIENTE(Num_Expedie<br>nte)|Expediente del paciente<br>solicitante.|
|Num_Cedula|VARCHAR|20|NO|FK|FK -><br>MEDICO(Num_Cedula)|Cédula del médico<br>asignado.|



**Tabla 8: CONSULTA (Agregación 1:1 con CITA)** 

|**Campo**|**Tipo Dato**|**Longitu**|**Nul**|**Clave**|**Restricciones /**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
||**Físico**|**d**|**o**||**Default**||
|ID_Consulta|INT|4 bytes|NO|PK|IDENTITY(1,1)|Identificador único de la<br>consulta.|
|Folio_Cita|INT|4 bytes|NO|FK / UNQ|FK -> CITA(Folio_Cita)|Folio de la cita atendida.|
|Diagnostico|VARCHAR(MA<br>X)|Max 2GB|NO|Ninguna|Texto extenso|Diagnóstico clínico<br>detallado.|
|Costo_Base|DECIMAL|10,2|NO|Ninguna|CHECK (Costo_Base >=<br>0)|Costo financiero de la<br>consulta médica.|



Página 7 

Sistemas de Bases de Datos — Tarea 3.2 | Clínica Salud Total 

### **Tabla 9: RECETA (Entidad Transaccional)** 

|**Campo**|**Tipo Dato**<br>**Físico**|**Longitu**<br>**d**|**Nul**<br>**o**|**Clave**|**Restricciones /**<br>**Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|Folio_Receta|INT|4 bytes|NO|PK|IDENTITY(1,1)|Folio correlativo de receta<br>médica.|
|ID_Consulta|INT|4 bytes|NO|FK|FK -><br>CONSULTA(ID_Consulta)|Consulta donde se emite<br>la receta.|
|Fecha_Emision|DATE|3 bytes|NO|Ninguna|DEFAULT<br>CAST(GETDATE() AS<br>DATE)|Fecha de emisión de la<br>receta.|



**Tabla 10: MEDICAMENTO (Catálogo de Farmacia)** 

|**Campo**|**Tipo Dato**|**Longitu**|**Nul**|**Clave**|**Restricciones /**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
||**Físico**|**d**|**o**||**Default**||
|Codigo_Med|INT|4 bytes|NO|PK|IDENTITY(1,1)|Código interno del<br>medicamento.|
|Nombre_Comer<br>cial|VARCHAR|100|NO|Ninguna|Texto de marca|Nombre comercial de<br>farmacia.|
|Formula|VARCHAR|200|NO|Ninguna|Sustancia activa|Fórmula y composición<br>química.|



Página 8 

Sistemas de Bases de Datos — Tarea 3.2 | Clínica Salud Total 

### **Tabla 11: RECETA_MEDICAMENTO (Relación N:M)** 

|**Campo**|**Tipo Dato**<br>**Físico**|**Longitu**<br>**d**|**Nul**<br>**o**|**Clave**|**Restricciones /**<br>**Default**|**Descripción Semántica**|
|---|---|---|---|---|---|---|
|Folio_Receta|INT|4 bytes|NO|PK / FK|FK -><br>RECETA(Folio_Receta)|Folio de receta prescrita.|
|Codigo_Med|INT|4 bytes|NO|PK / FK|FK -><br>MEDICAMENTO(Codigo_<br>Med)|Código de medicamento<br>surtido.|
|Dosis|VARCHAR|100|NO|Ninguna|Ej. '500 mg cada 8 hrs'|Dosis por toma prescrita.|
|Frecuencia|VARCHAR|100|NO|Ninguna|Ej. 'Cada 8 horas'|Intervalo de<br>administración.|
|Duracion_Dias|INT|4 bytes|NO|Ninguna|CHECK (Duracion_Dias ><br>0)|Días totales de<br>tratamiento.|



Página 9 

Sistemas de Bases de Datos — Tarea 3.2 | Clínica Salud Total 

## **4. Diagrama del Esquema Físico Generado por el SGBD (Mermaid / T-SQL)** 

La estructura física del modelo relacional fue compilada y validada en Microsoft SQL Server Express. A continuación se presenta el código Mermaid que documenta el diagrama de esquema físico generado, reflejando las 11 tablas, sus tipos de datos nativos T-SQL y sus cláusulas referenciales físicas: 

```mermaid
erDiagram
    PERSONA {
        int_IDENTITY ID_Persona PK
        varchar_50 Primer_Nombre "NOT NULL"
        varchar_50 Apellido_Paterno "NOT NULL"
        varchar_50 Apellido_Materno "NULL"
        varchar_100 Calle "NOT NULL"
        varchar_20 Numero "NOT NULL"
        varchar_100 Colonia "NOT NULL"
        varchar_5 Codigo_Postal "NOT NULL"
        date Fecha_Nacimiento "NOT NULL"
        int Edad_Derivado "NULL"
    }

    PERSONA_TELEFONO {
        int ID_Persona PK,FK "NOT NULL"
        varchar_15 Telefono PK "NOT NULL"
    }

    PACIENTE {
        varchar_20 Num_Expediente PK
        int ID_Persona FK "UNIQUE, NOT NULL"
        varchar_5 Tipo_Sangre "NOT NULL, CHECK"
    }

    DEPARTAMENTO {
        int_IDENTITY ID_Depto PK
        varchar_100 Nombre_Depto "UNIQUE, NOT NULL"
        varchar_100 Ubicacion "NOT NULL"
    }

    MEDICO {
        varchar_20 Num_Cedula PK
        int ID_Persona FK "UNIQUE, NOT NULL"
        date Fecha_Contratacion "NOT NULL"
        int ID_Depto FK "NOT NULL"
    }

    MEDICO_ESPECIALIDAD {
        varchar_20 Num_Cedula PK,FK "NOT NULL"
        varchar_100 Especialidad PK "NOT NULL"
    }

    CITA {
        int_IDENTITY Folio_Cita PK
        date Fecha "NOT NULL"
        time Hora "NOT NULL"
        varchar_20 Estado "DEFAULT 'Programada', CHECK"
        varchar_20 Num_Expediente FK "NOT NULL"
        varchar_20 Num_Cedula FK "NOT NULL"
    }

    CONSULTA {
        int_IDENTITY ID_Consulta PK
        int Folio_Cita FK "UNIQUE, NOT NULL"
        varchar_MAX Diagnostico "NOT NULL"
        decimal_10_2 Costo_Base "NOT NULL, CHECK (>=0)"
    }

    RECETA {
        int_IDENTITY Folio_Receta PK
        int ID_Consulta FK "NOT NULL"
        date Fecha_Emision "DEFAULT GETDATE()"
    }

    MEDICAMENTO {
        int_IDENTITY Codigo_Med PK
        varchar_100 Nombre_Comercial "NOT NULL"
        varchar_200 Formula "NOT NULL"
    }

    RECETA_MEDICAMENTO {
        int Folio_Receta PK,FK "NOT NULL"
        int Codigo_Med PK,FK "NOT NULL"
        varchar_100 Dosis "NOT NULL"
        varchar_100 Frecuencia "NOT NULL"
        int Duracion_Dias "NOT NULL, CHECK (>0)"
    }

    %% Definición Físico-Relacional de Llaves Foráneas
    PERSONA ||--o| PACIENTE : "1:1 (ON DELETE CASCADE)"
    PERSONA ||--o| MEDICO : "1:1 (ON DELETE CASCADE)"
    PERSONA ||--|{ PERSONA_TELEFONO : "1:N (ON DELETE CASCADE)"
    DEPARTAMENTO ||--|{ MEDICO : "1:N (ON DELETE NO ACTION)"
    MEDICO ||--|{ MEDICO_ESPECIALIDAD : "1:N (ON DELETE CASCADE)"
    PACIENTE ||--|{ CITA : "1:N (ON DELETE NO ACTION)"
    MEDICO ||--|{ CITA : "1:N (ON DELETE NO ACTION)"
    CITA ||--|| CONSULTA : "1:1 (ON DELETE CASCADE)"
    CONSULTA ||--|{ RECETA : "1:N (ON DELETE CASCADE)"
    RECETA ||--|{ RECETA_MEDICAMENTO : "1:N (ON DELETE CASCADE)"
    MEDICAMENTO ||--|{ RECETA_MEDICAMENTO : "1:N (ON DELETE NO ACTION)"

```



Página 10 

Sistemas de Bases de Datos — Tarea 3.2 | Clínica Salud Total 

## **5. Evidencias de Ejecución y Pruebas de Integridad en SGBD** 

Se ejecutaron pruebas de estrés y validación en Microsoft SQL Server Express utilizando el script de inserción masiva (inserts_masivos_sqlserver.sql), confirmando los siguientes resultados operativos: 



<!-- Start of picture text -->
Folio_Cita_| Fecha Hora Estado Num_Expediente Num_Cedula<br>1 [1| 2026-06-24 15:00:00.0000000 Programada EXP-2026-035  CED-8000011<br>2 2 | 2026-08-12  13:00:00.0000000 Programada EXP-2026-060  CED-8000012<br>3 3 2026-02-27 09:00:00.0000000 Completada EXP-2026-065 CED-8000011<br>4 4 2026-09-19 09:00:00.0000000 Completada EXP-2026-080 CED-8000018<br>5 5 2026-05-10 10:00:00.0000000 Completada EXP-2026-048 CED-8000001<br>6 6 2026-10-05 15:00:00.0000000 Programada EXP-2026-064 CED-8000004<br>7 7 2026-05-04 12:00:00.0000000 Programada EXP-2026-026 CED-8000020<br>8 8 2026-02-28 11:00:00.0000000 Completada EXP-2026-012 CED-8000015<br>9 9 2026-04-12 09:00:00.0000000 Cancelada EXP-2026-076 CED-8000015<br>10 10 2026-06-18  10:00:00.0000000 Completada EXP-2026-012 CED-8000006<br>ani W 2026-10-21 15:00:00.0000000 Cancelada EXP-2026-072 CED-8000006<br>1212 2026-08-08 13:00:00.0000000 Completada EXP-2026-007 _ CED-8000019<br>3 13 2026-08-13 09:00:00.0000000 Completada EXP-2026-013 _ CED-8000013<br>414 2026-06-13 14:00:00.0000000 Cancelada  EXP-2026-079 _ CED-8000011<br>15 15 2026-05-03 14:00:00.0000000 Completada EXP-2026-048 _ CED-8000018<br>16 16 2026-05-18 _10:00:00.0000000 Completada EXP-2026-049 —_ CED-8000003<br><!-- End of picture text -->



<!-- Start of picture text -->
ID_Consulta _Folio_Cita _Diagnostico Costo_Base<br>1 fi 13 Esguince de tobillo grado |. Inmovilizacién parcial y..._ 500.00<br>2 [2 4 Lumbago no especificadoy contractura muscular... 500.00<br>3 |3 5 Dislipidemia mixta. Dieta hipograsa y estatinas. 800.00<br>4 4 8 Esguince de tobillo grado |. Inmovilizacién parcial y.._ 650.00<br>5 5 10 Gastritis crénica agudizada. Se indica dieta astring... 650.00<br>6 6 2 Hipertensién arterial sistémica descompensada. S..__ 1200.00<br>7 (7 3 Hipertensién arterial sistémica descompensada. S..._ 650.00<br>8 8 15 Lumbago no especificadoy contractura muscular... 500.00<br>9 9 16 Lumbago no especificadoy contractura muscular... 500.00<br>10 10 7 Diabetes mellitus tipo 2 en control regular. Se refue... 650.00<br>nou 19 Faringoamigdalitis purulenta. Tratamiento antimicr... 500.00<br>1212 20 Diabetes mellitus tipo 2 en control regular. Se refue.. 800.00<br>3 13 21 Lumbago no especificadoy contractura muscular... 650.00<br>4 14 22 Gastritis crénica agudizada. Se indica dieta astring... 500.00<br>15 15 23 Faringoamigdalitis purulenta. Tratamiento antimicr... 1200.00<br>16 16 24 Faringoamigdalitis purulenta. Tratamiento antimicr... 500.00<br>7417 on (Cafsinn tensinnal fequncia Mansindaasiciascan 120000<br><!-- End of picture text -->

Página 11 

Sistemas de Bases de Datos — Tarea 3.2 | Clínica Salud Total 

## **6. Conclusión Técnica y Referencias Bibliográficas** 

**Conclusión Técnica:** La implementación física del esquema de base de datos para la Clínica Salud Total en Microsoft SQL Server Express demuestra la efectividad de traducir un diseño relacional lógico a un entorno de producción real. La configuración explícita de restricciones de integridad de dominio y las reglas referenciales ON DELETE NO ACTION garantizan la protección del historial clínico y previenen anomalías de modificación o borrados accidentales en la institución. 

### **Referencias Bibliográficas (Formato APA):** 

_Date, C. J. (2004). Introducción a los sistemas de bases de datos (8a. ed.). Pearson Educación._ 

_Elmasri, R., & Navathe, S. B. (2017). Fundamentos de sistemas de bases de datos (7a. ed.). Pearson Education._ 

_Microsoft Corporation. (2024). Transact-SQL Reference (Database Engine) - SQL Server. Microsoft Learn._ 

_Silberschatz, A., Korth, H. F., & Sudarshan, S. (2014). Fundamentos de bases de datos (6a. ed.). McGraw-Hill._ 

Página 12 

