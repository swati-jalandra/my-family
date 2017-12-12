# Queue is a first-in-first-out data structure that can be easily implemented using Array
class Queue
  attr_accessor :store

  def initialize
    @store = Array.new
  end

  def enqueue(element)
    store.unshift(element)
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

queue = Queue.new
p '--- Enqueue 1 ---'
p queue.enqueue(1)

p '--- Enqueue 2 ---'
p queue.enqueue(2)

p '--- Enqueue 3 ---'
p queue.enqueue(3)

p '--- Enqueue 4 ---'
p queue.enqueue(4)

p '--- Enqueue 5 ---'
p queue.enqueue(5)

p '--- Enqueue 6 ---'
p queue.enqueue(6)

p '--- Enqueue 7 ---'
p queue.enqueue(7)

p '--- pop 1 ---'
p queue.pop

p '--- pop 2 ---'
p queue.pop

p '--- pop 3 ---'
p queue.pop

p '--- pop 4 ---'
p queue.pop

p '--- pop 5 ---'
p queue.pop

p '--- pop 6 ---'
p queue.pop

p '--- pop 7 ---'
p queue.pop

