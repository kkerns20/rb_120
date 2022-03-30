#exs_3_1-2.rb
=begin
1. Add a class method to MyCar that calculates the gas mileage of any car
2. Override the to_s method to create a user friendly printout of an instance
=end

class MyCar
  attr_accessor :color, :model, :current_speed
  attr_reader :year

  def initialize(y, c, m)
    @year = y
    @color = c 
    @model = m 
    @current_speed = 0
  end

  def spray_paint(color)
    self.color = color
    "Your new #{color} paint job looks great!"
  end

  def to_s
    "Your car is a #{self.color}, #{self.year} #{self.model}"
  end

  def speed_up(mph)
    self.current_speed += mph
    "You accelerate #{mph} mph."
  end

  def brake(mph)
    self.current_speed -= mph
    "You brake and decelerate #{mph} mph."
  end

  def turn_off
    self.current_speed = 0
    "You have just turned off your car."
  end

  def current
    "You are now going #{self.current_speed} mph"
  end
  # use a class method because no matter what car you have, gas mileage is
  # calculated the same way
  def self.gas_mileage(gas, mileage)
    "You are getting #{mileage / gas} miles to the gallon of gas"
  end
end

armada = MyCar.new(2019, 'Silver', 'Nissan Armada')
whitey = MyCar.new(2016, 'White', 'Toyota Tundra')

puts armada
puts MyCar.gas_mileage(19, 240)
puts "#{whitey}"
puts MyCar.gas_mileage(24, 330)
