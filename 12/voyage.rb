require './state'
require 'pry'

class Voyage
  attr_accessor :instructions, :states

  COEFFICIENTS = [[1, 1], [1, -1], [-1, -1], [-1, 1]]

  def initialize(instructions)
    @instructions = instructions
    @states = { boat: State.new(0, 0), waypoint: State.new(10, 1)}
  end

  def perform
    instructions.each do |instruction|
      # binding.pry
      self.states = send(instruction[0], instruction[1])
    end
    states
  end

  def N(value)
    current_waypoint = states[:waypoint]
    waypoint = State.new(
      current_waypoint.latitude,
      current_waypoint.longitude + value,
    )
    { boat: states[:boat], waypoint: waypoint }
  end

  def E(value)
    current_waypoint = states[:waypoint]
    waypoint = State.new(
      current_waypoint.latitude + value,
      current_waypoint.longitude,
    )
    { boat: states[:boat], waypoint: waypoint }
  end

  def S(value)
    current_waypoint = states[:waypoint]
    waypoint = State.new(
      current_waypoint.latitude,
      current_waypoint.longitude - value,
    )
    { boat: states[:boat], waypoint: waypoint }
  end

  def W(value)
    current_waypoint = states[:waypoint]
    waypoint = State.new(
      current_waypoint.latitude - value,
      current_waypoint.longitude,
    )
    { boat: states[:boat], waypoint: waypoint }
  end

  def L(value)
    index = COEFFICIENTS.index(offset_quadrant)
    coeffs = COEFFICIENTS[index - (value / 90)]

    current_waypoint = states[:waypoint]
    if (value / 90) % 2 == 0
      waypoint = State.new(
        states[:boat].latitude + coeffs[0] * waypoint_offset[:x].abs,
        states[:boat].longitude + coeffs[1] * waypoint_offset[:y].abs,
      )
    else
      waypoint = State.new(
        states[:boat].latitude + coeffs[0] * waypoint_offset[:y].abs,
        states[:boat].longitude + coeffs[1] * waypoint_offset[:x].abs,
      )
    end
    { boat: states[:boat], waypoint: waypoint }
  end

  def R(value)
    index = COEFFICIENTS.index(offset_quadrant)
    coeffs = COEFFICIENTS[(index + (value / 90)) % COEFFICIENTS.length]

    current_waypoint = states[:waypoint]
    if (value / 90) % 2 == 0
      waypoint = State.new(
        states[:boat].latitude + coeffs[0] * waypoint_offset[:x].abs,
        states[:boat].longitude + coeffs[1] * waypoint_offset[:y].abs,
      )
    else
      waypoint = State.new(
        states[:boat].latitude + coeffs[0] * waypoint_offset[:y].abs,
        states[:boat].longitude + coeffs[1] * waypoint_offset[:x].abs,
      )
    end
    { boat: states[:boat], waypoint: waypoint }
  end

  def F(value)
    updated_boat = State.new(
      states[:boat].latitude + value*waypoint_offset[:x],
      states[:boat].longitude + value*waypoint_offset[:y],
    )
    updated_waypoint = State.new(
      updated_boat.latitude + waypoint_offset[:x],
      updated_boat.longitude + waypoint_offset[:y],
    )
    { boat: updated_boat, waypoint: updated_waypoint }
  end

  def waypoint_offset
    {
      x: states[:waypoint].latitude - states[:boat].latitude,
      y: states[:waypoint].longitude - states[:boat].longitude
    }
  end

  def offset_quadrant
    if waypoint_offset[:x] > 0
      if waypoint_offset[:y] > 0
        [1, 1]
      else
        [1, -1]
      end
    else
      if waypoint_offset[:y] > 0
        [-1, 1]
      else
        [-1, -1]
      end
    end
  end
end
