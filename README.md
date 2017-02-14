# concurrency-paradigms

The baseline "workload" will be the classic:

    Count the number of primes between 1 to n

but implemented in a sequential fashion.

In my machine running Windows 10 WSL (Ubuntu 16.04) with an i7 6700HQ
and 24G memory running ruby 2.3.3p222 (n = 1_000_000):

```
[~/parasquid/concurrency-paradigms] (master) tristan$ time ruby primes.rb
Progress: |=======================================================================================================  |
78498

real  0m8.122s
user  0m7.781s
sys   0m0.328s
```

Using the parallel gem (processes)

```
[~/parasquid/concurrency-paradigms] (master) tristan$ time ruby using_parallel_gem_processes.rb
8 processes |Time: 00:00:00 | ====================================================================== | Time: 00:00:00
78498

real  0m1.042s
user  0m3.594s
sys   0m0.516s
```
