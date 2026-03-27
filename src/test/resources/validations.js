/**
 * Librería de Validaciones para Pruebas Karate
 * Valida campos vacíos, nulos y requeridos
 */

function isEmptyString(value) {
    return value === '' || value === null || value === undefined;
}

function isEmptyArray(value) {
    return !Array.isArray(value) || value.length === 0;
}

function isValidEmail(email) {
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

function isValidUrl(url) {
    try {
        new java.net.URL(url);
        return true;
    } catch (e) {
        return false;
    }
}

function validateRequiredFields(obj, requiredFields) {
    var missingFields = [];
    for (var i = 0; i < requiredFields.length; i++) {
        var field = requiredFields[i];
        if (isEmptyString(obj[field])) {
            missingFields.push(field);
        }
    }
    return {
        isValid: missingFields.length === 0,
        missingFields: missingFields
    };
}

function validateEmptyStrings(obj, fields) {
    var emptyFields = [];
    for (var i = 0; i < fields.length; i++) {
        var field = fields[i];
        if (obj[field] !== undefined && isEmptyString(obj[field])) {
            emptyFields.push(field);
        }
    }
    return {
        hasEmptyStrings: emptyFields.length > 0,
        emptyFields: emptyFields
    };
}

function validateEmptyArrays(obj, fields) {
    var emptyArrays = [];
    for (var i = 0; i < fields.length; i++) {
        var field = fields[i];
        if (obj[field] !== undefined && isEmptyArray(obj[field])) {
            emptyArrays.push(field);
        }
    }
    return {
        hasEmptyArrays: emptyArrays.length > 0,
        emptyArrayFields: emptyArrays
    };
}

function validateFieldTypes(obj, expectedTypes) {
    var typeErrors = [];
    for (var field in expectedTypes) {
        var expectedType = expectedTypes[field];
        var actualType = typeof obj[field];
        if (obj[field] !== undefined && actualType !== expectedType) {
            typeErrors.push({
                field: field,
                expected: expectedType,
                actual: actualType
            });
        }
    }
    return {
        isValid: typeErrors.length === 0,
        errors: typeErrors
    };
}

function validatePetObject(pet) {
    var validation = {
        isValid: true,
        errors: [],
        warnings: []
    };

    // Campos requeridos
    var requiredFields = validateRequiredFields(pet, ['name', 'photoUrls', 'status']);
    if (!requiredFields.isValid) {
        validation.isValid = false;
        validation.errors.push('Campos requeridos faltantes: ' + requiredFields.missingFields.join(', '));
    }

    // Validar que photoUrls no esté vacío
    if (pet.photoUrls !== undefined) {
        if (isEmptyArray(pet.photoUrls)) {
            validation.isValid = false;
            validation.errors.push('photoUrls no puede estar vacío');
        } else {
            // Validar que cada URL sea válida
            for (var i = 0; i < pet.photoUrls.length; i++) {
                if (!isValidUrl(pet.photoUrls[i])) {
                    validation.warnings.push('URL inválida en photoUrls[' + i + ']: ' + pet.photoUrls[i]);
                }
            }
        }
    }

    // Validar status enum
    var validStatuses = ['available', 'pending', 'sold'];
    if (pet.status !== undefined && validStatuses.indexOf(pet.status) === -1) {
        validation.warnings.push('Status "' + pet.status + '" no está en enum válido: ' + validStatuses.join(', '));
    }

    // Validar que name no esté vacío
    if (pet.name !== undefined && isEmptyString(pet.name)) {
        validation.isValid = false;
        validation.errors.push('name no puede estar vacío');
    }

    // Validar structure de category si existe
    if (pet.category !== undefined && typeof pet.category === 'object') {
        if (pet.category.name !== undefined && isEmptyString(pet.category.name)) {
            validation.warnings.push('category.name está vacío');
        }
    }

    return validation;
}

function validateResponseFields(response, requiredFields) {
    var missingFields = [];
    for (var i = 0; i < requiredFields.length; i++) {
        var field = requiredFields[i];
        if (response[field] === undefined || response[field] === null) {
            missingFields.push(field);
        }
    }
    return {
        isValid: missingFields.length === 0,
        missingFields: missingFields,
        hasAllFields: function() { return this.isValid; }
    };
}

// Exportar funciones
var exports = {
    isEmptyString: isEmptyString,
    isEmptyArray: isEmptyArray,
    isValidEmail: isValidEmail,
    isValidUrl: isValidUrl,
    validateRequiredFields: validateRequiredFields,
    validateEmptyStrings: validateEmptyStrings,
    validateEmptyArrays: validateEmptyArrays,
    validateFieldTypes: validateFieldTypes,
    validatePetObject: validatePetObject,
    validateResponseFields: validateResponseFields
};
