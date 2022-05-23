from cmath import sqrt
from typing import List

# https://www.baeldung.com/cs/prime-number-algorithms
def findPrimesUpTo(n: int) :
    A = [True for i in range(n)]

    for i in range(2, sqrt(n)):
        if A[i]:
            for j in range(pow(i, 2), n+1, i):
                A[j] = False

    primes = []

    for i in range(2, sqrt(n)):
        if A[i]:
            primes.append(i)

    return primes

