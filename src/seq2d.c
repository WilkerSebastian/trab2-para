#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void generateMatrix(int** matrix, int size) {

    *matrix = (int*)calloc(size, sizeof(int));

    for (int i = 0; i < size; i++)
        (*matrix)[i] = rand() % 100;

}

void matrixMultiplication(int** A, int** B, int** C, int n) {

    int blockSize = 512;

    for (int i_block = 0; i_block < n; i_block += blockSize) {

        for (int j_block = 0; j_block < n; j_block += blockSize) {

            for (int k_block = 0; k_block < n; k_block += blockSize) {

                int i_end = i_block + blockSize < n ? i_block + blockSize : n;
                int j_end = j_block + blockSize < n ? j_block + blockSize : n;
                int k_end = k_block + blockSize < n ? k_block + blockSize : n;

                for (int i = i_block; i < i_end; i++) 
                    for (int k = k_block; k < k_end; k++) {

                        int r = (*A)[i * n + k];

                        for (int j = j_block; j < j_end; j++) 
                            (*C)[i * n + j] += r * (*B)[k * n + j];
                        
                    }
                
            }

        }

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
