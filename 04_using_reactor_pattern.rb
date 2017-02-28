require "eventmachine"
require_relative "numeric"

EM.run {
  work = (FIRST..LAST).to_a
  primes = []
  palindromes = []
  messages = []

  calculate_primes = ->{
    n = work.shift
    primes << n if n && n.is_prime?
  }

  calculate_palindromes = ->{
    n = primes.shift
    palindromes << n if n && n.is_palindrome?
  }

  print_messages = ->{
    n = palindromes.shift
    puts "#{n} is a palindromic prime" if n
  }

  timer = 0
  EM.add_periodic_timer(1) {
    puts "tick! #{timer += 1}"
  }

  tickloop = EM.tick_loop do
    if work.empty? && primes.empty? && palindromes.empty?
      :stop
    else
      operations = [calculate_primes, calculate_palindromes, print_messages]
      EM.next_tick(operations.sample)
    end
  end
  tickloop.on_stop { EM.stop }
}

puts "all done!"
