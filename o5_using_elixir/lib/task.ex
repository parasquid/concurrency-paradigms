defmodule Task do
  def run(last, max \\ 20) do
    Task.Supervisor.async_stream(TaskSupervisor, Enum.to_list(1..last),
                                 &prime_palindrome/1, max_concurrency: max)
    |> Stream.filter(fn({:ok, i}) -> is_integer(i) end)
    |> Enum.to_list
  end

  defp prime_palindrome(number) do
    number = number |> prime_value() |> palindrome_value()
    if is_integer(number), do: IO.puts number
    number
  end

  defp palindrome_prime(number) do
    number = number |> palindrome_value() |> prime_value()
    if is_integer(number), do: IO.puts number
    number
  end

  defp prime_value(number) when is_integer(number) do
    if Number.is_prime?(number), do: number, else: nil
  end
  defp prime_value(_), do: nil

  defp palindrome_value(number) when is_integer(number) do
    if Number.is_palindrome?(number), do: number, else: nil
  end
  defp palindrome_value(_), do: nil
end
