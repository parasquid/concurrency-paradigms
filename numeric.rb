SIMULATE_NETWORK_LATENCY = true
NETWORK_DELAY = 0.2

class Numeric
  # check for primality
  # see https://en.wikipedia.org/wiki/Primality_test#Pseudocode
  def is_prime?
    n = self
    return false if n <= 1
    return true if n <= 3
    return false if n % 2 == 0
    return false if n % 3 == 0

    i = 5 # start off with 5 because we've dealt with 2..4
    while i * i <= n
      return false if n % i == 0
      return false if n % (i + 2) == 0
      i = i + 6
    end

    sleep NETWORK_DELAY if SIMULATE_NETWORK_LATENCY
    true # fell through sieve, must be prime
  end

  def is_palindrome?
    number = self.to_s

    sleep NETWORK_DELAY if SIMULATE_NETWORK_LATENCY
    number == number.reverse
  end

end

FIRST = 1
LAST = SIMULATE_NETWORK_LATENCY ? 500 : 200_000
