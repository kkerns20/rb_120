# When we run the following code...

class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

#  We get the following error...
# test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

#  Why and how do we fix it?
=begin
The class definition is solid. We create a new instance(object)
of bob and its name attribute is assigned to "Steve".

When we go to reassign that name attribute, we run into the error.
This is because the name instance variable is set to a 'getter' method.
We can fix it by changing line 4 to `attr_writer` (setter method) or 
`attr_accessor` (both getter and setter method) and the code will run.
=end



