require "concurrent"
require "concurrent-edge"
require_relative "numeric"

Concurrent.use_stdlib_logger(Logger::FATAL)

class Worker < Concurrent::Actor::RestartingContext
  def initialize(out:)
    @out = out
  end
end



class MessagePrinter < Worker
  def on_message(n)
    puts "#{n} is a palindromic prime" if n
  end
end

class PalindromeCalculator < Worker
  def on_message(n)
    @out.tell(n.is_palindrome? ? n : nil)
  end
end

class PrimeCalculator < Worker
  def on_message(n)
    @out.tell(n.is_prime? ? n : nil)
  end
end

class NumberFeeder < Worker
  def on_message(range)
    range.each do |n|
      @out.tell(n)
    end
  end
end

messages = MessagePrinter.spawn(name: :messages, link: true, args: [{out: nil}])
palindromes = PalindromeCalculator.spawn(name: :palindromes, link: true, args: [{out: messages}])
primes = PrimeCalculator.spawn(name: :primes, link: true, args: [{out: palindromes}])
feeder = NumberFeeder.spawn(name: :feeder, link: true, args: [{out: primes}])

feeder.tell((FIRST..LAST))

feeder.ask(:await).wait
primes.ask(:await).wait
palindromes.ask(:await).wait
messages.ask(:await).wait

puts "all done!"