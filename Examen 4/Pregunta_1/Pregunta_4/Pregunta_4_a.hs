-- Dadas las funciones foldr y const dadas y la función que aplica una función solamente sobre la cola de una lista y agrupa la 
-- cabeza con otro valor dado 'what'. Considere también la siguiente función, que genera una lista de números enteros a partir de
-- un cierto valor inicial. Muestre la evaluación, paso a paso, de la expresión misteriosa "abc" (gen 1), considernado que:

-- 1. El lenguaje tiene orden de evaluación normal.
-- 2. El lenguaje tiene orden de evaluación aplicativo. 

-- Principalmente, tenemos presente que misteriosa = foldr what(const[]) y que gen 1 = 1 : gen 2 = 1 : 2 : gen 3 = ... lo cual genera
-- una lista infinita. 

-- Orden de Evaluación Normal.

-- misteriosa "abc" (gen 1)

-- Aplicamos la definición de misteriosa
-- = foldr what(const[]) "abc" (gen 1)

-- Expandimos foldr con el primer elemento 'a' de "abc". Recordando foldr f e (x:xs) = f x $ foldr f e xs
-- = what 'a' (foldr what (const []) "bc") (gen 1)

-- Expandimos gen 1, que produce 1 : gen 2. Aplicamos what: what x f (y:ys) = (x, y) : f ys
-- = ('a', 1) : (foldr what (const []) "bc") (2 : gen 3)

-- Realizamos el mismo proceso para el segundo caracter 'b', expandimos foldr sobre "bc"
-- = ('a', 1) : what 'b' (foldr what (const []) "c") (2 : gen 3)

-- gen 2 produce 2 : gen 3
-- = ('a', 1) : ('b', 2) : (foldr what (const []) "c") (gen 3)

-- Procesamos el último caracter 'c'
-- = ('a', 1) : ('b', 2) : what 'c' (dolfr what (const []) "") (gen 3)

-- gen 3 produce 3 : gen 4
-- = ('a', 1) : ('b', 2) : ('c', 3) : (foldr what (const []) "") (gen 4)

-- Llegamos a la lista vacía "", aplicamos entonces foldr sobre [], usando foldr _ e [] = e y const [] es el caso base que retorna []
-- = ('a', 1) : ('b', 2) : ('c', 3) : []

-- La evaluación normal termina y produce una lista finita, porque procesa la cadena "abc" caracter por caracter, además de solo 
-- consumir los elementos de gen 1 que necesita. Por último, cuando llega a la lista vacía "", retorna [].

-- Orden de Evaluación Aplicativa

-- Intentamos evaluar todos los argumentos completamente antes de aplicar la función. Como anotamos al inicio gen 1 generará una lista
-- infinita: [1,2,3,...]. Por lo tanto, el programa se quedaría intentando construir esta lista infinita antes de poder proceder con el 
-- resto de la evaluación. 

-- Por esto, en la evaluación aplicativa, esta expresión resulta en un loop infinito sin producir ningún resultado.


