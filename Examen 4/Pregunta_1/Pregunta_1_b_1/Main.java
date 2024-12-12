
public class Main {
    public static void main(String[] args) {
        // Ejemplo con Pila
        Pila<Integer> pila = new Pila<>();
        pila.agregar(1);
        pila.agregar(2);
        pila.agregar(3);
        System.out.println(pila.remover()); // Imprime: 3
        
        // Ejemplo con Cola
        Cola<Integer> cola = new Cola<>();
        cola.agregar(1);
        cola.agregar(2);
        cola.agregar(3);
        System.out.println(cola.remover()); // Imprime: 1
    }
}