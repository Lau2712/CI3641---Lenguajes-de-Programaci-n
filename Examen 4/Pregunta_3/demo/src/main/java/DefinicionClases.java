

import java.util.*;

public class DefinicionClases {
    private String name;
    private String superClassName;
    private Set<String> methods;

    public DefinicionClases(String name, String superClassName, List<String> methods) {
        this.name = name;
        this.superClassName = superClassName;
        this.methods = new HashSet<>(methods);
    }

    public String getName() {
        return name;
    }

    public String getSuperClassName() {
        return superClassName;
    }

    public Set<String> getMethods() {
        return methods;
    }

    public boolean hasInheritance() {
        return superClassName != null;
    }
}

