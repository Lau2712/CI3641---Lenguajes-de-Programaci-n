import java.util.Collection;
import java.util.LinkedList;
import java.util.Queue;

public class BFS extends Busqueda {
    public BFS(Grafo grafo) {
        super(grafo);
    }
    
    @Override
    protected Collection<Integer> createContainer() {
        return new LinkedList<>();
    }
    
    @Override
    protected int getNext(Collection<Integer> container) {
        return ((Queue<Integer>) container).poll();
    }

}
