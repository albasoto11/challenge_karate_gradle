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


# ═══════════════════════════════════════════════════════════════
  # 1. AÑADIR MASCOTA  →  POST /pet/
  # ═══════════════════════════════════════════════════════════════

  Scenario: [CA-01] Crear mascota y guardar ID para consulta posterior
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


  Scenario: [CA-02] Validar el estado available del registro
    Given url baseUrl + '/pet'
    And request bodyBase
    When method POST
    Then status 200
    And match response.status     == 'available'
    * print '>>> El estado no es available', response.status

  Scenario: [CA-03] POST /pet/ tiene datos en el cuerpo
    Given url baseUrl + '/pet/'
    And request bodyBase
    When method POST
    Then status 200
    And match response.name == ''
    * print '>>> ALERTA QA: API acepta nombre vacio

  Scenario: [CA-04] POST /pet/ sin el campo name (campo requerido)
    Given url baseUrl + '/pet/'
    And request bodyBase
    When method POST
    Then status 200
    * print '>>> ALERTA QA: API acepta body sin el campo "name" requerido'

  Scenario: [CB-05] No puede tener body vacío {}
    Given url baseUrl + '/pet/'
    And request {}
    When method POST
    # Se espera error de validación, no 200
    Then status != 200
    * print '>>> Body vacío respondió con status:', responseStatus

# ═══════════════════════════════════════════════════════════════
  # 2. OBTENER MASCOTA POR ID → GET /pet/{petId}
  # ═══════════════════════════════════════════════════════════════
  Scenario: [GET-01] Consultar GET /pet/{petId} - Consultar por ID
    Given url baseUrl + '/pet/354061'
    When method GET
    Then status 200
    * def retrievedPet = response
    * print '✓ Mascota consultada por ID:', retrievedPet.id, '| Nombre:', retrievedPet.name

#Consultar mascota que no existe
  Scenario: [GB-05] Consultar mascota NO existente
    Given url baseUrl + '/pet/aaaaa'
    When method GET
    Then status 404
    * print '✓ API correctamente retorna 404 para mascota no existente'

  Scenario: [GB-05] Consultar ID respuesta coincida con el 354061
    Given url baseUrl + '/pet/354061'
    When method GET
    Then status 200
    And match response.id == 354061
    * print '✓ SI CONINCIDE'

  Scenario: [CA-05-getById] Validar que datos no están vacíos
    Given url baseUrl + '/pet/354061'
    When method GET
    Then status 200
    * match response.id != null
    * match response.name != ''
    * match response.status != ''
    * match response.photoUrls !=[]
    * print '✅ Todos los datos tienen valores válidos (no vacíos)'

