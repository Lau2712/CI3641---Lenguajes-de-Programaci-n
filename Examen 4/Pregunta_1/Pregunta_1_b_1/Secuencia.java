package Pregunta_1.Pregunta_1_b_1;

public interface Secuencia<T> {
    void agregar(T elemento);
    T remover() throws SecuenciaVaciaException;
    boolean vacio();
}