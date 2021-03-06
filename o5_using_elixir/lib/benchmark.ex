defmodule Benchmark do
  def run do
    Benchee.run(%{
      "Task" => fn -> Concurrent.Task.run(100, false) end,
      # "Flow" => fn -> Concurrent.Flow.run(100, false) end,
      "Pool" => fn -> Concurrent.Pool.run(100, false) end
    })
  end
end
