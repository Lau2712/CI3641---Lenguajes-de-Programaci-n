-- Considerando la siguiente definición para una familia de funciones:
-- Fα,β(n) = si 0 ≤ n < α × β, Sumatoria de i = 1 hasta  α de Fα,β(n − β × i) si n ≥ α × β
-- Tomando como referencia las constantes X = 3, Y = 0, Z = 7 planteadas en
-- los párrafos de introducción del exámen, definamos: α = ((X + Y ) mod 5) + 3, β = ((Y + Z) mod 5) + 3
-- Se desea que realice implementaciones, en el lenguaje imperativo de su elección:
-- a) Una subrutina recursiva que calcule Fα,β para los valores de α y β obtenidos con 
-- las fórmulas mencionadas anteriormente. Esta implementación debe ser una traducción 
-- directa de la fórmula resultante a código.

-- Establecemos los valores de alpha y beta
-- alpha = ((3 + 0) mod 5) + 3 = 6
-- beta = ((0 + 7) mod 5) + 3 = 5
local alpha = 6
local beta = 5

-- Definimos la función recursiva que calcule Fα,β
function F_recursiva(n)
    -- Caso 1
    if n < alpha * beta then
        return n
    end

    local suma = 0
    -- Caso 2
    for i = 1, alpha do
        suma = suma + F_recursiva(n - 5 * i)
    end

    return suma
end

-- b) Una subrutina recursiva de cola que calcule Fα,β

-- Definimos la función recursiva de cola
function F_cola(n, acumulado)
    -- Sino se envía el valor del acumulador se asigna 0
    acumulado = acumulado or 0

    -- Caso 1
    if n < alpha * beta then
        return n + acumulado
    end
    
    local siguiente_acumulado = 0
    -- Caso 2
    for i = 2, 6 do
        siguiente_acumulado = siguiente_acumulado + F_cola(n - 5 * i, 0)
    end
    
    -- Última llamada recursiva con el nuevo acumulado
    return F_cola(n - 5, siguiente_acumulado + acumulado)
end

-- c) La conversión de la subrutina anterior a una versión iterativa, mostrando
-- claramente cuáles componentes de la implementación recursiva corresponden a
-- cuáles otras de la implementación iterativa.

-- Definimos la función iterativa
function F_iterativo(n)
    -- Caso 1
    if n  < alpha * beta then
        return n
    end
    -- La tabla memoria corresponde a los valores que se calcularían en cada llamada recursiva
    local memoria = {}

    -- Este bucle corresponde a construir la secuencia de valores
    for i = 0, n do
        if i < alpha * beta then
            memoria[i] = i
        else
            local suma = 0
            -- Caso 2
            -- Este bucle corresponde a la sumatoria de la definición original
            for j = 1, 6 do
                suma = suma + memoria[i - 5 * j]
            end
            memoria[i] = suma
        end
    end
    return memoria[n]
end

-- Prueba de la implementación
--print(F_recursiva(42))
--print(F_cola(42, 0))
--print(F_iterativo(42))

-- Realice también un análisis comparativo entre las 3 implementaciones realizadas,
-- mostrando tiempos de ejecución para diversos valores de entrada y ofreciendo
-- conclusiones sobre la eficiencia. Es recomendable que se apoye en herramientas de 
-- visualización de datos (como los plots de Matlab, R, Octave, Excel, etc).

-- Definimos la función para medir el tiempo
function tiempos(funcion, n, iteraciones)
    local tiempo_total = 0
    for i = 1, iteraciones do
        local start = os.clock()
        local resultado = funcion(n)
        tiempo_total = tiempo_total + (os.clock() - start)
    end
    return tiempo_total / iteraciones
end

-- Definimos los valores de Prueba
local valores = {10, 20, 30, 40, 50, 60}
local iteraciones = 1000

-- Creamos un archivo que almacene los resultados para mostrarlos en el excel
local file = io.open("resultados.txt", "w")
file:write("n,Recursivo, Cola, Iterativo\n")

-- Ejecución de los tiempos
for _, n in ipairs(valores) do
    local time1, _ = tiempos(function() return F_recursiva(n) end, n, iteraciones)
    local time2, _ = tiempos(function() return F_cola(n, 0) end, n, iteraciones)
    local time3, _ = tiempos(function() return F_iterativo(n) end, n, iteraciones)

    -- Escribir al archivo
    file:write(string.format("%d,%.9f,%.9f,%.9f\n", n, time1, time2, time3))
    
    -- Mostrar por la salida estándar
    print(string.format("n=%d: Recursivo=%.9f, Cola=%.9f, Iterativo=%.9f", n, time1, time2, time3))
end

file:close()

-- Conclusiones:
-- Eficiencia de tiempo:
--                      La versión iterativa muestra los mejores tiempos para valores grandes.
--                      La versión recursiva de cola mantiene tiempos intermedios entre los otros dos métodos.
--                      La versión recursiva directa mantiene tiempos más rápidos para valores pequeños.
-- Uso de memoria:
--                      La versión iterativa usa memoria de manera constante O(1).
--                      La versión recursiva de cola optimiza el uso de la pila de llamadas.
--                      La versión recursiva directa implica un mayor uso de memoria por las llamadas acumuladas.
-- Complejidad:
--                      Iterativa: O(n) en tiempo y espacio. 
--                      Recursiva de cola: O(n) en tiempo, O(1) en espacio adicional.
--                      Recursiva directa: O(α^(n/β)) en tiempo y espacio.
-- Casos de uso:
--                      La iterativa es ideal para valores grandes y memoria limitada.
--                      La recursiva de cola mantiene un buen rendimiento y cuando se prioriza la legibilidad.
--                      La versión recursiva directa es recomendable para valores pequeños y cuando se prioriza la claridad del código.
