# concurrency-paradigms

The baseline "workload" will be the following:

    Count the number of primes between 1 to n
    Determine if the number is a palindrome or not
    Push the number to Google Sheets

but implemented in a sequential fashion.

In my machine running a VM (Ubuntu 16.10) with an i7 6700HQ (4 cores for the VM) and 8G memory assigned running ruby ruby 2.3.1p112 (n = 10_000_000):

```
[~/parasquid/concurrency-paradigms] (master) tristan$ time ruby naive.rb

real  1m6.758s
user  1m5.452s
sys 0m1.092s
```

Using the parallel gem (processes)

```
[~/parasquid/concurrency-paradigms] (master) tristan$ time ruby using_parallel_gem_processes.rb

real  0m10.614s
user  0m31.256s
sys 0m0.088s
```
