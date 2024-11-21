// Programa que suma todos los elementos de una matriz de dos dimensiones en C
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Función que suma recorriendo primero filas y luego columnas
double sumaFilasColumnas(int **matriz, int N, int M) {
    double suma = 0;
    for(int i = 0; i < N; i++) {
        for(int j = 0; j < M; j++) {
            suma += matriz[i][j];
        }
    }
    return suma;
}

// Función que suma recorriendo primero columnas y luego filas
double sumaColumnasFilas(int **matriz, int N, int M) {
    double suma = 0;
    for(int j = 0; j < M; j++) {
        for(int i = 0; i < N; i++) {
            suma += matriz[i][j];
        }
    }
    return suma;
}

// Función principal para medir tiempos
void medirTiempos(int N, int M) {
    // Asignación dinámica de la matriz por bloques
    int **matriz = (int **)calloc(N, sizeof(int *));
    if (matriz == NULL) {
        printf("Asignación fallida para N=%d, M=%d\n", N, M);
        return;
    }
    
    // Asignación por bloques para reducir la fragmentación de memoria
    for(int i = 0; i < N; i++) {
        matriz[i] = (int *)calloc(M, sizeof(int));
        if (matriz[i] == NULL) {
            for(int j = 0; j < i; j++) {
                free(matriz[j]);
            }
            free(matriz);
            printf("Asignación fallida para N=%d, M=%d\n", N, M);
            return;
        }
    }

    clock_t inicio, fin;
    double tiempo;
    
    printf("\nPara matriz de %dx%d:\n", N, M);
    
    // Mediciones para filas-columnas
    for(int k = 0; k < 3; k++) {
        inicio = clock();
        sumaFilasColumnas(matriz, N, M);
        fin = clock();
        tiempo = ((double)(fin - inicio)) / CLOCKS_PER_SEC;
        printf("Tiempo filas-columnas (ejecución %d): %f segundos\n", k+1, tiempo);
    }
    
    // Mediciones para columnas-filas
    for(int k = 0; k < 3; k++) {
        inicio = clock();
        sumaColumnasFilas(matriz, N, M);
        fin = clock();
        tiempo = ((double)(fin - inicio)) / CLOCKS_PER_SEC;
        printf("Tiempo columnas-filas (ejecución %d): %f segundos\n", k+1, tiempo);
    }

    // Liberación de memoria por bloques
    for(int i = 0; i < N; i++) {
        free(matriz[i]);
    }
    free(matriz);
}

int main() {
    int dimensiones[] = {100, 1000, 10000, 100000, 1000000};
    
    for(int i = 0; i < 5; i++) {
        for(int j = 0; j < 5; j++) {
            medirTiempos(dimensiones[i], dimensiones[j]);
        }
    }
    printf("\nFIN\n");
    return 0;
}

// Análisis de los resultados:

// Si existe una diferencia en los tiempos de ejecución de filas-columnas y columnas-filas, esto principalmente
// se debe al principio de localidad espacial y temporal de la memoria caché.
// La versión filas-columnas suele ser más eficiente porque accede a elementos de la memoria, dandole un mejor uso al caché.

// La forma de la matriz afecta también significativamente el rendimiento. Si la matriz es rectangular puede tener distintos comportamientos
// depediendo de si es más ancha o alta.

// El patrón de acceso a la memoria es más eficiente cuando la matriz es recorrida siguiendo el patrón de la memoria (en C es por filas)

// Finalmente, al ejecutar el programa observamos la variación que ocurre en múltiples ejecuciones: destacamos principalmente que los tiempo 
// pueden variar ligera o considerablemente dependiendo de la actividad del sistema operativo (si sólo se ejecuta el programa o se están realizando
// otras tareas), el estado de la memoria caché, el efecto de almacenar las variables globales en el segmento de datos y de almacenar las variables
// locales en una pila.

// Para matrices de gran tamaño, se recomienda emplear la asignación dinámica de memoria (heap)