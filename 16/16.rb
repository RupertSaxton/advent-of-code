rules = File.open('rules.txt').readlines.map(&:chomp).map do |x|
  a = x.match /\w+: (?<range1>\d+-\d+) or (?<range2>\d+-\d+)/
  [a[:range1], a[:range2]]
end.map do |x|
  x.map do |y|
    bounds = y.match /(?<lower>\d+)-(?<upper>\d+)/
    (bounds[:lower].to_i..bounds[:upper].to_i)
  end
end.flatten

def build_ranges(ranges)
  output = []
  ranges.each do |range|
    output.any? do |x|
      if
    end
  end
end

pp rules
