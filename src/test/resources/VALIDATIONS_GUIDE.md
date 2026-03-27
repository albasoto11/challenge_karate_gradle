# 📋 Guía de Validaciones para Campos Vacíos

## Descripción
Librería de validaciones reutilizable para pruebas Karate que detecta y valida campos vacíos, nulos, arrays vacíos y tipos de datos.

## Archivos
- **`validations.js`** - Librería JavaScript con funciones de validación
- **`validacion-campos-vacios.feature`** - Scenarios de prueba completos

## Funciones Disponibles

### 1. `isEmptyString(value)`
Verifica si un valor es un string vacío, null o undefined.
```gherkin
* def isEmptyString = validations.isEmptyString
* match isEmptyString('') == true
* match isEmptyString(null) == true
* match isEmptyString('value') == false
```

### 2. `isEmptyArray(value)`
Verifica si un array está vacío.
```gherkin
* def isEmptyArray = validations.isEmptyArray
* match isEmptyArray([]) == true
* match isEmptyArray(['item']) == false
```

### 3. `isValidUrl(url)`
Valida que una URL tenga formato correcto.
```gherkin
* def isValidUrl = validations.isValidUrl
* match isValidUrl('https://example.com') == true
* match isValidUrl('not-a-url') == false
```

### 4. `isValidEmail(email)`
Valida formato de email con regex.
```gherkin
* def isValidEmail = validations.isValidEmail
* match isValidEmail('user@example.com') == true
```

### 5. `validateRequiredFields(obj, requiredFields[])`
Valida que todos los campos requeridos estén presentes y no vacíos.
```gherkin
* def obj = { name: 'Pet', status: 'available' }
* def result = validations.validateRequiredFields(obj, ['name', 'status', 'photoUrls'])
* match result.isValid == false
* match result.missingFields contains 'photoUrls'
```

### 6. `validateEmptyStrings(obj, fields[])`
Detecta strings vacíos en campos específicos.
```gherkin
* def obj = { name: '', description: 'value', category: '' }
* def result = validations.validateEmptyStrings(obj, ['name', 'description', 'category'])
* match result.hasEmptyStrings == true
* match result.emptyFields.length == 2
```

### 7. `validateEmptyArrays(obj, fields[])`
Detecta arrays vacíos en campos específicos.
```gherkin
* def obj = { tags: [], photoUrls: ['url1'] }
* def result = validations.validateEmptyArrays(obj, ['tags', 'photoUrls'])
* match result.hasEmptyArrays == true
* match result.emptyArrayFields contains 'tags'
```

### 8. `validateFieldTypes(obj, expectedTypes{})`
Valida que los tipos de datos sean correctos.
```gherkin
* def obj = { name: 'Pet', id: '123', tags: [] }
* def types = { name: 'string', id: 'number', tags: 'object' }
* def result = validations.validateFieldTypes(obj, types)
* match result.isValid == false
* match result.errors.length > 0
```

### 9. `validatePetObject(pet)`
Validación completa para objeto Pet (API específica).
```gherkin
* def pet = { id: 123, name: 'Fluffy', photoUrls: ['url'], status: 'available' }
* def result = validations.validatePetObject(pet)
* match result.isValid == true
* match result.errors.length == 0
```

Valida:
- ✅ Campos requeridos: name, photoUrls, status
- ✅ Que photoUrls no esté vacío
- ✅ Que name no esté vacío
- ✅ Status en enum: ['available', 'pending', 'sold']
- ✅ URLs válidas en photoUrls
- ⚠️ Genera warnings para campos sospechosos

### 10. `validateResponseFields(response, requiredFields[])`
Valida que respuesta API tenga campos requeridos.
```gherkin
* def response = { id: 123, name: 'Pet' }
* def result = validations.validateResponseFields(response, ['id', 'name', 'status'])
* match result.isValid == false
* match result.missingFields contains 'status'
```

## Ejemplos de Uso en Scenarios

### Ejemplo 1: Validar request antes de enviar
```gherkin
Scenario: POST /pet con validación de campos
  Given url baseUrl + '/pet'
  * def payload = { id: 123, name: 'Fluffy', photoUrls: ['url'], status: 'available' }
  * def validation = validations.validatePetObject(payload)
  * match validation.isValid == true
  And request payload
  When method POST
  Then status 200
```

### Ejemplo 2: Detectar campos vacíos en payload
```gherkin
Scenario: Detectar name vacío
  * def invalidPayload = { id: 123, name: '', photoUrls: ['url'], status: 'available' }
  * def validation = validations.validatePetObject(invalidPayload)
  * match validation.isValid == false
  * match validation.errors[0] contains 'name no puede estar vacío'
  * print '✓ Validación detectó el error'
```

### Ejemplo 3: Validar respuesta de API
```gherkin
Scenario: Validar respuesta tiene todos los campos
  Given url baseUrl + '/pet/123'
  When method GET
  Then status 200
  * def responseValidation = validations.validateResponseFields(response, ['id', 'name', 'status', 'photoUrls'])
  * match responseValidation.isValid == true
```

### Ejemplo 4: Validación de tipos
```gherkin
Scenario: Validar tipos en respuesta
  Given url baseUrl + '/pet'
  * def payload = { name: 'Pet', id: 123, active: true }
  * def types = { name: 'string', id: 'number', active: 'boolean' }
  * def typeValidation = validations.validateFieldTypes(payload, types)
  * match typeValidation.isValid == true
```

## Ejecutar Tests de Validación

```bash
# Ejecutar todos los scenarios de validación
mvn test -Dkarate.options="--tags @validation" -Dtest=KarateTest

# Ejecutar un scenario específico
mvn test -Dtest=KarateTest -Dkarate.options="--tags @VCV-01"

# Ejecutar con reporte
mvn clean test -Dtest=KarateTest
```

## Estructura de Respuesta de Validación

### Para `validatePetObject()`:
```json
{
  "isValid": true/false,
  "errors": ["error1", "error2"],
  "warnings": ["warning1"]
}
```

### Para `validateRequiredFields()`:
```json
{
  "isValid": true/false,
  "missingFields": ["field1", "field2"]
}
```

### Para `validateEmptyStrings()`:
```json
{
  "hasEmptyStrings": true/false,
  "emptyFields": ["field1", "field2"]
}
```

### Para `validateFieldTypes()`:
```json
{
  "isValid": true/false,
  "errors": [
    {
      "field": "fieldName",
      "expected": "string",
      "actual": "number"
    }
  ]
}
```

## Casos de Uso en QA

| Caso | Función | Descripción |
|------|---------|------------|
| Validar request | `validatePetObject()` | Verifica payload antes de enviar |
| Detectar blancos | `validateEmptyStrings()` | Busca strings vacíos |
| Detectar arrays vacíos | `validateEmptyArrays()` | Busca arrays sin elementos |
| Campos faltantes | `validateRequiredFields()` | Verifica campos obligatorios |
| Tipos incorrectos | `validateFieldTypes()` | Valida tipos de datos |
| Respuesta API | `validateResponseFields()` | Verifica campos en respuesta |

## Notas Importantes

✅ **Validaciones detectan:**
- Strings vacíos: `''`
- Valores null/undefined
- Arrays vacíos: `[]`
- Tipos de datos incorrectos
- URLs/Emails inválidas
- Valores no en enum

⚠️ **Warnings (no bloquean):**
- Status fuera de enum
- URLs con formato sospechoso
- Campos opcionales vacíos

❌ **Errores (bloquean):**
- Campos requeridos faltantes
- Campos requeridos vacíos
- Arrays requeridos vacíos

## Extender Validaciones

Para agregar nuevas funciones a `validations.js`:

```javascript
function validateCustomField(obj, fieldName, condition) {
    return {
        isValid: condition(obj[fieldName]),
        field: fieldName,
        value: obj[fieldName]
    };
}

// Luego exportarla
// exports.validateCustomField = validateCustomField;
```

---
**Última actualización:** 2026-03-27
**Versión:** 1.0
