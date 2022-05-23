cmake_minimum_required(VERSION 3.4.1)

add_library(
            primes
            SHARED
            ../../lib/src/c/primes.c
)

target_link_libraries(primes -lm)

