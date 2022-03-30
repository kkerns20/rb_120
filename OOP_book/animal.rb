# Animal is a generic supclass containing basic behavior for ALL animals
class Animal
  # method takes no arguments, so subclass must invoke with super()
  def initialize
  end
end

#Pet is a subclass of Animal, but but a superclass of GoodDog and Cat
class Pet < Animal
  attr_accessor :name

  def initialize(n)
    @name = n
  end

  def speak
    "Hello!"
  end
end

# Subclass GoodDog inherits all methods from Animal & Pet
class GoodDog < Pet
  def initialize(color)
    # super invokes initialize method from Pet superclass
    # because it is called with no () or arguments, it passes the argument
    # assigned to parameter color to the Pet#initialize method
    super
    @color = color
  end
  # but methods defined within the class override inherited methods of the 
  # same name
  def speak
    super + " from GoodDog class"
  end
end

# Subclass Cat inherits all the methods from Animal & Pet
class Cat < Pet
  def initialize(temperment, name)
    # super invokes initialize method from Pet superclass
    # because it is called with an argument, it forwards that argument along
    super(name)
    @temperment = temperment
  end
end

class Bear < Animal
  def initialize(action)
    # super called with () invokes the Animal superclass method with no arguments
    # if method in question takes no arguments, super must be called this way
    super()
    @action = action
  end
end

kirra = GoodDog.new("Kirree")
merlin = Cat.new("cuddly", "Merlin")

puts kirra