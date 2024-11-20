data class Persona(val nombre: String, val edad: Int)

class ConjuntoPersonas(private val personas: Set<Persona>) {

    fun contar(): Int = personas.size

    fun adultos(): ConjuntoPersonas = ConjuntoPersonas(personas.filter { it.age >= 18}.toSet())

    fun nombreComun(): String? = personas.groupBy { it.name }.maxByOrNull { it.value.size }?.key
}

// Ejemplo de uso:
// val people: ConjuntoPersonas(setOf(Persona("Ana", 20), Persona("Bob", 15), Persona("Ana", 25), Persona("Carlos", 18)))
// val total = personas.contar()
// val adultos = personas.adultos()
// val nombreComun = personas.nombreComun()