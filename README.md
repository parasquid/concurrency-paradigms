# concurrency-paradigms

The baseline "workload" will be the classic:

    Count the number of primes between 1 to n

but implemented in a sequential fashion.

In my machine running Windows 10 WSL (Ubuntu 16.04):

```
[~/parasquid/concurrency-paradigms] (master) tristan$ time ruby primes.rb

real  0m25.124s
user  0m25.016s
sys   0m0.109s
```
