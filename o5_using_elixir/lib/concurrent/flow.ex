defmodule Concurrent.Flow do
  import Server

  def run(last, print? \\ true, max_demand \\ 20) do
    1..last
    |> Flow.from_enumerable(max_demand: max_demand)
    |> Flow.map(fn(number) -> prime_value(number, false) end)
    |> Flow.map(fn(number) -> palindrome_value(number, print?) end)
    |> Stream.filter(&is_integer/1)
    |> Enum.to_list()
  end
end
