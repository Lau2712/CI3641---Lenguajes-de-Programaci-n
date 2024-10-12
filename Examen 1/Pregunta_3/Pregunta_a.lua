-- Se desea que modele e implemente un programa que simule programas, intérpretes y traductores como los vistos
-- al estudiar los diagramas de T. Este programa debe cumplir con las siguientes características.

-- a. Debe poder manejar programas, intérpretes y traductores.
-- b. Todos los lenguajes deben ser cadenas alfanuméricas y no tienen que corresponder a algún lenguaje existente.
-- c. Existirá un nombre especial LOCAL, que se referirá al lenguajes que puede interpretar la máquina local.
-- d. Una vez iniciado el programa, pedirá repetidamente al usuario una acción para proceder: DEFINIR, EJECUTABLE y SALIR.
-- Al finalizar la ejecución de cada acción, el programa deberá pedir la siguiente acción al usuario.


-- Definimos una variable local que contendra la simulación
local Simulador = {}

-- Definimos listas que contendrán los respectivos programas, interpretes y traductores ingresados por el usuario
Simulador.programas = {}
Simulador.interpretes = {}
Simulador.traductores = {}

-- Definimos la funcion DEFINIR del simulador
function Simulador:DEFINIR(tipo, ...)

    local args = {...}
    -- Si se va a ingresar un programa
    if tipo == "PROGRAMA" then
        local nombre, lenguaje = args[1], args[2]
        
        if self.programas[nombre] then
            print("Error: ya se ha ingresado un programa con el nombre ' " .. nombre .. "'.")
        else
            self.programas[nombre] = lenguaje
            print("Se ha definido el programa ' " .. nombre .. "' ejecutable en ' " .. lenguaje .. "'.")
        end

    -- Si se va a ingresar un interprete
    elseif tipo == "INTERPRETE" then
        local lenguaje_base, lenguaje = args[1], args[2]

        self.interpretes[lenguaje] = lenguaje_base
        print("Se definió un interprete para ' " .. lenguaje .. "' escrito en ' " .. lenguaje_base .. "'.")

    -- Si se va a ingresar un traductor
    elseif tipo == "TRADUCTOR" then
        local lenguaje_base, lenguaje_origen, lenguaje_destino = args[1], args[2], args[3]

        -- Si no hay lenguajes de origen se inicializa
        if not self.traductores[lenguaje_origen] then
            self.traductores[lenguaje_origen] = {}
        end

        self.traductores[lenguaje_origen][lenguaje_destino] = lenguaje_base
        print("Se definió un traductor de ' " .. lenguaje_origen .. "' hacia ' " .. lenguaje_destino .. "', escrito en ' " .. lenguaje_base .. "'.")
    
    -- Si se ingresa una definición incorrecta
    else
        print("Error: ' " .. tipo .. "' no es una definición correcta.")
    end
end

-- Definimos la funcion EJECUTABLE del simulador
function Simulador:EJECUTABLE(nombre)
    
    -- Si el nombre no tiene un programa asociado, indicamos un error
    if not self.programas[nombre] then
        print("Error: El programa ' " .. nombre .. "' no está definido.")
        return
    end

    -- Definimos una función local para verificar si se puede ejecutar el lenguaje
    local function puedeEjecutar(lenguaje, visitado)

        -- Si el lenguaje es LOCAL se puede ejecutar
        if lenguaje == "LOCAL" then
            return true
        end

        -- Si el lenguaje no ha sido definido hasta el momento no se puede ejecutar
        if visitado[lenguaje] then
            return false
        end

        visitado[lenguaje] = true

        -- Para poder ejecutar el lenguaje, este debe tener asociado un interprete y un traductor
        if self.interpretes[lenguaje] then
            return puedeEjecutar(self.interpretes[lenguaje], visitado)
        end

        if self.traductores[lenguaje] then
            for destino, origen in pairs(self.traductores[lenguaje]) do
                if puedeEjecutar(origen, visitado) and puedeEjecutar(destino, visitado) then
                    return true
                end
            end
        end

        -- Si no es ejecutable, entonces retorna false
        return false
    end

    -- Se define una variable local que almacene el resultado de la ejecución
    local resultado = puedeEjecutar(self.programas[nombre], {})

    if resultado then
        print("Si, es posible ejecutar el programa ' " .. nombre .. "'.")
    else
        print("No es posible ejecutar el programa ' " .. nombre .. "'.")
    end
end

-- Definimos la inicialización del simulador
function Simulador:INICIAR()

    -- Loop para mantener la ejecución hasta algún error o la cancelación por parte del usuario
    while true do
        io.write("> ")
        local input = io.read()
        local args = {}

        for arg in input:gmatch("%S+") do
            table.insert(args, arg)
        end

        local comando = args[1]
        if comando == "DEFINIR" then
            self.DEFINIR(table.unpack(args, 2))
        elseif comando == "EJECUTABLE" then
            self:EJECUTABLE(args[2])
        elseif comando == "SALIR" then
            break
        -- Si se ingresa un comando incorrecto
        else
            print("Error: ' " .. comando .. "' no es reconocido.")
        end
    end
end

return Simulador
