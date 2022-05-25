#ifndef BRIDGE_H
#define BRIDGE_H

typedef struct {
    int *numbers;
    int count;
} PythonPrimes;

PythonPrimes *pythonFindPrimesUpTo(int n);

#endif