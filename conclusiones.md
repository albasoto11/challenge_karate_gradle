## ✅ Conclusiones



### 1. Validaciones Implementadas

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

### 2. Problemas Encontrados en la API

#### API Acepta Campos Vacíos
**Hallazgo:** POST /pet acepta `name: ""` sin rechazarlo  
**Gravedad:** ⚠️ Media (debería validar)  
**Recomendación:** Agregar validación en servidor

#### API Acepta Status Fuera del Enum
**Hallazgo:** POST /pet acepta `status: "invalid"` sin error  
**Gravedad:** ⚠️ Media (debería rechazar)  
**Recomendación:** Implementar validación de enum

#### photoUrls Acepta URLs Inválidas
**Hallazgo:** POST /pet acepta URLs malformadas  
**Gravedad:** ⚠️ Baja (funciona pero debería validar)  
**Recomendación:** Agregar validación de URL format

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




