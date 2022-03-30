#exs_4_1-6.rb
=begin
1.
- Create a superclass Vehicle for MyCar class
- Move behavior that isn't specific to the MyCar class to the superclass
- Create a constant in MyCar that stores information about the vehicle
that makes it different from other types of Vehicles
- Create a new class called MyTruck that inherits from the superclass
- Define a constant that separates it from MyCar in some way
2.
- Add a class variable to the superclass to track number of objects
- Create a method to print the value of this class variable as well
3.
- Create a module that you can mix in to one of the subclasses
- It should describe a behavior unique to that subclass
4.
- Output all the method lookup chains for each class
5.
- Move all the methods from MyCar that also pertain to MyTruck into Vehicle
- Ensure that all the methods still work
6.
- Make an `age` method that calls a private method to calculate the age
- Make sure the private method is not available from outside the class
=end

module Babyable
  def travel_babies
    "Strap 'em down and we'll drive 'em down the road!"
  end
end

class Vehicle
  @@number_of_vehicles = 0

  attr_accessor :current_speed, :color 
  attr_reader :year, :model

  def initialize(y, c, m)
    @year = y
    @model = m 
    self.color = c 
    self.current_speed = 0
    @@number_of_vehicles += 1
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def to_s
    puts "#{self.class} is a #{color}, #{year} #{model}"
  end

  def speed_up(mph)
    self.current_speed += mph
    puts "You accelerate #{mph} mph."
  end

  def brake(mph)
    self.current_speed -= mph
    puts "You brake and decelerate #{mph} mph."
  end

  def turn_off
    self.current_speed = 0
    puts "You have just turned off your car."
  end

  def current
    puts "You are now going #{self.current_speed} mph"
  end
 
  def self.gas_mileage(gas, mileage)
    puts "You are getting #{mileage / gas} miles to the gallon of gas"
  end

  def self.number_of_vehicles
    puts "There are #{@@number_of_vehicles} vehicles in your garage."
  end

  def display_age
    puts "This vehicle is #{calculate_age} years old."
  end

  private

  def calculate_age
    Time.new.year - self.year
  end
end

class MyCar < Vehicle
  include Babyable
  BABY_SEATS = 2
end

class MyTruck < Vehicle
  BABY_SEATS = 0
end

Vehicle.number_of_vehicles 
  # => There are 0 vehicles in your garage.

armada = MyCar.new 2019, 'Silver', 'Nissan Armada'
puts armada 
  # MyCar is a Silver, 2019 Nissan Armada
  #<MyCar:0x000055590fdbe030>

mighty_whitey = MyTruck.new 2016, 'White', 'Toyota Tundra' 
puts "#{mighty_whitey}"
  # MyTruck is a White, 2016 Toyota Tundra
  # #<MyTruck:0x000055590fdbdc70>

Vehicle.number_of_vehicles 
  # => There are 2 vehicles in your garage.

puts armada.travel_babies
  # Strap 'em down and we'll drive 'em down the road!

puts Vehicle.ancestors
# Vehicle
# Object
# Kernel
# BasicObject
puts MyCar.ancestors
# MyCar
# Babyable
# Vehicle
# Object
# Kernel
# BasicObject
puts MyTruck.ancestors
# MyTruck
# Vehicle
# Object
# Kernel
# BasicObject

armada.speed_up 79
armada.brake 39
armada.turn_off
# You accelerate 79 mph.
# You brake and decelerate 39 mph.
# You have just turned off your car.

mighty_whitey.speed_up 55
mighty_whitey.brake 20
mighty_whitey.turn_off
# You accelerate 55 mph.
# You brake and decelerate 20 mph.
# You have just turned off your car.


MyCar.gas_mileage 19, 240
# You are getting 12 miles to the gallon of gas
MyTruck.gas_mileage 24, 330
# You are getting 13 miles to the gallon of gas

armada.display_age
# This vehicle is 3 years old.
mighty_whitey.calc_age
# NoMethodError: undefined method `calc_age' for #<MyTruck: ...
