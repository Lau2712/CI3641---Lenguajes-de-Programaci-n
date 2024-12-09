import java.lang.RuntimeException;

public interface Secuencia<T> {
    void agregar(T elemento);
    T remover() throws SecuenciaVaciaException;
    boolean vacio();
}