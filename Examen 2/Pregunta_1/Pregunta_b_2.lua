-- Implemente el algoritmo Mergesort y explique los detalles de su implementación.
-- Nota: Explicar los detalles no implica traducir línea por línea a lenguaje natural,
-- sino explicar el funcionamiento a grandes rasgos y las decisiones de implementación.

-- Optamos por crear nuevas tablas en lugar de modificar la original, priorizando la 
-- claridad en lugar de la eficiencia de memoria, lo cual no es in problema siempre y
-- cuando no se presente un caso donde la limitación de la memoria no es crítica.
-- Se aprovecha la optimización de Lua para los arreglos, además de no necesitar estructuras
-- de datos adicionales porque las tablas son lo suficientemene flexibles.


-- Definimos Merge
-- Función auxiliar para combinar los subarreglos ordenados
function merge(left, right)
    -- Utilizamos las tablas dinámicas de Lua para ir almacenando el resultado.
    local resultado = {}
    local i, j = 1, 1

    -- Empleamos el operador # para obtener la longitud de las tablas
    while i <= #left and j <= #right do
        if left[i] <= right[j] then
            -- Empleamos el comando insert en lugar de realizar la asignción directa de índices
            table.insert(resultado, left[i])
            i = i + 1
        else
            table. insert(resultado, right[j])
            j = j + 1
        end
    end

    while i <= #left do
        table.insert(resultado, left[i])
        i = i + 1
    end

    while j <= #right do
        table.insert(resultado, right[j])
        j = j + 1
    end

    return resultado

end

-- Función mergesort es la función recursiva principal
function mergesort(arreglo)
    -- Caso base
    if #arreglo <= 1 then
        return arreglo
    end

    local medio = math.floor(#arreglo / 2)
    -- Aprovechamos las tablas dinámicas de Lua para almacenar los arreglos.
    local izquierda = {}
    local derecha = {}

    for i = 1, medio do
        izquierda[i] = arreglo[i]
    end

    for i = medio + 1, #arreglo do
        derecha[i - medio] = arreglo[i]
    end

    izquierda = mergesort(izquierda)
    derecha = mergesort(derecha)

    return merge(izquierda, derecha)

end

-- Función para probar el algoritmo
function main()
    local arr = {64, 34, 25, 12, 22, 11, 90}
    local sorted = mergesort(arr)
    
    print("Arreglo ordenado:")
    for i, v in ipairs(sorted) do
        io.write(v, " ")
    end
    io.write("\n")
end

-- Ejecutamos
main()
