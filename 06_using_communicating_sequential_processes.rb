require "concurrent"
require "concurrent-edge"
require_relative "numeric"

WORKER_COUNT = 4
Channel = Concurrent::Channel

work = Channel.new(capacity: LAST)
primes = Channel.new(capacity: LAST)
palindromes = Channel.new(capacity: LAST)
messages = Channel.new(capacity: LAST)

done = Channel.new(capacity: 1)

WORKER_COUNT.times do |prime_worker|
  Channel.go {
    work.each do |n|
      primes << (n.is_prime? ? n : false)
    end
  }
end

WORKER_COUNT.times do |palindrome_worker|
  Channel.go {
    primes.each do |n|
      palindromes << (n && n.is_palindrome? ? n : false)
    end
  }
end

WORKER_COUNT.times do |message_worker|
  Channel.go {
    palindromes.each do |n|
      messages << (n ? "#{n} is a palindromic prime" : false)
    end
  }
end

Channel.go {
  (FIRST..LAST).each_with_index do |n|
    work << n
  end
}

Channel.go {
  (FIRST..LAST).each do |n|
    message = ~messages
    puts message if message
  end

  done << "all done!"
}

puts ~done