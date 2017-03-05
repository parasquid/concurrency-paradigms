require 'celluloid'
require_relative "numeric"

WORKER_COUNT = 4

class WorkQueue
  include Celluloid
  attr_reader :queue

  def initialize(out:)
    @out = out
  end

end

class MessagePrinter < WorkQueue
  def call(n)
    puts n
  end
end

class PalindromeCalculator < WorkQueue
  def call(n)
    @out.async.call(n) if n.is_palindrome?
  end
end

class PrimeCalculator < WorkQueue
  def call(n)
    @out.async.call(n) if n.is_prime?
  end
end

class NumberFeeder < WorkQueue
  def call(range)
    range.each { |n| @out.async.call(n) }
  end
end

messages = MessagePrinter.new(out: nil)
palindromes = PalindromeCalculator.new(out: messages)
primes = PrimeCalculator.new(out: palindromes)
feeder = NumberFeeder.new(out: primes)

feeder.call(FIRST..LAST)

sleep
