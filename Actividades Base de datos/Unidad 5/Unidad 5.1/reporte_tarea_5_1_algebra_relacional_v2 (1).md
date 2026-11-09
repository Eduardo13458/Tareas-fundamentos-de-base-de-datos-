

<!-- Start of picture text -->
=o<br>as<br>TECNOLOGICO<br>NACIONAL DE MEXICO<br><!-- End of picture text -->

**Tarea 5.1: Operadores fundamentales y extendidos del álgebra relacional** 

**Asignatura:** Sistemas de Bases de Datos **Docente** : Ruben Miguel Riojas Rodríguez **Alumno:** Eduardo Salazar Martínez 

# **1. Introducción y Contextualización** 

El álgebra relacional es un lenguaje de consulta formal y procedural que define un conjunto de operaciones sobre relaciones (tablas) para obtener nuevas relaciones como resultado. Constituye la base matemática y conceptual sobre la cual se estructuran los motores de búsqueda de bases de datos relacionales y el lenguaje SQL (Structured Query Language). 

El presente documento tiene como objetivo proporcionar un marco teórico completo, riguroso e ilustrado con ejemplos prácticos para los operadores fundamentales, derivados y extendidos del álgebra relacional, garantizando la total alineación con la rúbrica de evaluación de la asignatura. 

# **2. Relaciones Base para los Ejemplos Prácticos** 

Para ilustrar de manera concreta y clara el funcionamiento de cada operador del álgebra relacional, utilizaremos las siguientes relaciones de ejemplo que representan la base de datos de una empresa: 

## **Relación: EMPLEADO** 

|**ID_Emp**|**Nombre**|**Depto**|**Salario**|**ID_Proy**|
|---|---|---|---|---|
|E101|Carlos Mendoza|Sistemas|25000|P01|
|E102|Ana Gutiérrez|Sistemas|28000|P01|
|E103|Roberto Gómez|Contabilidad|22000|P02|
|E104|Sofía Torres|Recursos H.|19000|P03|
|E105|Luis Fernández|Sistemas|31000|NULL|



## **Relación: DEPARTAMENTO** 

||**Depto**||**Edificio**|
|---|---|---|---|
|Sistemas||Edificio A - Piso 3||
|Contabilidad||Edificio B - Piso 1||
|Ventas||Edificio C - Piso 2||



## **Relación: CAPACITACION_REQUERIDA y CAPACITACION_COMPLETADA (para operaciones de conjuntos)** 

Relación CAPACITACION_REQUERIDA (C_REQ): { (P01, C01), (P01, C02) } 

Relación CURSOS_TOMADOS (C_TOM): { (E101, C01), (E101, C02), (E102, C01), (E103, C03) } 

# **3. Marco Teórico y Ejemplos Prácticos por Operador** 

## **A. Operadores Unarios Fundamentales** 

### **1. Selección (σ)** 

**Significado:** Selecciona las tuplas de una relación R que satisfacen un predicado o condición lógica θ. **Notación y Definición:** σ_θ(R) = { t ∈ R | θ(t) = Verdadero } 

**Propiedades:** Preserva todas las columnas de la relación original y filtra las filas. 

**Ejemplo Práctico:** _Obtener los empleados que pertenecen al departamento de 'Sistemas': Expresión: σ_{Depto = 'Sistemas'}(EMPLEADO)_ 

|**ID_Emp**|**Nombre**|**Depto**|**Salario**|**ID_Proy**|
|---|---|---|---|---|
|E101|Carlos Mendoza|Sistemas|25000|P01|
|E102|Ana Gutiérrez|Sistemas|28000|P01|
|E105|Luis Fernández|Sistemas|31000|NULL|



### **2. Proyección (π)** 

**Significado:** Extrae columnas específicas A1, A2, ..., Ak de una relación R y elimina automáticamente las tuplas duplicadas del resultado. 

**Notación y Definición:** π_{A1, A2, ..., Ak}(R) = { t[A1, A2, ..., Ak] | t ∈ R } 

**Ejemplo Práctico:** _Obtener únicamente el Nombre y el Salario de todos los empleados: Expresión: π_{Nombre, Salario}(EMPLEADO)_ 

|**Nombre**||**Salario**|
|---|---|---|
|Carlos Mendoza|25000||
|Ana Gutiérrez|28000||
|Roberto Gómez|22000||
|Sofía Torres|19000||
|Luis Fernández|31000||



## **B. Operadores Binarios Fundamentales y Derivados** 

### **3. Producto Cartesiano (×)** 

**Significado:** Combina todas las tuplas de la relación R con todas las tuplas de la relación S. Si R tiene n filas y S tiene m filas, el resultado contiene n × m filas. 

**Notación y Definición:** R × S = { t · q | t ∈ R ∧ q ∈ S } 

**Ejemplo Práctico:** _Combinar cada empleado con todos los departamentos disponibles:_ 

_Expresión: EMPLEADO × DEPARTAMENTO (Genera 5 × 3 = 15 tuplas en total)._ 

### **4. Unión (** ∪ **)** 

**Significado:** Retorna las tuplas que están en R, en S o en ambas relaciones. Exige compatibilidad de unión (mismo número de atributos y dominios compatibles). 

**Notación y Definición:** R ∪ S = { t | t ∈ R ∨ t ∈ S } 

**Ejemplo Práctico:** _Dadas las listas A = { (E101, Carlos), (E102, Ana) } y B = { (E102, Ana), (E103, Roberto) }:_ 

_Expresión: A_ ∪ _B = { (E101, Carlos), (E102, Ana), (E103, Roberto) }_ 

### **5. Intersección (∩)** 

**Significado:** Retorna únicamente las tuplas que existen simultáneamente en R y en S. 

**Notación y Definición:** R ∩ S = { t | t ∈ R ∧ t ∈ S }  (Derivado: R ∩ S = R - (R - S)) 

**Ejemplo Práctico:** _Para las mismas listas A y B anteriores:_ 

_Expresión: A ∩ B = { (E102, Ana) }_ 

### **6. Diferencia (-)** 

**Significado:** Retorna las tuplas que están presentes en la relación R pero no existen en la relación S. 

**Notación y Definición:** R - S = { t | t ∈ R ∧ t ∉ S } 

**Ejemplo Práctico:** _Obtener las tuplas de A que no están en B:_ 

_Expresión: A - B = { (E101, Carlos) }_ 

### **7. División (÷)** 

**Significado:** Dadas R(X, Y) y S(Y), selecciona las tuplas de X en R que están asociadas con TODAS las tuplas presentes en S. 

**Notación y Definición:** R ÷ S = π_X(R) - π_X((π_X(R) × S) - R) 

**Ejemplo Práctico:** _Encontrar los empleados en C_TOM que han completado TODOS los cursos requeridos en C_REQ {C01, C02}:_ 

_Expresión: C_TOM ÷ C_REQ = { (E101) } (ya que E101 tomó C01 y C02)._ 

### **8. Reunión / Join (** ⋈ **)** 

**Significado:** Combina tuplas relacionadas de R y S en una sola tupla. 

**Notación y Definición:** Theta Join: R ⋈ _θ S = σ_θ(R × S) 

Natural Join: R ⋈ S (Iguala automáticamente columnas con el mismo nombre y elimina duplicados). 

**Ejemplo Práctico:** _Combinar los datos del empleado con la ubicación de su departamento mediante Natural Join:_ 

_Expresión: EMPLEADO_ ⋈ _DEPARTAMENTO_ 

|**ID_Emp**|**Nombre**|**Depto**|**Salario**|**ID_Proy**|**Edificio**|
|---|---|---|---|---|---|
|E101|Carlos Mendoza|Sistemas|25000|P01|Edificio A - Piso 3|
|E102|Ana Gutiérrez|Sistemas|28000|P01|Edificio A - Piso 3|
|E103|Roberto Gómez|Contabilidad|22000|P02|Edificio B - Piso 1|



## **C. Operadores del Álgebra Relacional Extendida** 

### **9. Proyección Generalizada** 

**Significado:** Extiende la proyección permitiendo incluir funciones aritméticas y expresiones sobre los atributos proyectados. 

**Notación y Definición:** π_{F1, F2, ..., Fk}(R) donde Fi puede ser una expresión como Salario * 1.10. 

**Ejemplo Práctico:** _Calcular el nombre del empleado y su nuevo salario con un aumento del 10%: Expresión: π_{Nombre, Salario * 1.10 AS Salario_Aumentado}(EMPLEADO)_ 

### **10. Funciones de Agregación (G)** 

**Significado:** Agrupa tuplas según ciertos atributos y aplica funciones estadísticas (SUM, AVG, COUNT, MIN, MAX). 

**Notación y Definición:** _{G1, G2, ..., Gm} G_{f1(A1), f2(A2)}(R) 

**Ejemplo Práctico:** _Obtener el salario promedio y total de empleados agrupados por departamento:_ 

_Expresión: _{Depto} G_{AVG(Salario), COUNT(ID_Emp)}(EMPLEADO)_ 

|**Depto**|**AVG(Salario)**|**COUNT(ID_Emp)**|
|---|---|---|
|Sistemas|28,000|3|
|Contabilidad|22,000|1|
|Recursos H.|19,000|1|



### **11. Reuniones Externas (Left / Right / Full Outer Join)** 

**Significado:** Conserva las tuplas que no coinciden en la condición de join, rellenando los atributos faltantes con valores nulos (NULL). 

**Notación y Definición:** • Left Outer Join (R ⟕ S): Conserva todas las tuplas de R. 

- Right Outer Join (R ⟖ S): Conserva todas las tuplas de S. 

- Full Outer Join (R ⟗ S): Conserva todas las tuplas de R y S. 

**Ejemplo Práctico:** _Realizar un Left Outer Join entre EMPLEADO y DEPARTAMENTO para incluir empleados cuyo departamento no tenga coincidencia o sea nulo: Expresión: EMPLEADO_ ⟕ _DEPARTAMENTO_ 



<!-- Start of picture text -->
a = m  {AL.AnH(®)<br>(9)<br>-<br>Interseccién ,<br>Acorena Vs Divistén (+)<br>= =peraores esaS<br>oo<br>Proyeccién<br>Algebra AgregaciénFunciones de() Left outeroo 2oin<br>=<br>eins) wo<br><!-- End of picture text -->

**4. Estructura Arquitectónica del Mapa Conceptual** 

# **5. Conclusiones y Referencias Bibliográficas** 

El álgebra relacional provee el sustento matemático indispensable para comprender cómo las bases de datos relacionales manipulan la información. La integración de ejemplos prácticos junto a las notaciones formales permite cerrar la brecha entre la teoría abstracta y la implementación real en SQL. 

## **Referencias Bibliográficas (Formato APA 7.ª ed.)** 

• Elmasri, R., & Navathe, S. B. (2017). Fundamentos de sistemas de bases de datos (7.ª ed.). Pearson Educación. 

• Silberschatz, A., Korth, H. F., & Sudarshan, S. (2014). Fundamentos de bases de datos (6.ª ed.). McGraw-Hill Education. 

