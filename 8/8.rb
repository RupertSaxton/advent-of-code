require_relative './machine'

data = File.open('input8.txt').readlines.map do |line|
  split = line.chomp.split(' ')
  split[1] = split[1].to_i
  split[0] = split[0].to_sym
  split
end

a = Machine.new(data)
puts "#{a.play}"
