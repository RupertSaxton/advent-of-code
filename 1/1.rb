file = File.open('input1.txt')
file_data = file.readlines.map(&:chomp)

inputs = file_data.map!(&:to_i).sort!

def two_sum(array, target_val)
  start_ptr = 0
  end_ptr = array.length - 1

  while start_ptr < end_ptr do
    sum = array[start_ptr] + array[end_ptr]

    if sum == target_val
      return [array[start_ptr], array[end_ptr]]
    elsif sum < target_val
      start_ptr += 1
    elsif sum > target_val
      end_ptr -= 1
    end
  end

  []
end

def three_sum(array, target_val)
  output = []

  array.each.with_index do |x, i|
    remaining_array = array[0..i-1] + array[i+1..-1]
    combination = [x] + two_sum(remaining_array, target_val - x)
    return combination if combination.sum == target_val && combination.length == 3
  end

  output
end

puts "#{two_sum(inputs, 2020)}"
puts "#{three_sum(inputs, 2020)}"
