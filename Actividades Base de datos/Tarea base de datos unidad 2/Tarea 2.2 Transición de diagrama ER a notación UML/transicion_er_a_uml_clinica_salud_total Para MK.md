_Clínica Salud Total | Tarea 2.2: Transición de E-R a Notación UML_ 

## **LICENC** NACIONALTECNOLOGICODE MEXICO 

# **TAREA 2.2: TRANSICIÓN DE DIAGRAMA ENTIDADRELACIÓN A NOTACIÓN UML** 

**Asignatura:** Sistemas de Bases de Datos **Docente** : Ruben Miguel Riojas Rodríguez **Alumno:** Eduardo Salazar Martínez 

Página 1 

_Clínica Salud Total | Tarea 2.2: Transición de E-R a Notación UML_ 

### **1. Introducción y Contextualización del Caso** 

El diseño de sistemas de información modernos exige salvar la brecha entre la persistencia de datos relacional y la arquitectura de software en capa de aplicación. En la actividad previa (Tarea 2.1), se desarrolló el modelo conceptual Entidad-Relación Extendido (EER) para la **Clínica Salud Total** , resolviendo la ineficiencia de registros fragmentados mediante la consolidación de expedientes, personal médico, citas, diagnósticos y prescripción de medicamentos. 

Se establece la transición formal desde el modelo E-R/EER hacia el **Diagrama de Clases en Notación UML (Unified Modeling Language)** . Esta transformación traslada las estructuras de datos estáticas (entidades, claves, relaciones) hacia un paradigma Orientado a Objetos (POO), incorporando visibilidad de atributos, métodos de dominio, comportamiento dinámico y tipos de asociación explícitos (herencia, agregación y composición). 

##### **■ OBJETIVO DE LA TRANSICIÓN** 

La transición de E-R a UML traslada un esquema puramente relacional enfocado en tablas y restricciones SQL hacia una arquitectura de clases con encapsulamiento, abstracción y métodos de negocio que facilitan la implementación mediante patrones de Mapeo Objeto-Relacional (ORM). 

Página 2 

_Clínica Salud Total | Tarea 2.2: Transición de E-R a Notación UML_ 

### **2. Correspondencia Directa entre el Modelo E-R/EER y Notación UML** 

Para garantizar una transformación rigurosa sin pérdida de semántica, se define una matriz de equivalencias entre los elementos conceptuales del modelo Entidad-Relación Extendido y sus contrapartes en el Diagrama de Clases UML: 

|**Elemento Modelo E-R / EER**|**Notación Diagrama de Clases**<br>**UML**|**Descripción y Mapeo en Clínica Salud**<br>**Total**|
|---|---|---|
|Entidades Principales|Clases de Dominio|Transformación de entidades relacionales en|
|(PERSONA, CITA, etc.)|(class Persona, class Cita)|clases estructuradas con atributos privados y<br>métodos públicos.|
|Superclase / Subclases<br>Jerarquía (d, t)|Herencia / Generalización<br>(Persona <|-- Paciente)|Mapeo directo de la especialización disjunta y<br>total. Paciente y Médico heredan atributos y<br>operaciones de Persona.|
|Atributos Simples y Claves|Propiedades y Visibilidad|Los atributos de entidad pasan a ser|
|(PK, FK, VARCHAR, INT)|(- idPersona: int [PK])|propiedades privadas (-) con tipo de dato<br>explícito e identificador de rol.|
|Atributos Derivados|Métodos / Operaciones|Los atributos calculados dinámicamente dejan|
|(Edad en Persona)|(+ calcularEdad(): int)|de ser campos almacenados y se convierten<br>en operaciones de clase.|
|Atributos Multivalorados|Composición / Colecciones|Se descomponen mediante relaciones de|
|(Teléfono, Especialidad)|(Persona 1 *-- 1..* PersonaTelefono)|composición o listas administradas de objetos<br>dependientes.|
|Agregación EER<br>(CONSULTA origina de CITA)|Agregación UML (o--)<br>(Cita 1 o-- 0..1 Consulta)|La Consulta Médica agrega la interacción<br>entre Cita, Médico y Paciente en una relación<br>todo-parte de acoplamiento débil.|
|Relación 1:N Fuerte|Composición UML (*--)|La Receta no posee existencia independiente|
|(CONSULTA -> RECETA)|(Consulta 1 *-- 0..* Receta)|fuera del contexto de una Consulta Médica<br>activa (vida dependiente).|
|Relación M:N con Atributos|Clase de Asociación|La relación M:N se resuelve mediante una|
|(RECETA <-> MEDICAMENTO)|(DetalleRecetaMedicamento)|clase asociativa que encapsula dosis,<br>frecuencia y duración del tratamiento.|



Página 3 

_Clínica Salud Total | Tarea 2.2: Transición de E-R a Notación UML_ 

### **3. Especificación Detallada de Clases y Estructura UML** 

A continuación se presenta la definición formal de las clases del sistema de la Clínica Salud Total en notación UML, detallando visibilidad, tipos de datos, multiplicidades y firmas de métodos: 

#### **3.1. Clases de Dominio y Jerarquía de Herederos** 

**Clase: Persona (Clase Abstracta Base)** 

|**Atributos Privados (-)**|**Métodos Públicos (+)**|
|---|---|
|`- idPersona: int {PK}`|`+ calcularEdad(): int`|
|`- primerNombre: String`|`+ obtenerNombreCompleto(): String`|
|`- apellidoPaterno: String`|`+ obtenerDireccionCompleta(): String`|
|`- apellidoMaterno: String [0..1]`<br>`- calle: String`||
|`- numero: String`<br>`- colonia: String`<br>`- codigoPostal: String`||
|`- fechaNacimiento: Date`||



**Clase: Paciente (Subclase heredada de Persona)** 

|**Atributos Privados (-)**|**Métodos Públicos (+)**|
|---|---|
|`- numExpediente: String {PK, Format: 'EXP-YYYY-`|`+ obtenerHistorialCitas(): List<Cita>`|
|`XXXX'}`|`+ validarExpediente(): boolean`|
|`- tipoSangre: String {CHECK in ('A+','A-`||
|`','O+','O-',...)}`||



**Clase: Medico (Subclase heredada de Persona)** 

|**Atributos Privados (-)**|**Métodos Públicos (+)**|
|---|---|
|`- numCedula: String {PK}`|`+ obtenerEspecialidades(): List<String>`|
|`- fechaContratacion: Date`|`+ asignarDepartamento(depto: Departamento):`<br>`void`|



#### **Clase: Departamento** 

|**Atributos Privados (-)**|**Métodos Públicos (+)**|
|---|---|
|`- idDepto: int {PK}`|`+ listarMedicos(): List<Medico>`|
|`- nombreDepto: String {UNIQUE}`|`+ obtenerEstadisticasAtencion(): Map`|
|`- ubicacion: String`||



Página 4 

_Clínica Salud Total | Tarea 2.2: Transición de E-R a Notación UML_ 

#### **Clase: Cita** 

|**Atributos Privados (-)**|**Métodos Públicos (+)**|
|---|---|
|`- folioCita: int {PK}`|`+ reprogramar(nuevaFecha: Date, nuevaHora:`|
|`- fecha: Date`|`Time): void`|
|`- hora: Time`|`+ cancelar(): void`|
|`- estado: String {DEFAULT 'Programada'}`|`+ registrarAtencion(): Consulta`|



#### **Clase: Consulta (Clase de Agregación)** 

|**Atributos Privados (-)**|**Métodos Públicos (+)**|
|---|---|
|`- idConsulta: int {PK}`|`+ generarReceta(): Receta`|
|`- diagnostico: String`|`+ calcularCostoTotal(): double`|
|`- costoBase: double {costoBase >= 0}`||



#### **Clase: Receta** 

|**Atributos Privados (-)**|**Métodos Públicos (+)**|
|---|---|
|`- folioReceta: int {PK}`|`+ agregarMedicamento(med: Medicamento, dosis:`|
|`- fechaEmision: Date`|`String, freq: String, duracion: int): void`<br>`+ obtenerDetalles():`<br>`List<DetalleRecetaMedicamento>`|



#### **Clase: Medicamento** 

|**Atributos Privados (-)**|**Métodos Públicos (+)**|
|---|---|
|`- codigoMed: int {PK}`|`+ consultarStock(): int`|
|`- nombreComercial: String`|`+ obtenerPresentacion(): String`|
|`- formula: String`||



#### **Clase: DetalleRecetaMedicamento (Clase Asociativa M:N)** 

|**Atributos Privados (-)**|**Métodos Públicos (+)**|
|---|---|
|`- dosis: String`|`+ obtenerResumenTratamiento(): String`|
|`- frecuencia: String`||
|`- duracionDias: int`||



Página 5 

_Clínica Salud Total | Tarea 2.2: Transición de E-R a Notación UML_ 

### **4. Matriz Comparativa Detallada: Modelo E-R vs. Diagrama de Clases UML** 

Para profundizar en las diferencias conceptuales, metodológicas y operativas entre ambos enfoques, se estructura la siguiente matriz de análisis comparativo: 

|**Dimensión / Criterio**|**Modelo Entidad-Relación (E-R /**<br>**EER)**|**Diagrama de Clases UML**|**Análisis de Impactización**|
|---|---|---|---|
|Propósito Principal|Diseñar el esquema conceptual de<br>persistencia física en un Sistema<br>Gestor de Bases de Datos<br>Relacional (SGBD).|Modelar la arquitectura estática y<br>dinámica de las clases del dominio<br>del software orientado a objetos.|E-R busca la estructuración del<br>almacenamiento; UML busca<br>la estructura del código<br>ejecutable.|
|Enfoque de Datos y<br>Comportamiento|Estático y pasivo: se enfoca<br>únicamente en entidades,<br>atributos, llaves y restricciones de<br>integridad.|Dinámico e activo: integra estado<br>(propiedades) y comportamiento<br>ejecutable (métodos y<br>operaciones).|UML añade lógica de negocio<br>dentro de los mismos bloques<br>mediante encapsulamiento<br>POO.|
|Encapsulamiento y<br>Visibilidad|No existe encapsulamiento: todos<br>los campos de una tabla son<br>públicos y accesibles por SQL.|Encapsulamiento estricto: define<br>atributos privados (-), protegidos<br>(#) y métodos públicos (+).|UML garantiza la integridad de<br>datos impidiendo<br>modificaciones directas a<br>propiedades.|
|Expresividad de<br>Relaciones Avanzadas|Soporta Especialización (d, t) y<br>Agregación básica mediante tablas<br>intermedias y FKs.|Soporta Herencia (<|--),<br>Composición (*--), Agregación (o--<br>), Interfaces y Asociaciones<br>complejas.|UML diferencia<br>semánticamente entre la<br>dependencia vital<br>(Composición) y el<br>agrupamiento débil<br>(Agregación).|
|Manejo de Derivados y<br>Calculados|Atributos derivados (Edad) no se<br>almacenan física ni formalmente<br>en tablas 3FN.|Se representan explícitamente<br>mediante métodos de cálculo de<br>clase (+calcularEdad(): int).|En UML los atributos<br>calculados son responsabilidad<br>de la lógica de la capa de<br>aplicación.|



Página 6 

_Clínica Salud Total | Tarea 2.2: Transición de E-R a Notación UML_ 

### **5. Análisis de Coincidencias para el Desarrollo Orientado a Objetos (POO & ORM)** 

#### **5.1. Resolución del Desfasaje Impedante (Impedance Mismatch)** 

El denominado **desfasaje impedante relacional-objeto** representa la incompatibilidad conceptual entre el modelo relacional (basado en tablas, tuplas, álgebras relacionales y claves primarias/foráneas) y el paradigma orientado a objetos (basado en objetos, identidad en memoria, grafos de referencias y polimorfismo). La conversión a notación UML permite anticipar y resolver estos conflictos antes de escribir código de persistencia. 

#### **5.2. Estrategia de Mapeo de Herencia en ORM** 

La especialización disjunta y total **(d, t) de la superclase PERSONA** hacia las subclases PACIENTE y MÉDICO puede implementarse en frameworks ORM (tales como Hibernate, Entity Framework o SQLAlchemy) utilizando tres patrones estándar: 

- **Joined Table (Tabla por Subclase):** Se crea una tabla para la superclase PERSONA y tablas independientes para PACIENTE y MÉDICO vinculadas por la misma llave primaria (ID_Persona). Es la estrategia más limpia, evita nulos sobrantes y preserva la normalización 3FN alcanzada en el modelo relacional. 

**• Single Table (Tabla Única por Jerarquía):** Consolida todas las propiedades en una sola tabla con una columna discriminadora ('TIPO_PERSONA'). Es eficiente en consultas pero introduce múltiples valores nulos en columnas específicas. 

- **Table Per Concrete Class:** Elimina la tabla superclase y duplica los atributos comunes en las tablas de las subclases concretas. Dificulta las consultas polimórficas sobre todas las personas. 

#### **5.3. Trazabilidad de Reglas de Negocio en la Capa de Dominio** 

La notación UML permite trasladar las Reglas de Negocio Formales (RN-01 a RN-08) directamente a constructos POO: 

✔ **RN-01 (Jerarquía Disjunta):** Se implementa mediante una clase abstracta Persona con un constructor de ámbito protegido (protected), impidiendo la instanciación directa de personas genéricas. 

- ✔ **RN-02 (Expedientes de Pacientes):** La propiedad numExpediente se valida mediante una expresión regular en el setter de la clase Paciente, asegurando la sintaxis 'EXP-YYYY-XXXX'. 

✔ **RN-04 (Estructura Departamental):** La relación de agregación Departamento o-- Medico se gestiona mediante métodos encadenados (+asignarDepartamento()) que mantienen la consistencia bidireccional. 

✔ **RN-06 y RN-07 (Consulta y Recetas):** La composición Consulta *-- Receta garantiza que las recetas se instancien mediante el método de fábrica +generarReceta() dentro del contexto de una consulta finalizada. 

Página 7 

_Clínica Salud Total | Tarea 2.2: Transición de E-R a Notación UML_ 

### **6. Conclusiones Técnicas** 

La transición del Diagrama Entidad-Relación Extendido hacia la Notación UML demuestra que ambos modelos no son excluyentes, sino complementarios en el ciclo de vida del desarrollo de software médica: 

**1.** El modelo E-R/EER constituye el cimiento óptimo para garantizar la integridad referencial, la normalización (1FN/3FN) y la eficiencia del almacenamiento físico en el SGBD. 

**2.** El Diagrama de Clases UML proporciona el plano de arquitectura necesario para implementar la capa de lógica de negocio en la aplicación, encapsulando comportamientos y habilitando el uso de patrones de diseño (Domain-Driven Design). 

**3.** La correspondencia formal establecida facilita el uso de herramientas de Mapeo ObjetoRelacional (ORM), reduciendo significativamente el tiempo de desarrollo y los errores en tiempo de ejecución. 

Página 8 

_Clínica Salud Total | Tarea 2.2: Transición de E-R a Notación UML_ 

**Figura 1.** Diagrama UML del Sistema Clínica Salud Total. 



<!-- Start of picture text -->
=<br>neta<br>SRE,<br>phen<br>ee<br>String tiposanre a<br>*String obtenertistoriaicitas() _+void asignarDepartamento(Departamendep to )<br>Date fecha |<br>fae<br><!-- End of picture text -->

Página 9 

_Clínica Salud Total | Tarea 2.2: Transición de E-R a Notación UML_ 

### **7. Referencias Bibliográficas (APA 7.ª Edición)** 

Coronel, C., & Morris, S. (2019). Database Systems: Design, Implementation, & Management (13th ed.). Cengage Learning. 

Date, C. J. (2004). An Introduction to Database Systems (8th ed.). Pearson Addison-Wesley. 

Elmasri, R., & Navathe, S. B. (2017). Fundamentos de sistemas de bases de datos (7.ª ed.). Pearson Educación. 

Object Management Group. (2017). Unified Modeling Language (UML) Specification (Version 2.5.1). OMG. 

Silberschatz, A., Korth, H. F., & Sudarshan, S. (2014). Fundamentos de bases de datos (6.ª ed.). McGraw-Hill Education. 

Página 10 

