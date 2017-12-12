# Stack is a last-in-first-out data structure that can be easily implemented using Array
# https://stackoverflow.com/questions/5006395/does-ruby-have-containers-like-stacks-queues-linked-lists-maps-or-sets
class Stack
  attr_accessor :store

  def initialize
    @store = Array.new
  end

  def push(element)
    store.push(element)
    self
  end

  def pop
    store.pop
    self
  end

  def size
    store.size
  end

  private

  def full?
    store.size > 10
  end

  def empty?
    store.empty?
  end
end

stack = Stack.new
p '--- push 1 ---'
p stack.push(1)

p '--- push 2 ---'
p stack.push(2)

p '--- push 3 ---'
p stack.push(3)

p '--- push 4 ---'
p stack.push(4)

p '--- push 5 ---'
p stack.push(5)

p '--- push 6 ---'
p stack.push(6)

p '--- push 7 ---'
p stack.push(7)

p '--- pop 7 ---'
p stack.pop

p '--- pop 6 ---'
p stack.pop

p '--- pop 5 ---'
p stack.pop

p '--- pop 4 ---'
p stack.pop

p '--- pop 3 ---'
p stack.pop

p '--- pop 2 ---'
p stack.pop

p '--- pop 1 ---'
p stack.pop
