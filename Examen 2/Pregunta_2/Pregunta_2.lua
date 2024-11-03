-- Modelar e implementar un programa que maneje expresiones aritméticas sobre enteros que cumpla con las siguientes 
-- características:a) Debe saber tratar expresiones escritas en orden pre-fijo y post-fijo, con los siguientes 
-- operadores: suma (+), resta (-), multiplicación (*) y división entera (/). b) Una vez iniciado el programa, pedirá
-- repetidamente al usuario una acción para proceder. Tal acción puede ser: EVAL<orden><expr>, el orden solo puede ser:
-- PRE y POST. Por ejemplo: Eval PRE + * + 3 4 5 7 deberá imprimir 42, EVAL POST 8 3 - 8 4 4 + * + deberá imprimir 69.
-- MOSTRAR representa una impresión en orden in-fijo de la expresión que está escrita de acuerdo a orden. El programa
-- debe tomar la precedencia y asociatividad estándar, donde: la suma y la resta tienen la misma precedencia, la
-- multiplicación y la división tienen la misma precedencia y todos los operandos asocian a izquierda. La expresión
-- resultante debe tener la menor cantidad posible de paréntesis, de tal forma que la expresión mostrada como resultado
-- tenga la misma semántica que la expresión que fue pasada como argumento a la acción. Por ejemplo: MOSTRAR PRE + * + 3 4 5 7
-- imprimé (3 + 4) * 5 + 7. SALIR debe salir del programa. Al finalizar la ejecución de cada acción, el programa deberá
-- pedir la siguiente acción al usuario.

local Evaluador = {}

-- Definimos un árbol para representar las expresiones
Evaluador.Nodo = {}
Evaluador.Nodo.__index = Evaluador.Nodo

function Evaluador.Nodo.nuevo(valor)
    local self = setmetatable({}, Evaluador.Nodo)
    self.valor = valor
    self.izquierda = nil
    self.derecha = nil
    return self
end

-- Definimos una función para verificar el operador.
function Evaluador.esOperador(operador)
    return operador == "+" or operador == "-" or operador == "*" or operador == "/"
end

-- Definimos una función para obtener la precedencia
function Evaluador.obtenerPrecedencia(op)
    if op == "+" or op == "-" then
        return 1
    elseif op == "*" or op == "/" then 
        return 2
    else 
        return 0
    end
end

-- Definimos una función para evaluar el árbol de expresiones
function Evaluador.evaluar(nodo)

    if not Evaluador.esOperador(nodo.valor) then
        return tonumber(nodo.valor)
    end

    local izquierda = Evaluador.evaluar(nodo.izquierda)
    local derecha = Evaluador.evaluar(nodo.derecha)

    if nodo.valor == "+" then
        return izquierda + derecha
    elseif nodo.valor == "-" then
        return izquierda - derecha
    elseif nodo.valor == "*" then
        return izquierda * derecha
    elseif nodo.valor == "/" then
        return math.floor(izquierda / derecha)
    end
end

-- Definimos una función para construir el árbol pre-fijo
function Evaluador.construirPrefijo(operadores, indice)
    -- Caso base
    if indice > #operadores then
        return nil, indice
    end

    local nodo = Evaluador.Nodo.nuevo(operadores[indice])
    if not Evaluador.esOperador(operadores[indice]) then
        return nodo, indice + 1
    end

    local izquierda, nuevo_indice = Evaluador.construirPrefijo(operadores, indice + 1)
    nodo.izquierda = izquierda

    local derecha, indice_final = Evaluador.construirPrefijo(operadores, nuevo_indice)
    nodo.derecha = derecha

    return nodo, indice_final
end

-- Función para construir el árbol post-fijo
function Evaluador.construirPostfijo(operadores, indice)
    -- Caso base
    if indice < 1 then
        return nil, indice
    end

    local nodo = Evaluador.Nodo.nuevo(operadores[indice])
    if not Evaluador.esOperador(operadores[indice]) then
        return nodo, indice - 1
    end

    local derecha, nuevo_indice = Evaluador.construirPostfijo(operadores, indice - 1)
    nodo.derecha = derecha

    local izquierda, indice_final = Evaluador.construirPostfijo(operadores, nuevo_indice)
    nodo.izquierda = izquierda

    return nodo, indice_final
end

-- Función para convertir el árbol a notación infija
function Evaluador.convertirInfija(nodo)

    if not Evaluador.esOperador(nodo.valor) then
        return nodo.valor
    end

    local izquierda = Evaluador.convertirInfija(nodo.izquierda)
    local derecha = Evaluador.convertirInfija(nodo.derecha)

    if nodo.derecha and Evaluador.esOperador(nodo.derecha.valor) then
        if Evaluador.obtenerPrecedencia(nodo.valor) > Evaluador.obtenerPrecedencia(nodo.derecha.valor) then
            derecha = "(" .. derecha .. ")"
        end
    end

    if nodo.izquierda and Evaluador.esOperador(nodo.izquierda.valor) then
        if Evaluador.obtenerPrecedencia(nodo.valor) > Evaluador.obtenerPrecedencia(nodo.izquierda.valor) or 
        (Evaluador.obtenerPrecedencia(nodo.valor) == Evaluador.obtenerPrecedencia(nodo.izquierda.valor) and nodo.valor == "-") then
            izquierda = "(" .. izquierda .. ")"
        end
    end

    return izquierda .. " " .. nodo.valor .. " " .. derecha
end

-- Exportar el módulo
return Evaluador

-- Definimos el bucle principal del programa
--while true do
--    io.write("> ")
--    local entrada = io.read()
--    local operadores = {}

    -- Separamos la entrada de los operadores
--    for operador in string.gmatch(entrada, "%S+") do
--        operadores[#operadores + 1] = operador
--    end

--    if operadores[1] == "SALIR" then
--        break
--    elseif operadores[1] == "EVAL" or operadores[1] == "MOSTRAR" then
--        local comando = operadores[1]
--        local orden = operadores[2]
        -- Eliminamos el comando
--        table.remove(operadores, 1)
--        -- Eliminamos la orden
--        table.remove(operadores, 1)

--        local raiz
--        if orden == "PRE" then
--            raiz = construirPrefijo(operadores, 1)
--        elseif orden == "POST" then
--            raiz = construirPostfijo(operadores, #operadores)
--        end

--        if comando == "EVAL" then
--            print(evaluar(raiz))
--        else
--            print(convertirInfija(raiz))
--        end
--    end
--end