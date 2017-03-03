defmodule Concurrent.Task do
  import Server

  def run(last, max \\ 20) do
    Task.Supervisor.async_stream(TaskSupervisor, Enum.to_list(1..last),
                                 &prime_palindrome/1, max_concurrency: max)
    |> Stream.filter(fn({:ok, i}) -> is_integer(i) end)
    |> Enum.to_list()
  end
end
