import java.util.ArrayList;

public class Cola<T> implements Secuencia<T> {
    private ArrayList<T> elementos;
    
    public Cola() {
        elementos = new ArrayList<>();
    }
    
    public void agregar(T elemento) {
        elementos.add(elemento);
    }
    
    public T remover() {
        if (vacio()) {
            throw new SecuenciaVaciaException("La cola está vacía");
        }
        return elementos.remove(0);
    }
    
    public boolean vacio() {
        return elementos.isEmpty();
    }
}