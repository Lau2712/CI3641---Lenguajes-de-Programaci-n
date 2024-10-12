-- 2. Dada una matriz cuadrada A (NxN), decidir si A corresponde a una Matriz Mágica. Una matriz mágica
-- es aquella donde la suma de cada una de sus filas, columnas y las dos diagonales corresponden al
-- mismo número

-- Definimos la funcion matrizMagica
function matrizMagica(A)
    -- Definimos una variable local que contendrá el tamaño de la matriz
    local n = #A

    -- Calculamos la suma mágica de la primera fila
    local sumaMagica = 0
    for i = 1, n do
        sumaMagica = sumaMagica + A[1][i]
    end

    -- Verificamos que las demás filas den el mismo resultado
    for i = 1, n do
        local sumaFila = 0

        for j = 1, n do
            sumaFila = sumaFila + A[i][j]
        end
        -- Si el resultado es distinto retorna falso
        if sumaFila ~= sumaMagica then
            return false
        end
    end

    -- Si el resultado coincide procedemos a determinar la suma de las columnas
    for i = 1, n do
        local sumaColumna = 0

        for j = 1, n do
            sumaColumna = sumaColumna + A[j][i]
        end

        -- Si el resultado es distinto al de las filas retorna falso
        if sumaColumna ~= sumaMagica then
            return false
        end
    end

    -- Si el resultado coincide verificamos las diagonales principales
    local sumaDiagonal = 0

    for i = 1, n do
        sumaDiagonal = sumaDiagonal + A[i][i]
    end

    -- Si el resultado es distinto al de las filas retorna falso
    if sumaDiagonal ~= sumaMagica then
        return false
    end

    local sumaDiagonalInversa = 0

    for i = 1, n do
        sumaDiagonalInversa = sumaDiagonalInversa + A[i][n - i + 1]
    end

    -- Si el resultado es distinto al de las filas retorna falso
    if sumaDiagonalInversa ~= sumaMagica then
        return false
    end 

    -- Si pasaron todas las validaciones retorna verdadero
    return true
end

-- Definimos una función para leer la matriz
function matriz()
    print("Ingrese la dimension de la matriz deseada")
    local n = tonumber(io.read())

    -- Definimos una variable local que contendra la matriz
    local A = {}

    -- Se solicitan los datos de la matriz
    print("Ingrese los datos de la matriz fila por fila")
    for i = 1, n do
        A[i] = {}
        for j = 1, n do
            A[i][j] = tonumber(io.read())
        end
    end

    return A
end

-- Definimos una función para probar el algoritmo
function main()
    local A = matriz()

    if matrizMagica(A) then
        print("La matriz es magica")
    else
        print("La matriz no es magica")
    end
end

-- Llamado a la función
main()