// Defina un tipo que represente conjuntos de personas, donde cada persona tiene un nombre y edad
data class Persona(val nombre: String, val edad: Int)

class ConjuntoPersonas(private val personas: Set<Persona>) {

    fun contar(): Int = personas.size

    fun adultos(): ConjuntoPersonas = ConjuntoPersonas(personas.filter { it.edad >= 18}.toSet())

    fun nombreComun(): String? = personas.groupBy { it.nombre }.maxByOrNull { it.value.size }?.key
}

// Ejemplo de uso:
// fun main() {
//     val people = ConjuntoPersonas(setOf(Persona("Ana", 20), Persona("Bob", 15), Persona("Ana", 25), Persona("Carlos", 18)))
//     val total = people.contar()
//     val adultos = people.adultos()
//     val nombreComun = people.nombreComun()

//     println(total)
//     println(adultos)
//     println(nombreComun)
// }