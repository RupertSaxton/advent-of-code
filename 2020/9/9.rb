data = File.open('input9.txt').readlines.map(&:chomp).map(&:to_i)

def two_sum(array, target_val)
  start_ptr = 0
  end_ptr = array.length - 1

  while start_ptr < end_ptr do
    sum = array[start_ptr] + array[end_ptr]

    if sum == target_val
      return true
    elsif sum < target_val
      start_ptr += 1
    elsif sum > target_val
      end_ptr -= 1
    end
  end

  false
end

def part1(data, offset)
  data[offset..-1].each.with_index do |x, i|
    sub_array = data[i..i+offset-1].dup.sort
    return x unless two_sum(sub_array, x)
  end
end

def find_contiguous_block(data, target_val)
  (2..data.length - 2).each do |x|
    data[0..data.length - x].each.with_index do |_y, i|
      block = data[i..i+x]
      return block if block.sum == target_val
    end
  end
end

def part2(data, target_val)
  block = find_contiguous_block(data, target_val)
  block.max + block.min
end

puts part1(data, 25)
puts part2(data, part1(data, 25))
