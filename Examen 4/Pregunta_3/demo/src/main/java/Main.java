
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

        String className;
        String superClassName = null;
        List<String> methods = new ArrayList<>();
        
        if (parts[1].contains(":")) {
            String[] inheritance = parts[1].split(":");
            className = inheritance[0].trim();
            superClassName = inheritance[1].trim();
        } else {
            className = parts[1];
        }

        for (int i = 2; i < parts.length; i++) {
            methods.add(parts[i]);
        }

        vmt.addClass(className, superClassName, methods);
    }
}
