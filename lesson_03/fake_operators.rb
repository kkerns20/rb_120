class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other_person)
    age > other_person.age
  end
end

# instantiate two Person objects
bob = Person.new("Bob", 49)
kim = Person.new("Kim", 33)
# What happens if we compare them?
puts "bob is older than kim" if bob > kim 
# NoMethodError
# Fixed by adding Person#> method
puts "bob is older" if bob > kim            # => "bob is older"
puts "bob is older" if bob.>(kim)           # => "bob is older"
# defining `>` doesn't automatically give us `<`

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    return if person.not_yet_18?              # suppose we had Person#not_yet_18?
    members.push person
  end
  # we can build in a guard clause to reject adding members unless some criteria is met
end

cowboys = Team.new("Dallas Cowboys")
emmitt = Person.new("Emmitt Smith", 46)     # suppose we're using the Person class from earlier

cowboys << emmitt                           # will this work?

p cowboys.members                             # => [#<Person:0x007fe08c209530>]
# makes the most sense when working with classes that represent collections

