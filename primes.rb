class Primes
  # check for primality
  # see https://en.wikipedia.org/wiki/Primality_test#Pseudocode
  def self.is_prime(n)
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

    true # fell through sieve, must be prime
  end

  def self.is_palindrome(n)
    number = n.to_s
    number == number.reverse
  end

end
