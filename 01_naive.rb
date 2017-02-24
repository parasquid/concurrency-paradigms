require "ruby-progressbar"
require_relative "primes"

primes = []
progress = ProgressBar.create(total: LAST)
(FIRST..LAST).each do |n|
  primes << n if Primes.is_prime(n)
  progress.increment
end

palindromes = []
progress = ProgressBar.create(total: primes.count)
primes.each do |n|
  palindromes << n if Primes.is_palindrome(n)
  progress.increment
end

palindromes.each { |n| puts "#{n} is a palindromic prime" }