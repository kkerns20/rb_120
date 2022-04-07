class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end

# What is used but doesn't add any value?

# the `return` does not add any value and should be avoided.
# also, the attr_accessor does add 'potential' value, as
# we're given an option to alter brightness and color 
# outside of the Light class