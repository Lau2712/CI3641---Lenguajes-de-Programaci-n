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

    test_definicion_incorrecta = function()
        local sim = Simulador
        assert_salida("Error: ' ALGO' no es una definición correcta.", sim.DEFINIR, sim, "ALGO", "x", "y")
    end,

    test_definir_programa_nombre_vacio = function()
        local sim = Simulador
        assert_salida("Error: El nombre del programa no puede estar vacío.", sim.DEFINIR, sim, "PROGRAMA", "", "LOCAL")
    end,

    test_ejecutar_programa_no_definido = function()
        local sim = Simulador
        sim.programas = {}
        assert_salida("Error: El programa ' noexiste' no está definido.", sim.EJECUTABLE, sim, "noexiste")
    end,

    test_programa_no_ejecutable = function()
        local sim = Simulador
        sim.programas = {}
        sim.interpretes = {}
        sim.traductores = {}
        sim:DEFINIR("PROGRAMA", "inalcanzable", "LenguajeX")
        assert_salida("No es posible ejecutar el programa 'inalcanzable'.", sim.EJECUTABLE, sim, "inalcanzable")
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

    test_ejecucion_cadena_larga = function()
        local sim = Simulador
        sim.programas = {}
        sim.interpretes = {}
        sim.traductores = {}
        
        sim:DEFINIR("PROGRAMA", "prog1", "Lang1")
        sim:DEFINIR("TRADUCTOR", "Lang2", "Lang1", "Lang2")
        sim:DEFINIR("TRADUCTOR", "Lang3", "Lang2", "Lang3")
        sim:DEFINIR("TRADUCTOR", "Lang4", "Lang3", "Lang4")
        sim:DEFINIR("INTERPRETE", "LOCAL", "Lang4")
        
        assert_salida("Si, es posible ejecutar el programa 'prog1'.", sim.EJECUTABLE, sim, "prog1")
    end,

    test_ejecucion_ciclo = function()
        local sim = Simulador
        sim.programas = {}
        sim.interpretes = {}
        sim.traductores = {}
        
        sim:DEFINIR("PROGRAMA", "prog2", "LangA")
        sim:DEFINIR("TRADUCTOR", "LangB", "LangA", "LangB")
        sim:DEFINIR("TRADUCTOR", "LangC", "LangB", "LangC")
        sim:DEFINIR("TRADUCTOR", "LangA", "LangC", "LangA")
        
        assert_salida("No es posible ejecutar el programa 'prog2'.", sim.EJECUTABLE, sim, "prog2")
    end,

    test_definiciones_duplicadas = function()
        local sim = Simulador
        sim.interpretes = {}
        sim.traductores = {}
        
        assert_salida("Se definió un interprete para 'Java', escrito en 'C'.", sim.DEFINIR, sim, "INTERPRETE", "C", "Java")
        assert_salida("Se definió un interprete para 'Java', escrito en 'Python'.", sim.DEFINIR, sim, "INTERPRETE", "Python", "Java")
        
        assert_salida("Se definió un traductor de 'Java' hacia 'C', escrito en 'C'.", sim.DEFINIR, sim, "TRADUCTOR", "C", "Java", "C")
        assert_salida("Se definió un traductor de 'Java' hacia 'C', escrito en 'Python'.", sim.DEFINIR, sim, "TRADUCTOR", "Python", "Java", "C")
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
