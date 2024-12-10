package Pregunta_1.Pregunta_1_b_2;

public class Main {
    public static void main(String[] args) {
        Grafo graph = new Grafo();
        
        // Agregar aristas al grafo
        graph.addEdge(0, 1);
        graph.addEdge(0, 2);
        graph.addEdge(1, 3);
        graph.addEdge(2, 3);
        graph.addEdge(3, 4);
        
        Busqueda dfs = new DFS(graph);
        Busqueda bfs = new BFS(graph);
        
        System.out.println("DFS nodes explored: " + dfs.buscar(0, 4));
        System.out.println("BFS nodes explored: " + bfs.buscar(0, 4));
    }
}
