require './voyage'

instructions = File.open('input12.txt').readlines.map(&:chomp).map do |instruction|
  match = instruction.match /(?<method>[NESWLRF]{1})(?<value>\d+)/
  [match[:method].to_sym, match[:value].to_i]
end

boat = Voyage.new(instructions).perform
pp boat
