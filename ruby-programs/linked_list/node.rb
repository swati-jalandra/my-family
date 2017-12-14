class Node
  attr_accessor :value, :next

  def initialize(value, pointer = nil)
    @value = value
    @next = pointer
  end

  def to_s
    "Node with value #{value}"
  end
end
