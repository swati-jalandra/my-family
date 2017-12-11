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

  def find(value)
    node = head

    return false if !node.next
    return node if node.value == value
    loop do
      node = node.next
      return node if node.value == value
    end
  end

  def append_after(target, value)
    node = find(target)

    return unless node

    old_next = node.next
    node.next = Node.new(value)
    node.next.next = old_next
  end

  def delete(value)
    if head.value == value
      @head = head.next
      return
    end
    node = find_before(value)
    node.next = node.next.next
  end

  def find_before(value)
    node = head

    return false if !node.next
    return node if node.next.value == value

    loop do
      node = node.next
      return node if node.next && node.next.value == value
    end
  end
end

list = LinkedList.new()

list.append(10)
list.append(20)
list.append(30)
list.append(40)

puts "=========== Create Single linked list ==========================>"
puts list.inspect

puts "=========== Insert node in middle ==============================>"

list.append_after(10, 15)
puts list.inspect

puts "=========== Delete node ========================================>"
list.delete(15)
puts list.inspect





