#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>
#include <string.h>
#include "primes.h"

// https://www.baeldung.com/cs/prime-number-algorithms
Primes *findPrimesUpTo(int n)
{
    if (n <= 1)
    {
        return NULL;
    }

    bool *A = malloc(n * sizeof(bool));
    memset(A, true, n);

    for (int i = 2; i < sqrt(n); i++)
    {
        if (A[i])
        {
            for (int j = pow(i, 2); j <= n; j += i)
            {
                A[j] = false;
            }
        }
    }

    int *prime_list = malloc((n - 2) * sizeof(int));
    int count = 0;

    for (int i = 2; i < n; i++)
    {
        if (A[i])
        {
            prime_list[count++] = i;
        }
    }

    prime_list = realloc(prime_list, sizeof(int) * count);

    free(A);

    Primes *result = malloc(sizeof(Primes));

    result->numbers = prime_list;
    result->count = count;

    return result;
}

void main()
{
    Primes *primes = findPrimesUpTo(10);

    printf("%d\n", primes->count);

    printf("[");
    for (int i = 0; i < primes->count; i++)
    {
        if (i == primes->count - 1)
        {
            printf("%d", primes->numbers[i]);
        }
        else
        {
            printf("%d, ", primes->numbers[i]);
        }
    }
    printf("]\n");
}