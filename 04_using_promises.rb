require "em-promise"
require_relative "numeric"

def numbers(range)
  deferred = EM::Q.defer
  EM.defer { deferred.resolve(range.to_a) }
  deferred.promise
end

def primes(n_array)
  deferred = EM::Q.defer
  EM.defer { deferred.resolve(n_array.select { |n| n.is_prime? }) }
  deferred.promise
end

def palindromes(primes)
  deferred = EM::Q.defer
  EM.defer { deferred.resolve(primes.select { |n| n.is_palindrome? }) }
  deferred.promise
end

def print_out(palindromes)
  deferred = EM::Q.defer
  palindromes.each do |n| puts "#{n} is a palindromic prime"; end
  deferred.resolve(true)
  deferred.promise
end

EM.run do
  numbers(FIRST..LAST).then(->(n_array) { n_array })
    .then(->(numbers) { primes(numbers) })
    .then(->(primes) { palindromes(primes) })
    .then(->(palindomes) { print_out(palindomes) })
    .then(->(time_to_stop) { EM.stop if time_to_stop })
end

puts "all done!"