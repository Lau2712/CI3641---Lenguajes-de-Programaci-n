

import java.util.*;

public class DefinicionClases {
    private String name;
    private String superClassName;
    private Set<String> methods;

    // Constructor
    public DefinicionClases(String name, String superClassName, List<String> methods) {
        this.name = name;
        this.superClassName = superClassName;
        this.methods = new HashSet<>(methods);
    }

    // Obtener el nombre de la clase
    public String getName() {
        return name;
    }

    // Obtener el nombre de la superclase
    public String getSuperClassName() {
        return superClassName;
    }

    // Obtener los métodos
    public Set<String> getMethods() {
        return methods;
    }

    // Verificar si la clase tiene herencia
    public boolean hasInheritance() {
        return superClassName != null;
    }
}

