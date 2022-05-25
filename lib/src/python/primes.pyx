from math import isqrt
from typing import List

# https://www.baeldung.com/cs/prime-number-algorithms
cdef public find_primes_up_to(int n) :
    A = [True for i in range(n)]

    for i in range(2, isqrt(n) + 1):
        if A[i]:
            for j in range(pow(i, 2), n, i):
                A[j] = False

    primes = []

    for i in range(2, n):
        if A[i]:
            primes.append(i)

    return primes

