# class definition
class GoodDog

  #initialize class variable (available through the class definition)
  @@number_of_dogs = 0

  # creates 6 getter/setter (accessor) methods and 3 instance variables
  attr_accessor :name, :height, :weight

  # constructor method, triggered when a new GoodDog object is created (.new)
  def initialize(n, h, w)
    #define instance variables upon creation of a new object
    # ties specific and individual data to created object (state)
    @name = n
    @height = h
    @weight = w

    # increment number of dos each time a new GoodDog object is initialized
    @@number_of_dogs += 1
    # class variable avaiable throughout class definition
  end

  #instance method, describes behavior available to all GoodDog objects
  def speak
    # access value referenced by @name with getter method and using self
    "#{self.name} say arf!"
    # instance methods have access to instance variable
  end

  def change_info(n, h, w, a)
    # reassign instance variables with setter methods
    # must prefix 'self.' to disambiguate from local variable assignment
    # using self inside an instance method references the instance (object)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  # creates a class method with the keyword `self` prepended to the method name
  # using self outside an instance method references the class itself
  def self.what_am_i
    "I'm a GoodDog class!"
  end

  # Access class level details by combining class methods with class variables
  def self.total_number_of_dogs
    @@number_of_dogs
    # class methods have access to class variables
  end
end

# Initialize new instance (object) of GoodDog class
sparky = GoodDog.new("Sparky", '12 inches', '10 lbs', 4)

# Access object's state (stored in instance variables)
# puts automatically calls to_s defined in the class allowing us to see info
puts sparky
# => This is a GoodDog named Sparky who is 28 years old in dog years.
#    Sparky weighs 10 lbs and is 12 inches tall.

# string interpolation also calls to_s and will return the return value of the
# custom to_s defined for the class
puts "#{sparky}"

# Change object's state
sparky.change_info('Spartacus', '24 inches', '45 lbs', 7)

# Access object's changed state
puts sparky
# => This is a GoodDog named Spartacus who is 49 years old in dog years.
#    Spartacus weighs 45 lbs and is 24 inches tall.

# Invoke a class method without a calling object
GoodDog.what_am_i
# => "I'm a GoodDog class!"

# Class variables track data that pertains to class as a whole, not individuals
GoodDog.total_number_of_dogs 
# => 1 (the object referenced by sparky)