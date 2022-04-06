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

  # def <<(person)
  #   return if person.not_yet_18?              # suppose we had Person#not_yet_18?
  #   members.push person
  # end
  # we can build in a guard clause to reject adding members unless some criteria is met
  def <<(person)
    members.push person
  end

  def +(other_team)
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end
end

# cowboys = Team.new("Dallas Cowboys")
# emmitt = Person.new("Emmitt Smith", 46)     # suppose we're using the Person class from earlier

# cowboys << emmitt                           # will this work?

# p cowboys.members                             # => [#<Person:0x007fe08c209530>]
# # makes the most sense when working with classes that represent collections

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Michael Irvin", 49)


niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)
niners << Person.new("Deion Sanders", 47)

dream_team = niners + cowboys # without rewriting the Team#+ method, we would have an array, not a new Team object
puts dream_team.inspect                     # => #<Team:0x007fac3b9eb878 @name="Temporary Team" ...