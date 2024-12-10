package Pregunta_1.Pregunta_1_b_2;

import java.util.*;

public class DFS extends Busqueda {
    public DFS(Grafo grafo) {
        super(grafo);
    }
    
    @Override
    protected Collection<Integer> createContainer() {
        return new Stack<>();
    }
    
    @Override
    protected int getNext(Collection<Integer> container) {
        return ((Stack<Integer>) container).pop();
    }
    
}
