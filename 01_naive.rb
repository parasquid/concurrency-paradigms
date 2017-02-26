require "ruby-progressbar"
require_relative "numeric"

primes = []
progress = ProgressBar.create(total: LAST)
(FIRST..LAST).each do |n|
  primes << n if n.is_prime?
  progress.increment
end

palindromes = []
progress = ProgressBar.create(total: primes.count)
primes.each do |n|
  palindromes << n if n.is_palindrome?
  progress.increment
end

palindromes.each { |n| puts "#{n} is a palindromic prime" }
