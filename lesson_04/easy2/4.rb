# Simplify this class and remove two methods 
# while maintaining functionality

class BeesWax
  # remove explicit setter and getter methods 
  # and replace with `attr_accessor`
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def describe_type
    # refer to the instance variable without the @
    # this is much cleaner and is standard practice IF
    # getter method is available
    puts "I am a #{type} of Bees Wax"
  end
end