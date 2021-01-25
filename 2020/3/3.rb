file = File.open('input3.txt')
file_data = file.readlines.map(&:chomp)

def part_1(slope_map)
  path = slope_map.map.with_index do |x, index|
    x[(3*index) % x.length]
  end
  puts path.count('#')
end

def part_2(slope_map)
  multipliers = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
  output = Array.new(multipliers.length) { |_| [] }

  multipliers.each.with_index do |mult, index|
    x, y = mult
    j, i = 0, 0
    while i < slope_map.length do
      output[index] += [slope_map[i][j % slope_map[i].length]]
      i += y
      j += x
    end
  end
  puts "#{output.map { |x| x.count('#') }.inject(&:*)}"
end

part_1(file_data)
part_2(file_data)
