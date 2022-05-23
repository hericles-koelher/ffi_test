#ifndef PRIMES_H
#define PRIMES_H

typedef struct primes
{
    int *numbers;
    int count;
} Primes;

Primes *findPrimesUpTo(int n);

#endif