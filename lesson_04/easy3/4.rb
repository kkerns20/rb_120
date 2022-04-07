# Given the class below, if we created a new instance 
# of the class and then called to_s on that instance we 
# would get something like "#<Cat:0x007ff39b356d30>"

class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{type} cat"
  end
end