# O5UsingElixir

### install dependencies & execute Mix
```
$ mix deps.get
$ iex -S mix

```

## Run Benchmark

```
iex> Benchmark.run
```

## Run Individual Module (defaulted to maximum 20 processes)
```
iex> Concurrent.Task.run(100) #run number 1..100
iex> Concurrent.Pool.run(100)
iex> Concurrent.Flow.run(100)
```
