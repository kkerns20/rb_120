#  Create an object in Ruby

#  Objects are created from a Class in instantiation
  
# Create an object from a built in Ruby Class
name = String.new
name << 'John'
p name
p name.class

# Create an object that is an instance of a custom class.
# Use the class method `new` which returns an object of the calling class.
class Creation
end

the_world = Creation.new
p the_world.class
