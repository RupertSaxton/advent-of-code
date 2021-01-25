require 'pry'

ivs = {
  [1,3,2] => 1,
  [2,1,3] => 10,
  [1,2,3] => 27,
  [2,3,1] => 78,
  [3,2,1] => 438,
  [3,1,2] => 1836,
}

def part1(input)
  output = input.dup
  numbers_spoken = Hash.new { |h, k| h[k] = [] }
  input.each.with_index { |x, i| numbers_spoken[x] += [i] }

  (2020-input.length).times do |i|
    j = i + input.length
    # binding.pry
    if numbers_spoken[output[-1]].length <= 1
      numbers_spoken[0] += [j]
      output += [0]
    else
      number = numbers_spoken[output[-1]][-1] - numbers_spoken[output[-1]][-2]
      numbers_spoken[number] += [j]
      output += [number]
    end
  end
  output
end

ivs.each do |k, v|
  puts "#{part1(k)[-1] == ivs[k]}"
end

puts part1([0,8,15,2,12,1,4])[-1]
