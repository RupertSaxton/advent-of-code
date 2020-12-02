file = File.open('input2.txt')
file_data = file.readlines.map(&:chomp).map(&:split)

inputs = file_data.map do |line|
  lower, upper = line[0].split('-')
  letter = line[1].chomp(':')
  password = line[2]
  { lower: lower.to_i, upper: upper.to_i, letter: letter, password: password }
end

def part_1_rules(inputs)
  valid_inputs = inputs.select do |input|
    range = (input[:lower]..input[:upper])
    range.include?(input[:password].count(input[:letter]))
  end
end

def part_2_rules(inputs)
  valid_inputs = inputs.select do |input|
    (input[:password][input[:lower] - 1] == input[:letter]) ^ (input[:password][input[:upper] - 1] == input[:letter])
  end
end

puts part_1_rules(inputs).length
puts part_2_rules(inputs).length
