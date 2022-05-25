#include "bridge.h"
#include "primes.h"
#include "Python.h"
#include <stdlib.h>
#include <stdio.h>

PythonPrimes *pythonFindPrimesUpTo(int n){
    printf("Iniciando função\n");

    int err = PyImport_AppendInittab("primes", PyInit_primes);
    Py_Initialize();
    PyObject *primes_module = PyImport_ImportModule("primes");

    printf("Buscando números primos\n");
    PyObject *primeList = find_primes_up_to(n);

    printf("Buscando tamanho da lista\n");
    int sizeOfList = PyList_Size(primeList);

    int *primeArrayList = malloc(sizeof(int) * sizeOfList);

    for(int i = 0; i < sizeOfList; i++){
        primeArrayList[i] = (int) PyLong_AsLong(PyList_GetItem(primeList, PyLong_AsSsize_t(PyLong_FromLong(i))));
    }

    Py_Finalize();

    PythonPrimes *result = malloc(sizeof(PythonPrimes));

    result->count = sizeOfList;
    result->numbers = primeArrayList;

    return result;
}

void main()
{
    PythonPrimes *primes = pythonFindPrimesUpTo(10);

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