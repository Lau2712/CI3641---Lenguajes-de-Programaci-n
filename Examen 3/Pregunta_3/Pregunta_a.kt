// Definimos las clases base para los tipos de datos

sealed class DataType(val nombre: String, representacion: Int, alineacion: Int)
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
}

// Para el manejo principal del programa:
class TypeManager {
    private val types = mutableMapOf<String, DataType>()
    private val calculator = CalculadoraMemoria()

    fun addAtomic(nombre: String, representacion: Int, alineacion: Int): Boolean {
        if (types.containsKey(nombre)) return false
        types[nombre] = DataType.Atomic(nombre, representacion, alineacion)
        return true
    }

    fun addStruct(nombre: String, fieldTypes: List<String>): Boolean {
        if (types.containsKey(nombre)) return false
        
        val fields = fieldTypes.mapNotNull { types[it] }
        if (fields.representacion != fieldTypes.representacion) return false
        
        val (representacion, alineacion, _) = calculator.calculateUnpacked(
            DataType.Struct(nombre, fields, 0, 0)
        )
        
        types[nombre] = DataType.Struct(nombre, fields, representacion, alineacion)
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

// Para ejecutar
// kotlinc src/main/kotlin/*.kt -include-runtime -d program.jar
// java -jar program.jar