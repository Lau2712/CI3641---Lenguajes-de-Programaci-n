package test
import main.TypeManager
import main.DataType
import main.CalculadoraMemoria 

fun main() {
    val tests = MemoryCalculatorTest()
    var passed = 0
    var failed = 0
    
    println("Iniciando pruebas...")
    
    // Ejecutar cada test y contar resultados
    tests.runTests().forEach { (testName, result) ->
        print("Test '$testName': ")
        when (result) {
            true -> {
                println("PASO")
                passed++
            }
            false -> {
                println("FALLO")
                failed++
            }
        }
    }
    
    // Mostrar resumen
    println("\nResumen de pruebas:")
    println("Pasaron: $passed")
    println("Fallaron: $failed")
    println("Total: ${passed + failed}")
}

class MemoryCalculatorTest {
    fun runTests(): Map<String, Boolean> {
        return mapOf(
            "test add atomic type" to testAddAtomicType(),
            "test describe atomic type" to testDescribeAtomicType(),
            "test struct calculation" to testStructCalculation(),
            "test invalid struct" to testInvalidStruct(),
            "test describe nonexistent" to testDescribeNonexistent(),
            "test union calculation" to testUnionCalculation(),
            "test complex struct" to testComplexStruct(),
            "test invalid union" to testInvalidUnion(),
            "test nested struct" to testNestedStruct(),
            "test nested union" to testNestedUnion()
        )
    }

    private fun testUnionCalculation(): Boolean {
        val typeManager = TypeManager()
        return try {
            typeManager.addAtomic("int", 4, 4)
            typeManager.addAtomic("char", 1, 1)
            assert(typeManager.addUnion("simple_union", listOf("int", "char")))
            val description = typeManager.describe("simple_union")
            assert(description != null)
            assert(description!!.contains("Tipo: simple_union"))
            assert(description.contains("Tamaño: 4"))
            true
        } catch (e: AssertionError) {
            false
        }
    }

    private fun testComplexStruct(): Boolean {
        val typeManager = TypeManager()
        return try {
            typeManager.addAtomic("int", 4, 4)
            typeManager.addAtomic("char", 1, 1)
            typeManager.addStruct("struct1", listOf("int", "char"))
            assert(typeManager.addStruct("complex_struct", listOf("struct1", "int")))
            val description = typeManager.describe("complex_struct")
            assert(description != null)
            true
        } catch (e: AssertionError) {
            false
        }
    }

    private fun testInvalidUnion(): Boolean {
        val typeManager = TypeManager()
        return try {
            assert(!typeManager.addUnion("invalid_union", listOf("nonexistent_type")))
            true
        } catch (e: AssertionError) {
            false
        }
    }

    private fun testNestedStruct(): Boolean {
        val typeManager = TypeManager()
        return try {
            typeManager.addAtomic("int", 4, 4)
            typeManager.addStruct("inner_struct", listOf("int"))
            assert(typeManager.addStruct("outer_struct", listOf("inner_struct")))
            val description = typeManager.describe("outer_struct")
            assert(description != null)
            true
        } catch (e: AssertionError) {
            false
        }
    }

    private fun testNestedUnion(): Boolean {
        val typeManager = TypeManager()
        return try {
            typeManager.addAtomic("int", 4, 4)
            typeManager.addUnion("inner_union", listOf("int"))
            assert(typeManager.addUnion("outer_union", listOf("inner_union", "int")))
            val description = typeManager.describe("outer_union")
            assert(description != null)
            true
        } catch (e: AssertionError) {
            false
        }
    }

    private fun testAddAtomicType(): Boolean {
        val typeManager = TypeManager()
        return try {
            assert(typeManager.addAtomic("int", 4, 4))
            assert(!typeManager.addAtomic("int", 4, 4))
            true
        } catch (e: AssertionError) {
            false
        }
    }

    private fun testDescribeAtomicType(): Boolean {
        val typeManager = TypeManager()
        return try {
            typeManager.addAtomic("char", 1, 1)
            val description = typeManager.describe("char")
            assert(description != null)
            assert(description!!.contains("Tipo: char"))
            assert(description.contains("Tamaño: 1"))
            assert(description.contains("Alineación: 1"))
            true
        } catch (e: AssertionError) {
            false
        }
    }

    private fun testStructCalculation(): Boolean {
        val typeManager = TypeManager()
        return try {
            typeManager.addAtomic("int", 4, 4)
            typeManager.addAtomic("char", 1, 1)
            assert(typeManager.addStruct("simple_struct", listOf("int", "char")))
            val description = typeManager.describe("simple_struct")
            assert(description != null)
            assert(description!!.contains("Tipo: simple_struct"))
            true
        } catch (e: AssertionError) {
            false
        }
    }

    private fun testInvalidStruct(): Boolean {
        val typeManager = TypeManager()
        return try {
            assert(!typeManager.addStruct("invalid_struct", listOf("nonexistent_type")))
            true
        } catch (e: AssertionError) {
            false
        }
    }

    private fun testDescribeNonexistent(): Boolean {
        val typeManager = TypeManager()
        return try {
            assert(typeManager.describe("nonexistent") == null)
            true
        } catch (e: AssertionError) {
            false
        }
    }
}
