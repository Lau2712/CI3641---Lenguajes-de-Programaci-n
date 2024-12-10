
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


import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import java.util.*;

public class Tests {
    @Test
    public void testDefinicionClases() {
        List<String> methods = Arrays.asList("method1", "method2");
        DefinicionClases clase = new DefinicionClases("TestClass", "SuperClass", methods);
        
        assertEquals("TestClass", clase.getName());
        assertEquals("SuperClass", clase.getSuperClassName());
        assertTrue(clase.hasInheritance());
        assertEquals(new HashSet<>(methods), clase.getMethods());
    }

    @Test
    public void testMetodo() {
        Metodo metodo = new Metodo("testMethod", "TestClass");
        assertEquals("testMethod", metodo.getName());
        assertEquals("TestClass", metodo.getClassName());
        assertEquals("testMethod -> TestClass :: testMethod", metodo.toString());
    }

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
        assertTrue(vmt.addClass("A", null, Arrays.asList("f", "g")));
        assertTrue(vmt.addClass("B", "A", Arrays.asList("h")));
        
        List<Metodo> methods = vmt.describeClass("B");
        assertNotNull(methods);
        assertEquals(3, methods.size());
    }

    @Test
    public void testDuplicateClass() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertTrue(vmt.addClass("A", null, Arrays.asList("f", "g")));
        assertFalse(vmt.addClass("A", null, Arrays.asList("h")));
    }

    @Test
    public void testInvalidSuperClass() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertFalse(vmt.addClass("B", "A", Arrays.asList("f")));
    }

    @Test
    public void testDuplicateMethods() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertFalse(vmt.addClass("A", null, Arrays.asList("f", "f")));
    }

    @Test
    public void testInheritanceCycle() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertTrue(vmt.addClass("A", null, Arrays.asList("f")));
        assertTrue(vmt.addClass("B", "A", Arrays.asList("g")));
        assertFalse(vmt.addClass("A", "B", Arrays.asList("h")));
    }

    @Test
    public void testDescribeNonExistentClass() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertNull(vmt.describeClass("NonExistent"));
    }

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

    @Test
    public void testMultiLevelInheritance() {
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();
        assertTrue(vmt.addClass("A", null, Arrays.asList("f")));
        assertTrue(vmt.addClass("B", "A", Arrays.asList("g")));
        assertTrue(vmt.addClass("C", "B", Arrays.asList("h")));
        
        List<Metodo> methods = vmt.describeClass("C");
        assertNotNull(methods);
        assertEquals(3, methods.size());
    }
}
