require 'pry'

instructions = File.open('input14.txt').readlines.map(&:chomp)

mem = {}

mask = ''
instructions.each do |instruction|
  if instruction.match? /mask/
    mask = instruction.sub("mask = ", '')
  else
    matches = instruction.match /mem\[(?<address>\d+)\] = (?<value>\d+)/
    address = matches[:address]
    value = matches[:value].to_i
    mem[address] = (mask.gsub('X', '0').to_i(2) | value) & mask.gsub('X', '1').to_i(2)
  end
end

puts mem.values.reduce(&:+)
