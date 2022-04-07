class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end
# instead of `light_status` change it to `status`
  def light_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end
end

my_light = Light.new("100", 'white')
p my_light.light_status #this is redundant and unnecessary
# my_light.status would be more readable