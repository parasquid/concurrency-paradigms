defmodule Task do
  def run(last, max \\ 20) do
    Task.Supervisor.async_stream(TaskSupervisor, Enum.to_list(1..last),
                                 Number, :is_prime?, [], max_concurrency: max)
    |> Enum.to_list()
  end
end
