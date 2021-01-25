file = File.read('input4.txt')
grouped = file.split("\n\n").map(&:chomp)

REQUIRED_FIELDS = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
OPTIONAL_FIELDS = ['cid']

def transform_to_hash(input)
  input.map do |creds|
    cleaned = creds.gsub("\n", ' ')
    output = {}
    cleaned.split(' ').each do |pairs|
      pair = pairs.split(':')
      output[pair[0]] = pair[1]
    end
    output
  end
end

def select_required_fields_present(input)
  parsed_details = transform_to_hash(input)
  parsed_details.select do |hash|
    REQUIRED_FIELDS & hash.keys == REQUIRED_FIELDS
  end
end

def valid_byr?(byr)
  (1920..2002).include? byr.to_i
end

def valid_iyr?(iyr)
  (2010..2020).include? iyr.to_i
end

def valid_eyr?(eyr)
  (2020..2030).include? eyr.to_i
end

def valid_hgt?(hgt)
  return false unless hgt.match?(/\A[0-9]+cm|in\z/)
  ranges = { "cm" => (150..193), "in" => (59..76) }
  # require 'pry'; binding.pry
  ranges[hgt.match(/cm|in/)[0]].include? hgt.match(/\A[0-9]+/)[0].to_i
end

def valid_hcl?(hcl)
  hcl.match? /\A#[0-9a-f]{6}\z/
end

def valid_ecl?(ecl)
  ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include? ecl
end

def valid_pid?(pid)
  pid.match? /\A[0-9]{9}\z/
end

def valid_fields?(passport)
  REQUIRED_FIELDS & passport.keys == REQUIRED_FIELDS
end

def select_valid_passports(input)
  parsed_details = transform_to_hash(input)
  parsed_details.select do |x|
    valid_fields?(x) && valid_byr?(x['byr']) && valid_iyr?(x['iyr']) && valid_eyr?(x['eyr']) && valid_hcl?(x['hcl']) && valid_ecl?(x['ecl']) && valid_pid?(x['pid']) && valid_hgt?(x['hgt'])
  end
end

part1 = select_required_fields_present(grouped)
puts(part1.length) == 222

part2 = select_valid_passports(grouped)
puts part2.length == 140
