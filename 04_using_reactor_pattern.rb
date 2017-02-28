require "eventmachine"
require_relative "numeric"

EM.run {
  work = (FIRST..LAST)
  primes = []
  palindromes = []
  messages = []

  calculate_primes = ->{
    puts "calculate_primes"
    primes = work.map { |n|
      n if n.is_prime?
    }.compact
  }

  calculate_palindromes = ->{
    puts "calculate_palindromes"
    palindromes = primes.map { |n|
      n if n.is_palindrome?
    }.compact
  }

  print_messages = ->{
    palindromes.map { |n| "#{n} is a palindromic prime" }
  }

  puts "deferring prime calculation"
  EM.defer(calculate_primes, ->(primes) {
    puts "deferring palindrome calculation"
    EM.defer(calculate_palindromes, ->(palindromes) {
      puts "deferring message printing"
      EM.defer(print_messages, ->(messages) {
        puts messages
        EM.stop
      })
      puts "message printing deferred"
    })
    puts "palindrome calculation deferred"
  })
  puts "prime calculation deferred"

  timer = 0
  EM.add_periodic_timer(1) {
    puts timer += 1
  }

}

puts "all done!"
