require 'set'

input = File.open('other.txt').readlines.map { |x| x.chomp.to_i }.sort

input = [0] + input + [input[-1] + 3]
puts "#{input}"

def part1(input)
  ones = 0
  threes = 0
  input[1..-1].each.with_index do |x, i|
    difference = x - input[i]
    if difference == 1
      ones += 1
    elsif difference == 3
      threes += 1
    end
  end

  ones * threes
end


def part2(input)
  counts = []
  input.each.with_index do |x, i|
    intersection = (x+1..x+3).to_a & input[i+1..i+3]
    if intersection.length == 3
      counts << intersection[1..-1]
    end
    counts << intersection
    # puts "counts: #{counts}"s
  end
  counts.map! { |arr| [arr[-1]] }.flatten!
  nodes = []
  input.each do |x|
    count = counts.count(x)
    nodes << count
  end
  total_memo = 0
  running_memo = 1
  nodes[0..-3].each.with_index do |x, i|
    if nodes[i+1..i+2] == [1, 1]
      total_memo += running_memo
      running_memo = 1
    elsif x > 0
      running_memo *= x
    end
  end

  total_memo + running_memo
  # counts.flatten!.sort
  # counts.map { |x| (1..x).reduce(&:*) }.sum
end

puts part1(input)
# x = part2(input)
# require 'pry'; binding.pry
# puts "#{input}"
puts "#{part2(input)}"

def wip(input)
  jumps = input[1..-1].map.with_index do |x, i|
    x - input[i]
  end

  indexes = jumps.each_index.select { |i| jumps[i] == 3}
end

# puts "#{wip(input)}"
