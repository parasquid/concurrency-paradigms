defmodule Number do
  @simulate_network_latency true
  @network_latency 200 #miliseconds

  def is_palindrome?(number) do
    if @simulate_network_latency, do: :timer.sleep(@network_latency)
    str = to_string(number)
    str == String.reverse(str)
  end

  def is_prime?(number) do
    if @simulate_network_latency, do: :timer.sleep(@network_latency)
    Enum.all?(2..number-1, fn(divider) -> is_prime?(number, divider) end)
  end

  defp is_prime?(number, _divider) when number <= 1, do: false
  defp is_prime?(number, _divider) when number <= 3, do: true

  defp is_prime?(number, divider) do
    if rem(number, divider) == 0, do: false, else: true
  end
end
