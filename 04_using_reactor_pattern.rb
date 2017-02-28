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
    puts n if n
  }

  timer = 0
  EM.add_periodic_timer(1) {
    puts "tick! #{timer += 1}"
  }

  tickloop = EM.tick_loop do
    if work.empty?
      :stop
    else
      EM.next_tick(calculate_primes)
      EM.next_tick(calculate_palindromes)
      EM.next_tick(print_messages)
    end
  end
  tickloop.on_stop { EM.stop }
}

puts "all done!"
