-- Considere una versión de la función what que funciona sobre árboles (aplica la función proporcionada a ambos sub-árboles) y
-- llamémosla what tree function. Usando la función foldA definidia anteriormente definimos la función sospechosa. Definimos la
-- función que genera un árbol de números enteros a partir de un cierto valor inicial. Finalmente, definimos el valor arbolito
-- como una instancia de Arbol Char. 

-- Muestre la evaluación, paso a paso, de la expresión sospechosa arbolito (genA 1), considerando:
-- 1. El lenguaje tiene orden de evaluación normal. 
-- 2. El lenguaje tiene orden de evaluación aplicativa. 

-- Orden de Evaluación Normal. 

-- Usando la definición de sospechosa. 
-- = foldA whatTF (const Hoja) arbolito (genA 1)

-- Expandimos foldA sobre el arbolito
-- = whatTF (foldA whatTF (const Hoja) (Rama 'b' Hoja (Rama 'c' Hoja Hoja)))
--          (foldA whatTF (const Hoja) Hoja)
--          (genA 1)

-- Aplicamos whatTF
-- = Rama (foldA whatTF (const Hoja) (Rama 'b' Hoja (Rama 'c' Hoja Hoja)), 'a')
--        (foldA whatTF (const Hoja) Hoja)
--        (genA 1)

-- Evaluamos el subárbol izquierdo
-- = Rama ('a', 1)
--        (Rama ('b', 2) Hoja (Rama ('c', 3) Hoja Hoja))
--        Hoja

-- La evaluación termina produciendo un árbol finito porque solo se necesito evaluar los primero elementos de genA 1 que corresponden
-- a la estructura de arbolito. Cuando llega a Hoja, no necesita evaluar más elementos de genA. 

-- Orden de Evaluación Aplicativa. 

-- Inicialmente se intentan evaluar todos los argumentos. Al momento de evaluar genA 1 tendríamos genA 1 = Rama 1 (genA 2) (genA 2),
-- genA 2 = Rama 2 (genA 3) (genA 4), genA 3 = Rama 3 (genA 4) (genA 6), ...

-- Luego, el programa no termina porque intenta construir completamente el árbol infinito genA 1 antes de proceder. Además que cada nodo
-- genera dos nuevas llamadas recursivas y nunca se termina de construir el árbol completo. 

-- A pesar que la función foldA por sí misma puede manejar estructuras infinitas en la evaluación perezosa, su resultado dependerá de 
-- cómo se use la función f que se le pasa como argumento. En nuestro caso la función whatTF que se usa dentro de sospechosa necesita
-- evaluar ambos subárboles, lo cual significa que aunque foldA puede manejar las estructuras infinitas, whatTF fuerza la evaluación de 
-- todo el árbol. 

-- Finalmente, en la evaluación normal el proceso termina porqu arbolito es finito, mientras que en la evaluación aplicativa el proceso
-- no terminará por la naturaleza infinita de genA 1. 
