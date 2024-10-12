-- Creamos un programa que se encargará de hacer las pruebas unitarias.

local Simulador = require("Examen 1.Pregunta_3.Pregunta_a")

local function assert_salida(salida_esperada, func, ...)
    local old_print = print
    local output = ""
    print = function(s) output = s end
    func(...)
    print = old_print
    assert(output == salida_esperada, string.format("\nSalida esperada:\n%s\nObtenida:\n%s", salida_esperada, output))
end

local pruebas = {
    test_programa = function()
        local sim = Simulador
        sim.programas = {}
        assert_salida("Se ha definido el programa 'fibonacci', ejecutable en 'LOCAL'.", sim.DEFINIR, sim, "PROGRAMA", "fibonacci", "LOCAL")
        assert_salida("Error: ya se ha ingresado un programa con el nombre 'fibonacci'.", sim.DEFINIR, sim, "PROGRAMA", "fibonacci", "Java")
    
    end,

    test_interprete = function()
        local sim = Simulador
        sim.interpretes = {}
        assert_salida("Se definió un interprete para 'Java', escrito en 'C'.", sim.DEFINIR, sim, "INTERPRETE", "C", "Java")
    end,

    test_traductor = function()
        local sim = Simulador
        sim.traductores = {}
        assert_salida("Se definió un traductor de 'Java' hacia 'C', escrito en 'C'.", sim.DEFINIR, sim, "TRADUCTOR", "C", "Java", "C")
    end,

    test_ejecucion = function()
        local sim = Simulador
        sim.programas = {}
        sim.interpretes = {}
        sim.traductores = {}
        sim:DEFINIR("PROGRAMA", "fibonacci", "LOCAL")
        sim: DEFINIR("PROGRAMA", "factorial", "Java")
        sim:DEFINIR("INTERPRETE", "C", "Java")
        sim:DEFINIR("TRADUCTOR", "C", "Java", "C")
        sim:DEFINIR("INTERPRETE", "LOCAL", "C")

        assert_salida("Si, es posible ejecutar el programa 'fibonacci'.", sim.EJECUTABLE, sim, "fibonacci")
        assert_salida("Si, es posible ejecutar el programa 'factorial'.", sim.EJECUTABLE, sim, "factorial")
    end,

    test_ejecucion_compleja = function()
        local sim = Simulador
        sim.programas = {}
        sim.interpretes = {}
        sim.traductores = {}
        sim:DEFINIR("PROGRAMA", "holamundo", "Python3")
        sim:DEFINIR("TRADUCTOR", "wtf42", "Python3", "LOCAL")
        sim:DEFINIR("INTERPRETE", "LOCAL", "wtf42")

        assert_salida(
            "Si, es posible ejecutar el programa 'holamundo'.",
            sim.EJECUTABLE, sim, "holamundo"
        )
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
