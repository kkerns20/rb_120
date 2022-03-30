# Use modules to mix-in generic, but not hierarchal behaviors
module Swimmable
  def swim
    puts "I'm swimming!"
  end
end

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
    "#{self.name} says: " + super
  end

  include Swimmable
end

class Fish < Animal
  # Mix the swimming module in because fish swim
  include Swimmable
end

# Subclass Cat inherits all the methods from Animal & Pet
# but does not get the methods from Swimmable module because cats don't swimu
class Cat < Pet
  def initialize(temperment, name)
    # super invokes initialize method from Pet superclass
    # because it is called with an argument, it forwards that argument along
    super(name)
    @temperment = temperment
  end
end

class Bear < Animal
  include Swimmable
  def initialize(action)
    # super called with () invokes the Animal superclass method with no arguments
    # if method in question takes no arguments, super must be called this way
    super()
    @action = action
    # Mix the swimming module in because fish swim
  end
end

kirra = GoodDog.new("Kirree") 
merlin = Cat.new("cuddly", "Merlin")

# ------- INHERITED BEHAVIORS -------
# both instances of Pet subclasses inherit the speak method
puts kirra.speak   # "Kirree says: Hello!"
  # super looks up to see if there is a method of the 
  # same name and invokes it with the GoodDog method
puts merlin.speak  # Hello!
  # There is no Cat speak method so it is inherited from superclass

# ---- HOW SUPER FORWARDS ARGUMENTS ----
albie = GoodDog.new('brown')
p albie # => <GoodDog:0x000055d00f7c14a8 @name="brown", @color="brown">
# albie here has @name 'brown and @color 'brown because the GoodDog
# initialize method is defined with a super call that automatically forwards
# the arguments passed ot the method that called it to the superclass method

khaleesi = Cat.new('curious', 'Khaleesi')
p khaleesi # => <Cat:0x000055e2169a7f38 @name="Khaleesi", @temperment="curious">
# khaleesi has an initiaze definition that uses two arguments, and when super
# is called with `name` argument, that gets passed alons and assigned to 
# the @name instance variable when the Animal#initialize method is invoked

smokey = Bear.new("run away!")
p smokey # => <Bear:0x0000562fc972a9f8 @action="run away!">
# smokey inherits the Scary Animal initialize method, which takes no arguments
# inoke it with super() and no arguments get passed

#------- MIXING IN MODULES --------
# Fish class instances use inherited initialize method from Animal
dory = Fish.new

# Fish and Dog instances can swim, but objects from other classes cannot
kirra.swim   # => "I'm swimming!"
dory.swim    # => "I'm swimming!"
merlin.swim  # => NoMethodError: undefined method `swim` for #<Cat:... 