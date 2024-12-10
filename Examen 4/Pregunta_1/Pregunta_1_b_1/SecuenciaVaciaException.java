package Pregunta_1.Pregunta_1_b_1;
import java.lang.RuntimeException;

public class SecuenciaVaciaException extends RuntimeException {
    public SecuenciaVaciaException(String mensaje) {
        super(mensaje);
    }
}
