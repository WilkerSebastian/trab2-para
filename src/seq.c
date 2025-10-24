#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void generateMatrix(int** matrix, int size) {

    *matrix = (int*)calloc(size, sizeof(int));

    for (int i = 0; i < size; i++)
        (*matrix)[i] = rand() % 100;

}

void matrixMultiplication(int** A, int** B, int** C, int n) {

    for (int i = 0; i < n; i++) 
        for (int j = 0; j < n; j++) {

            (*C)[i * n + j] = 0;

            for (int k = 0; k < n; k++) 
                (*C)[i * n + j] += (*A)[i * n + k] * (*B)[k * n + j];
        
        }

}

int main(int argc, char const *argv[]) {

    srand(time(NULL));

    if (!argv[1]) {

        printf("Deve ser fornecido o tamanho da matriz\n");
        return 1;

    }

    clock_t start, end;
    double cpuTime;

    int n = atoi(argv[1]);
    int size = n * n;

    int* A = NULL;
    int* B = NULL;
    int* C = NULL;

    C = (int*)calloc(size, sizeof(int));

    generateMatrix(&A, size);
    generateMatrix(&B, size);

    start = clock();

    matrixMultiplication(&A, &B , &C, n);

    end = clock();

    cpuTime = ((double)(end - start)) / CLOCKS_PER_SEC;

    FILE *log = fopen("performace.txt", "w");

    fprintf(log, "%f", cpuTime);
        
    fclose(log);

    free(A);
    free(B);
    free(C);

    return 0;

}
