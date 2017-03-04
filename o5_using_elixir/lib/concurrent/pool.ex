defmodule Concurrent.Pool do
  def run(last, print? \\ true) do
    tasks = Enum.map 1..last, fn(number) ->
      Task.async fn ->
        :poolboy.transaction :pool, fn(pid) ->
          Concurrent.Agent.set_value(pid, number)
          Concurrent.Agent.prime_value?(pid, false)
          Concurrent.Agent.palindrome_value?(pid, print?)
          Concurrent.Agent.get_value(pid)
        end, 60_000 # 60 seconds!!
      end
    end

    tasks |> Enum.map(&Task.await(&1))
  end
end
