require "parallel"
require "ruby-progressbar"
require 'etc'
require_relative "primes"

NUM_PROCESSORS = Etc.nprocessors

slices = []
(FIRST..LAST).each_slice(LAST / NUM_PROCESSORS) { |slice| slices << slice }

primes = Parallel.map(slices,
  in_processes: NUM_PROCESSORS,
  progress: "#{NUM_PROCESSORS} processes"
) do |slice|
  slice.reduce([]) { |memo, n| memo << n if Primes.is_prime(n); memo }
end.flatten


slices = []
primes.each_slice(primes.count / NUM_PROCESSORS) { |slice| slices << slice }

palindromes = Parallel.map(slices,
  in_processes: NUM_PROCESSORS,
  progress: "#{NUM_PROCESSORS} processes"
) do |slice|
  slice.reduce([]) { |memo, n| memo << n if Primes.is_palindrome(n); memo }
end.flatten

palindromes.each do |n|
  puts "#{n} is a palindromic prime"
end