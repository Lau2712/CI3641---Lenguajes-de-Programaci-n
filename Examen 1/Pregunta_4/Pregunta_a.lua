-- Se desea que modele e implemente un módulo que definal el tipo de los cuaterniones y operadores aritméticas sobre estos.
-- Dados en 3 valores: i, j y k, tales que i^2 = j^2 = k^2 = ijk = -1, la forma general de cuaternión se define como:
-- a + bi + cj + dk, para a, b, c y d pertenecientes a los reales.

-- a. Debe saber tratas la suma, conjugada, producto y medida.

-- b. Los cuaterniones deben poder operarse entre sí sin necesidad de que el usuario de la librería escriba llamadas adicionales.

-- c. Los cuaterniones deben poder operarse también con números enteros o flotantes por la derecha (suma y producto).

local Cuaternion = {}
Cuaternion.__index = Cuaternion

function Cuaternion.nuevo(a, b, c, d)
    return setmetatable({a = a or 0, b = b or 0, c = c or 0, d = d or 0}, Cuaternion)
end

function Cuaternion:__add(otro)
    if type(otro) == "number" then
        return Cuaternion.nuevo(self.a + otro, self.b, self.c, self.d)
    else
        return Cuaternion.nuevo(self.a + otro.a, self.b + otro.b, self.c + otro.c, self.d + otro.d)
    end
end

function Cuaternion:__unm()
    return Cuaternion.nuevo(-self.a, -self.b, -self.c, -self.d)
end

function Cuaternion:__mul(otro)
    if type(otro) == "number" then
        return Cuaternion.nuevo(self.a * otro, self.b * otro, self.c * otro, self.d * otro)
    else
        local a = self.a * otro.a - self.b * otro.b - self.c * otro.c - self.d * otro.d
        local b = self.a * otro.b + self.b * otro.a + self.c * otro.d - self.d * otro.c
        local c = self.a * otro.c - self.b * otro.d + self.c * otro.a + self.d * otro.b
        local d = self.a * otro.d + self.b * otro.c - self.c * otro.b + self.d * otro.a
        return Cuaternion.nuevo(a, b, c, d)
    end
end

function Cuaternion:conjugar()
    return Cuaternion.nuevo(self.a, -self.b, -self.c, -self.d)
end

function Cuaternion:medida()
    return math.sqrt(self.a^2 + self.b^2 + self.c^2 + self.d^2)
end

function Cuaternion:__tostring()
    return string.format("%.2f + %.2fi + %.2fj + %.2fk", self.a, self.b, self.c, self.d)
end

setmetatable(Cuaternion, {
    __call = function(_, ...) return Cuaternion.nuevo(...) end
})

return Cuaternion
