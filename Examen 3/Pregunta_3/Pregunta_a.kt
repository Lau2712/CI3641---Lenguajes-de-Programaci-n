package main

// Definimos las clases base para los tipos de datos
sealed class DataType(val nombre: String, val representacion: Int, val alineacion: Int)
{
    class Atomico(nombre: String, representacion: Int, alineacion: Int) : DataType(nombre, representacion, alineacion)

    class Struct(nombre: String, val fields: List<DataType>, representacion: Int, alineacion: Int) : DataType(nombre, representacion, alineacion)

    class Union(nombre: String, val variants: List<DataType>, representacion: Int, alineacion: Int) : DataType(nombre, representacion, alineacion)
}

// Creamos una clase para manejar los cálculos de tamaño y alineación:
class CalculadoraMemoria{
    fun calculateUnpacked(dataType: DataType): Triple<Int, Int, Int> {
        return when (dataType) {
            is DataType.Atomico -> Triple(dataType.representacion, dataType.alineacion, 0)
            is DataType.Struct -> calculateUnpackedStruct(dataType)
            is DataType.Union -> calculateUnpackedUnion(dataType)
        }
    }

    fun calculatePacked(dataType: DataType): Triple<Int, Int, Int> {
        return Triple(0, 0, 0)
    }

    fun calculateOptimal(dataType: DataType): Triple<Int, Int, Int> {
        return Triple(0, 0, 0)
    }

    private fun calculateUnpackedStruct(struct: DataType.Struct): Triple<Int, Int, Int> {
        var currentOffset = 0
        var wastedBytes = 0
        var maxAlignment = 1

        struct.fields.forEach { field ->
            val fieldAlignment = field.alineacion
            maxAlignment = maxOf(maxAlignment, fieldAlignment)

            val padding = (fieldAlignment - (currentOffset % fieldAlignment)) % fieldAlignment
            wastedBytes += padding
            currentOffset += padding + field.representacion
        }

        val finalPadding = (maxAlignment - (currentOffset % maxAlignment)) % maxAlignment
        wastedBytes += finalPadding

        return Triple(currentOffset + finalPadding, maxAlignment, wastedBytes)
    }

    private fun calculateUnpackedUnion(union: DataType.Union): Triple<Int, Int, Int> {
        var maxSize = 0
        var maxAlignment = 1

        union.variants.forEach { variant ->
            maxSize = maxOf(maxSize, variant.representacion)
            maxAlignment = maxOf(maxAlignment, variant.alineacion)
        }

        val totalSize = maxSize + (maxAlignment - (maxSize % maxAlignment)) % maxAlignment
        val wastedBytes = totalSize - maxSize

        return Triple(totalSize, maxAlignment, wastedBytes)
    }
}

// Para el manejo principal del programa:
class TypeManager {
    private val types = mutableMapOf<String, DataType>()
    private val calculator = CalculadoraMemoria()

    fun addAtomic(nombre: String, representacion: Int, alineacion: Int): Boolean {
        if (types.containsKey(nombre)) return false
        types[nombre] = DataType.Atomico(nombre, representacion, alineacion)
        return true
    }

    fun addStruct(nombre: String, fieldTypes: List<String>): Boolean {
        if (types.containsKey(nombre)) return false
        val fields = fieldTypes.mapNotNull { types[it] }
        if (fields.size != fieldTypes.size) return false
        
        val (representacion, alineacion, _) = calculator.calculateUnpacked(
            DataType.Struct(nombre, fields, 0, 0)
        )
        
        types[nombre] = DataType.Struct(nombre, fields, representacion, alineacion)
        return true
    }

    fun addUnion(nombre: String, variantTypes: List<String>): Boolean {
        if (types.containsKey(nombre)) return false
        val variants = variantTypes.mapNotNull { types[it] }
        if (variants.size != variantTypes.size) return false
        
        val (representacion, alineacion, _) = calculator.calculateUnpacked(
            DataType.Union(nombre, variants, 0, 0)
        )
        
        types[nombre] = DataType.Union(nombre, variants, representacion, alineacion)
        return true
    }

    fun describe(nombre: String): String? {
        val type = types[nombre] ?: return null

        val (unpackedrepresentacion, unpackedAlign, unpackedWaste) = calculator.calculateUnpacked(type)
        val (packedrepresentacion, packedAlign, packedWaste) = calculator.calculatePacked(type)
        val (optimalrepresentacion, optimalAlign, optimalWaste) = calculator.calculateOptimal(type)

        return """
            Tipo: $nombre
            Sin empaquetar:
                Tamaño: $unpackedrepresentacion
                Alineación: $unpackedAlign
                Bytes desperdiciados: $unpackedWaste
            Empaquetado:
                Tamaño: $packedrepresentacion
                Alineación: $packedAlign
                Bytes desperdiciados: $packedWaste
            Óptimo:
                Tamaño: $optimalrepresentacion
                Alineación: $optimalAlign
                Bytes desperdiciados: $optimalWaste
        """.trimIndent()
    }
}

// fun main() {
//     val manager = TypeManager()

//     while (true) {
//         print("> ")
//         val input = readLine() ?: break
//         val parts = input.split(" ")

//         when (parts[0].uppercase()) {
//             "ATOMICO" -> {
//                 if (parts.size != 4) {
//                     println("Formato: ATOMICO <nombre> <representación> <alineación>")
//                     continue
//                 }
//                 val success = manager.addAtomic(
//                     parts[1],
//                     parts[2].toIntOrNull() ?: continue,
//                     parts[3].toIntOrNull() ?: continue
//                 )
//                 if (!success) println("Error: El tipo ${parts[1]} ya existe")
//             }

//             "STRUCT" -> {
//                 if (parts.size < 3) {
//                     println("Formato: STRUCT <nombre> [<tipo>...]")
//                     continue
//                 }
//                 val success = manager.addStruct(parts[1], parts.drop(2))
//                 if (!success) println("Error: El tipo ${parts[1]} ya existe o tipos inválidos")
//             }
//             "UNION" -> {
//                 if (parts.size < 3) {
//                     println("Formato: UNION <nombre> [<tipo>...]")
//                     continue
//                 }
//                 val success = manager.addUnion(parts[1], parts.drop(2))
//                 if (!success) println("Error: El tipo ${parts[1]} ya existe o tipos inválidos")
//             }
//             "DESCRIBIR" -> {
//                 if (parts.size != 2) {
//                     println("Formato: DESCRIBIR <nombre>")
//                     continue
//                 }
//                 val description = manager.describe(parts[1])
//                 if (description == null) println("Error: Tipo no encontrado")
//                 else println(description)
//             }
//             "SALIR" -> break
//             else -> println("Comando no reconocido")
//         }
//     }
// }

// // Para ejecutar
// // kotlinc src/main/kotlin/*.kt -include-runtime -d program.jar
// // java -jar program.jar