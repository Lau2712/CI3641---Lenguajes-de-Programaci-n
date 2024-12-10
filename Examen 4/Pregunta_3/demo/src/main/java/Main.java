
import java.util.*;

public class Main {
     public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        TablaMetodoVirtual vmt = new TablaMetodoVirtual();

        while (true) {
            System.out.print("> ");
            String line = scanner.nextLine().trim();
            String[] parts = line.split("\\s+");

            if (parts[0].equals("SALIR")) {
                break;
            } else if (parts[0].equals("CLASS")) {
                processClassCommand(vmt, parts);
            } else if (parts[0].equals("DESCRIBIR")) {
                if (parts.length != 2) {
                    System.out.println("Error: Formato incorrecto. Use: DESCRIBIR <nombre>");
                    continue;
                }
                List<Metodo> methods = vmt.describeClass(parts[1]);
                if (methods != null) {
                    methods.forEach(System.out::println);
                }
            } else {
                System.out.println("Comando no reconocido");
            }
        }
        scanner.close();
    }

    private static void processClassCommand(TablaMetodoVirtual vmt, String[] parts) {
        if (parts.length < 2) {
            System.out.println("Error: Formato incorrecto para comando CLASS");
            return;
        }

        // Get the full command after "CLASS"
        StringBuilder fullCommand = new StringBuilder();
        for (int i = 1; i < parts.length; i++) {
            fullCommand.append(parts[i]).append(" ");
        }
        String command = fullCommand.toString().trim();

        String className = null;
        String superClassName = null;
        List<String> methods = new ArrayList<>();

        // Parse class and inheritance
        String[] classAndMethods = command.split("\\s+");
        String classDeclaration = classAndMethods[0];
        
        
        if (classAndMethods[1].contains(":")) {
            String[] inheritance = command.split(":", 2);
            className = inheritance[0].trim();
            if (inheritance.length > 1) {
                String superClassAux = inheritance[1].trim();
                superClassName = superClassAux.substring(0,1);
            }
        } else {
            className = classDeclaration;
        }
        

        // Parse methods
        for (int i = 1; i < classAndMethods.length; i++) {
            if ((!classAndMethods[i].equals(":")) && (!classAndMethods[i].equals(superClassName))) {
                methods.add(classAndMethods[i]);
            }
        }

        System.out.println("Debug - Class: " + className);
        System.out.println("Debug - Superclass: " + superClassName);
        System.out.println("Debug - Methods: " + methods);

        vmt.addClass(className, superClassName, methods);
    }
}

