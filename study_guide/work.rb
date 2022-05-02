module Speakable
  def speak(sound)
    puts sound
  end
end

class Animal
  def eats
    puts "eats food"
  end
end

class Fish < Animal; end

class Person < Animal
  include Speakable
end

class Cat < Animal
  include Speakable
end

felix = Cat.new
bob = Person.new
nemo = Fish.new

# all objects have access to Animal#eats through class inheritance
felix.eats          # => "eats food"
bob.eats            # => "eats food"
nemo.eats           # => "eats food"

# not all animals speak, but some do, so we mixin a module
felix.speak('meow') # => "meow"
bob.speak('hello')  # => "hello"
nemo.speak('glub')  # => NoMethodError: undefined method `speak'