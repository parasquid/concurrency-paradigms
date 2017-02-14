# https://github.com/grosser/parallel
# make sure you first do
# `gem install parallel`
require "parallel"
require "ruby-progressbar"
require 'etc'

NUM_PROCESSORS = Etc.nprocessors

class Prime
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

  def initialize(start:2, up_to:)
    @start = start
    @end = up_to
  end

  def list_primes
    slices = []
    (@start..@end).each_slice(@end / NUM_PROCESSORS) { |slice| slices << slice }

    Parallel.map(slices,
      in_processes: NUM_PROCESSORS,
      progress: "#{NUM_PROCESSORS} processes"
    ) do |slice|
      slice.reduce([]) { |memo, n| memo << n if self.class.is_prime(n); memo }
    end.flatten
  end

  def count_primes
    list_primes.count
  end
end

p = Prime.new(up_to: 1_000_000)
puts p.count_primes
