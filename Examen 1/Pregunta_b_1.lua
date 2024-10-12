-- Implemente los siguientes programas:
-- 1. Dados 3 enteros no negativos a, b y c, tal que c >= 2, calcular la potenciación modulada
-- a^b mod c. Utilice la siguiente fórmula, resultante de aplicar propiedades de módulo a la 
-- potenciación. 

-- Definimos la función potenciaModulada
function potenciaModulada(a, b, c)
    
    if b == 0 then
        return 1
    else
        -- Definimos una variable local que contendrá el resultado
        local resultado = potenciaModulada(a, b - 1, c)
        resultado = (resultado * (a % c)) % c
        return resultado
    end
end

-- Definimos una función para probar el algoritmo
function main()

    print("Ingrese 3 numeros enteros no negativos a, b y c, con c >= 2, en ese orden.")

    -- Definimos las variables ingresadas
    local a = tonumber(io.read())
    local b = tonumber(io.read())
    local c = tonumber(io.read())

    -- Validamos que sean no negativos y que c sea mayor o igual a 2
    if a < 0 or b < 0 or c < 2 then
        print("Los números ingresados no son válidos.")
        return
    end

    -- Llamamos a la función e imprimos el resultado
    local resultado = potenciaModulada(a, b, c)
    print(string.format("%d^%d mod %d = %d", a, b, c, resultado))	
end

-- Ejecutamos
main()