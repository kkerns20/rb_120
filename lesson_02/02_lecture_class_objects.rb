=begin
1.
  - Code the class definition, given the instance and name method calls
2. 
  - Modify class definiton to include the given methods
3. 
  - Create a smart #name= method that takes either a first or full name
    - should set first_name and last_name appropriately
4. 
  - Create some more person onbjects, compare their names for equality
5. 
  - Explain the output of the code
    - Override the to_s method
  
=end

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def to_s
    name
  end

  # Redundant code in intiailize and name= can be pulled here
  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end
#  1.
bob = Person.new('bob')
p bob.name                  # => 'bob'
p bob.name = 'Robert'
p bob.name                  # => 'Robert'
# 2.
bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'
# 3.
bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

p bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'
# 4.
bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p bob.name == rob.name
# 5.
bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}" 
# With the `to_s` method in our Person class, theis correctly output's
# the name we desire of "Robert Smith"