# this will not work
class Student
  attr_reader :name

  def initialize(name, id)
    @name = name
    @id = id
  end

  def ==(other_student)
    id == other_student.id  # #id is private so cannot be called by another instance 
  end

  private
  attr_reader :id
end

wit = Student.new('Wit', 12345)
rhone = Student.new('Rhone', 23414)
wit == rhone                        # => NoMethodError: # #id is private so cannot be called by another instance 

# this will work
class Student
  attr_reader :name

  def initialize(name, id)
    @name = name
    @id = id
  end

  def ==(other_student)
    id == other_student.id  # #id is private so cannot be called by another instance 
  end

  protected
  attr_reader :id
end

wit = Student.new('Wit', 12345)
rhone = Student.new('Rhone', 23414)
wit == rhone                        # false
wit = wit                           # true