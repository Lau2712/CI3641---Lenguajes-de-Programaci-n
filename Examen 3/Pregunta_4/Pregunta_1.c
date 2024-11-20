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
    // Asignación dinámica de la matriz
    int **matriz = (int **)malloc(N * sizeof(int *));
    if (matriz == NULL) {
        printf("No hay suficiente memoria para N=%d, M=%d\n", N, M);
        return;
    }
    
    for(int i = 0; i < N; i++) {
        matriz[i] = (int *)malloc(M * sizeof(int));
        if (matriz[i] == NULL) {
            printf("No hay suficiente memoria para N=%d, M=%d\n", N, M);
            // Liberar memoria ya asignada
            for(int j = 0; j < i; j++) {
                free(matriz[j]);
            }
            free(matriz);
            return;
        }
    }

    // Medición de tiempos para filas-columnas
    clock_t inicio, fin;
    double tiempo;
    
    printf("\nPara matriz de %dx%d:\n", N, M);
    
    // Tres ejecuciones para filas-columnas
    for(int k = 0; k < 3; k++) {
        inicio = clock();
        sumaFilasColumnas(matriz, N, M);
        fin = clock();
        tiempo = ((double)(fin - inicio)) / CLOCKS_PER_SEC;
        printf("Tiempo filas-columnas (ejecución %d): %f segundos\n", k+1, tiempo);
    }
    
    // Tres ejecuciones para columnas-filas
    for(int k = 0; k < 3; k++) {
        inicio = clock();
        sumaColumnasFilas(matriz, N, M);
        fin = clock();
        tiempo = ((double)(fin - inicio)) / CLOCKS_PER_SEC;
        printf("Tiempo columnas-filas (ejecución %d): %f segundos\n", k+1, tiempo);
    }

    // Liberar memoria
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
    
    return 0;
}

// Análisis de los resultados:

// Diferencia entre implementaciones:
// Sí hay diferencias en los tiempos de ejecución entre las dos implementaciones debido al principio de localidad espacial y temporal de la memoria caché.
// La versión filas-columnas suele ser más rápida porque accede a elementos contiguos en memoria, aprovechando mejor la caché.
// Efecto de la forma de la matriz:
// La forma de la matriz afecta significativamente el rendimiento.
// Matrices rectangulares pueden mostrar diferentes comportamientos dependiendo de si son más anchas o altas.
// El patrón de acceso a memoria es más eficiente cuando se recorre siguiendo el layout en memoria (por filas en C).
// Variación en múltiples ejecuciones:
// Los tiempos pueden variar ligeramente entre ejecuciones debido a:
// Actividad del sistema operativo
// Estado de la caché
// Otros procesos en ejecución
// Efecto de la declaración global vs local:
// La declaración global (estática) vs local (pila) puede afectar el rendimiento:
// Variables globales se almacenan en el segmento de datos
// Variables locales se almacenan en la pila
// Para matrices grandes, es preferible usar asignación dinámica (heap)

// Para compilar y ejecutar el programa:
// gcc -o matriz_suma matriz_suma.c
