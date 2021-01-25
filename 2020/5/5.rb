def find_row(boarding_pass)
  range = (0..127)
  boarding_pass[0..6].split('').each do |x|
    if x == 'F'
      range = (range.min..((range.max-range.min)/2)+range.min)
    elsif x == 'B'
      range = (((range.max-range.min)/2)+range.min+1..range.max)
    end
  end
  range.to_a.pop
end

def find_column(boarding_pass)
  range = (0..7)
  boarding_pass[7..9].split('').each do |x|
    if x == 'L'
      range = (range.min..((range.max-range.min)/2)+range.min)
    elsif x == 'R'
      range = (((range.max-range.min)/2)+range.min+1..range.max)
    end
  end
  range.to_a.pop
end

def find_seat_id(boarding_pass)
  find_row(boarding_pass) * 8 + find_column(boarding_pass)
end

validations = [
  { seat: 'BFFFBBFRRR', row: 70,  column: 7, id: 567 },
  { seat: 'FFFBBBFRRR', row: 14,  column: 7, id: 119 },
  { seat: 'BBFFBBFRLL', row: 102, column: 4, id: 820 }
]
validations.each do |x|
  puts "*** #{x[:seat]} ***\n"
  puts "Row: #{x[:row]} == #{find_row(x[:seat])}... #{x[:row] == find_row(x[:seat])}\n"
  puts "Column: #{x[:column]} == #{find_column(x[:seat])}... #{x[:column] == find_column(x[:seat])}\n"
  puts "ID: #{x[:id]} == #{find_seat_id(x[:seat])}... #{x[:id] == find_seat_id(x[:seat])}\n"
  puts "\n\n"
end

data = File.open('input5.txt').readlines.map(&:chomp)
a = data.max do |a, b|
  find_seat_id(a) <=> find_seat_id(b)
end
puts find_seat_id(a)

b = data.sort { |a, b| find_seat_id(a) <=> find_seat_id(b) }.map { |x| find_seat_id(x) }
range = (b.min..b.max).to_a
puts "#{(range - b) | (b - range)}"