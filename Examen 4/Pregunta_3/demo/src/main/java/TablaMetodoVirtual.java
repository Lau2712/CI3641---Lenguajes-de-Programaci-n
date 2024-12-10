

import java.util.*;

public class TablaMetodoVirtual {
    private Map<String, DefinicionClases> classes;
    
    // Constructor
    public TablaMetodoVirtual() {
        classes = new HashMap<>();
    }

    // Función para agregar una clase
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

     // Función para detectar ciclos en la herencia
    private boolean detectCycle(String className, String currentSuper) {
        if (className.equals(currentSuper)) return true;
        DefinicionClases superClass = classes.get(currentSuper);
        if (superClass == null || !superClass.hasInheritance()) return false;
        return detectCycle(className, superClass.getSuperClassName());
    }

    // Función para describir la clase
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

    // Función para construir la tabla de métodos virtuales
    private void buildVirtualTable(String className, Map<String, String> methodOwners) {
        DefinicionClases classDef = classes.get(className);
        
        addSuperClassMethods(classDef, methodOwners);
        
        // Añadir los métodos de la clase actual
        for (String method : classDef.getMethods()) {
            methodOwners.put(method, className);
        }
    }

    // Función para obtener los métodos de una superclase
    private void addSuperClassMethods(DefinicionClases classDef, Map<String, String> methodOwners) {
        if (classDef.hasInheritance()) {
            String superClassNameAux = classDef.getSuperClassName();
            DefinicionClases superClass = classes.get(superClassNameAux);
            
            // Se añaden los métodos de la superclase actual
            for (String method : superClass.getMethods()) {
                // Solo se añade si el método no ha sido sobreescrito
                if (!methodOwners.containsKey(method)) {
                    methodOwners.put(method, superClass.getName());
                }
            }
            
            // Llamada recursiva para las superclases
            addSuperClassMethods(superClass, methodOwners);
        }
    }
}


