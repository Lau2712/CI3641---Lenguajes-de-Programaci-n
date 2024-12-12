import java.util.*;

public class Grafo {

    private Map<Integer, List<Integer>> adjacencyList;
    
    public Grafo() {
        adjacencyList = new HashMap<>();
    }
    
    public void addEdge(int source, int destination) {
        adjacencyList.computeIfAbsent(source, k -> new ArrayList<>()).add(destination);
        // Si el grafo es no dirigido, descomentar la siguiente línea
        // adjacencyList.computeIfAbsent(destination, k -> new ArrayList<>()).add(source);
    }
    
    public List<Integer> getNeighbors(int node) {
        return adjacencyList.getOrDefault(node, new ArrayList<>());
    }
    
}
