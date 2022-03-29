=begin
1. 
  - Create a class called MyCar. 
  - When you initialize a new instance or object of the class, allow the user 
  to define some instance variables that tell us the year, color, and model of the car. 
  - Create an instance variable that is set to 0 during instantiation of the  
  object to track the current speed of the car as well. 
  - Create instance methods that allow the car to speed up, brake, and shut the car off.
2.
  - Add an accessor method to your MyCar class to change and view the color of your car. 
  - Add an accessor method that allows you to view, but not modify, the year of your car.
3.
  - Create a method called spray_paint that can be called on an object and will 
  modify the color of the car.
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

  def info
    "Your car is a #{self.color} #{self.year} #{self.model}"
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
end

armada = MyCar.new(2019, 'Silver', 'Nissan Armada')

puts '---ex 1---'
puts armada.speed_up(75)
puts armada.current
puts armada.speed_up(10)
puts armada.current
puts armada.brake(55)
puts armada.current
puts armada.brake(20)
puts armada.current
puts armada.turn_off
puts armada.current
puts '---ex2---'
puts armada.info
puts armada.spray_paint('Black')
puts armada.info
