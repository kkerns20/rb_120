=begin
7.
  - Create a class called Studetn with attributes name and grade
  - Do not make the getter public
  - Create a better_grade_than? method
=end

class Student
  attr_accessor :name
  attr_writer :grade

  def initialize(name, grade)
    self.name = name
    self.grade = grade 
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  attr_reader :grade
  
  def grade
    @grade
  end
end

joe = Student.new("Joe", 98)
bob = Student.new("Bob", 79)

puts 'Well done!' if joe.better_grade_than?(bob) # => "Well done!"
puts joe.grade # => NoMethodError