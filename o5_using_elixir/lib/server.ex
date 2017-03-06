defmodule Server do
  @simulate_network_latency true
  @network_latency 200 #miliseconds

  def prime_palindrome(number, print? \\ true) do
    number |> prime_value(false) |> palindrome_value(print?)
  end

  def palindrome_prime(number, print? \\ true) do
    number |> palindrome_value(false) |> prime_value(print?)
  end

  def prime_value(number, print? \\ true) do
    if @simulate_network_latency, do: :timer.sleep(@network_latency)
    number = if Number.is_prime?(number), do: number, else: nil
    print_number(number, print?)
    number
  end

  def palindrome_value(number, print? \\ true) do
    if @simulate_network_latency, do: :timer.sleep(@network_latency)
    number = if Number.is_palindrome?(number), do: number, else: nil
    print_number(number, print?)
    number
  end

  defp print_number(number, true) when is_number(number) do
    IO.write("[#{number}]")
  end
  defp print_number(_, true),  do: IO.write(".")
  defp print_number(_, false), do: nil
end
