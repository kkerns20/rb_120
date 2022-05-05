# using the default `==` method
class Student
  attr_reader :name, :id

  def initialize(name, id)
    @name = name
    @id = id
  end
end

rhone_1 = Student.new('Rhone', 33020)
rhone_2 = Student.new('Rhone', 33020) 

p rhone_1 == rhone_2      # => false