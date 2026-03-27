Feature: Pruebas Automatizadas - API PET
   # Base URL : https://petstore.swagger.io/v2
  # Endpoint : POST   /pet/
  #            GET    /pet/{petId}
  #            PUT    /pet/
  #            GET    /pet/findByStatus

  Background:
    # ID único por ejecución para evitar colisiones
    * def petId   = Math.floor(Math.random() * 900000) + 100000
    * def petName = 'Pet_' + petId
    * def bodyBase = read('classpath:/data/createPet.json')
    * def bodyUpdate = read('classpath:/data/updatePet.json')


# ═══════════════════════════════════════════════════════════════
  # 1. AÑADIR MASCOTA  →  POST /pet/
  # ═══════════════════════════════════════════════════════════════
  @create
  Scenario: [POST-01] Crear mascota y guardar ID para consulta posterior
    Given url baseUrl + '/pet'
    And request bodyBase
    When method POST
    Then status 200
    * def globalPetId = response.id
    * def globalPetName = response.name
    * def globalPetStatus = response.status
    # Guardar en variable global de Karate para uso en getById.feature
    * karate.set('createdPetId', globalPetId)
    * karate.set('createdPetName', globalPetName)
    * karate.set('createdPetStatus', globalPetStatus)
    * print '✅ Mascota creada y guardada: ID=' + globalPetId + ' | Nombre=' + globalPetName

  @create
  Scenario: [POST-02] Validar el estado available del registro
    Given url baseUrl + '/pet'
    And request bodyBase
    When method POST
    Then status 200
    And match response.status     == 'available'
    * print '>>> El estado no es available', response.status
  @create
  Scenario: [POST-03] POST /pet/ tiene datos en el cuerpo
    Given url baseUrl + '/pet/'
    And request bodyBase
    When method POST
    Then status 200
    And match response.name == ''
    * print '>>> ALERTA QA: API acepta nombre vacio
  @create
  Scenario: [POST-04] POST /pet/ sin el campo name (campo requerido)
    Given url baseUrl + '/pet/'
    And request bodyBase
    When method POST
    Then status 200
    * print '>>> ALERTA QA: API acepta body sin el campo "name" requerido'
  @create
  Scenario: [POST-05] No puede tener body vacío {}
    Given url baseUrl + '/pet/'
    And request {}
    When method POST
    # Se espera error de validación, no 200
    Then status != 200
    * print '>>> Body vacío respondió con status:', responseStatus

# ═══════════════════════════════════════════════════════════════
  # 2. OBTENER MASCOTA POR ID → GET /pet/{petId}
  # ═══════════════════════════════════════════════════════════════
  @get-by-id
  Scenario: [GET-01] Consultar GET /pet/{petId} - Consultar por ID
    Given url baseUrl + '/pet/354061'
    When method GET
    Then status 200
    * def retrievedPet = response
    * print '✓ Mascota consultada por ID:', retrievedPet.id, '| Nombre:', retrievedPet.name

  @get-by-id
#Consultar mascota que no existe
  Scenario: [GET-02] Consultar mascota NO existente
    Given url baseUrl + '/pet/aaaaa'
    When method GET
    Then status 404
    * print '✓ API correctamente retorna 404 para mascota no existente'

  @get-by-id
  Scenario: [GET-03] Consultar ID respuesta coincida con el 354061
    Given url baseUrl + '/pet/354061'
    When method GET
    Then status 200
    And match response.id == 354061
    * print '✓ SI CONINCIDE'

  @get-by-id
  Scenario: [GET-04] Validar que datos no están vacíos
    Given url baseUrl + '/pet/354061'
    When method GET
    Then status 200
    * match response.id != null
    * match response.name != ''
    * match response.status != ''
    * match response.photoUrls !=[]
    * print '✅ Todos los datos tienen valores válidos (no vacíos)'

# ═══════════════════════════════════════════════════════════════
  # 2. Actualizar mascota → GET /pet/{petId}
  # ═══════════════════════════════════════════════════════════════
  @update
  Scenario: [PUT-01] Actualizar nombre y status a "sold"
    # Setup: crear mascota
    Given url baseUrl + '/pet'
    And request bodyBase
    When method POST
    Then status 200
    * def createdId = response.id
    * def updatedName = 'sofia' + createdId
    Given url baseUrl + '/pet'
    And request
    """
  {
  "id": #(createdId),
  "category": { "id": 0, "name": "string" },
  "name": "#(updatedName)",
  "photoUrls": ["string"],
  "tags": [{ "id": 0, "name": "string" }],
  "status": "sold"
  }
  """
    When method PUT
    Then status 200
    And match response.id     == createdId
    And match response.status == 'sold'
    * print '>>> PUT exitoso. Nuevo name:', response.name, '| status:', response.status

    # Verificar persistencia con GET
    Given url baseUrl + '/pet/' + createdId
    When method GET
    Then status 200
    And match response.name   == updatedName
    And match response.status == 'sold'
    * print '>>> Verificación GET post-PUT: PASÓ'

  @update
  Scenario: [PUT-02] PUT /pet/ con ID inexistente
    Given url baseUrl + '/pet/'
    And request
      """
      {
        "id": 999999986,
        "category": { "id": 0, "name": "string" },
        "name": "doggie",
        "photoUrls": ["string"],
        "tags": [{ "id": 0, "name": "string" }],
        "status": "sold"
      }
      """
    When method PUT
    Then status != 500
    * print '>>> ALERTA: Permite actualizar registro con ID inexistente'
 # ═══════════════════════════════════════════════════════════════
  # 4. BUSCAR POR ESTATUS  →  GET /pet/findByStatus
  # ═══════════════════════════════════════════════════════════════

  @smoke @find-by-status
  Scenario: [GET/status-01] Buscar mascotas con status "available"
    Given url baseUrl + '/pet/findByStatus'
    And param status = 'available'
    When method GET
    Then status 200
    * print '>>> Total mascotas available:', response.length

  @smoke @find-by-status
  Scenario: [GET/status-02] findByStatus sin parámetro status
    Given url baseUrl + '/pet/findByStatus'
    When method GET
    Then status = 400
    * print '>>> Sin parámetro status respondió:'
  @smoke @find-by-status
  Scenario: [GET/status-03] findByStatus con status vacío
    Given url baseUrl + '/pet/findByStatus'
    And param status = ''
    When method GET
    Then status 200
    * print '>>> Status vacío retornó:', response.length, 'resultados'