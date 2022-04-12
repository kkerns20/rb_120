=begin
# Problem
- Fixed Length Array = an array that always has a fixed number of elements
- Write a class that implements a fixed length array
- Needs the following:
  - Initialize with one argument, an integer representing the length of hte array
  - Array should be initialized with all elements set to nil
  - Be able to reference individual elements in the array with FixedArray#[] method
    - Accepts integer as argument, representing the index of hte element to return
    - Should also accept negative integer as argument, representing negative index
  - Define a FixedArray#to_a method that return an array of all elements withing FixedArray
  - Define a FixedArray#[]=() setter method that allows reassignmnent of individual elements within the array
  - Define a FixedArray#to_s method that returns a string representation of the array
=end

# class FixedArray
#   attr_reader :array

#   def initialize(size)
#     @size = size
#     @array = [nil] * @size
#   end

#   def []=(index, obj)
#     self[index]
#     # raise IndexError if index.abs > @size - 1
#     array[index] = obj
#   end

#   def [](index)
#     array.fetch(index)
#   end

#   def to_s
#     array.to_s
#   end

#   def to_a
#     array
#   end
# end

class FixedArray
  def initialize(max_size)
    @array = Array.new(max_size)
  end

  def [](index)
    @array.fetch(index)
  end

  def []=(index, value)
    self[index]             # raise error if index is invalid!
    @array[index] = value
  end

  def to_a
    @array.clone
  end

  def to_s
    to_a.to_s
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end