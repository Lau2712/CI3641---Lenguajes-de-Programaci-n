local Cuaternion = require "Examen 1.Pregunta_4.Pregunta_a"

local function assert_equal(expected, actual, message)
    if expected ~= actual then
        error(message or string.format("Error: se esperaba %s, pero se obtuvo %s", tostring(expected), tostring(actual)))
    end
end

local function assert_near(expected, actual, delta, message)
    if math.abs(expected - actual) > delta then
        error(message or string.format("Error: se esperaba %s pero esta cerca %s (within %s)", tostring(actual), tostring(expected), tostring(delta)))
    end
end

local pruebas = {
    test_crear_cuaternion = function()
        local q = Cuaternion(1, 2, 3, 4)
        assert_equal(1, q.a)
        assert_equal(2, q.b)
        assert_equal(3, q.c)
        assert_equal(4, q.d)
    end,

    test_suma_cuaterniones = function()
        local q1 = Cuaternion(1, 2, 3, 4)
        local q2 = Cuaternion(5, 6, 7, 8)
        local result = q1 + q2
        assert_equal("6.00 + 8.00i + 10.00j + 12.00k", tostring(result))
    end,

    test_sumar_cuaternion_y_entero = function()
        local q = Cuaternion(1, 2, 3, 4)
        local result = q + 5
        assert_equal("6.00 + 2.00i + 3.00j + 4.00k", tostring(result))
    end,

    test_multiplicar_cuaterniones = function()
        local q1 = Cuaternion(1, 2, 3, 4)
        local q2 = Cuaternion(5, 6, 7, 8)
        local result = q1 * q2
        assert_equal("-60.00 + 12.00i + 30.00j + 24.00k", tostring(result))
    end,

    test_multiplicar_cuaternion_y_entero = function()
        local q = Cuaternion(1, 2, 3, 4)
        local result = q * 2
        assert_equal("2.00 + 4.00i + 6.00j + 8.00k", tostring(result))
    end,

    test_cuaternion_conjugado = function()
        local q = Cuaternion(1, 2, 3, 4)
        local result = q:conjugar()
        assert_equal("1.00 + -2.00i + -3.00j + -4.00k", tostring(result))
    end,

    test_valor_absoluto_cuaternion = function()
        local q = Cuaternion(1, 2, 3, 4)
        local result = q:medida()
        assert_near(5.477, result, 0.001)
    end,

    test_ejecucion_compleja = function()
        local a = Cuaternion(1, 2, 3, 4)
        local b = Cuaternion(5, 6, 7, 8)
        local c = Cuaternion(9, 10, 11, 12)
        local result = (b + b) * (c + a:conjugar())
        assert_equal("-236.00 + 184.00i + 252.00j + 224.00k", tostring(result))
    end,
}

local fallidas = 0
local aprobadas = 0

for nombre, funcion_prueba in pairs(pruebas) do
    io.write("Corriendo test " .. nombre .. "... ")
    local estado, error = pcall(funcion_prueba)
    if estado then
        print("APROBADA")
        aprobadas = aprobadas + 1
    else
        print("FALLIDA")
        print(error)
        fallidas = fallidas + 1
    end
end

print("\nResultados de las pruebas:")
print("Aprobadas: " .. aprobadas)
print("Fallidas: " .. fallidas)
print("Total: " .. (aprobadas + fallidas))