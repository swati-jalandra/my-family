require_relative 'node'

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

  def append_after(target, value)
    node = find(target)

    return unless node
    old_next = node.next
    node.next = Node.new(value)
    node.next.next = old_next
  end

  def find(target)
    node = head

    return false if !node.next
    return node if node.value == target

    loop do
      node = node.next
      return node if node.value == target
    end
  end
end

list = LinkedList.new()

p 'No of nodes that you want to create:'

nodes = gets.chomp.to_i
(1..nodes).each { |value| list.append(value) }

p list

p 'Node you want to delete: '
node = gets.chomp.to_i
list.delete(node)

p list

list.append_after(10, 25)

p list


