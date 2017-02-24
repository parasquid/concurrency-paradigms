# concurrency-paradigms

The baseline "workload" will be the following:

    Count the number of primes between 1 to n
    Determine if the number is a palindrome or not
    Push the number to Google Sheets

but implemented in a sequential fashion.

In my machine running a VM (Ubuntu 16.10) with an i7 6700HQ (4 cores for the VM) and 8G memory assigned running ruby ruby 2.3.1p112 (n = 1_000_000):

```
[~/parasquid/concurrency-paradigms] (master) tristan$ time ruby 01_naive.rb

real  0m0.973s
user  0m0.960s
sys   0m0.012s

```


```
[~/parasquid/concurrency-paradigms] (master) tristan$ time ruby 02_using_parallel_gem_processes.rb

real  0m0.169s
user  0m0.212s
sys   0m0.060s

```

```
[~/parasquid/concurrency-paradigms] (master) tristan$ time ruby 03_using_communicating_sequential_processes.rb

real  0m4.122s
user  0m3.052s
sys   0m1.292s

```

Simulating network latency (with n = 500, delay is 0.2):

```
[~/parasquid/concurrency-paradigms] (master) tristan$ time ruby 01_naive.rb

real  0m37.931s
user  0m0.112s
sys   0m0.028s
```


```
[~/parasquid/concurrency-paradigms] (master) tristan$ time ruby 02_using_parallel_gem_processes.rb

real  0m10.985s
user  0m0.096s
sys   0m0.072s
```

```
[~/parasquid/concurrency-paradigms] (master) tristan$ time ruby 03_using_communicating_sequential_processes.rb

real  0m5.765s
user  0m1.516s
sys   0m3.856s
```

Note: It seems that the CSP is limited by the number of workers in the worker pool. Doubling the number of workers in the pool drastically reduces the time spent in computing the palindromic primes with simulated network latency.