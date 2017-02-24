require "ruby-progressbar"
require "concurrent"
require "concurrent-edge"
require 'etc'
require_relative "primes"

NUM_PROCESSORS = Etc.nprocessors
Channel = Concurrent::Channel

work = Channel.new(capacity: LAST)
primes = Channel.new(capacity: LAST)
palindromes = Channel.new(capacity: LAST)
messages = Channel.new(capacity: LAST)

done = Channel.new(capacity: 1)

(1..NUM_PROCESSORS).each do |prime_worker|
  Channel.go {
    work.each do |n|
      if Primes.is_prime(n)
        primes << n
      else
        primes << false
      end
    end
  }
end

(1..NUM_PROCESSORS).each do |palindrome_worker|
  Channel.go {
    primes.each do |n|
      if n && Primes.is_palindrome(n)
        palindromes << n
      else
        palindromes << false
      end
    end
  }
end

(1..NUM_PROCESSORS).each do |message_worker|
  Channel.go {
    palindromes.each do |n|
      if n
        messages << "#{n} is a palindromic prime"
      else
        messages << false
      end
    end
  }
end

Channel.go {
  (FIRST..LAST).each_with_index do |n|
    work << n
  end
  work.close
}

Channel.go {
  (FIRST..LAST).each do |n|
    message = ~messages
    puts message if message
  end
  done << "all done!"
}


puts ~done
