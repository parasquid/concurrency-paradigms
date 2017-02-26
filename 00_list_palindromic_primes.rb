require_relative "numeric"

(FIRST..LAST).each do |n|
  puts "#{n} is a palindromic prime" if n.is_prime? && n.is_palindrome?
end
