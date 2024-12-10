
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import java.util.*;

public class Tests {

    // Prueba básica para la creación y descripción de una clase
    @Test
    public void testBasicClassDefinition() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertTrue(vmt.addClass("A", null, Arrays.asList("f", "g")));
        
        List<Metodo> methods = vmt.describeClass("A");
        assertNotNull(methods);
        assertEquals(2, methods.size());
    }

    // Prueba para la herencia
    @Test
    public void testInheritance() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        vmt.addClass("A", null, Arrays.asList("f", "g"));
        vmt.addClass("B", "A", Arrays.asList("f", "h"));
        
        List<Metodo> methods = vmt.describeClass("B");
        assertNotNull(methods);
        assertEquals(3, methods.size());
    }

    // Prueba para la definición de una clase
    @Test
    public void testDefinicionClases() {
        List<String> methods = Arrays.asList("method1", "method2");
        DefinicionClases clase = new DefinicionClases("TestClass", "SuperClass", methods);
        
        assertEquals("TestClass", clase.getName());
        assertEquals("SuperClass", clase.getSuperClassName());
        assertTrue(clase.hasInheritance());
        assertEquals(new HashSet<>(methods), clase.getMethods());
    }

    // Prueba para la definición de un método
    @Test
    public void testMetodo() {
        Metodo metodo = new Metodo("testMethod", "TestClass");
        assertEquals("testMethod", metodo.getName());
        assertEquals("TestClass", metodo.getClassName());
        assertEquals("testMethod -> TestClass :: testMethod", metodo.toString());
    }

    // Prueba de validación de clase duplicada
    @Test
    public void testDuplicateClass() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertTrue(vmt.addClass("A", null, Arrays.asList("f", "g")));
        assertFalse(vmt.addClass("A", null, Arrays.asList("h")));
    }

    // Prueba de validación superclase no existente
    @Test
    public void testInvalidSuperClass() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertFalse(vmt.addClass("B", "A", Arrays.asList("f")));
    }

    // Prueba de validación métodos duplicados
    @Test
    public void testDuplicateMethods() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertFalse(vmt.addClass("A", null, Arrays.asList("f", "f")));
    }

    // Prueba de validación ciclo en herencia
    @Test
    public void testInheritanceCycle() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertTrue(vmt.addClass("A", null, Arrays.asList("f")));
        assertTrue(vmt.addClass("B", "A", Arrays.asList("g")));
        assertFalse(vmt.addClass("A", "B", Arrays.asList("h")));
    }

    // Prueba de validación describir una clase no existente
    @Test
    public void testDescribeNonExistentClass() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertNull(vmt.describeClass("NonExistent"));
    }

    // Prueba de validación de métodos sobreescritos
    @Test
    public void testMethodOverriding() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertTrue(vmt.addClass("A", null, Arrays.asList("f", "g")));
        assertTrue(vmt.addClass("B", "A", Arrays.asList("f")));
        
        List<Metodo> methods = vmt.describeClass("B");
        assertNotNull(methods);
        
        // Verificar que el método f está definido en B
        boolean found = false;
        for (Metodo m : methods) {
            if (m.getName().equals("f") && m.getClassName().equals("B")) {
                found = true;
                break;
            }
        }
        assertTrue(found);
    }

    // Prueba con múltiples niveles de herencia
    @Test
    public void testMultiLevelInheritance() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertTrue(vmt.addClass("A", null, Arrays.asList("f")));
        assertTrue(vmt.addClass("B", "A", Arrays.asList("g")));
        assertTrue(vmt.addClass("C", "B", Arrays.asList("h")));
        
        List<Metodo> methods = vmt.describeClass("C");
        assertNotNull(methods);
        assertEquals(3, methods.size());

        // Validamos que cada método haya sido añadido correctamente con su respectiva clase
        boolean foundF = false;
        boolean foundG = false;
        boolean foundH = false;
        
        for (Metodo method : methods) {
            switch (method.getName()) {
                case "f":
                    assertEquals("A", method.getClassName());
                    foundF = true;
                    break;
                case "g":
                    assertEquals("B", method.getClassName());
                    foundG = true;
                    break;
                case "h":
                    assertEquals("C", method.getClassName());
                    foundH = true;
                    break;
            }
        }
        
        assertTrue(foundF, "Método 'f' de la clase A no se encontró");
        assertTrue(foundG, "Método 'g' de la clase B no se encontró");
        assertTrue(foundH, "Método 'h' de la clase C no se encontró");
    }
}