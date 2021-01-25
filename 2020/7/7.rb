require 'set'
require 'pry'

data = File.open('input7.txt').readlines.map(&:chomp)

bags = {}

data.each do |line|
  key = line.match(/\A(?<bag_type>.*) bags contain/)[:bag_type]
  results = line.scan(/\d .* bags?/)
  results = results.length > 0 ? results[0].split(', ') : results
  bags[key] = results.map do |x|
    match = x.match(/(?<quantity>\d) (?<bag_type>.*) bag/)
    [match[:bag_type], match[:quantity].to_i]
  end
end

# puts "#{bags}"

# puts bags.length

# puts bags_containing_shiny_gold_bags.to_set.length

class Tree
  attr_accessor :nodes, :value, :quantity

  def initialize(value, quantity)
    @value = value
    @quantity = quantity
    @nodes = []
  end
end

def build_tree(bags, root)
  tree = Tree.new(*root)
  if bags[root[0]]
    bags[root[0]].each do |bag|
      tree.nodes << build_tree(bags, bag)
    end
  end
  tree
end

def count_bags(tree)
  return tree.quantity if tree.nodes == []
  node_sum = tree.nodes.sum do |node|
    (tree.quantity * count_bags(node))
  end
  tree.quantity + node_sum
end

def part2(bags)
  tree = build_tree(bags, ["shiny gold", 1])
  count_bags(tree) - 1
end

puts part2(bags)