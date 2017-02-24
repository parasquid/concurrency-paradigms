require "ruby-progressbar"
require "concurrent"
require "concurrent-edge"
require 'etc'
require_relative "primes"

NUM_PROCESSORS = Etc.nprocessors
Channel = Concurrent::Channel

work = Channel.new(capacity: NUM_PROCESSORS)
primes = Channel.new(capacity: NUM_PROCESSORS)
palindromes = Channel.new(capacity: NUM_PROCESSORS)
messages = Channel.new(capacity: NUM_PROCESSORS)

Channel.go {
  (FIRST..LAST).each_with_index do |n, index|
    work << n
  end
  work.close
}

Channel.go {
  work.each do |n|
    if Primes.is_prime(n)
      primes << n
    end
  end
  puts "work unblocked!"
  primes.close
}

Channel.go {
  primes.each do |n|
    if Primes.is_palindrome(n)
      palindromes << n
    end
  end
  puts "primes unblocked!"
  palindromes.close
}

Channel.go {
  palindromes.each do |n|
    messages << "#{n} is a palindromic prime"
  end
  puts "palindromes unblocked!"
  messages.close
}

messages.each do |message|
  puts message
end
