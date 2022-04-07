# If we call `Hello.hi` we get an error message...
# Fix it

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  # to call `Hello.hi` we must make it a class method first
  def self.hi
    # and then instantiate an object of the `Greeting` class
    # so that it may define `greet` only on its instances, 
    # rather than on the `Greeting` class itself
    greeting = Greeting.new
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

p Hello.hi