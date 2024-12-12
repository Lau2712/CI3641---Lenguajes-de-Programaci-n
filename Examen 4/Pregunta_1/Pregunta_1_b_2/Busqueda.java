import java.util.*;

public abstract class Busqueda {
    protected Grafo grafo;
    
    public Busqueda(Grafo grafo) {
        this.grafo = grafo;
    }
    
    public int buscar(int D, int H) {
        Set<Integer> visited = new HashSet<>();
        Collection<Integer> container = createContainer();
        container.add(D);
        int nodesExplored = 0;
        
        while (!container.isEmpty()) {
            int current = getNext(container);
            
            if (!visited.contains(current)) {
                nodesExplored++;
                visited.add(current);
                
                if (current == H) {
                    return nodesExplored;
                }
                
                for (int neighbor : grafo.getNeighbors(current)) {
                    if (!visited.contains(neighbor)) {
                        container.add(neighbor);
                    }
                }
            }
        }
        
        return -1;
    }
    
    protected abstract Collection<Integer> createContainer();
    protected abstract int getNext(Collection<Integer> container);
    
}
