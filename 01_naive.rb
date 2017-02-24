require "ruby-progressbar"
require_relative "primes"

first = 1
last = 10_000_000
primes = []
progress = ProgressBar.create(total: last)
(first..last).each do |n|
  primes << n if Primes.is_prime(n)
  progress.increment
end

palindromes = []
progress = ProgressBar.create(total: primes.count)
primes.each do |n|
  palindromes << n if Primes.is_palindrome(n)
  progress.increment
end
