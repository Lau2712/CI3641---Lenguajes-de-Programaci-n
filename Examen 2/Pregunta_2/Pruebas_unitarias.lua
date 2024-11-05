local Evaluador = require("Examen 2.Pregunta_2.Pregunta_2")

-- Definimos la función para validar la salida
local function assert_salida(salida_esperada, func, nodo)
    local old_print = print
    local output = ""
    print = function(s) output = tostring(s) end
    print(func(nodo))  -- Added print here to capture the function result
    print = old_print
    assert(output == salida_esperada, string.format("\nSalida esperada:\n%s\nObtenida:\n%s", salida_esperada, output))
end

local pruebas = {
    -- Test EVAL prefijo básico
    test_eval_prefijo_simple = function()
        local eval = Evaluador
        local nodo = (eval.construirPrefijo({"+", "3", "4"}, 1))
        assert_salida("7", eval.evaluar, nodo)
    end,

    -- Test EVAL prefijo complejo
    test_eval_prefijo_complejo = function()
        local eval = Evaluador
        local nodo = (eval.construirPrefijo({"+", "*", "+", "3", "4", "5", "7"}, 1))
        assert_salida("42", eval.evaluar, nodo)
    end,

    -- Test EVAL postfijo básico
    test_eval_postfijo_simple = function()
        local eval = Evaluador
        local nodo = (eval.construirPostfijo({"8", "3", "-"}, 3))
        assert_salida("5", eval.evaluar, nodo)
    end,

    -- Test EVAL postfijo complejo
    test_eval_postfijo_complejo = function()
        local eval = Evaluador
        local nodo = (eval.construirPostfijo({"8", "3", "-", "8", "4", "4", "+", "*", "+"}, 9))
        assert_salida("69", eval.evaluar, nodo)
    end,

    -- Test MOSTRAR prefijo básico
    test_mostrar_prefijo_simple = function()
        local eval = Evaluador
        local nodo = (eval.construirPrefijo({"+", "3", "4"}, 1))
        assert_salida("3 + 4", eval.convertirInfija, nodo)
    end,

    -- Test MOSTRAR prefijo complejo
    test_mostrar_prefijo_complejo = function()
        local eval = Evaluador
        local nodo = (eval.construirPrefijo({"+", "*", "+", "3", "4", "5", "7"}, 1))
        assert_salida("(3 + 4) * 5 + 7", eval.convertirInfija, nodo)
    end,

    -- Teste MOSTRAR postfijo básico
    test_mostrar_postfijo_simple = function()
        local eval = Evaluador
        local nodo = (eval.construirPostfijo({"8", "3", "-"}, 3))
        assert_salida("8 - 3", eval.convertirInfija, nodo)
    end,

    -- Test MOSTRAR postfijo complejo
    test_mostrar_postfijo_complejo = function()
        local eval = Evaluador
        local nodo = (eval.construirPostfijo({"8", "3", "-", "8", "4", "4", "+", "*", "+"}, 9))
        assert_salida("8 - 3 + 8 * (4 + 4)", eval.convertirInfija, nodo)
    end,

    -- Test para validar que la división entera funcione correctamente
    test_division_entera = function()
        local eval = Evaluador
        local nodo = (eval.construirPrefijo({"/", "10", "3"}, 1))
        assert_salida("3", eval.evaluar, nodo)
    end,

    -- Test para validar la precedencia de los operadores
    test_precedencia_operadores = function()
        local eval = Evaluador
        local nodo = (eval.construirPrefijo({"+", "2", "*", "3", "4"}, 1))
        assert_salida("14", eval.evaluar, nodo)
    end
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
