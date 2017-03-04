defmodule Concurrent.Agent do
  import Server

  def start_link(_) do
    Agent.start_link(fn -> nil end)
  end

  def set_value(agent, value), do: Agent.update(agent, fn(number)-> value end)

  def get_value(agent), do: Agent.get(agent, &(&1))

  def prime_value?(agent, print? \\ true) do
    Agent.update(agent, fn(number) -> prime_value(number, print?) end)
  end

  def palindrome_value?(agent, print? \\ true) do
    Agent.update(agent, fn(number) -> palindrome_value(number, print?) end)
  end
end
