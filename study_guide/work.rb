class Gradelevel
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(student)
    members.push student
  end

  def +(other_grade)
    result_group = Gradelevel.new('New Group')
    # Use Array#+ to change the @members of the new grade to return
    result_group.members = members + other_grade.members
    result_group
  end
end

# define Student class for collaborator objects
class Student
  attr_accessor :name, :gpa

  def initialize(name, gpa)
    @name = name
    @gpa = gpa
  end
end

juniors = Gradelevel.new('Juniors')
juniors << Student.new('Jon', 3.9)
juniors << Student.new('Rory', 3.91)
juniors << Student.new('Phil', 3.75)

seniors = Gradelevel.new('Seniors')
seniors << Student.new('Jordan', 3.25)
seniors << Student.new('Ernie', 3.45)
seniors << Student.new('Jack', 3.45)

upperclassmen = juniors + seniors
p upperclassmen
# <Gradelevel:0x00007f2e31a0cf60 @name="New Group", 
# @members=[#<Student:0x00007f2e31a0d5f0 @name="Jon", @gpa=3.9>, 
            #<Student:0x00007f2e31a0d4b0 @name="Rory", @gpa=3.91>, 
            #<Student:0x00007f2e31a0d438 @name="Phil", @gpa=3.75>, 
            #<Student:0x00007f2e31a0d258 @name="Jordan", @gpa=3.25>, 
            #<Student:0x00007f2e31a0d190 @name="Ernie", @gpa=3.45>, 
            #<Student:0x00007f2e31a0d0f0 @name="Jack", @gpa=3.45>]>