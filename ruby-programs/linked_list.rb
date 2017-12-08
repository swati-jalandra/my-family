#http://www.rubyguides.com/2017/08/ruby-linked-list/
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


class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  def append(value)
    if head
      find_tail.next = Node.new(value)
    else
      @head = Node.new(value)
    end
  end

  def find_tail
    node = head

    return node if !node.next
    loop do
      node = node.next
      return node if !node.next
    end
  end
end

list = LinkedList.new()

list.append(10)
list.append(20)
list.append(30)
list.append(40)

puts list.inspect



