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
