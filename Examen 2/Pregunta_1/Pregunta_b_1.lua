-- Considere la siguiente función: f(n) = n/2 si n es par, 3n + 1 si n es impar. Definimos la función
-- dist(n) como la cantidad de aplicaciones consecutivas de f que se deben hacer sobre n, hasta que el
-- resultado sea 1. Por ejemplo: f(42) = 21, f(21) = 64, f(64) = 32, f(32) = 16, f(16) = 8, f(8) = 4,
--f(4) = 2, f(2) = 1. Por lo tanto count(42) ) = 8. Escriba un programa que, dado un entero n calcule count(n).

-- Definimos la función f(n)
function f(n)

    if n % 2 == 0 then
        return n / 2
    else
        return 3 * n + 1
    end

end

-- Función que determina la cantidad de aplicaciones consecutivas de f
function count(n)
    -- Caso base
    if n <= 0 then
        return 0
    end

    -- Definimos la variable dist
    local dist = 0
    local actual = n

    -- Mientras que actual sea distinto de 1
    while actual ~= 1 do
        actual = f(actual)
        dist = dist + 1
    end

    return dist
end

-- Definimos una función para probar el algoritmo
function main()

    print("Ingrese un numero: ")
    local n = tonumber(io.read())

    local resultado = count(n)
    print("El numero de pasos es:", resultado)

end

-- Ejecutamos
main()
