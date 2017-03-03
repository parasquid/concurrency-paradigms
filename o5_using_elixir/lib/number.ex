defmodule Number do
  def is_palindrome?(number) when is_integer(number) do
    str = to_string(number)
    str == String.reverse(str)
  end
  def is_palindrome?(_), do: false

  def is_prime?(number) when is_integer(number) do
    Enum.all?(2..number-1, fn(divider) -> is_prime?(number, divider) end)
  end
  def is_prime?(_), do: false

  defp is_prime?(number, _divider) when number <= 1, do: false
  defp is_prime?(number, _divider) when number <= 3, do: true
  defp is_prime?(number, divider), do: rem(number, divider) != 0
end
