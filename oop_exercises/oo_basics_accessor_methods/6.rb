# add the appropriate accessor methods
# @name is capitalized upon assignment.
class Person
  attr_accessor :name

  def name=(n)
    @name = n.capitalize
  end
end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name