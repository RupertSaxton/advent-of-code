require 'set'
require 'pry'

data = File.open('input7.txt').readlines.map(&:chomp)

bags = {}

data.each do |line|
  key = line.match(/\A(?<bag_type>.*) bags contain/)[:bag_type]
  results = line.scan(/\d .* bags?/)
  results = results.length > 0 ? results[0].split(', ') : results
  bags[key] = results.map { |x| x.match(/\d (?<bag_type>.*) bag/)[:bag_type] }
end

bags_containing_shiny_gold_bags = []

bags_to_check = ["shiny gold"]

while bags_to_check.length > bags_containing_shiny_gold_bags.length do
  bags_containing_shiny_gold_bags = bags_to_check.dup
  bags.each do |k, v|
    if (bags_to_check & v).length > 0
      bags_to_check << k
    end
  end
  bags_to_check = bags_to_check.to_set.to_a
end

puts bags.length

puts bags_containing_shiny_gold_bags.to_set.length
