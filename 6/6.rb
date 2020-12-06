require 'set'

data = File.read('input6.txt').split("\n\n").map do |x|
  x.split("\n").map { |y| y.split('') }
end

def part1(data)
  data.sum do |group_response|
    group_response.reduce(&:+).to_set.length
  end
end

def part2(data)
  data.sum do |group_response|
    group_response.reduce(&:&).length
  end
end

puts part1(data)
puts part2(data)