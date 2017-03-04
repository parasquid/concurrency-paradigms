defmodule Concurrent.Task do
  import Server

  def run(last, print? \\ true, max \\ 20) do
    Task.Supervisor.async_stream(TaskSupervisor, Enum.to_list(1..last),
                                 fn(i) -> prime_palindrome(i, print?) end,
                                 max_concurrency: max)
    |> Stream.filter(fn({:ok, i}) -> is_integer(i) end)
    |> Enum.to_list()
  end
end
