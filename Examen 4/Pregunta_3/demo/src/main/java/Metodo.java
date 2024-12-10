

public class Metodo {
    private String name;
    private String className;

    public Metodo(String name, String className) {
        this.name = name;
        this.className = className;
    }

    public String getName() {
        return name;
    }

    public String getClassName() {
        return className;
    }

    @Override
    public String toString() {
        return name + " -> " + className + " :: " + name;
    }
}
