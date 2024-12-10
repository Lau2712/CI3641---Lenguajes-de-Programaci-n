

public class Metodo {
    private String name;
    private String className;

    // Constructor
    public Metodo(String name, String className) {
        this.name = name;
        this.className = className;
    }

    // Getters
    public String getName() {
        return name;
    }

    public String getClassName() {
        return className;
    }

    // ToString
    @Override
    public String toString() {
        return name + " -> " + className + " :: " + name;
    }
}

