

import java.util.*;

public class TablaMetodoVirtual {
    private Map<String, DefinicionClases> classes;
    
    public TablaMetodoVirtual() {
        classes = new HashMap<>();
    }

    public boolean addClass(String name, String superClassName, List<String> methods) {
        // Verificar si la clase ya existe
        if (classes.containsKey(name)) {
            System.out.println("Error: La clase " + name + " ya existe");
            return false;
        }

        // Verificar si la superclase existe (si se especifica una)
        if (superClassName != null && !classes.containsKey(superClassName)) {
            System.out.println("Error: La superclase " + superClassName + " no existe");
            return false;
        }

        // Verificar métodos duplicados
        Set<String> methodSet = new HashSet<>(methods);
        if (methodSet.size() != methods.size()) {
            System.out.println("Error: Hay métodos duplicados en la definición");
            return false;
        }

        // Verificar ciclos en la herencia
        if (superClassName != null && detectCycle(name, superClassName)) {
            System.out.println("Error: Se detectó un ciclo en la jerarquía de herencia");
            return false;
        }

        classes.put(name, new DefinicionClases(name, superClassName, methods));
        return true;
    }

    private boolean detectCycle(String className, String currentSuper) {
        if (className.equals(currentSuper)) return true;
        DefinicionClases superClass = classes.get(currentSuper);
        if (superClass == null || !superClass.hasInheritance()) return false;
        return detectCycle(className, superClass.getSuperClassName());
    }

    public List<Metodo> describeClass(String className) {
        if (!classes.containsKey(className)) {
            System.out.println("Error: La clase " + className + " no existe");
            return null;
        }

        List<Metodo> virtualTable = new ArrayList<>();
        Map<String, String> methodOwners = new HashMap<>();
        
        // Construir la tabla de métodos virtuales
        buildVirtualTable(className, methodOwners);
        
        // Convertir el mapa a una lista ordenada de métodos
        methodOwners.forEach((methodName, ownerClass) -> 
            virtualTable.add(new Metodo(methodName, ownerClass)));
        
        Collections.sort(virtualTable, (m1, m2) -> m1.getName().compareTo(m2.getName()));
        return virtualTable;
    }

    private void buildVirtualTable(String className, Map<String, String> methodOwners) {
        DefinicionClases classDef = classes.get(className);
        
        System.out.println("Debug - Processing class: " + className);
        System.out.println("Debug - Methods in current class: " + classDef.getMethods());
        
        if (classDef.hasInheritance()) {
            DefinicionClases superClass = classes.get(classDef.getSuperClassName());
            for (String method : superClass.getMethods()) {
                methodOwners.put(method, superClass.getName());
            }
        }
        
        // Add/override with current class methods
        for (String method : classDef.getMethods()) {
            methodOwners.put(method, className);
        }
    }
}

