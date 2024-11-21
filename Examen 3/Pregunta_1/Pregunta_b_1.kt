// Defina un tipo de datos recursivo que represente numerales de Church

sealed class Church {
    object Zero : Church()
    data class Suc(val n: Church) : Church()

    companion object {
        fun add(a: Church, b: Church): Church = when (a) {
            is Zero -> b
            is Suc -> Suc(add(a.n, b))
        }
    }
}

// Los numerales se pueden construir de la siguiente manera:
// val zero = Church.Zero
// val one = Church.Suc(zero)
// val two = Church.Suc(Church.Suc(zero))