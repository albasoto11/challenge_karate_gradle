// karate-config.js
// Ubicación: src/test/java/karate-config.js
// Configuración global — cargada automáticamente por Karate en cada ejecución

function fn() {
    var env = karate.env || 'qa';
    karate.log('==============================');
    karate.log('  KARATE ENV:', env);
    karate.log('==============================');

    var config = {};


    config.baseUrl = 'https://petstore.swagger.io/v2';



    karate.log('  Base URL:', config.baseUrl);

    // ── Timeouts globales ─────────────────────────────────────
    karate.configure('connectTimeout', 10000);
    karate.configure('readTimeout',    15000);


    // ── Headers por defecto ───────────────────────────────────
    karate.configure('headers', {
        'Content-Type': 'application/json',
        'Accept':       'application/json'
    });

    // ── Body base de mascota (estructura oficial Swagger) ─────
    // Refleja exactamente el schema de https://petstore.swagger.io/v2/pet/
    config.defaultPetBody = {
        id: 0,
        category: {
            id: 0,
            name: 'string'
        },
        name: 'doggie',
        photoUrls: ['string'],
        tags: [
            { id: 0, name: 'string' }
        ],
        status: 'available'
    };

    // ── Utilidades ────────────────────────────────────────────
    config.generateId   = function() { return Math.floor(Math.random() * 900000) + 100000; };
    config.generateName = function(prefix) { return (prefix || 'Pet') + '_' + Date.now(); };

    // ── Datos válidos de referencia ───────────────────────────
    config.validStatuses   = ['available', 'pending', 'sold'];
    config.defaultPhotoUrl = 'string';

    return config;
}
