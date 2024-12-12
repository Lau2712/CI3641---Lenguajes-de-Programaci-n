import java.lang.RuntimeException;

public class SecuenciaVaciaException extends RuntimeException {
    public SecuenciaVaciaException(String mensaje) {
        super(mensaje);
    }
}
