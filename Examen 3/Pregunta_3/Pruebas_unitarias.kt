import org.junit.jupiter.api.Test
import org.junit.jupiter.api.BeforeEach
import kotlin.test.assertEquals
import kotlin.test.assertTrue
import kotlin.test.assertFalse

class TypeManagerTest {
    private lateinit var manager: TypeManager

    @BeforeEach
    fun setup() {
        manager = TypeManager()
    }

    @Test
    fun `test atomic type creation`() {
        assertTrue(manager.addAtomic("int", 4, 4))
        assertFalse(manager.addAtomic("int", 8, 8))
    }

    @Test
    fun `test struct creation`() {
        manager.addAtomic("int", 4, 4)
        manager.addAtomic("char", 1, 1)
        assertTrue(manager.addStruct("mystruct", listOf("int", "char")))
    }
}

Para ejecutar el programa:

kotlin:src/main/kotlin/Main.kt

fun main() {
    val manager = TypeManager()
    
    while (true) {
        print("> ")
        val input = readLine() ?: break
        val parts = input.split(" ")
        
        when (parts[0].uppercase()) {
            "ATOMICO" -> {
                if (parts.size != 4) {
                    println("Formato: ATOMICO <nombre> <representación> <alineación>")
                    continue
                }
                val success = manager.addAtomic(
                    parts[1],
                    parts[2].toIntOrNull() ?: continue,
                    parts[3].toIntOrNull() ?: continue
                )
                if (!success) println("Error: El tipo ${parts[1]} ya existe")
            }
            "DESCRIBIR" -> {
                if (parts.size != 2) {
                    println("Formato: DESCRIBIR <nombre>")
                    continue
                }
                val description = manager.describe(parts[1])
                if (description == null) println("Error: Tipo no encontrado")
                else println(description)
            }
            "SALIR" -> break
            else -> println("Comando no reconocido")
        }
    }
}