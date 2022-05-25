cmake_minimum_required(VERSION 3.4.1)

add_library(
            primes
            SHARED
            ../../lib/src/c/primes.c
)

target_link_libraries(primes -lm)

#[[ add_library(
            primes_python
            SHARED
            ../../lib/src/python/c_code/bridge.c
            ../../lib/src/python/c_code/primes.c
)

include_directories(../../lib/src/python/include/python3.9)
link_directories(../../lib/src/python/lib/python3.9)

target_link_libraries(primes_python -lpython3.9) ]]