require 'pry'

input = File.open('input13.txt').readlines.map(&:chomp)

def part1(input)
  target_time = input[0].to_i
  buses = input[1].split(',').select { |x| x != 'x' }.map(&:to_i).sort

  times = {}
  buses.each do |x|
      earliest_time = (target_time / x) * x + x
      times[earliest_time] = x
  end

  puts (times.keys.min - target_time)*times[times.keys.min]
end

def part2(input)
  buses = []
  input.split(',').each.with_index do |x, i|
    if x != 'x'
      buses << [x.to_i, i]
    end
  end

  step, total_offset = buses[0]
  output = step
  buses[1..-1].each do |div, offset|
    while true do
      break if (output + offset) % div == 0
      output += step
    end
    step = step * div
  end
  output
end

puts "#{part2(input[1])}"
