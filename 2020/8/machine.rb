class State
  attr_accessor :accumulator, :next

  def initialize(accumulator, next_val)
    @accumulator = accumulator
    @next = next_val
  end
end

class Machine
  attr_accessor :instructions, :state, :visited

  def initialize(instructions)
    @instructions = instructions
    @state = State.new(0, 0)
    @visited = []
  end

  def play
    while true do
      break if self.state.next < 0 || self.state.next > self.instructions.length - 1
      break if visited.include? self.state.next
      self.state = send(*self.instructions[self.state.next], self.state)
    end
    if self.state.next == self.instructions.length
    end
    self.state.accumulator
  end

  def acc(value, current_state)
    visited << current_state.next
    updated_acc = current_state.accumulator + value
    updated_next = current_state.next + 1
    State.new(updated_acc, updated_next)
  end

  def jmp(value, current_state)
    visited << current_state.next
    updated_next = current_state.next + value
    State.new(current_state.accumulator, updated_next)
  end

  def nop(value, current_state)
    visited << current_state.next
    updated_next = current_state.next + 1
    State.new(current_state.accumulator, updated_next)
  end
end
