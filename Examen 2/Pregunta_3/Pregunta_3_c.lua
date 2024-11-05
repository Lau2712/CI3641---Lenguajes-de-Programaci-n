-- Dada una lista de enteros, queremos un iterador que devuelva todos los elementos
-- de la lista en orden (de menor a mayor). Por ejemplo, para la lista [1,3,3,2,1]
-- los elementos en orden serían: 1 1 2 3 3. Nota: el ordenamiento debe ser parte de
-- la lógica del iterador. No es válido ordenar primero la lista y luego devolver los
-- elementos de la lista previamente ordenada.

-- Definimos la función iterador
function iteradorOrdenado(lista)
    local visitado = {}
    local n = #lista

    -- Función encargada de iterar, es retornada y llamada cada vez que se necesite el
    -- siguiente valor.
    return function()
        -- Verifica si quedan elementos por iterar
        if n == 0 then
            return nil
        end

        local minVal = nil
        local minIndice = nil

        -- Se encuentra el elemento más pequeño que no se ha visitado
        for i = 1, #lista do
            if not visitado[i] then
                if minVal == nil or lista[i] < minVal then
                    minVal = lista[i]
                    minIndice = i
                end
            end
        end

        -- Marca el elemento como visitado y lo retorna
        if minIndice then
            visitado[minIndice] = true
            n = n - 1
            return minVal
        end

        return nil
    end
end

-- Prueba
local numeros = {1, 3, 3, 2, 1}
local iterador = iteradorOrdenado(numeros)

local elemento = iterador()
local resultado = {}
local i = 1

while elemento do
    resultado[i] = elemento
    elemento = iterador()
    i = i + 1
end

print(table.concat(resultado, ", "))
