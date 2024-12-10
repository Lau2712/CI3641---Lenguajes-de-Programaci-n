
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import java.util.*;

public class Tests {
    @Test
    public void testBasicClassDefinition() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertTrue(vmt.addClass("A", null, Arrays.asList("f", "g")));
        
        List<Metodo> methods = vmt.describeClass("A");
        assertNotNull(methods);
        assertEquals(2, methods.size());
    }

    @Test
    public void testInheritance() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        vmt.addClass("A", null, Arrays.asList("f", "g"));
        vmt.addClass("B", "A", Arrays.asList("f", "h"));
        
        List<Metodo> methods = vmt.describeClass("B");
        assertNotNull(methods);
        assertEquals(3, methods.size());
    }
}
