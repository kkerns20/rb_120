=begin
- write a CircleQueue class 
  - should create an array of size based upon argument in #new(int)
- nil will be used ot designate empty spots
- instance method `enqueue` will add a value 
- instance method `dequeue` will pop the oldest value

# Algo
- create an instance of Array clas based on max_size as a constuctor
- enqueue --> instance method
  - shift the array
  - push argument to array
- dequeue
  - return nil if array is all nils
  - find first non nil index
    - set this value as a negative index of array to oldest
    - reset this element to nil
    - return oldest
=end

class CircularQueue
  def initialize(max_size)
    @array = Array.new(max_size)
  end

  def enqueue(input)
    @array.shift
    @array.push(input)
  end

  def dequeue
    return nil if @array.all?(nil)
    non_empty = @array.compact.size
    oldest = @array[-non_empty]
    @array[-non_empty] = nil
    oldest
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil