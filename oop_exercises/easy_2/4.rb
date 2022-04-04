# write a class that will display:
# ABC
# xyz

# when the following is run:
# my_data = Transform.new('abc')
# puts my_data.uppercase
# puts Transform.lowercase('XYZ')

class Transform
  attr_reader :data

  def initialize(input)
    @data = input
  end

  def uppercase
    @data.upcase
  end

  def self.lowercase(input)
    input.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')
