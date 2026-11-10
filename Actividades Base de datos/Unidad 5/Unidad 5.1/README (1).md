# Unidad 5: Álgebra Relacional
## Actividad 5.1: Operadores Fundamentales y Extendidos del Álgebra Relacional

---

### Información Institucional y del Estudiante

| Campo | Detalle |
| :--- | :--- |
| **Institución:** | Tecnológico Nacional de México |
| **Materia:** | Fundamentos de Bases de Datos |
| **Unidad:** | Unidad 5 – Lenguajes de Consulta Formales (Álgebra Relacional) |
| **Docente:** | Ruben Miguel Riojas Rodríguez |
| **Alumno:** | Eduardo Salazar Martínez |
| **Repositorio Principal:** | [Tareas-fundamentos-de-base-de-datos-](../../) |
| **Video en YouTube:** | *(Enlace al video explicativo público)* |

---

## 1. Introducción y Propósito de la Unidad

El **Álgebra Relacional** es un lenguaje procedimental de consulta formal que opera sobre una o más relaciones (tablas) para producir una nueva relación como resultado, sin modificar los datos almacenados originalmente (propiedad de clausura).

Comprender la notación matemática y la semántica formal del álgebra relacional es fundamental para la ingeniería de bases de datos, ya que constituye la base teórica y algorítmica sobre la cual los Sistemas Gestores de Bases de Datos Relacionales (RDBMS) analizan, reescriben y optimizan las consultas formuladas en **SQL**.

---

## 2. Índice del Directorio ()

Este directorio contiene la totalidad de los recursos teóricos, gráficos y documentales desarrollados para la actividad:



---

## 3. Marco Teórico: Catálogo Formal de Operadores

### A. Operadores Unarios (Operan sobre una sola relación R)

1. **Selección (σ):**
   * **Notación Formal:** σ_θ(R) = { t ∈ R | θ(t) = Verdadero }
   * **Propósito:** Filtro horizontal de tuplas que satisfacen el predicado lógico θ. Conserva todos los atributos del esquema original.
   * **Ejemplo:** σ_{departamento = 'Sistemas'}(EMPLEADO)

2. **Proyección (π):**
   * **Notación Formal:** π_{A_1, A_2, ..., A_k}(R) = { t[A_1, ..., A_k] | t ∈ R }
   * **Propósito:** Filtro vertical que extrae exclusivamente el subconjunto de columnas indicadas, suprimiendo duplicados.
   * **Ejemplo:** π_{nombre, salario}(EMPLEADO)

---

### B. Operadores Binarios Primitivos y Derivados (Operan sobre dos relaciones R y S)

3. **Producto Cartesiano (×):**
   * **Notación Formal:** R × S = { t · q | t ∈ R ∧ q ∈ S }
   * **Propósito:** Concatena cada tupla de R con cada tupla de S. Base formal para la construcción de Joins.

4. **Operadores de Conjuntos (∪, ∩, -):**
   * *Requisito estricto:* Ambas relaciones deben poseer **compatibilidad de unión** (mismo grado y dominios de atributos compatibles).
   * **Unión (∪):** R ∪ S retorna tuplas presentes en R, en S o en ambas.
   * **Intersección (∩):** R ∩ S = R - (R - S) retorna tuplas que coexisten en ambas relaciones.
   * **Diferencia (-):** R - S retorna tuplas presentes en R pero ausentes en S.

5. **Reunión / Join (⋈):**
   * **Theta Join (⋈_θ):** σ_θ(R × S), aplica una condición de emparejamiento explícita θ.
   * **Natural Join (⋈):** Empareja tuplas igualando automáticamente atributos homónimos y eliminando redundancia de columnas duplicadas.

6. **División (÷):**
   * **Notación Formal:** R ÷ S = π_X(R) - π_X((π_X(R) × S) - R)
   * **Propósito:** Responde consultas de universalidad ('para todos los elementos de S').

---

### C. Álgebra Relacional Extendida

7. **Proyección Generalizada:**
   * **Notación Formal:** π_{F_1, F_2, ..., F_n}(R)
   * **Propósito:** Permite incluir funciones y cálculos aritméticos en los atributos proyectados (ej. π_{nombre, salario * 1.10}(EMPLEADO)).

8. **Funciones de Agregación (G):**
   * **Notación Formal:** _{G_1, ..., G_m}G_{f_1(A_1), ..., f_k(A_k)}(R)
   * **Propósito:** Agrupa por atributos G_i y calcula funciones estadísticas f_i ∈ {SUM, AVG, COUNT, MIN, MAX}.

9. **Reuniones Externas (Outer Joins):**
   * Preservan tuplas que no satisfacen la condición del join rellenando los valores faltantes con nulos (NULL).
   * **Left Outer Join (R ⟕ S):** Conserva todas las tuplas de R.
   * **Right Outer Join (R ⟖ S):** Conserva todas las tuplas de S.
   * **Full Outer Join (R ⟗ S):** Conserva todas las tuplas de ambas relaciones.

---

## 4. Mapa Conceptual del Álgebra Relacional



---

## 5. Video Explicativo

De acuerdo con los lineamientos de la rúbrica oficial de evaluación, se elaboró una exposición grabada explicando la notación formal y el comportamiento de los operadores.

* **URL del Video:** *(Colocar el enlace a YouTube)*
* **Configuración:** Modo público en canal oficial.
* **Cámara Web:** Recuadro visible del rostro del estudiante en la esquina inferior derecha durante toda la exposición.

---

## 6. Referencias Bibliográficas (Formato APA 7.ª ed.)

* Codd, E. F. (1970). A relational model of data for large shared data banks. *Communications of the ACM*, 13(6), 377–387.
* Elmasri, R., & Navathe, S. B. (2017). *Fundamentos de sistemas de bases de datos* (7.ª ed.). Pearson Educación.
* Silberschatz, A., Korth, H. F., & Sudarshan, S. (2014). *Fundamentos de bases de datos* (6.ª ed.). McGraw-Hill Education.
