class Parent
  def say_hi
    puts "Hi from Parent"
  end
end

class Child < Parent
  # Overriding method say_hi from superclass Parent
  def say_hi
    puts "Hi from Child"
  end

  # Overriding method send from superclass Object
  # Object send serves as a way to call a method by passing it a symbol 
  # or a string which represents the method you want to call.
  def send
    puts "send from Child"
  end

  # Overriding method instance_of? from super class Object
  # returns `true` if an object is an instance of a given class
  # false otherwise
  def instance_of?
    puts "I'm a fake instance"
  end
end

child = Child.new
child.say_hi

son = Child.new
# son.send :say_hi            # => Exception: wrong number of arguments
puts son.instance_of? Child   # => Exception: wrong number of arguments
puts son.instance_of? Parent  # => Exception: wrong number of arguments