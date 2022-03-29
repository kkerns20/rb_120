# class definition
class GoodDog

  # creates 6 getter/setter (accessor) methods and 3 instance variables
  attr_accessor :name, :height, :weight

  # constructor method, triggered when a new GoodDog object is created (.new)
  def initialize(n, h, w)
    #define instance variables upon creation of a new object
    # ties specific and individual data to created object (state)
    @name = n
    @height = h
    @weight = w
  end

  #instance method, describes behavior available to all GoodDog objects
  def speak
    # access value referenced by @name with getter method and using self
    "#{self.name} say arf!"
    # instance methods have access to instance variable
  end

  def change_info(n, h, w)
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