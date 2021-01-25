require 'set'

input = File.open('input10.txt').readlines.map { |x| x.chomp.to_i }.sort

input = [0] + input + [input[-1] + 3]

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

class Tree
  attr_accessor :nodes, :value

  def initialize(value)
    @value = value
    @nodes = []
  end
end

def build_tree(input)
  value = input[0]
  tree = Tree.new(value)
  return tree if input.length == 1
  if input.length < 4
    intersection = (value+1..value+3).to_a & input[1..-1]
  else
    intersection = (value+1..value+3).to_a & input[1..3]
  end
  intersection.each.with_index do |x, i|
    tree.nodes << build_tree(input[i+1..-1])
  end
  tree
end

def count_value_in_tree(tree, target_value, current_count)
  return 1 if tree.value == target_value
  tree.nodes.sum do |node|
    count_value_in_tree(node, target_value, current_count)
  end
end

def find_break_indexes(input)
  values = input[0..-3].select.with_index do |x, i|
    diff1 = input[i+1] - x
    diff2 = input[i+2] - input[i+1]
    if diff1 == 3 && diff2 == 3
      true
    else
      false
    end
  end
  values.map do |x|
    input.index(x)
  end
end


def part2(input)
  breaks = [0] + find_break_indexes(input) + [input.length - 1]
  counts = breaks[0..-2].map.with_index do |x, i|
    tree = build_tree(input[x..breaks[i+1]])
    count_value_in_tree(tree, input[breaks[i+1]], 0)
  end
  counts.reduce(&:*)
end

puts part1(input)
puts "#{part2(input)}"