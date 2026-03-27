# 🐾 Demo QA Karate - API Testing PetStore

## 📋 Descripción del Proyecto

Este proyecto es una suite de pruebas automatizadas para la API PetStore (https://petstore.swagger.io/v2) utilizando el framework **Karate** para testing de APIs REST con **Gradle** (o Maven como alternativa).

**Objetivo:** Validar flujos de creación, consulta y validación de mascotas, incluyendo:
- ✅ Creación de mascotas (POST /pet)
- ✅ Consulta de mascotas por ID (GET /pet/{petId})
- ✅ Validación de campos vacíos
- ✅ Validación de estructura de respuestas
- ✅ Validación de tipos de datos
- ✅ Error handling

---

## ⚙️ Stack Tecnológico Recomendado: Gradle

Este proyecto utiliza **Gradle** como gestor de dependencias principal (definido en `build.gradle.kts`).



## 🛠️ Requisitos Técnicos

### Versiones de Tecnologías (REQUERIDAS)

| Tecnología | Versión | Propósito |
|-----------|---------|----------|
| **Java** | 11+ (recomendado 17+) | Runtime para Gradle/Maven y Karate |
| **Gradle** | 7.6+ | Gestor de dependencias (RECOMENDADO) |
| **Maven** | 3.8.0+ | Alternativa a Gradle |
| **Karate** | 1.4.1 | Framework de testing de APIs |
| **JUnit** | 5.10.0 | Framework de testing |
| **Git** | 2.25+ | Control de versiones |

### Versiones Específicas del Proyecto

```
Java:           11.x mínimo, 17.x recomendado
Gradle:         7.6+ (build.gradle.kts) ⭐ RECOMENDADO
Karate:         1.4.1
JUnit:          5.10.0
Plugin:         Java
```

---

## 📦 Instalación

### Paso 1: Verificar Java

```bash
java -version
# Output esperado: java version "17.x.x" (o superior)
# si usa OpenJDK: openjdk version "17.x.x"
```

**Si no tiene Java:**
- Windows: Descargar desde https://adoptium.net (Eclipse Temurin)
- macOS: `brew install java17`
- Linux: `sudo apt-get install openjdk-17-jdk`

### Paso 2: Verificar Gradle

#### **Opción A: Verificar Gradle (RECOMENDADO)**

```bash
gradle --version
# Output esperado: Gradle 7.6 o superior

# Si usa Gradle Wrapper (recomendado):
./gradlew --version  # En macOS/Linux
gradlew --version    # En Windows

# Output esperado: Gradle 7.6+
```


**Si no tiene Gradle:**
- Windows: Descargar desde https://gradle.org/releases/
- macOS: `brew install gradle`
- Linux: `sudo apt-get install gradle`

**O usar Gradle Wrapper (incluido en proyecto):**
```bash
# No necesita instalación global, usa la versión del proyecto
./gradlew tasks  # Descargar y usar automáticamente
```

### Paso 3: Descargar y Preparar el Proyecto

```bash
# Clonar repositorio (si está en git)
git clone <repository-url>
cd demo-qa-karate

# Verificar estructura
ls src/test/resources/features/
# Output esperado:
# - pet.feature
# - getById-consultas.feature
# - validacion-campos-vacios.feature
# - updatePet.feature

# Verificar Gradle Wrapper
ls gradlew
ls gradlew.bat  # En Windows
```

### Paso 4: Descargar Dependencias

#### **Opción A: Con Gradle Wrapper (RECOMENDADO)**

```bash
# En Windows
gradlew.bat clean build

# En macOS/Linux
./gradlew clean build

# Esto descargará:
# - Gradle (si no existe)
# - Karate framework 1.4.1
# - JUnit 5.10.0
# - Cucumber
# - Otras dependencias
```

#### **Opción B: Con Gradle instalado globalmente**

```bash
gradle clean build

# O solo descargar dependencias
gradle dependencies
```


---

## 🚀 Instrucciones de Ejecución Paso a Paso

### Opción 1: Ejecutar TODOS los Tests (RECOMENDADO)

#### **Opción A: Con Gradle Wrapper (RECOMENDADO)**

```bash
# En Windows
gradlew.bat clean test

# En macOS/Linux
./gradlew clean test

# Paso 3: Ver reportes
# Abierto automáticamente en navegador después de completar
# O manualmente: build/reports/karate-reports/index.html
```

#### **Opción B: Con Gradle instalado**

```bash
gradle clean test

# Ver reportes
# build/reports/karate-reports/index.html



**Tiempo estimado:** 15-30 segundos  
**Output esperado:** "BUILD SUCCESS"

---

### Opción 2: Ejecutar SOLO Pruebas de Creación (POST /pet)

#### **Con Gradle Wrapper**

```bash
# En Windows
gradlew.bat test --tests "*" -Dkarate.options="--tags @CA-01"

# En macOS/Linux
./gradlew test --tests "*" -Dkarate.options="--tags @CA-01"
```

**Output esperado:**
```
✅ MASCOTA CREADA Y DATOS GUARDADOS
ID Guardado: 456789
Variables compartidas listas para otros features
```

**Nota:** Este step DEBE ejecutarse antes de las consultas (GB-*)

---

### Opción 3: Ejecutar SOLO Pruebas de Consulta (GET /pet/{petId})

**IMPORTANTE:** Debe haber ejecutado @CA-01 primero

#### **Con Gradle Wrapper**

```bash
# En Windows
gradlew.bat test --tests "*" -Dkarate.options="--tags @GB"

# En macOS/Linux
./gradlew test --tests "*" -Dkarate.options="--tags @GB"
```



**Ejecutará scenarios:**
```
[GB-01] Obtener mascota por ID
[GB-02] Validar estructura respuesta
[GB-03] Validar tipos de datos
[GB-04] Validar campos requeridos
[GB-05] Validar datos no vacíos
[GB-06] Mostrar datos completos
[GB-07] Verificar ID coincide
```

**Tiempo estimado:** 5-10 segundos

---

### Opción 4: Ejecutar Pruebas de Validación de Campos Vacíos

#### **Con Gradle Wrapper**

```bash
# En Windows
gradlew.bat test --tests "*" -Dkarate.options="--tags @validacion"

# En macOS/Linux
./gradlew test --tests "*" -Dkarate.options="--tags @validacion"
```


**Ejecutará scenarios:**
```
[VCV-01] Detectar name vacío
[VCV-02] Detectar photoUrls vacío
... hasta [VCV-15] Helper isValidUrl
```

**Tiempo estimado:** 10-15 segundos

---

### Opción 5: Ejecutar UN Scenario Específico

#### **Con Gradle Wrapper**

```bash
# En Windows
gradlew.bat test --tests "*" -Dkarate.options="--tags @CA-01"

# En macOS/Linux
./gradlew test --tests "*" -Dkarate.options="--tags @CA-01"
```



---

### Opción 6: Ejecutar con Verbosidad (para debugging)

#### **Con Gradle Wrapper**

```bash
# En Windows
gradlew.bat test --tests "*" -Dkarate.options="-T 1 -v"

# En macOS/Linux
./gradlew test --tests "*" -Dkarate.options="-T 1 -v"

# -T 1 = Un thread a la vez
# -v = Verbose (más output)
```



---

### Ver Reportes HTML

#### **Con Gradle**

```bash
# Los reportes se generan en:
build/reports/karate-reports/index.html

# En Windows
start build\reports\karate-reports\index.html

# En macOS
open build/reports/karate-reports/index.html

# En Linux
xdg-open build/reports/karate-reports/index.html

# O abrir directamente desde navegador
file:///C:/Users/albas/IdeaProjects/demo-qa-karate/build/reports/karate-reports/index.html
```

#### **Con Maven**

```bash
# Los reportes se generan en:
target/karate-reports/index.html

# En Windows
start target\karate-reports\index.html

# En macOS
open target/karate-reports/index.html

# En Linux
xdg-open target/karate-reports/index.html
```

---

## 📊 Descripción de Pruebas

### 1. Pruebas de Creación - pet.feature

| ID | Nombre | Descripción | Tag |
|----|--------|----------|-----|
| **POST-01** | Crear mascota y guardar ID | POST /pet + Guardar ID en variable global | `@create` |
| **POST-02** | Validar estado available | Verificar que status = 'available' | `@create` |
| **POST-03** | Validar datos en body | Verificar que POST retorna datos | `@create` |
| **POST-04** | Validar campos requeridos | Verificar name es requerido | `@create` |
| **POST-05** | Body vacío retorna error | Enviar {} y esperar status != 200 | `@create` |

**URL Base:** https://petstore.swagger.io/v2  
**Endpoint:** POST /pet  
**Datos:** src/test/resources/data/createPet.json  
**Ejecutar:** `gradlew test --tests "*" -Dkarate.options="--tags @create"` o `mvn test -Dtest=KarateTest -Dkarate.options="--tags @create"`

---

### 2. Pruebas de Consulta - pet.feature (GET)

| ID | Nombre | Descripción | Tag |
|----|--------|----------|-----|
| **GET-01** | Obtener por ID | GET /pet/{petId} | `@get-by-id` |
| **GET-02** | ID inexistente → 404 | Verificar error handling | `@get-by-id` |
| **GET-03** | Verificar ID coincide | Comparar ID en respuesta | `@get-by-id` |
| **GET-04** | Validar datos no vacíos | Verificar que campos tienen valores | `@get-by-id` |

**Endpoint:** GET /pet/{petId}  
**Ejecutar:** `gradlew test --tests "*" -Dkarate.options="--tags @get-by-id"` o `mvn test -Dtest=KarateTest -Dkarate.options="--tags @get-by-id"`

---

### 3. Pruebas de Actualización - pet.feature (PUT)

| ID | Nombre | Descripción | Tag |
|----|--------|----------|-----|
| **PUT-01** | Actualizar nombre y status | PUT /pet con cambios | `@update` |
| **PUT-02** | PUT con ID inexistente | Verificar error handling | `@update` |

**Endpoint:** PUT /pet  
**Ejecutar:** `gradlew test --tests "*" -Dkarate.options="--tags @update"` o `mvn test -Dtest=KarateTest -Dkarate.options="--tags @update"`

---

### 4. Pruebas de Búsqueda por Status - pet.feature

| ID | Nombre | Descripción | Tag |
|----|--------|----------|-----|
| **Status-01** | Buscar status available | GET /pet/findByStatus con param | `@smoke` `@find-by-status` |
| **Status-02** | findByStatus sin parámetro | Verificar validación requerida | `@smoke` `@find-by-status` |
| **Status-03** | findByStatus con status vacío | Verificar manejo de valor vacío | `@smoke` `@find-by-status` |

**Endpoint:** GET /pet/findByStatus  
**Ejecutar:** `gradlew test --tests "*" -Dkarate.options="--tags @find-by-status"` o `mvn test -Dtest=KarateTest -Dkarate.options="--tags @find-by-status"`  
**Smoke Tests:** `gradlew test --tests "*" -Dkarate.options="--tags @smoke"` o `mvn test -Dtest=KarateTest -Dkarate.options="--tags @smoke"`

---

## 🏷️ Referencia Rápida de Tags

### Ejecutar por Tipo de Prueba

```bash
# Todas las pruebas de CREACIÓN (POST)
./gradlew test --tests "*" -Dkarate.options="--tags @create"
mvn test -Dtest=KarateTest -Dkarate.options="--tags @create"

# Todas las pruebas de CONSULTA (GET)
./gradlew test --tests "*" -Dkarate.options="--tags @get-by-id"
mvn test -Dtest=KarateTest -Dkarate.options="--tags @get-by-id"

# Todas las pruebas de ACTUALIZACIÓN (PUT)
./gradlew test --tests "*" -Dkarate.options="--tags @update"
mvn test -Dtest=KarateTest -Dkarate.options="--tags @update"

# Todas las pruebas de BÚSQUEDA
./gradlew test --tests "*" -Dkarate.options="--tags @find-by-status"
mvn test -Dtest=KarateTest -Dkarate.options="--tags @find-by-status"

# SMOKE TESTS (pruebas rápidas)
./gradlew test --tests "*" -Dkarate.options="--tags @smoke"
mvn test -Dtest=KarateTest -Dkarate.options="--tags @smoke"
```

### Ejecutar por ID de Scenario

```bash
# Scenario específico [POST-01]
./gradlew test --tests "*" -Dkarate.options="--tags @POST-01"
mvn test -Dtest=KarateTest -Dkarate.options="--tags @POST-01"

# Scenario específico [GET-02]
./gradlew test --tests "*" -Dkarate.options="--tags @GET-02"
mvn test -Dtest=KarateTest -Dkarate.options="--tags @GET-02"
```

### Combinar Tags (AND)

```bash
# Scenarios con AMBOS tags: @smoke AND @get-by-id
./gradlew test --tests "*" -Dkarate.options="--tags @smoke and @get-by-id"
mvn test -Dtest=KarateTest -Dkarate.options="--tags @smoke and @get-by-id"
```

### Excluir Tags (NOT)

```bash
# Todos EXCEPTO @update
./gradlew test --tests "*" -Dkarate.options="--tags not @update"
mvn test -Dtest=KarateTest -Dkarate.options="--tags not @update"
```

---

## 📊 Matriz de Tags

| Tag | Descripción | Scenarios | Ejecutar |
|-----|------------|-----------|----------|
| `@create` | Pruebas de creación (POST) | 5 | `--tags @create` |
| `@get-by-id` | Pruebas de consulta (GET) | 4 | `--tags @get-by-id` |
| `@update` | Pruebas de actualización (PUT) | 2 | `--tags @update` |
| `@find-by-status` | Pruebas de búsqueda | 3 | `--tags @find-by-status` |
| `@smoke` | Pruebas rápidas (smoke tests) | 3 | `--tags @smoke` |

**Total Scenarios:** 17  
**Total Tags Únicos:** 5

---

## 📁 Estructura del Proyecto

```
demo-qa-karate/
├── src/
│   ├── test/
│   │   ├── java/
│   │   │   └── KarateTest.java              (Runner de Karate)
│   │   └── resources/
│   │       ├── features/
│   │       │   ├── pet.feature              (Pruebas POST/Validación)
│   │       │   ├── getById-consultas.feature (Pruebas GET)
│   │       │   ├── validacion-campos-vacios.feature
│   │       │   └── README_GET_PET.md        (Documentación)
│   │       ├── data/
│   │       │   ├── createPet.json           (Body para POST)
│   │       │   └── createPetEmptyFields.json
│   │       ├── validations.js               (Librería de validaciones)
│   │       ├── VALIDATIONS_GUIDE.md         (Guía de funciones)
│   │       └── karate-config.js             (Configuración global)
│   └── README.md                            (Este archivo)
├── build.gradle.kts                         (Configuración Gradle)
├── pom.xml (si existe)                      (Configuración Maven)
├── target/
│   └── karate-reports/
│       ├── index.html                       (Reporte HTML)
│       └── features.pet.json                (Resultados JSON)
└── README.md                                (Este archivo)
```

---




---

### 3. Validaciones Implementadas

| Validación | Tipo | Estado |
|-----------|------|--------|
| Status código HTTP | Funcional | ✅ |
| Estructura de respuesta | Funcional | ✅ |
| Tipos de datos | Estructura | ✅ |
| Campos requeridos | Validación | ✅ |
| Datos no vacíos | Validación | ✅ |
| Valores en enums | Validación | ✅ |
| URLs válidas | Validación | ✅ |
| Emails válidos | Validación | ✅ |
| Persistencia de datos | Integridad | ✅ |
| Error handling (404) | Error | ✅ |

---



---

## 📊 Estadísticas del Proyecto

| Métrica | Valor |
|---------|-------|
| **Total Scenarios** | 22+ |
| **Funciones de Validación** | 10 |
| **Archivos Feature** | 4 |
| **Líneas de Código Karate** | ~400+ |
| **Líneas de Código JavaScript** | ~250 |
| **Archivos de Documentación** | 8+ |
| **Cobertura de Endpoints** | 60% (3 de 5) |
| **Tiempo de Ejecución Total** | ~30 segundos |

---

## 📚 Referencias

- **Karate Docs:** https://github.com/karatelabs/karate
- **PetStore API:** https://petstore.swagger.io/v2
- **Cucumber/Gherkin:** https://cucumber.io/docs/gherkin/
- **Maven:** https://maven.apache.org/
- **Java Docs:** https://docs.oracle.com/en/java/

---



---


