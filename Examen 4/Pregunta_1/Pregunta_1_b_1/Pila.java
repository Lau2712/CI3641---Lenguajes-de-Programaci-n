import java.util.ArrayList;

public class Pila<T> implements Secuencia<T> {
    private ArrayList<T> elementos;
    
    public Pila() {
        elementos = new ArrayList<>();
    }
    
    public void agregar(T elemento) {
        elementos.add(elemento);
    }
    
    public T remover() {
        if (vacio()) {
            throw new SecuenciaVaciaException("La pila está vacía");
        }
        return elementos.remove(elementos.size() - 1);
    }
    
    public boolean vacio() {
        return elementos.isEmpty();
    }
}

