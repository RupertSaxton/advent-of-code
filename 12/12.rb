instructions = File.open('input12.txt').readlines.map(&:chomp).map do |instruction|
  match = instruction.match /(?<method>[NESWLRF]{1})(?<value>\d+)/
  [match[:method].to_sym, match[:value].to_i]
end

class State
  attr_accessor :latitude, :longitude, :orientation

  def initialize(latitude, longitude, orientation)
    @latitude = latitude
    @longitude = longitude
    @orientation = orientation
  end
end

class Boat
  attr_accessor :instructions, :state

  ORIENTATIONS = [:N, :E, :S, :W].freeze

  def initialize(instructions)
    @instructions = instructions
    @state = State.new(0, 0, :E)
  end

  def voyage
    instructions.each do |instruction|
      self.state = send(instruction[0], instruction[1])
    end
    state
  end

  def N(value)
    State.new(state.latitude, state.longitude + value, state.orientation)
  end

  def E(value)
    State.new(state.latitude + value, state.longitude, state.orientation)
  end

  def S(value)
    State.new(state.latitude, state.longitude - value, state.orientation)
  end

  def W(value)
    State.new(state.latitude - value, state.longitude, state.orientation)
  end

  def L(value)
    index = ORIENTATIONS.index(state.orientation)
    updated_index = index - (value / 90)
    State.new(state.latitude, state.longitude, ORIENTATIONS[updated_index])
  end

  def R(value)
    index = ORIENTATIONS.index(state.orientation)
    updated_index = (index + (value / 90)) % ORIENTATIONS.length
    State.new(state.latitude, state.longitude, ORIENTATIONS[updated_index])
  end

  def F(value)
    send(state.orientation, value)
  end
end

boat = Boat.new(instructions).voyage
puts boat.inspect
